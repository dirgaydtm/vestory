import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers/core_providers.dart';
import '../models/user_model.dart';
import '../services/user_local_datasource.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(
    localDataSource: ref.read(userLocalDataSourceProvider),
    prefs: ref.read(sharedPreferencesProvider),
  );
});

abstract class UserRepository {
  Future<void> saveUserProfile(UserModel user);
  Future<UserModel?> getUserProfile();
  Future<void> setOnboardingSeen();
}

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final SharedPreferences prefs;

  UserRepositoryImpl({required this.localDataSource, required this.prefs});

  @override
  Future<void> saveUserProfile(UserModel user) async {
    await localDataSource.saveUser(user);
  }

  @override
  Future<UserModel?> getUserProfile() async {
    return await localDataSource.getUser();
  }

  @override
  Future<void> setOnboardingSeen() async {
    await prefs.setBool('has_seen_onboarding', true);
  }
}
