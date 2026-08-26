import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class MissionSummaryCard extends StatelessWidget {
  final int claimedCount;
  final int totalCount;

  const MissionSummaryCard({
    super.key,
    required this.claimedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.greenLight,
        borderRadius: .circular(20),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  Text(
                    'Penghargaan',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: .w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$claimedCount/$totalCount',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: .w600,
                      color: AppColors.textHeading,
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(color: AppColors.greenNormal, thickness: 2),
            Expanded(
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  Text(
                    'Total Misi',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: .w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '$totalCount',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: .w600,
                      color: AppColors.textHeading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
