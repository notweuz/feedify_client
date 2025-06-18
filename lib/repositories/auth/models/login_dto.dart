class LoginDTO {
  final String username;
  final String password;

  const LoginDTO({
    required this.username,
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password
  };
}