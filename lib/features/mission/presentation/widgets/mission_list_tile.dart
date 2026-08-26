import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/mission_progress.dart';

class MissionListTile extends StatelessWidget {
  final int index;
  final MissionProgress progress;
  final bool showCheck;

  const MissionListTile({
    super.key,
    required this.index,
    required this.progress,
    this.showCheck = false,
  });

  List<Color> get _gradientColors {
    if (progress.isCompleted || progress.isClaimed) {
      return [AppColors.greenNormal, AppColors.baseWhite];
    }
    if (progress.currentValue > 0) {
      return [AppColors.orangeNormal, AppColors.baseWhite];
    }
    return [AppColors.redNormal, AppColors.baseWhite];
  }

  Color get _badgeColor {
    if (progress.isCompleted || progress.isClaimed) {
      return AppColors.greenNormal;
    }
    if (progress.currentValue > 0) {
      return AppColors.orangeNormal;
    }
    return AppColors.redNormal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _gradientColors,
          begin: .centerLeft,
          end: .centerRight,
        ),
        borderRadius: .circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: showCheck ? _badgeColor : AppColors.baseWhite,
              shape: .circle,
            ),
            child: Center(
              child: showCheck
                  ? Icon(Icons.check, color: AppColors.baseWhite, size: 18)
                  : Text(
                      '$index',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: .w700,
                        fontSize: 14,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              progress.mission.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: .w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            progress.progressText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: .w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
