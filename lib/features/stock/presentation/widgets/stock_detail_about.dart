import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/stock_utils.dart';

class StockDetailAbout extends StatelessWidget {
  final Stock stock;

  const StockDetailAbout({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'Latar Belakang Perusahaan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: .bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          stock.companyDescription,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
