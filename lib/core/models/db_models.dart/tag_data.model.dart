// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'dart:convert';

VideoModel videoModelFromJson(String str) =>
    VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  VideoModel({
    required this.tags,
  });

  Map<String, Tag> tags;

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        tags: Map.from(json["tags"])
            .map((k, v) => MapEntry<String, Tag>(k, Tag.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "tags": Map.from(tags)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Tag {
  Tag({
    required this.hostId,
    required this.hostname,
    required this.map,
    required this.membersttl,
    required this.tagdescription,
    required this.tagname,
    required this.time,
    required this.totalslots,
    required this.membersUid,
  });

  String hostId;
  String hostname;
  MapClass map;
  int membersttl;
  String tagdescription;
  String tagname;
  Time time;
  int totalslots;
  List<String> membersUid;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        hostId: json["hostId"],
        hostname: json["hostname"],
        map: MapClass.fromJson(json["map"]),
        membersttl: json["membersttl"],
        tagdescription: json["tagdescription"],
        tagname: json["tagname"],
        time: Time.fromJson(json["time"]),
        totalslots: json["totalslots"],
        membersUid: json["membersUID"] == null
            ? []
            : List<String>.from(
                json["membersUID"].map((x) => x == null ? null : x)),
      );

  Map<String, dynamic> toJson() => {
        "hostId": hostId,
        "hostname": hostname,
        "map": map.toJson(),
        "membersttl": membersttl,
        "tagdescription": tagdescription,
        "tagname": tagname,
        "time": time.toJson(),
        "totalslots": totalslots,
        "membersUID": membersUid == null
            ? null
            : List<dynamic>.from(membersUid.map((x) => x == null ? null : x)),
      };
}

class MapClass {
  MapClass({
    required this.landmark,
    required this.latitude,
    required this.londitude,
  });

  String landmark;
  String latitude;
  String londitude;

  factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
        landmark: json["landmark"],
        latitude: json["latitude"],
        londitude: json["londitude"],
      );

  Map<String, dynamic> toJson() => {
        "landmark": landmark,
        "latitude": latitude,
        "londitude": londitude,
      };
}

class Time {
  Time({
    required this.datefrom,
    required this.dateto,
    required this.from,
    required this.to,
  });

  DateTime datefrom;
  String dateto;
  String from;
  String to;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        datefrom: DateTime.parse(json["datefrom"]),
        dateto: json["dateto"],
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "datefrom": datefrom.toIso8601String(),
        "dateto": dateto,
        "from": from,
        "to": to,
      };
}
