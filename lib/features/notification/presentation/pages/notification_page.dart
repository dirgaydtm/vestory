import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/database/app_database.dart';
import '../providers/notification_provider.dart';
import '../../../../shared/presentation/providers/preferences_provider.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(notificationStateProvider);
    final notificationsAsync = ref.watch(notificationsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.baseWhite,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: !isEnabled
                  ? _buildEmptyState()
                  : notificationsAsync.when(
                      data: (notifications) {
                        if (notifications.isEmpty) {
                          return _buildEmptyState();
                        }
                        return _buildNotificationList(notifications);
                      },
                      loading: () => Center(child: CircularProgressIndicator()),
                      error: (err, stack) =>
                          Center(child: Text('Gagal memuat notifikasi: $err')),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.greenLight,
                shape: .circle,
                border: Border.all(color: AppColors.greenNormal),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.baseBlack,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 16),
          Text(
            'Notifikasi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: .bold,
              color: AppColors.baseBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Image.asset('assets/images/notification/empty.png', width: 250),
    );
  }

  Widget _buildNotificationList(List<NotificationsTableData> notifications) {
    final grouped = _groupNotifications(notifications);
    final keys = grouped.keys.toList();

    return ListView.builder(
      padding: .symmetric(horizontal: 24, vertical: 8),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final dateLabel = keys[index];
        final items = grouped[dateLabel]!;

        return Column(
          crossAxisAlignment: .start,
          children: [
            if (index > 0)
              Divider(color: AppColors.greenNormal, thickness: 1, height: 32),
            Text(
              dateLabel,
              style: TextStyle(
                fontSize: 16,
                fontWeight: .bold,
                color: AppColors.baseBlack,
              ),
            ),
            SizedBox(height: 12),
            ...items.map((item) => _buildNotificationTile(item)),
          ],
        );
      },
    );
  }

  Widget _buildNotificationTile(NotificationsTableData notification) {
    return Container(
      margin: .only(bottom: 12),
      padding: .all(16),
      decoration: BoxDecoration(
        color: AppColors.greenLight.withValues(alpha: 0.5),
        borderRadius: .circular(24),
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.greenNormal,
              shape: .circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: .bold,
                    color: AppColors.greenNormal,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  notification.body,
                  style: TextStyle(fontSize: 14, color: AppColors.baseBlack),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            '1/1',
            style: TextStyle(fontSize: 14, color: AppColors.greenNormal),
          ),
        ],
      ),
    );
  }

  Map<String, List<NotificationsTableData>> _groupNotifications(
    List<NotificationsTableData> notifications,
  ) {
    final Map<String, List<NotificationsTableData>> map = {};
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final notif in notifications) {
      final date = DateTime(
        notif.createdAt.year,
        notif.createdAt.month,
        notif.createdAt.day,
      );
      String label;
      if (date == today) {
        label = 'Hari ini';
      } else if (date == yesterday) {
        label = 'Kemarin';
      } else {
        label = DateFormat('dd MMM yyyy').format(date);
      }
      map.putIfAbsent(label, () => []).add(notif);
    }

    return map;
  }
}
