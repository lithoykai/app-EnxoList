class AuthRequest {
  String email;
  String? name;
  String password;
  String? coupleEmail;

  AuthRequest(
      {required this.email,
      required this.password,
      this.name,
      this.coupleEmail});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'name': name ?? '',
      'role': name == null ? '' : 'USER',
      'coupleEmail': coupleEmail ?? '',
    };
    return data;
  }

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      coupleEmail: json['coupleEmail'],
    );
  }
}
