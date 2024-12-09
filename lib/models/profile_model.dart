class Profile {
  final String username;
  final String profilePhoto;
  final int followers;
  final int following;
  final int likes;
  final bool isFollowing;
  final List<String> thumbnails;

  Profile({
    required this.username,
    required this.profilePhoto,
    required this.followers,
    required this.following,
    required this.likes,
    required this.isFollowing,
    required this.thumbnails,
  });
}