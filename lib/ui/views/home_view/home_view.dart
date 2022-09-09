// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/app/services/shared_pref.dart';
// import 'package:interactive_maps_marker/interactive_maps_marker.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
// import 'package:kntag/drawer.dart';
import 'package:kntag/ui/maps/Maps/interactive_maps_marker.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';
import 'package:sizer/sizer.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeMap extends StatefulWidget {
  final void Function(int) changePage;

  HomeMap({
    required this.changePage,
  });
  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  List<GroupTagList> containerDetails = [];
  int currentIndex = 0;
  String currentAddress = "";
  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late GoogleMapController mapController;

  final dbRef = FirebaseDatabase.instance.ref();
  var usersnap;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    containerDetails = tagTileDatas();
    _changeTab;
    var i = {"id": 9};
  }

  void _changeTab(int index) {
    // setState(() {
    //   currentIndex = index;
    // });
    widget.changePage(index);
    print("_changeTabpage1 $index");
  }

  Position? _currentPosition;

  addmarkers(userS) async {
    for (var i = 0; i < userS.child("tags").children.toList().length; i++) {
      var hostid =
          userS.child("tags").children.toList()[i].child('hostId').value;
      markers.add(MarkerItem(
        tagname:
            userS.child("tags").children.toList()[i].child('tagname').value,
        id: i,
        latitude: double.parse(userS
            .child("tags")
            .children
            .toList()[i]
            .child('map/latitude')
            .value),
        longitude: double.parse(userS
            .child("tags")
            .children
            .toList()[i]
            .child('map/londitude')
            .value),
        imgs: userS.child("users/$hostid/ProfileImage").value,
      ));
    }
  }

  getData() async {
    getString();
  }

  void getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print("errrror:$e");
    });
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition?.latitude ?? 0, _currentPosition?.longitude ?? 0);

      Placemark place = p[0];

      setState(() {
        currentAddress = "${place.locality}";
      });
    } catch (e) {
      print("exceeeptionnn$e");
    }
  }

  List tagMembers = [];
  List tagMembersProfile = [];

  List<MarkerItem> markers = [];
  Future<Map<String, dynamic>> future() async {
    final tags = await FirebaseDatabase.instance.ref('tags').get();
    final data = Map<String, dynamic>.from(tags.value as Map);
    final hostID = data['8ux4wwBY03NN2xpM01LXK58rkgF2Tag3947']['hostId'];
    final users = await FirebaseDatabase.instance.ref('users/$hostID').get();
    return <String, dynamic>{
      'tags': Map<String, dynamic>.from(tags.value as Map),
      'users': Map<String, dynamic>.from(users.value as Map)
    };
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    final user = FirebaseAuth.instance.currentUser;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // drawer: Drawer(child: Drawerpage()),
      extendBodyBehindAppBar: true,

      body: StreamBuilder(
          stream: dbRef.onValue,
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final userS = snapshot.data.snapshot;

              addmarkers(userS);
              return _currentPosition == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : InteractiveMapsMarker(
                      initialLocation: markers.isEmpty
                          ? LatLng(_currentPosition?.latitude ?? 0,
                              _currentPosition?.longitude ?? 0)
                          : LatLng(markers[0].latitude, markers[0].longitude),
                      itemcount: userS.children.toList()[0].key == "tags"
                          ? userS.child("tags").children.toList().length
                          : 1,
                      changePage: _changeTab,
                      items: markers,
                      center: LatLng(_currentPosition?.latitude ?? 0,
                          _currentPosition?.longitude ?? 0),
                      imgs: markers,

                      // itemContent: (context, index) {
                      //   MarkerItem item = markers[index];
                      //   return BottomTile(item: item);
                      // },
                      itemBuilder: (BuildContext context, int index) {
                        var hostid;
                        var membersUid;
                        var membersTotal;
                        try {
                          hostid = userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('hostId')
                              .value;
                          membersUid = userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('membersUID')
                              .value;

                          membersTotal = userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('membersttl')
                              .value;

                          for (int i = 1; i <= membersTotal; i++) {
                            tagMembers.add(userS
                                .child("users/${membersUid[i]}/UserName")
                                .value);
                          }
                          print("tagees $tagMembers");
                          for (int i = 1; i <= membersTotal; i++) {
                            tagMembersProfile.add(userS
                                .child("users/${membersUid[i]}/ProfileImage")
                                .value);
                          }
                          print("tagees $tagMembers");
                        } catch (e) {
                          print("EXCEPTION: : $e");
                        }

                        return userS.children.toList().length == 2
                            ? Container(
                                // margin: const EdgeInsets.all(10.0),
                                height: currentHeight * 0.5,
                                child: BookClubContainer(
                                  membersUid: userS
                                          .child("tags")
                                          .children
                                          .toList()[index]
                                          .child('membersUID')
                                          .value ??
                                      [''],
                                  uid: "${user?.uid}",
                                  tagDesc: userS
                                      .child("tags")
                                      .children
                                      .toList()[index]
                                      .child('tagdescription')
                                      .value,
                                  hostName: userS
                                      .child("users/$hostid/UserName")
                                      .value,
                                  hostid: userS
                                      .child("tags")
                                      .children
                                      .toList()[index]
                                      .child('hostId')
                                      .value,
                                  tagId:
                                      "${userS.child("tags").children.toList()[index].key}",
                                  peopleProfileImg: tagMembersProfile,
                                  peopleName: tagMembers,
                                  latitude: userS
                                      .child("tags")
                                      .children
                                      .toList()[index]
                                      .child('map/latitude')
                                      .value,
                                  longitude: userS
                                      .child("tags")
                                      .children
                                      .toList()[index]
                                      .child('map/londitude')
                                      .value,
                                  tagText:
                                      "#${userS.child("tags").children.toList()[index].child('tagname').value}",
                                  joined: userS
                                      .child("tags")
                                      .children
                                      .toList()[index]
                                      .child('membersttl')
                                      .value
                                      .toString(),
                                  location: userS
                                      .child("tags")
                                      .children
                                      .toList()[index]
                                      .child('map/landmark')
                                      .value,
                                  date: userS
                                      .child("tags")
                                      .children
                                      .toList()[index]
                                      .child('time/datefrom')
                                      .value,
                                  time:
                                      "${userS.child("tags").children.toList()[index].child('time/from').value}:${userS.child("tags").children.toList()[index].child('time/to').value}",
                                  spotsLeft:
                                      "${userS.child("tags").children.toList()[index].child('totalslots').value.toString()}/25",
                                  profile: userS
                                      .child("users/$hostid/ProfileImage")
                                      .value,
                                  userProfile: [
                                    userS
                                            .child(
                                                "users/${membersUid}/ProfileImage")
                                            .value ??
                                        userS
                                            .child("users/$hostid/ProfileImage")
                                            .value,
                                  ],
                                  page: "Home",
                                ),
                              )
                            : Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        width: currentWidth * 0.9,
                                        height: currentHeight * 0.2,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black87
                                                    .withOpacity(0.100),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: Offset(0, 3),
                                              )
                                            ],
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Be the first person",
                                                style: TextStyle(
                                                    fontFamily: "Singolare",
                                                    fontSize: 15.sp),
                                              ),
                                              OutlinedButton(
                                                  onPressed: () {
                                                    FirebaseAuth.instance
                                                                .currentUser ==
                                                            null
                                                        ? DialogBox.loginDialog(
                                                            context)
                                                        : widget.changePage(1);
                                                  },
                                                  child: Text("Create Tag"),
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .red)))))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                      },
                    );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          }),
    );
  }
}
