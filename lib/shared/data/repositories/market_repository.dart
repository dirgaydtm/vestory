import '../../../core/database/app_database.dart';
import '../models/stock_history_model.dart';
import '../services/market_local_datasource.dart';
import 'user_repository.dart';

class MarketRepository {
  final MarketLocalDataSource _dataSource;
  final UserRepository _userRepository;

  Map<String, List<StockHistoryModel>> _historyCache = {};
  bool _isInitialized = false;

  MarketRepository(this._dataSource, this._userRepository);

  Future<void> init() async {
    if (_isInitialized) return;
    _historyCache = await _dataSource.loadJsonHistory();

    final user = await _userRepository.getUserProfile();
    final currentDate = user?.currentSimulationDate ?? .new(2026, 1, 1);

    final currentStocks = await _dataSource.watchAllStocks().first;

    bool needsReseed = currentStocks.isEmpty;
    if (!needsReseed && currentDate == DateTime(2026, 1, 1)) {
      if (currentStocks.every((s) => s.previousPrice == s.currentPrice)) {
        needsReseed = true;
      }
    }

    if (needsReseed) {
      await _seedInitialStocks(currentDate);
    }

    _isInitialized = true;
  }

  StocksCompanion _createStockCompanion(
    String ticker,
    StockHistoryModel currentPoint,
    StockHistoryModel prevPoint,
  ) {
    return StocksCompanion(
      ticker: .new(ticker),
      name: .new(ticker),
      description: const .new(''),
      currentPrice: .new(currentPoint.close),
      previousPrice: .new(prevPoint.close),
      volume: .new(currentPoint.volume.toInt()),
    );
  }

  Future<void> _seedInitialStocks(DateTime currentDate) async {
    final sampleHistory = _historyCache.values.first;
    int idx = sampleHistory.indexWhere(
      (h) =>
          h.date.isAfter(currentDate) || h.date.isAtSameMomentAs(currentDate),
    );
    if (idx == -1) idx = sampleHistory.length - 1;

    final prevIdx = idx > 0 ? idx - 1 : idx;

    final initialStocks = _historyCache.keys.map((ticker) {
      final history = _historyCache[ticker]!;
      return _createStockCompanion(ticker, history[idx], history[prevIdx]);
    }).toList();

    await _dataSource.updateStockPrices(initialStocks);
    await _dataSource.updateSimulationDate(sampleHistory[idx].date);
  }

  Future<void> nextDay() async {
    if (!_isInitialized) await init();

    final user = await _userRepository.getUserProfile();
    if (user == null) return;

    DateTime currentDate = user.currentSimulationDate ?? .new(2026, 1, 1);

    final sampleHistory = _historyCache.values.first;
    final nextIdx = sampleHistory.indexWhere(
      (h) => h.date.isAfter(currentDate),
    );

    if (nextIdx == -1) return;

    final nextDate = sampleHistory[nextIdx].date;
    final prevIdx = nextIdx > 0 ? nextIdx - 1 : nextIdx;

    final updatedStocks = _historyCache.keys.map((ticker) {
      final history = _historyCache[ticker]!;
      return _createStockCompanion(ticker, history[nextIdx], history[prevIdx]);
    }).toList();

    await _dataSource.updateSimulationDate(nextDate);
    await _dataSource.updateStockPrices(updatedStocks);
  }

  Future<void> buyStock(String ticker, int lots) async {
    final user = await _userRepository.getUserProfile();
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
    final user = await _userRepository.getUserProfile();
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

    final user = await _userRepository.getUserProfile();
    if (user == null) return [];

    final currentDate = user.currentSimulationDate ?? DateTime(2026, 1, 1);
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
