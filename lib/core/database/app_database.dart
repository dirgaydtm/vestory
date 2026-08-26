import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;
import 'daos/user_profile_dao.dart';
import 'daos/market_dao.dart';
import 'daos/mission_dao.dart';
import 'tables/user_profile_table.dart';
import 'tables/stocks_table.dart';
import 'tables/portfolios_table.dart';
import 'tables/transactions_table.dart';
import 'tables/claimed_missions_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [UserProfile, Stocks, Portfolios, Transactions, ClaimedMissions],
  daos: [UserProfileDao, MarketDao, MissionDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  AppDatabase.forTesting(super.connection);

  @override
  int get schemaVersion => 1;

  Future<void> clearAllTables() async {
    await transaction(() async {
      await delete(userProfile).go();
      await delete(stocks).go();
      await delete(portfolios).go();
      await delete(transactions).go();
      await delete(claimedMissions).go();
    });
  }
}
