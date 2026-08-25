import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import 'market_provider.dart';
import 'user_provider.dart';

class PortfolioPerformance {
  final double totalEquity;
  final double diff;
  final double diffPercent;
  final bool isPositive;

  const PortfolioPerformance({
    required this.totalEquity,
    required this.diff,
    required this.diffPercent,
    required this.isPositive,
  });
}

final portfolioPerformanceProvider = Provider<PortfolioPerformance?>((ref) {
  final userAsync = ref.watch(userProfileProvider);
  final portfoliosAsync = ref.watch(marketPortfoliosProvider);
  final stocksAsync = ref.watch(marketStocksProvider);

  if (userAsync.value == null ||
      portfoliosAsync.value == null ||
      stocksAsync.value == null) {
    return null;
  }

  final user = userAsync.value!;
  final portfolios = portfoliosAsync.value!;
  final stocks = stocksAsync.value!;

  double currentPortfolioValue = 0.0;

  for (final portfolio in portfolios) {
    final stockIndex = stocks.indexWhere((s) => s.ticker == portfolio.ticker);
    if (stockIndex != -1) {
      final stock = stocks[stockIndex];
      currentPortfolioValue += portfolio.totalLots * 100 * stock.currentPrice;
    }
  }

  final double totalEquity = user.balance + currentPortfolioValue;
  final double diff = totalEquity - AppConstants.initialBalance;
  final double diffPercent = (diff / AppConstants.initialBalance) * 100;
  final bool isPositive = diff >= 0;

  return PortfolioPerformance(
    totalEquity: totalEquity,
    diff: diff,
    diffPercent: diffPercent,
    isPositive: isPositive,
  );
});
