import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers/core_providers.dart';
import '../services/system_local_datasource.dart';

final systemRepositoryProvider = Provider<SystemRepository>((ref) {
  return SystemRepositoryImpl(
    localDataSource: ref.read(systemLocalDataSourceProvider),
    prefs: ref.read(sharedPreferencesProvider),
  );
});

abstract class SystemRepository {
  Future<void> resetAllData();
}

class SystemRepositoryImpl implements SystemRepository {
  final SystemLocalDataSource localDataSource;
  final SharedPreferences prefs;

  SystemRepositoryImpl({required this.localDataSource, required this.prefs});

  @override
  Future<void> resetAllData() async {
    await localDataSource.clearAllData();
    await prefs.remove('has_seen_onboarding');
    await prefs.remove('notifications_enabled');
  }
}
