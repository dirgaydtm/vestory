import 'package:drift/drift.dart';

class Portfolios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ticker => text()();
  IntColumn get totalLots => integer()();
  RealColumn get averageBuyPrice => real()();
}
