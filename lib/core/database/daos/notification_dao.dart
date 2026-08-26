import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/notifications_table.dart';

part 'notification_dao.g.dart';

@DriftAccessor(tables: [NotificationsTable])
class NotificationDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationDaoMixin {
  NotificationDao(super.db);

  Stream<List<NotificationsTableData>> watchAllNotifications() {
    return (select(notificationsTable)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  Future<int> insertNotification(NotificationsTableCompanion notification) {
    return into(notificationsTable).insert(notification);
  }

  Future<void> markAsRead(int id) {
    return (update(notificationsTable)..where((t) => t.id.equals(id))).write(
      const NotificationsTableCompanion(isRead: Value(true)),
    );
  }
}
