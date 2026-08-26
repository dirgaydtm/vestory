import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';

class MissionRewardCard extends StatelessWidget {
  final double rewardMoney;
  final String achievementName;

  const MissionRewardCard({
    super.key,
    required this.rewardMoney,
    required this.achievementName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      padding: .symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        borderRadius: .circular(24),
        border: .all(color: AppColors.redLightActive, width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'Reward List',
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w700,
              color: AppColors.textHeading,
            ),
          ),
          SizedBox(height: 6),
          Text(
            rewardMoney.toIdr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Achievement: "$achievementName"',
            textAlign: .center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: .w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
