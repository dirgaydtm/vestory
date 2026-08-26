import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/presentation/providers/market_provider.dart';
import '../../../../core/utils/currency_format.dart';
import '../providers/chart_range_provider.dart';

class StockChartSection extends ConsumerWidget {
  final String ticker;

  const StockChartSection({super.key, required this.ticker});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(stockDetailChartProvider(ticker));
    final selectedRange = ref.watch(chartRangeProvider);
    final ranges = ['1D', '1W', '1M', '3M', 'ALL'];

    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: ranges.map((label) {
            final isSelected = label == selectedRange;
            return GestureDetector(
              onTap: () => ref.read(chartRangeProvider.notifier).state = label,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? .bold : .w500,
                  color: isSelected
                      ? AppColors.greenDark
                      : AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: historyAsync.when(
            data: (fullHistory) {
              final history = sliceHistory(fullHistory, selectedRange);
              if (history.isEmpty) {
                return Center(child: Text('No chart data'));
              }

              final spots = history
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.close))
                  .toList();

              final minY =
                  history.map((e) => e.close).reduce((a, b) => a < b ? a : b) *
                  0.98;
              final maxY =
                  history.map((e) => e.close).reduce((a, b) => a > b ? a : b) *
                  1.02;

              return LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    horizontalInterval: (maxY - minY) / 6 > 0
                        ? (maxY - minY) / 6
                        : 1,
                    verticalInterval: (history.length / 12) > 0
                        ? (history.length / 12)
                        : 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: AppColors.textSecondary.withValues(alpha: 0.15),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: AppColors.textSecondary.withValues(alpha: 0.15),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            spot.y.toIdr(withPrefix: false),
                            TextStyle(
                              color: AppColors.textWhite,
                              fontWeight: .bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: (history.length - 1).toDouble(),
                  minY: minY,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: false,
                      color: AppColors.blueNormal,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.blueNormal.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error loading chart')),
          ),
        ),
      ],
    );
  }
}
