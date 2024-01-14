class AuthRequest {
  String email;
  String? name;
  String password;

  AuthRequest({required this.email, required this.password, this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'name': name ?? ''
    };
    return data;
  }
}
