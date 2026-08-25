// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_dao.dart';

// ignore_for_file: type=lint
mixin _$MarketDaoMixin on DatabaseAccessor<AppDatabase> {
  $StocksTable get stocks => attachedDatabase.stocks;
  $PortfoliosTable get portfolios => attachedDatabase.portfolios;
  $TransactionsTable get transactions => attachedDatabase.transactions;
  $UserProfileTable get userProfile => attachedDatabase.userProfile;
  MarketDaoManager get managers => MarketDaoManager(this);
}

class MarketDaoManager {
  final _$MarketDaoMixin _db;
  MarketDaoManager(this._db);
  $$StocksTableTableManager get stocks =>
      $$StocksTableTableManager(_db.attachedDatabase, _db.stocks);
  $$PortfoliosTableTableManager get portfolios =>
      $$PortfoliosTableTableManager(_db.attachedDatabase, _db.portfolios);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db.attachedDatabase, _db.transactions);
  $$UserProfileTableTableManager get userProfile =>
      $$UserProfileTableTableManager(_db.attachedDatabase, _db.userProfile);
}
