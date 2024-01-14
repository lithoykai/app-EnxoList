class User {
  String? id;
  String email;
  String? name;
  String? _token;

  User({required this.email, this.name});

  String? get token => _token;
}
