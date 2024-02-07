class UserEntity {
  String id;
  String email;
  String name;
  String token;
  DateTime expiryDate;

  UserEntity({
    required this.email,
    required this.name,
    required this.id,
    required this.token,
    required this.expiryDate,
  });
}
