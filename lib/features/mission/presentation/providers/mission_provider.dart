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

  return AppMissions.missions.map((mission) {
    double currentValue = 0;

    switch (mission.type) {
      case MissionType.targetProfit:
        currentValue = perf.diff;
        break;
      case MissionType.targetTotalEquity:
        currentValue = perf.totalEquity;
        break;
      case MissionType.buySpecificStock:
        final count = transactions
            .where((t) => t.type == 'BUY' && t.ticker == mission.targetTicker)
            .length;
        currentValue = count.toDouble();
        break;
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
    final updatedUser = currentUser.copyWith(
      balance: currentUser.balance + mission.rewardMoney,
    );
    await userRepo.saveUserProfile(updatedUser);
  }
});
