import 'package:drift/drift.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ticker => text().nullable()(); // Nullable because a transaction might just be a DEPOSIT/WITHDRAW
  TextColumn get type => text()(); // e.g. BUY, SELL, DEPOSIT, WITHDRAW
  IntColumn get lots => integer().nullable()();
  RealColumn get pricePerLot => real().nullable()();
  RealColumn get totalAmount => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
