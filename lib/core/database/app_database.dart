import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;
import 'daos/user_profile_dao.dart';
import 'tables/user_profile_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [UserProfile], daos: [UserProfileDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
}
