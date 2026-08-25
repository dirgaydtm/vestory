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

  Future<UserProfileData?> getUserProfile() =>
      select(userProfile).getSingleOrNull();

  Future<void> updateSimulationDate(DateTime newDate) =>
      update(userProfile)
          .write(UserProfileCompanion(currentSimulationDate: Value(newDate)));

  Future<void> updateStockPrices(List<StocksCompanion> stocksList) => batch(
    (b) => b.insertAll(stocks, stocksList, mode: InsertMode.insertOrReplace),
  );

  Future<void> executeTrade({
    required double newBalance,
    required TransactionsCompanion transactionRecord,
    required String ticker,
    required int updatedLots,
    required double updatedAveragePrice,
  }) async {
    await transaction(() async {
      await update(userProfile)
          .write(UserProfileCompanion(balance: Value(newBalance)));

      await into(transactions).insert(transactionRecord);

      if (updatedLots > 0) {
        await into(portfolios).insert(
          PortfoliosCompanion(
            ticker: Value(ticker),
            totalLots: Value(updatedLots),
            averageBuyPrice: Value(updatedAveragePrice),
          ),
          mode: InsertMode.insertOrReplace,
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
}
