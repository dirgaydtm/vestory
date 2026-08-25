import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/user_profile_table.dart';

part 'user_profile_dao.g.dart';

@DriftAccessor(tables: [UserProfile])
class UserProfileDao extends DatabaseAccessor<AppDatabase>
    with _$UserProfileDaoMixin {
  UserProfileDao(super.db);

  Future<void> saveUserProfile(UserProfileCompanion entry) async {
    await delete(userProfile).go();
    await into(userProfile).insert(entry);
  }

  Future<UserProfileData?> getUserProfile() {
    return (select(userProfile)..limit(1)).getSingleOrNull();
  }
}
