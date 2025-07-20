class Register {
  final String? displayName;
  final String username;
  final String password;

  const Register({
    this.displayName,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'display_name': (displayName != null && displayName!.isEmpty) ? null : displayName,
    'username': username,
    'password': password,
  };
}
