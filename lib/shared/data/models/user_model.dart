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

  UserModel copyWith({
    int? id,
    String? name,
    String? playStyle,
    double? balance,
    DateTime? currentSimulationDate,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      playStyle: playStyle ?? this.playStyle,
      balance: balance ?? this.balance,
      currentSimulationDate:
          currentSimulationDate ?? this.currentSimulationDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
