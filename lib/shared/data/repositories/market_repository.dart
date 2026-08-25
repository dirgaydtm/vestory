import '../../../core/database/app_database.dart';
import '../models/stock_history_model.dart';
import '../services/market_local_datasource.dart';

class MarketRepository {
  final MarketLocalDataSource _dataSource;

  Map<String, List<StockHistoryModel>> _historyCache = {};
  bool _isInitialized = false;

  MarketRepository(this._dataSource);

  Future<void> init() async {
    if (_isInitialized) return;
    _historyCache = await _dataSource.loadJsonHistory();
    _isInitialized = true;
  }

  Future<void> nextDay() async {
    if (!_isInitialized) await init();

    final user = await _dataSource.getUserProfile();
    if (user == null) return;

    DateTime currentDate = user.currentSimulationDate ?? .new(2025, 1, 1);

    final sampleTicker = _historyCache.keys.first;
    final historyList = _historyCache[sampleTicker]!;

    int currentIndex = historyList.indexWhere(
      (h) => h.date.isAfter(currentDate),
    );

    if (currentIndex == -1) {
      return;
    }

    final nextDate = historyList[currentIndex].date;

    List<StocksCompanion> updatedStocks = [];

    for (String ticker in _historyCache.keys) {
      final tickerHistory = _historyCache[ticker]!;
      final dataPoint = tickerHistory.firstWhere(
        (h) => h.date == nextDate,
        orElse: () => tickerHistory.last,
      );

      final prevIndex = tickerHistory.indexWhere((h) => h.date == nextDate) - 1;
      final prevDataPoint = prevIndex >= 0
          ? tickerHistory[prevIndex]
          : dataPoint;

      updatedStocks.add(
        StocksCompanion(
          ticker: .new(ticker),
          name: .new(ticker),
          description: const .new(''),
          currentPrice: .new(dataPoint.close),
          previousPrice: .new(prevDataPoint.close),
          volume: .new(dataPoint.volume),
        ),
      );
    }

    await _dataSource.updateSimulationDate(nextDate);
    await _dataSource.updateStockPrices(updatedStocks);
  }

  Future<void> buyStock(String ticker, int lots) async {
    final user = await _dataSource.getUserProfile();
    final stock = await _dataSource.getStock(ticker);

    if (user == null || stock == null) throw Exception("Data not found");

    final pricePerLot = stock.currentPrice * 100;
    final totalCost = pricePerLot * lots;

    if (user.balance < totalCost) {
      throw Exception("Insufficient balance");
    }

    final newBalance = user.balance - totalCost;

    final currentPortfolio = await _dataSource.getPortfolio(ticker);
    int newTotalLots = lots;
    double newAveragePrice = stock.currentPrice;

    if (currentPortfolio != null) {
      newTotalLots += currentPortfolio.totalLots;
      final oldTotalValue =
          currentPortfolio.totalLots * currentPortfolio.averageBuyPrice * 100;
      newAveragePrice = ((oldTotalValue + totalCost) / newTotalLots) / 100;
    }

    final TransactionsCompanion transaction = .insert(
      ticker: .new(ticker),
      type: 'BUY',
      lots: .new(lots),
      pricePerLot: .new(stock.currentPrice),
      totalAmount: totalCost,
    );

    await _dataSource.executeTrade(
      newBalance: newBalance,
      transaction: transaction,
      ticker: ticker,
      updatedLots: newTotalLots,
      updatedAveragePrice: newAveragePrice,
    );
  }

  Future<void> sellStock(String ticker, int lots) async {
    final user = await _dataSource.getUserProfile();
    final stock = await _dataSource.getStock(ticker);
    final portfolio = await _dataSource.getPortfolio(ticker);

    if (user == null || stock == null || portfolio == null) {
      throw Exception("Data not found");
    }

    if (portfolio.totalLots < lots) {
      throw Exception("Not enough lots to sell");
    }

    final pricePerLot = stock.currentPrice * 100;
    final totalRevenue = pricePerLot * lots;
    final newBalance = user.balance + totalRevenue;
    final newTotalLots = portfolio.totalLots - lots;

    final TransactionsCompanion transaction = .insert(
      ticker: .new(ticker),
      type: 'SELL',
      lots: .new(lots),
      pricePerLot: .new(stock.currentPrice),
      totalAmount: totalRevenue,
    );

    await _dataSource.executeTrade(
      newBalance: newBalance,
      transaction: transaction,
      ticker: ticker,
      updatedLots: newTotalLots,
      updatedAveragePrice: portfolio.averageBuyPrice,
    );
  }

  Future<List<StockHistoryModel>> getChartData(
    String ticker,
    int daysBack,
  ) async {
    if (!_isInitialized) await init();

    final user = await _dataSource.getUserProfile();
    if (user == null) return [];

    final currentDate = user.currentSimulationDate ?? DateTime(2025, 1, 1);
    final historyList = _historyCache[ticker] ?? [];

    final pastData = historyList
        .where(
          (h) =>
              h.date.isBefore(currentDate) ||
              h.date.isAtSameMomentAs(currentDate),
        )
        .toList();

    if (pastData.length <= daysBack) {
      return pastData;
    }

    return pastData.sublist(pastData.length - daysBack);
  }
}
