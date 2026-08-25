class UserModel {
  final int? id;
  final String name;
  final String playStyle;
  final DateTime? createdAt;

  const UserModel({
    this.id,
    required this.name,
    required this.playStyle,
    this.createdAt,
  });
}
