class AuthStatusDTO {
  final bool active;

  const AuthStatusDTO({required this.active});

  factory AuthStatusDTO.fromJson(Map<String, dynamic> json) {
    return AuthStatusDTO(active: json['active']);
  }
}
