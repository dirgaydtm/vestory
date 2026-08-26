// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_dao.dart';

// ignore_for_file: type=lint
mixin _$MissionDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClaimedMissionsTable get claimedMissions => attachedDatabase.claimedMissions;
  MissionDaoManager get managers => MissionDaoManager(this);
}

class MissionDaoManager {
  final _$MissionDaoMixin _db;
  MissionDaoManager(this._db);
  $$ClaimedMissionsTableTableManager get claimedMissions =>
      $$ClaimedMissionsTableTableManager(
        _db.attachedDatabase,
        _db.claimedMissions,
      );
}
