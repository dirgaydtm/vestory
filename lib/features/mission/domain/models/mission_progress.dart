import 'mission_model.dart';

class MissionProgress {
  final MissionModel mission;
  final double currentValue;
  final bool isCompleted;
  final bool isClaimed;

  const MissionProgress({
    required this.mission,
    required this.currentValue,
    required this.isCompleted,
    required this.isClaimed,
  });
}
