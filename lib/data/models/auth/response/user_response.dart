class UserResponse {
  String? id;
  String email;
  String? token;
  int? expiryDate;

  UserResponse({this.id, required this.email, this.token, this.expiryDate});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      email: json['email'],
      id: json['id'],
      token: json['token'] ?? '',
      expiryDate: json['expiryDate'],
    );
  }
}
