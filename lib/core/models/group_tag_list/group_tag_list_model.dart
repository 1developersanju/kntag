class GroupTagList {
  String myProfile;
  String tagText;
  String location;
  String date;
  String time;
  String joined;
  String spotLeft;
  List userProfileData;
  GroupTagList(
      {required this.tagText,
      required this.location,
      required this.date,
      required this.time,
      required this.joined,
      required this.spotLeft,
      required this.myProfile,
      required this.userProfileData});
}

String profilepic =
    "https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";
String profilepic1 =
    "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";

String profilepic2 =
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";
String profilepic3 =
    "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";

tagTileDatas() {
  List<GroupTagList> tagTileDetails = [];

  GroupTagList tileData = GroupTagList(
      tagText: "",
      date: "",
      location: '',
      time: '',
      joined: '',
      spotLeft: '',
      myProfile: '',
      userProfileData: []);

  //1
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
    userProfileData: [profilepic1, profilepic3],
  );
  tagTileDetails.add(tileData);

  //2
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
    userProfileData: [profilepic1, profilepic2, profilepic3],
  );
  tagTileDetails.add(tileData);
  //3
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
    userProfileData: [profilepic1, profilepic2, profilepic3],
  );
  tagTileDetails.add(tileData);

  //4
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
    userProfileData: [profilepic1, profilepic2, profilepic3],
  );
  tagTileDetails.add(tileData);

  //5
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
    userProfileData: [profilepic1, profilepic2, profilepic3],
  );
  tagTileDetails.add(tileData);

  //6
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
    userProfileData: [profilepic1, profilepic2, profilepic3],
  );
  tagTileDetails.add(tileData);

  //7
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
    userProfileData: [profilepic1, profilepic2, profilepic3],
  );
  tagTileDetails.add(tileData);

  return tagTileDetails;
}
