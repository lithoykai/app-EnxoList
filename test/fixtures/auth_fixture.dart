import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';

AuthRequest authRequest = AuthRequest(
  email: 'teste@teste.com',
  password: 'teste123',
);

UserResponse fakeUserResponse = UserResponse(
    id: "65a2c8aa3c50904ce685f7ae",
    email: "admin@teste.com",
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhdXRoLWFwaSIsInN1YiI6ImFkbWluQHRlc3RlLmNvbSIsImV4cCI6MTcwNjU3NzA5NH0.RQP_O6_focb5hohFiFCf5uvCBuE2i-ivb7CVJgom-lw",
    expiryDate: DateTime.now().add(Duration(hours: 720)),
    name: "Teste");

Map<String, dynamic> fakeUserHttpResponse = {
  "id": "65a2c8aa3c50904ce685f7ae",
  "name": "Teste",
  "email": "admin@teste.com",
  "token":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhdXRoLWFwaSIsInN1YiI6ImFkbWluQHRlc3RlLmNvbSIsImV4cCI6MTcwNjU3NzA5NH0.RQP_O6_focb5hohFiFCf5uvCBuE2i-ivb7CVJgom-lw",
  "expiryDate": 2
};
