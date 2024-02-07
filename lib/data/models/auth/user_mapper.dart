import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/domain/entities/user/user_entity.dart';

UserResponse $UserModelFromEntity(UserEntity entity) {
  return UserResponse(
    id: entity.id,
    email: entity.email,
    token: entity.token,
    expiryDate: entity.expiryDate,
    name: entity.name,
  );
}

UserEntity $UserEntityFromModel(UserResponse model) {
  return UserEntity(
      email: model.email,
      name: model.name,
      id: model.id,
      token: model.token,
      expiryDate: model.expiryDate);
}
