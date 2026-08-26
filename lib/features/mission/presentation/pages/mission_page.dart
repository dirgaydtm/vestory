import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/mission_progress.dart';
import '../providers/mission_provider.dart';
import '../widgets/mission_detail_tile.dart';
import '../widgets/mission_list_tile.dart';
import '../widgets/mission_summary_card.dart';

class MissionPage extends ConsumerStatefulWidget {
  const MissionPage({super.key});

  @override
  ConsumerState<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends ConsumerState<MissionPage> {
  int _expandedIndex = -1;

  void _toggleExpand(int index) {
    setState(() => _expandedIndex = _expandedIndex == index ? -1 : index);
  }

  @override
  Widget build(BuildContext context) {
    final missionList = ref.watch(missionProgressListProvider);
    final claimedCount = ref.watch(claimedCountProvider);

    final currentMissions =
        missionList?.where((p) => !p.isCompleted).take(3).toList() ?? [];

    return Scaffold(
      backgroundColor: AppColors.baseBackground,
      body: SafeArea(
        child: missionList == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: .fromLTRB(20, 24, 20, 40),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    MissionSummaryCard(
                      claimedCount: claimedCount,
                      totalCount: missionList.length,
                    ),
                    SizedBox(height: 24),
                    if (currentMissions.isNotEmpty) ...[
                      Text(
                        'Misi Saat Ini',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w700,
                          color: AppColors.textHeading,
                        ),
                      ),
                      SizedBox(height: 10),
                      _MisiSaatIniCard(
                        missions: currentMissions,
                        allMissions: missionList,
                      ),
                      SizedBox(height: 24),
                    ],
                    Text(
                      'Detail Misi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w700,
                        color: AppColors.textHeading,
                      ),
                    ),
                    SizedBox(height: 10),
                    ...List.generate(missionList.length, (i) {
                      return Padding(
                        padding: .only(
                          bottom: i < missionList.length - 1 ? 10 : 0,
                        ),
                        child: MissionDetailTile(
                          progress: missionList[i],
                          isExpanded: _expandedIndex == i,
                          onToggle: () => _toggleExpand(i),
                        ),
                      );
                    }),
                  ],
                ),
              ),
      ),
    );
  }
}

class _MisiSaatIniCard extends StatelessWidget {
  final List<MissionProgress> missions;
  final List<MissionProgress> allMissions;

  const _MisiSaatIniCard({required this.missions, required this.allMissions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(14),
      decoration: BoxDecoration(
        color: AppColors.baseWhite,
        borderRadius: .circular(16),
        border: .all(color: AppColors.neutralNormal, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.baseBlack.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(missions.length, (i) {
          return Padding(
            padding: .only(bottom: i < missions.length - 1 ? 8 : 0),
            child: MissionListTile(
              index: allMissions.indexOf(missions[i]) + 1,
              progress: missions[i],
              showCheck: missions[i].isClaimed,
            ),
          );
        }),
      ),
    );
  }
}
