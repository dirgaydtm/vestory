import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';

class StockDetailStats extends StatelessWidget {
  final Stock stock;

  const StockDetailStats({super.key, required this.stock});

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: .symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.greenNormal,
          borderRadius: .circular(16),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              label,
              style: TextStyle(color: AppColors.textWhite, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: AppColors.textWhite,
                fontSize: 20,
                fontWeight: .bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(
          'Volume',
          '${(stock.volume / 1000000).toStringAsFixed(2)} M',
        ),
        SizedBox(width: 16),
        _buildStatCard(
          'Avg Volume',
          '${((stock.volume * 1.5) / 1000000).toStringAsFixed(2)} M',
        ),
      ],
    );
  }
}
