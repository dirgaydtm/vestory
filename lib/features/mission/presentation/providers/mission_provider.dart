import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/mission_dao.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/data/repositories/user_repository.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../shared/presentation/providers/portfolio_provider.dart';
import '../../../../shared/presentation/providers/user_provider.dart';
import '../../data/constants/app_missions.dart';
import '../../domain/models/mission_model.dart';
import '../../domain/models/mission_progress.dart';

final missionDaoProvider = Provider<MissionDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.missionDao;
});

final claimedMissionsProvider = StreamProvider<Set<String>>((ref) async* {
  final dao = ref.watch(missionDaoProvider);
  await for (final missions in dao.watchClaimedMissions()) {
    yield missions.map((m) => m.id).toSet();
  }
});

final claimedCountProvider = Provider<int>((ref) {
  final claimedAsync = ref.watch(claimedMissionsProvider);
  return claimedAsync.value?.length ?? 0;
});

final missionProgressListProvider = Provider<List<MissionProgress>?>((ref) {
  final perf = ref.watch(portfolioPerformanceProvider);
  final transactionsAsync = ref.watch(marketTransactionsProvider);
  final claimedAsync = ref.watch(claimedMissionsProvider);

  if (perf == null ||
      transactionsAsync.value == null ||
      claimedAsync.value == null) {
    return null;
  }

  final transactions = transactionsAsync.value!;
  final claimedIds = claimedAsync.value!;

  final totalClaimedRewards = claimedIds.fold(0.0, (sum, id) {
    final m = AppMissions.missions.where((m) => m.id == id).firstOrNull;
    return sum + (m?.rewardMoney ?? 0);
  });

  return AppMissions.missions.map((mission) {
    double currentValue = 0;

    switch (mission.type) {
      case MissionType.targetProfit:
        currentValue = (perf.diff - totalClaimedRewards).clamp(
          0,
          double.infinity,
        );
      case MissionType.targetTotalEquity:
        currentValue = perf.totalExpense;
      case MissionType.buySpecificStock:
        currentValue = transactions
            .where((t) => t.type == 'BUY' && t.ticker == mission.targetTicker)
            .length
            .toDouble();
    }

    final isCompleted = currentValue >= mission.targetValue;
    final isClaimed = claimedIds.contains(mission.id);

    return MissionProgress(
      mission: mission,
      currentValue: currentValue,
      isCompleted: isCompleted,
      isClaimed: isClaimed,
    );
  }).toList();
});

final claimMissionProvider = FutureProvider.family<void, MissionModel>((
  ref,
  mission,
) async {
  final dao = ref.watch(missionDaoProvider);
  final userRepo = ref.watch(userRepositoryProvider);
  final currentUser = ref.read(userProfileProvider).value;

  if (currentUser != null) {
    await dao.claimMission(
      ClaimedMission(id: mission.id, claimedAt: DateTime.now()),
    );
    await userRepo.saveUserProfile(
      currentUser.copyWith(balance: currentUser.balance + mission.rewardMoney),
    );
  }
});
