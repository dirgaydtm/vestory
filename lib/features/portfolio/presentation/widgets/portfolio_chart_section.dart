import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../shared/presentation/providers/portfolio_provider.dart';

class PortfolioChartSection extends ConsumerStatefulWidget {
  const PortfolioChartSection({super.key});

  @override
  ConsumerState<PortfolioChartSection> createState() =>
      _PortfolioChartSectionState();
}

class _PortfolioChartSectionState extends ConsumerState<PortfolioChartSection> {
  String _selectedRange = '1M';
  final List<String> _ranges = ['1D', '1W', '1M', '3M', 'ALL'];

  Widget _buildRangeFilter() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: _ranges.map((range) {
        final isSelected = _selectedRange == range;
        return GestureDetector(
          onTap: () => setState(() => _selectedRange = range),
          child: Container(
            padding: .symmetric(horizontal: 16, vertical: 8),
            child: Text(
              range,
              style: TextStyle(
                color: isSelected
                    ? AppColors.greenNormal
                    : AppColors.textPrimary,
                fontWeight: isSelected ? .bold : .normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chartState = ref.watch(portfolioChartProvider(_selectedRange));

    return Column(
      children: [
        _buildRangeFilter(),
        SizedBox(height: 24),
        SizedBox(
          height: 160,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: true,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
                  strokeWidth: 1,
                ),
                getDrawingVerticalLine: (value) => FlLine(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      return LineTooltipItem(
                        spot.y.toIdr(withPrefix: true),
                        TextStyle(
                          color: AppColors.baseWhite,
                          fontWeight: .bold,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              minX: 0,
              maxX: chartState.dataPoints.toDouble(),
              minY: chartState.minY,
              maxY: chartState.maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: chartState.spots,
                  color: AppColors.blueNormal,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.blueNormal.withValues(alpha: 0.5),
                        AppColors.blueNormal.withValues(alpha: 0.0),
                      ],
                      begin: .topCenter,
                      end: .bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
