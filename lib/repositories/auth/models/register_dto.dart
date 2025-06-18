class RegisterDTO {
  final String? displayName;
  final String username;
  final String password;

  const RegisterDTO({
    this.displayName,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'display_name': displayName,
    'username': username,
    'password': password,
  };
}
