import 'package:hive_flutter/hive_flutter.dart';

part 'user_DTO.g.dart';

@HiveType(typeId: 1)
class UserDTO {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;

  UserDTO({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
