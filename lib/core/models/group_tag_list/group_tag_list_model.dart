class GroupTagList {
  String myProfile;
  String tagText;
  String location;
  String date;
  String time;
  String joined;
  String spotLeft;
  GroupTagList(
      {required this.tagText,
      required this.location,
      required this.date,
      required this.time,
      required this.joined,
      required this.spotLeft,
      required this.myProfile});
}

String profilepic =
    "https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";
tagTileDatas() {
  List<GroupTagList> tagTileDetails = [];

  GroupTagList tileData = GroupTagList(
      tagText: "",
      date: "",
      location: '',
      time: '',
      joined: '',
      spotLeft: '',
      myProfile: '');

  //1
  tileData = GroupTagList(
    tagText: "#BookClub",
    date: "13th june 2022",
    location: 'Race Course',
    time: '07pm to 10:30pm',
    joined: '13',
    spotLeft: '12/25',
    myProfile: profilepic,
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
  );
  tagTileDetails.add(tileData);

  return tagTileDetails;
}
