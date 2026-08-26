import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../providers/mission_provider.dart';
import '../widgets/mission_list_tile.dart';
import '../widgets/mission_reward_card.dart';

class MissionDetailPage extends ConsumerWidget {
  final String id;

  const MissionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missionList = ref.watch(missionProgressListProvider);
    final progress = missionList?.firstWhere((p) => p.mission.id == id);

    if (progress == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final m = progress.mission;
    final isCompleted = progress.isCompleted;
    final index = (missionList?.indexOf(progress) ?? 0) + 1;

    return Scaffold(
      backgroundColor: AppColors.greenNormal,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: 240,
            width: .infinity,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: -50,
                  child: Image.asset('assets/images/mission/triple-arrow.png'),
                ),
                Center(
                  child: SafeArea(
                    child: Padding(
                      padding: .only(top: 16),
                      child: Container(
                        padding: .symmetric(horizontal: 28, vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.baseWhite,
                          borderRadius: .circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.baseBlack.withValues(alpha: 0.1),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          isCompleted ? 'Misi Selesai!' : 'Detail Misi',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: .w800,
                            color: AppColors.greenDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 200,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.baseWhite,
                borderRadius: .vertical(top: .circular(28)),
              ),
              child: SingleChildScrollView(
                padding: .fromLTRB(24, 28, 24, 120),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    MissionListTile(
                      index: index,
                      progress: progress,
                      showCheck: progress.isCompleted,
                    ),
                    SizedBox(height: 28),
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w700,
                        color: AppColors.textHeading,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      m.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 28),
                    MissionRewardCard(
                      rewardMoney: m.rewardMoney,
                      achievementName: m.achievementName,
                    ),
                    SizedBox(height: 28),
                    Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w700,
                        color: AppColors.textHeading,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      m.feedback,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: AppColors.baseWhite,
              padding: .fromLTRB(
                24,
                12,
                24,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              child: PrimaryButton(text: 'Kembali', onPressed: context.pop),
            ),
          ),
        ],
      ),
    );
  }
}
