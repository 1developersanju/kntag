// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    required this.users,
  });

  Users users;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "users": users.toJson(),
      };
}

class Users {
  Users({
    required this.gboLlJif6YUr6Df0WvbwtQeDc6S2,
    required this.h5OsagvouCbnDMmyqNeHCnxVlCx1,
  });

  GboLlJif6YUr6Df0WvbwtQeDc6S2 gboLlJif6YUr6Df0WvbwtQeDc6S2;
  H5OsagvouCbnDMmyqNeHCnxVlCx1 h5OsagvouCbnDMmyqNeHCnxVlCx1;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        gboLlJif6YUr6Df0WvbwtQeDc6S2: GboLlJif6YUr6Df0WvbwtQeDc6S2.fromJson(
            json["GboLlJIF6yUr6df0WVBWTQeDC6S2"]),
        h5OsagvouCbnDMmyqNeHCnxVlCx1: H5OsagvouCbnDMmyqNeHCnxVlCx1.fromJson(
            json["h5OSAGVOUCbnDMmyqNeHCnxVLCx1"]),
      );

  Map<String, dynamic> toJson() => {
        "GboLlJIF6yUr6df0WVBWTQeDC6S2": gboLlJif6YUr6Df0WvbwtQeDc6S2.toJson(),
        "h5OSAGVOUCbnDMmyqNeHCnxVLCx1": h5OsagvouCbnDMmyqNeHCnxVlCx1.toJson(),
      };
}

class GboLlJif6YUr6Df0WvbwtQeDc6S2 {
  GboLlJif6YUr6Df0WvbwtQeDc6S2({
    required this.description,
    required this.joinedTags,
    required this.profileImage,
    required this.userName,
    required this.createdTags,
    required this.totaljoinedtags,
    required this.totaltags,
  });

  String description;
  List<String> joinedTags;
  String profileImage;
  String userName;
  List<String> createdTags;
  int totaljoinedtags;
  int totaltags;

  factory GboLlJif6YUr6Df0WvbwtQeDc6S2.fromJson(Map<String, dynamic> json) =>
      GboLlJif6YUr6Df0WvbwtQeDc6S2(
        description: json["Description"],
        joinedTags: List<String>.from(
            json["JoinedTags"].map((x) => x == null ? null : x)),
        profileImage: json["ProfileImage"],
        userName: json["UserName"],
        createdTags: List<String>.from(
            json["createdTags"].map((x) => x == null ? null : x)),
        totaljoinedtags: json["totaljoinedtags"],
        totaltags: json["totaltags"],
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "JoinedTags":
            List<dynamic>.from(joinedTags.map((x) => x == null ? null : x)),
        "ProfileImage": profileImage,
        "UserName": userName,
        "createdTags":
            List<dynamic>.from(createdTags.map((x) => x == null ? null : x)),
        "totaljoinedtags": totaljoinedtags,
        "totaltags": totaltags,
      };
}

class H5OsagvouCbnDMmyqNeHCnxVlCx1 {
  H5OsagvouCbnDMmyqNeHCnxVlCx1({
    required this.description,
    required this.joinedTags,
    required this.profileImage,
    required this.userName,
    required this.createdTags,
    required this.totaljoinedtags,
    required this.totaltags,
  });

  String description;
  String joinedTags;
  String profileImage;
  String userName;
  List<String> createdTags;
  int totaljoinedtags;
  int totaltags;

  factory H5OsagvouCbnDMmyqNeHCnxVlCx1.fromJson(Map<String, dynamic> json) =>
      H5OsagvouCbnDMmyqNeHCnxVlCx1(
        description: json["Description"],
        joinedTags: json["JoinedTags"],
        profileImage: json["ProfileImage"],
        userName: json["UserName"],
        createdTags: List<String>.from(
            json["createdTags"].map((x) => x == null ? null : x)),
        totaljoinedtags: json["totaljoinedtags"],
        totaltags: json["totaltags"],
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "JoinedTags": joinedTags,
        "ProfileImage": profileImage,
        "UserName": userName,
        "createdTags":
            List<dynamic>.from(createdTags.map((x) => x == null ? null : x)),
        "totaljoinedtags": totaljoinedtags,
        "totaltags": totaltags,
      };
}
