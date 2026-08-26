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

  String get progressText {
    final curr = currentValue.clamp(0, mission.targetValue);
    if (mission.targetValue <= 1) {
      return '${curr.toInt()}/${mission.targetValue.toInt()}';
    }
    String fmt(double v) {
      if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(0)}jt';
      if (v >= 1000) return '${(v / 1000).toStringAsFixed(0)}rb';
      return v.toStringAsFixed(0);
    }

    return '${fmt(curr.toDouble())}/${fmt(mission.targetValue)}';
  }

  double get progressRatio {
    if (mission.targetValue == 0) return 1.0;
    return (currentValue / mission.targetValue).clamp(0.0, 1.0);
  }
}
