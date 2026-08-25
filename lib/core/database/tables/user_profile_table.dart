import 'package:drift/drift.dart';

class UserProfile extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get playStyle => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
