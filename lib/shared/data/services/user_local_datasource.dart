import 'package:drift/drift.dart' as drift;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/daos/user_profile_dao.dart';
import '../../../core/providers/core_providers.dart';
import '../models/user_model.dart';

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  final db = ref.read(databaseProvider);
  return UserLocalDataSourceImpl(dao: db.userProfileDao);
});

abstract class UserLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Stream<UserModel?> watchUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final UserProfileDao dao;

  UserLocalDataSourceImpl({required this.dao});

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      await dao.saveUserProfile(
        UserProfileCompanion.insert(
          name: user.name,
          playStyle: user.playStyle,
          balance: drift.Value(user.balance),
        ),
      );
    } catch (e) {
      debugPrint('Drift DB Error: $e');
    }
  }

  @override
  Future<UserModel?> getUser() async {
    final user = await dao.getUserProfile();
    if (user == null) return null;

    return UserModel(
      id: user.id,
      name: user.name,
      playStyle: user.playStyle,
      balance: user.balance,
      currentSimulationDate: user.currentSimulationDate,
      createdAt: user.createdAt,
    );
  }

  @override
  Stream<UserModel?> watchUser() {
    return dao.watchUserProfile().map((user) {
      if (user == null) return null;
      return UserModel(
        id: user.id,
        name: user.name,
        playStyle: user.playStyle,
        balance: user.balance,
        currentSimulationDate: user.currentSimulationDate,
        createdAt: user.createdAt,
      );
    });
  }
}
