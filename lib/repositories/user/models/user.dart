class User {
  final int id;
  final String? displayName;
  final String username;
  final String description;
  final String? avatarUrl;
  final String? bannerUrl;
  final DateTime registrationDate;
  final int postsCount;
  final int followersCount;
  final int followingCount;

  const User({
    required this.id,
    this.displayName,
    required this.username,
    required this.description,
    this.avatarUrl,
    this.bannerUrl,
    required this.registrationDate,
    required this.postsCount,
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
      bannerUrl: json["banner_url"],
      registrationDate: DateTime.parse(json["registration_date"]),
      postsCount: json['posts_count'],
      followersCount: json["followers_count"],
      followingCount: json["following_count"],
    );
  }
}
