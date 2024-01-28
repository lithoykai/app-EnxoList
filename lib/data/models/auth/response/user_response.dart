class UserResponse {
  String? id;
  String email;
  String? name;
  String? _token;

  UserResponse({
    this.id,
    required this.email,
    this.name,
  });

  String get token => _token!;

  set token(String token) {
    _token = token;
  }

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      email: json['email'],
      id: json['id'],
      name: json['name'] ?? '',
    );
  }
}
