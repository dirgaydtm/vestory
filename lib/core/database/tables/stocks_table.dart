import 'package:drift/drift.dart';

class Stocks extends Table {
  TextColumn get ticker => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  RealColumn get currentPrice => real()();
  RealColumn get previousPrice => real()();
  IntColumn get volume => integer()();

  @override
  Set<Column> get primaryKey => {ticker};
}
