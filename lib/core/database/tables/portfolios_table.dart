import 'package:drift/drift.dart';

class Portfolios extends Table {
  TextColumn get ticker => text()();
  IntColumn get totalLots => integer()();
  RealColumn get averageBuyPrice => real()();

  @override
  Set<Column> get primaryKey => {ticker};
}
