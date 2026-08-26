import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';

class PortfolioProfitLoss extends StatelessWidget {
  final double totalProfit;
  final double totalLoss;

  const PortfolioProfitLoss({
    super.key,
    required this.totalProfit,
    required this.totalLoss,
  });

  Widget _buildCard(String label, String value, bool isProfit) {
    return Container(
      width: double.infinity,
      padding: .symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isProfit
            ? AppColors.greenNormal.withValues(alpha: 0.1)
            : AppColors.redNormal.withValues(alpha: 0.1),
        borderRadius: .circular(24),
        border: Border.all(
          color: isProfit ? AppColors.greenNormal : AppColors.redNormal,
        ),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .bold,
              color: AppColors.textHeading,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .bold,
              color: isProfit ? AppColors.greenNormal : AppColors.redNormal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          'Total Profit',
          '+${totalProfit.toIdr(withPrefix: true)}',
          true,
        ),
        SizedBox(height: 16),
        _buildCard(
          'Total Loss',
          '-${totalLoss.toIdr(withPrefix: true)}',
          false,
        ),
      ],
    );
  }
}
