import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/claimed_missions_table.dart';

part 'mission_dao.g.dart';

@DriftAccessor(tables: [ClaimedMissions])
class MissionDao extends DatabaseAccessor<AppDatabase> with _$MissionDaoMixin {
  MissionDao(super.db);

  Stream<List<ClaimedMission>> watchClaimedMissions() {
    return select(claimedMissions).watch();
  }

  Future<void> claimMission(ClaimedMission mission) {
    return into(claimedMissions).insert(mission);
  }
}
