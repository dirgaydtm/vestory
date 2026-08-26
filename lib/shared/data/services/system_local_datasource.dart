import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';

final systemLocalDataSourceProvider = Provider<SystemLocalDataSource>((ref) {
  final db = ref.read(databaseProvider);
  return SystemLocalDataSourceImpl(db: db);
});

abstract class SystemLocalDataSource {
  Future<void> clearAllData();
}

class SystemLocalDataSourceImpl implements SystemLocalDataSource {
  final AppDatabase db;

  SystemLocalDataSourceImpl({required this.db});

  @override
  Future<void> clearAllData() async {
    await db.clearAllTables();
  }
}
