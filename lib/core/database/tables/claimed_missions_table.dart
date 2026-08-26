import 'package:drift/drift.dart';

class ClaimedMissions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get claimedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
