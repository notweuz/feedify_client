class AuthStatus {
  final bool active;

  const AuthStatus({required this.active});

  factory AuthStatus.fromJson(Map<String, dynamic> json) {
    return AuthStatus(active: json['active']);
  }
}
