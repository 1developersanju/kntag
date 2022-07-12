class UserTagList {
  String oppProfile;
  String tagText;
  String status;
  String date;
  String oppName;

  data() {}

  UserTagList({
    required this.tagText,
    required this.status,
    required this.date,
    required this.oppName,
    required this.oppProfile,
  });
}

String profilepic =
    "https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";

userTagTileDatas() {
  List<UserTagList> tagTileDetails = [];

  UserTagList tileData = UserTagList(
    tagText: "",
    date: "",
    status: '',
    oppName: '',
    oppProfile: '',
  );

  //1
  tileData = UserTagList(
    tagText: "#MovieMake",
    date: "2022-06-13",
    status: 'accept',
    oppName: 'Sanjeev',
    oppProfile: profilepic,
  );
  tagTileDetails.add(tileData);

  //2
  tileData = UserTagList(
    tagText: "#BookClub",
    date: "2022-06-13",
    status: 'request',
    oppName: 'Yuvan',
    oppProfile: profilepic,
  );
  tagTileDetails.add(tileData);
  //3
  tileData = UserTagList(
    tagText: "#CricketClub",
    date: "2022-06-13",
    status: 'accept',
    oppName: 'Vivekanandan',
    oppProfile: profilepic,
  );
  tagTileDetails.add(tileData);

  //4
  tileData = UserTagList(
    tagText: "#GTG",
    date: "2022-06-13",
    status: 'request',
    oppName: 'Ann',
    oppProfile: profilepic,
  );

  tagTileDetails.add(tileData);

  return tagTileDetails;
}
