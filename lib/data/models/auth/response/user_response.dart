import 'package:enxolist/data/models/auth/user_mapper.dart';
import 'package:enxolist/domain/entities/user/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_response.g.dart';

@HiveType(typeId: 0)
class UserResponse extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String name;
  @HiveField(3)
  String token;
  @HiveField(4)
  DateTime expiryDate;
  @HiveField(5)
  String? userCoupleId;
  @HiveField(6)
  bool? isCouple = false;

  UserResponse({
    required this.id,
    required this.email,
    required this.token,
    required this.expiryDate,
    required this.name,
    this.userCoupleId,
    this.isCouple = false,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      token: json['token'] ?? '',
      expiryDate: DateTime.now().add(Duration(hours: json['expiryDate'])),
      userCoupleId: json['userCoupleId'],
      isCouple: json['isCouple'],
    );
  }

  Map<String, dynamic> toJson() => {};
  factory UserResponse.fromEntity(UserEntity entity) =>
      $UserModelFromEntity(entity);
  UserEntity toEntity() => $UserEntityFromModel(this);
}
