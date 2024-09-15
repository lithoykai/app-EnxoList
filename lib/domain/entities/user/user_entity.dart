class UserEntity {
  String id;
  String email;
  String name;
  String token;
  DateTime expiryDate;
  String? userCoupleId;
  bool isCouple = false;

  UserEntity({
    required this.email,
    required this.name,
    required this.id,
    required this.token,
    required this.expiryDate,
    required this.userCoupleId,
    required this.isCouple,
  });
}
