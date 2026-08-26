import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/widgets/primary_button.dart';
import '../../domain/models/mission_progress.dart';
import '../providers/mission_provider.dart';
import 'mission_progress_bar.dart';
import 'mission_reward_card.dart';

class MissionDetailTile extends ConsumerStatefulWidget {
  final MissionProgress progress;
  final bool isExpanded;
  final VoidCallback onToggle;

  const MissionDetailTile({
    super.key,
    required this.progress,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  ConsumerState<MissionDetailTile> createState() => _MissionDetailTileState();
}

class _MissionDetailTileState extends ConsumerState<MissionDetailTile> {
  bool _isClaiming = false;

  Future<void> _claim() async {
    if (_isClaiming) return;
    setState(() => _isClaiming = true);
    try {
      await ref.read(claimMissionProvider(widget.progress.mission).future);
      if (mounted) {
        context.push('/mission/detail/${widget.progress.mission.id}');
      }
    } finally {
      if (mounted) setState(() => _isClaiming = false);
    }
  }

  Color get _borderColor {
    if (widget.progress.isCompleted || widget.progress.isClaimed) {
      return AppColors.greenLightActive;
    }
    if (widget.progress.currentValue > 0) {
      return AppColors.orangeLightActive;
    }
    return AppColors.redLightActive;
  }

  Color get _headerBg {
    if (widget.progress.isCompleted || widget.progress.isClaimed) {
      return AppColors.greenLight;
    }
    if (widget.progress.currentValue > 0) {
      return AppColors.orangeLight;
    }
    return AppColors.redLight;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.progress;
    final m = p.mission;
    final canClaim = p.isCompleted && !p.isClaimed;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _headerBg,
        borderRadius: .circular(16),
        border: .all(color: _borderColor, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          InkWell(
            onTap: widget.onToggle,
            child: Padding(
              padding: .symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      m.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  AnimatedRotation(
                    turns: widget.isExpanded ? 0.5 : 0,
                    duration: Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: !widget.isExpanded
                ? SizedBox.shrink()
                : Padding(
                    padding: .fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Divider(color: _borderColor, height: 1),
                        SizedBox(height: 12),
                        Text(
                          m.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 12),
                        MissionProgressBar(
                          progress: p.progressRatio,
                          isCompleted: p.isCompleted,
                          isClaimed: p.isClaimed,
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Text(
                            p.progressText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: .w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        MissionRewardCard(
                          rewardMoney: m.rewardMoney,
                          achievementName: m.achievementName,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Feedback',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: .w700,
                            color: AppColors.textHeading,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          m.feedback,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 16),
                        PrimaryButton(
                          text: 'Lanjutkan Misi',
                          onPressed: p.isCompleted
                              ? () {}
                              : () => context.push('/search'),
                          color: p.isCompleted
                              ? AppColors.greenLightActive
                              : AppColors.greenNormal,
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                text: 'Detail',
                                isOutlined: true,
                                color: canClaim || p.isClaimed
                                    ? AppColors.greenNormal
                                    : AppColors.neutralDark,
                                onPressed: () => context.push(
                                  '/mission/detail/${p.mission.id}',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: PrimaryButton(
                                text: _isClaiming ? 'Mengklaim...' : 'Klaim',
                                color: canClaim
                                    ? AppColors.greenNormal
                                    : AppColors.neutralNormalActive,
                                onPressed: canClaim ? _claim : () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
