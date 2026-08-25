import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/portfolios_table.dart';
import '../tables/stocks_table.dart';
import '../tables/transactions_table.dart';
import '../tables/user_profile_table.dart';

part 'market_dao.g.dart';

@DriftAccessor(tables: [Stocks, Portfolios, Transactions, UserProfile])
class MarketDao extends DatabaseAccessor<AppDatabase> with _$MarketDaoMixin {
  MarketDao(super.db);

  Future<void> updateSimulationDate(DateTime newDate) =>
      update(userProfile)
          .write(UserProfileCompanion(currentSimulationDate: .new(newDate)));

  Future<void> updateStockPrices(List<StocksCompanion> stocksList) =>
      batch((b) => b.insertAll(stocks, stocksList, mode: .insertOrReplace));

  Future<void> executeTrade({
    required double newBalance,
    required TransactionsCompanion transactionRecord,
    required String ticker,
    required int updatedLots,
    required double updatedAveragePrice,
  }) async {
    await transaction(() async {
      await update(userProfile)
          .write(UserProfileCompanion(balance: .new(newBalance)));

      await into(transactions).insert(transactionRecord);

      if (updatedLots > 0) {
        await into(portfolios).insert(
          PortfoliosCompanion(
            ticker: .new(ticker),
            totalLots: .new(updatedLots),
            averageBuyPrice: .new(updatedAveragePrice),
          ),
          mode: .insertOrReplace,
        );
      } else {
        await (delete(portfolios)..where((t) => t.ticker.equals(ticker))).go();
      }
    });
  }

  Future<Portfolio?> getPortfolio(String ticker) => (select(
    portfolios,
  )..where((t) => t.ticker.equals(ticker))).getSingleOrNull();

  Future<Stock?> getStock(String ticker) =>
      (select(stocks)..where((t) => t.ticker.equals(ticker))).getSingleOrNull();

  Stream<List<Stock>> watchAllStocks() => select(stocks).watch();

  Stream<List<Portfolio>> watchAllPortfolios() => select(portfolios).watch();
}
