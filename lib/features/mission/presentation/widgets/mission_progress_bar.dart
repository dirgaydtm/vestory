import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MissionProgressBar extends StatelessWidget {
  final double progress;
  final bool isCompleted;
  final bool isClaimed;

  const MissionProgressBar({
    super.key,
    required this.progress,
    required this.isCompleted,
    required this.isClaimed,
  });

  Color get _barColor {
    if (isClaimed) return AppColors.greenNormalActive;
    if (isCompleted) return AppColors.redNormal;
    return AppColors.orangeNormal;
  }

  Color get _trackColor {
    if (isClaimed) return AppColors.greenLight;
    if (isCompleted) return AppColors.redLightActive;
    return AppColors.orangeLightActive;
  }

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Container(
            height: 20,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: _trackColor,
              borderRadius: .circular(8),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOut,
            height: 20,
            width: constraints.maxWidth * clampedProgress,
            decoration: BoxDecoration(
              color: _barColor,
              borderRadius: .circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
