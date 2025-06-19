class User {
  final int id;
  final String? displayName;
  final String username;
  final String description;
  final String? avatarUrl;
  final DateTime registrationDate;
  final int followersCount;
  final int followingCount;

  const User({
    required this.id,
    required this.displayName,
    required this.username,
    required this.description,
    required this.avatarUrl,
    required this.registrationDate,
    required this.followersCount,
    required this.followingCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      displayName: json["display_name"],
      username: json["username"],
      description: json["description"],
      avatarUrl: json["avatar_url"],
      registrationDate: DateTime.parse(json["registration_date"]),
      followersCount: json["followers_count"],
      followingCount: json["following_count"],
    );
  }
}
