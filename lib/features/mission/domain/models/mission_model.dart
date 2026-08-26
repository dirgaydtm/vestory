enum MissionType { targetProfit, targetTotalEquity, buySpecificStock }

class MissionModel {
  final String id;
  final String title;
  final String description;
  final MissionType type;
  final double targetValue;
  final String? targetTicker;
  final double rewardMoney;
  final String achievementName;
  final String feedback;

  const MissionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.targetValue,
    this.targetTicker,
    required this.rewardMoney,
    required this.achievementName,
    required this.feedback,
  });
}
