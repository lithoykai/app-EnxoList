class RegisterRequest {
  String email;
  String name;
  String password;

  RegisterRequest(
      {required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'password': password,
    };

    return data;
  }
}
