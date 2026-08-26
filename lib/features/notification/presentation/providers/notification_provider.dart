import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/notification_dao.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/presentation/providers/preferences_provider.dart';
import '../../../mission/presentation/providers/mission_provider.dart';
import '../../../mission/domain/models/mission_progress.dart';

final notificationDaoProvider = Provider<NotificationDao>(
  (ref) => ref.watch(databaseProvider).notificationDao,
);

final notificationsStreamProvider =
    StreamProvider<List<NotificationsTableData>>((ref) {
      return !ref.watch(notificationStateProvider)
          ? Stream.value([])
          : ref.watch(notificationDaoProvider).watchAllNotifications();
    });

final missionNotificationObserverProvider = Provider<void>((ref) {
  final isEnabled = ref.watch(notificationStateProvider);
  if (!isEnabled) return;
  Set<String> previousCompleted = {};

  ref.listen<List<MissionProgress>?>(missionProgressListProvider, (
    previous,
    next,
  ) {
    if (next == null) return;

    final currentCompleted = next
        .where((m) => m.isCompleted)
        .map((m) => m.mission.id)
        .toSet();

    if (previous != null) {
      final newlyCompleted = currentCompleted.difference(previousCompleted);

      for (final missionId in newlyCompleted) {
        final mission = next
            .firstWhere((m) => m.mission.id == missionId)
            .mission;

        final dao = ref.read(notificationDaoProvider);
        dao.insertNotification(
          NotificationsTableCompanion.insert(
            title: 'Misi Sudah Selesai!',
            body: mission.title,
            createdAt: DateTime.now(),
          ),
        );
      }
    }

    previousCompleted = currentCompleted;
  }, fireImmediately: true);
});
