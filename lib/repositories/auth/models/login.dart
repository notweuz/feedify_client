class Login {
  final String username;
  final String password;

  const Login({
    required this.username,
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password
  };
}