class UserModel {
  final int? id;
  final String name;
  final String playStyle;
  final DateTime? createdAt;
  final double balance;
  final DateTime? currentSimulationDate;

  const UserModel({
    this.id,
    required this.name,
    required this.playStyle,
    required this.balance,
    this.currentSimulationDate,
    this.createdAt,
  });
}
