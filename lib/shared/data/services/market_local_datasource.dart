import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/market_dao.dart';
import '../models/stock_history_model.dart';

class MarketLocalDataSource {
  final MarketDao _dao;

  MarketLocalDataSource(this._dao);

  Future<Map<String, List<StockHistoryModel>>> loadJsonHistory() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/market_history.json',
    );
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    final Map<String, List<StockHistoryModel>> result = {};
    jsonMap.forEach((ticker, historyList) {
      final list = historyList as List<dynamic>;
      result[ticker] = list
          .map((e) => StockHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    return result;
  }

  Stream<List<Stock>> watchAllStocks() => _dao.watchAllStocks();
  Stream<List<Portfolio>> watchAllPortfolios() => _dao.watchAllPortfolios();

  Future<void> updateSimulationDate(DateTime newDate) =>
      _dao.updateSimulationDate(newDate);

  Future<void> updateStockPrices(List<StocksCompanion> stocks) =>
      _dao.updateStockPrices(stocks);

  Future<void> executeTrade({
    required double newBalance,
    required TransactionsCompanion transaction,
    required String ticker,
    required int updatedLots,
    required double updatedAveragePrice,
  }) => _dao.executeTrade(
    newBalance: newBalance,
    transactionRecord: transaction,
    ticker: ticker,
    updatedLots: updatedLots,
    updatedAveragePrice: updatedAveragePrice,
  );

  Future<Portfolio?> getPortfolio(String ticker) => _dao.getPortfolio(ticker);

  Future<Stock?> getStock(String ticker) => _dao.getStock(ticker);
}
