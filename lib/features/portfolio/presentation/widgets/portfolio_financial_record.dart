import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../shared/presentation/providers/user_provider.dart';

class PortfolioFinancialRecord extends ConsumerWidget {
  final double totalIncome;
  final double totalExpense;

  const PortfolioFinancialRecord({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
  });

  Widget _buildLegendItem(Color color, String label, double amount) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: .bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        Text(
          amount.toIdr(withPrefix: true),
          style: TextStyle(
            fontSize: 14,
            fontWeight: .bold,
            color: AppColors.textHeading,
          ),
        ),
      ],
    );
  }

  String _getMonthYear(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);
    final now = userAsync.value?.currentSimulationDate ?? DateTime(2026, 1, 1);
    final sum = totalIncome + totalExpense;
    final incomePerc = sum == 0 ? 0.0 : (totalIncome / sum) * 100;
    final expensePerc = sum == 0 ? 100.0 : (totalExpense / sum) * 100;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          'Catatan Keuangan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: .bold,
            color: AppColors.textHeading,
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: .all(20),
          decoration: BoxDecoration(
            color: AppColors.greenLight,
            borderRadius: .circular(24),
          ),
          child: Column(
            children: [
              Container(
                padding: .symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.baseWhite,
                  borderRadius: .circular(24),
                ),
                child: Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      _getMonthYear(now),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    sections: sum == 0
                        ? [
                            PieChartSectionData(
                              color: AppColors.greenNormal,
                              value: 100,
                              title: '',
                              radius: 40,
                            ),
                          ]
                        : [
                            PieChartSectionData(
                              color: AppColors.greenNormal,
                              value: incomePerc,
                              title: '',
                              radius: 40,
                            ),
                            PieChartSectionData(
                              color: AppColors.orangeNormal,
                              value: expensePerc,
                              title: '',
                              radius: 40,
                            ),
                          ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              _buildLegendItem(
                AppColors.greenNormal,
                'Uang Masuk',
                totalIncome,
              ),
              SizedBox(height: 12),
              _buildLegendItem(
                AppColors.orangeNormal,
                'Uang Keluar',
                totalExpense,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
