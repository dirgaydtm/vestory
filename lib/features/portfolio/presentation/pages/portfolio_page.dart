import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_format.dart';
import '../../../../shared/presentation/providers/portfolio_provider.dart';
import '../../../../shared/presentation/widgets/vestory_back_button.dart';
import '../widgets/portfolio_chart_section.dart';
import '../widgets/portfolio_financial_record.dart';
import '../widgets/portfolio_profit_loss.dart';
import '../widgets/portfolio_transaction_history.dart';

class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perf = ref.watch(portfolioPerformanceProvider);
    final totalIncome = perf?.totalIncome ?? 0.0;
    final totalExpense = perf?.totalExpense ?? 0.0;
    final currentEquity = perf?.totalEquity ?? 0.0;
    final diff = perf?.diff ?? 0.0;
    final isPositive = perf?.isPositive ?? true;

    return Scaffold(
      backgroundColor: AppColors.baseBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .all(24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  VestoryBackButton(onTap: () => context.pop()),
                  SizedBox(width: 16),
                  Text(
                    'Portfolio',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: .bold,
                      color: AppColors.textHeading,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                currentEquity.toIdr(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: .bold,
                  color: AppColors.textHeading,
                ),
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: .center,
                children: [
                  Text(
                    '${isPositive ? '+' : ''}${diff.toIdr(withPrefix: true)}',
                    style: TextStyle(
                      color: isPositive
                          ? AppColors.greenNormal
                          : AppColors.redNormal,
                      fontWeight: .bold,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(
                    isPositive ? Icons.show_chart : Icons.stacked_line_chart,
                    color: isPositive
                        ? AppColors.greenNormal
                        : AppColors.redNormal,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '${isPositive ? '+' : ''}${diff.toIdr(withPrefix: true)}',
                    style: TextStyle(
                      color: isPositive
                          ? AppColors.greenNormal
                          : AppColors.redNormal,
                      fontWeight: .bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              PortfolioChartSection(),
              SizedBox(height: 24),
              PortfolioProfitLoss(
                totalProfit: perf?.totalFloatingProfit ?? 0.0,
                totalLoss: perf?.totalFloatingLoss ?? 0.0,
              ),
              SizedBox(height: 32),
              PortfolioFinancialRecord(
                totalIncome: totalIncome,
                totalExpense: totalExpense,
              ),
              SizedBox(height: 32),
              PortfolioTransactionHistory(),
            ],
          ),
        ),
      ),
    );
  }
}
