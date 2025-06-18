class AuthDTO {
  final String accessToken;

  const AuthDTO({required this.accessToken});

  factory AuthDTO.fromJson(Map<String, dynamic> json) {
    return AuthDTO(accessToken: json['access_token']);
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken
  };
}
