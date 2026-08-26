import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import 'market_provider.dart';
import 'user_provider.dart';

class PortfolioPerformance {
  final double totalEquity;
  final double netCapital;
  final double diff;
  final double diffPercent;
  final bool isPositive;
  final double totalFloatingProfit;
  final double totalFloatingLoss;
  final double totalIncome;
  final double totalExpense;

  const PortfolioPerformance({
    required this.totalEquity,
    required this.netCapital,
    required this.diff,
    required this.diffPercent,
    required this.isPositive,
    required this.totalFloatingProfit,
    required this.totalFloatingLoss,
    required this.totalIncome,
    required this.totalExpense,
  });
}

final portfolioPerformanceProvider = Provider<PortfolioPerformance?>((ref) {
  final userAsync = ref.watch(userProfileProvider);
  final portfoliosAsync = ref.watch(marketPortfoliosProvider);
  final stocksAsync = ref.watch(marketStocksProvider);
  final transactionsAsync = ref.watch(marketTransactionsProvider);

  if (userAsync.value == null ||
      portfoliosAsync.value == null ||
      stocksAsync.value == null ||
      transactionsAsync.value == null) {
    return null;
  }

  final user = userAsync.value!;
  final portfolios = portfoliosAsync.value!;
  final stocks = stocksAsync.value!;
  final transactions = transactionsAsync.value!;

  double currentPortfolioValue = 0.0;
  double totalFloatingProfit = 0.0;
  double totalFloatingLoss = 0.0;

  for (final portfolio in portfolios) {
    final stock = stocks.where((s) => s.ticker == portfolio.ticker).firstOrNull;
    if (stock != null) {
      final currentPrice = stock.currentPrice;
      final avgPrice = portfolio.averageBuyPrice;
      final lots = portfolio.totalLots;

      final currentValue = lots * 100 * currentPrice;
      currentPortfolioValue += currentValue;

      final estimatedSellFee =
          currentValue *
          (AppConstants.brokerFeeRate + AppConstants.exchangeFeeRate);
      final netCurrentValue = currentValue - estimatedSellFee;

      final costBasis = lots * 100 * avgPrice;
      final floatingDiff = netCurrentValue - costBasis;

      if (floatingDiff >= 0) {
        totalFloatingProfit += floatingDiff;
      } else {
        totalFloatingLoss += floatingDiff.abs();
      }
    }
  }

  double netDeposits = 0.0;
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  for (final t in transactions) {
    if (t.type == 'DEPOSIT') {
      netDeposits += t.totalAmount;
    } else if (t.type == 'WITHDRAW') {
      netDeposits -= t.totalAmount;
    } else if (t.type == 'SELL') {
      totalIncome += t.totalAmount;
    } else if (t.type == 'BUY') {
      totalExpense += t.totalAmount;
    }
  }

  final double netCapital = AppConstants.initialBalance + netDeposits;
  final double totalEquity = user.balance + currentPortfolioValue;
  final double diff = totalEquity - netCapital;
  final double diffPercent = netCapital > 0 ? (diff / netCapital) * 100 : 0.0;
  final bool isPositive = diff >= 0;

  return PortfolioPerformance(
    totalEquity: totalEquity,
    netCapital: netCapital,
    diff: diff,
    diffPercent: diffPercent,
    isPositive: isPositive,
    totalFloatingProfit: totalFloatingProfit,
    totalFloatingLoss: totalFloatingLoss,
    totalIncome: totalIncome,
    totalExpense: totalExpense,
  );
});

class PortfolioChartState {
  final List<FlSpot> spots;
  final double minY;
  final double maxY;
  final int dataPoints;

  const PortfolioChartState({
    required this.spots,
    required this.minY,
    required this.maxY,
    required this.dataPoints,
  });
}

final portfolioChartProvider = Provider.family<PortfolioChartState, String>((
  ref,
  selectedRange,
) {
  final userAsync = ref.watch(userProfileProvider);
  final transactionsAsync = ref.watch(marketTransactionsProvider);
  final perf = ref.watch(portfolioPerformanceProvider);

  if (userAsync.value == null ||
      transactionsAsync.value == null ||
      perf == null) {
    return const PortfolioChartState(
      spots: [],
      minY: 0,
      maxY: 0,
      dataPoints: 1,
    );
  }

  final user = userAsync.value!;
  final transactions = transactionsAsync.value!;
  final currentEquity = perf.totalEquity;
  final initialBalance = AppConstants.initialBalance;

  final sorted = transactions.toList()
    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  final now = user.currentSimulationDate ?? DateTime(2026, 1, 1);

  final dataPoints = switch (selectedRange) {
    '1D' => 1,
    '1W' => 6,
    '1M' => 29,
    '3M' => 89,
    _ => 289,
  };
  const step = Duration(days: 1);

  final startDate = now.subtract(step * dataPoints);

  final timeZero = sorted.isNotEmpty
      ? sorted.first.createdAt
      : now.subtract(Duration(days: 30));
  final totalLifeTime = now.difference(timeZero).inMilliseconds;

  double getEquityAt(DateTime date) {
    double netDepositsUpToDate = 0;
    for (final t in sorted) {
      if (t.createdAt.isAfter(date)) break;
      if (t.type == 'DEPOSIT') {
        netDepositsUpToDate += t.totalAmount;
      } else if (t.type == 'WITHDRAW') {
        netDepositsUpToDate -= t.totalAmount;
      }
    }

    double lifeProgress = 0.0;
    if (date.isBefore(timeZero)) {
      lifeProgress = 0.0;
    } else if (totalLifeTime > 0) {
      final elapsedSinceTimeZero = date.difference(timeZero).inMilliseconds;
      lifeProgress = (elapsedSinceTimeZero / totalLifeTime).clamp(0.0, 1.0);
    } else {
      lifeProgress = 1.0;
    }

    final profitAtDateSinceTimeZero = perf.diff * lifeProgress;

    return initialBalance + netDepositsUpToDate + profitAtDateSinceTimeZero;
  }

  final spots = <FlSpot>[];
  for (int i = 0; i < dataPoints; i++) {
    final date = startDate.add(step * i);
    spots.add(FlSpot(i.toDouble(), getEquityAt(date)));
  }
  spots.add(FlSpot(dataPoints.toDouble(), currentEquity));

  double minY = spots.isEmpty ? 0 : spots.map((s) => s.y).reduce(math.min);
  double maxY = spots.isEmpty ? 0 : spots.map((s) => s.y).reduce(math.max);

  if (spots.isNotEmpty) {
    minY = minY * 0.99;
    maxY = maxY * 1.01;
    if (minY == maxY) {
      minY -= 1000;
      maxY += 1000;
    }
  }

  return PortfolioChartState(
    spots: spots,
    minY: minY,
    maxY: maxY,
    dataPoints: dataPoints,
  );
});
