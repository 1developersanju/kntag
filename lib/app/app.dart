class User {
  String username;
  String about;
  List createdtags;
  List joinedtags;
  String profileimg;

  User({
    required this.createdtags,
    required this.about,
    required this.joinedtags,
    required this.username,
    required this.profileimg,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "profileimg": profileimg,
        "about": about,
        "joinedtags": joinedtags,
        "createdtags": createdtags,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        createdtags: json["createdtags"],
        joinedtags: json["joinedtags"],
        about: json["about"],
        profileimg: json["profileimg"],
      );
}
