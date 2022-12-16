// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kntag/app/db.dart';
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
import 'package:widget_marker_google_map/widget_marker_google_map.dart';

class HomeMap2 extends StatefulWidget {
  final void Function(int) changePage;

  HomeMap2({
    required this.changePage,
  });

  @override
  State<HomeMap2> createState() => _HomeMap2State();
}

class _HomeMap2State extends State<HomeMap2> {
  List<GroupTagList> containerDetails = [];
  int currentIndex = 0;
  String currentAddress = "";
  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late GoogleMapController _controller;
  var previousPage;
  late PageController _pageController;

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  final dbRef = FirebaseDatabase.instance.ref();
  var usersnap;
  List<WidgetMarker> allMarkers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    containerDetails = tagTileDatas();
    _changeTab;
    var i = {"id": 9};
    // _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
    //   ..addListener(() {
    //     _onScroll();
    //   });
  }

  void _onScroll() {
    if (_pageController.page?.toInt() != previousPage) {
      previousPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(11.036713, 77.041925),
      zoom: 14.0,
      bearing: 45.0,
      tilt: 45.0,
    )));
  }

  void _changeTab(int index) {
    // setState(() {
    //   currentIndex = index;
    // });
    widget.changePage(index);
    print("_changeTabpage1 $index");
  }

  Position? _currentPosition;

  addmarkers(userS) {
    for (var i = 0; i < userS.child("tags").children.toList().length; i++) {
      allMarkers.add(WidgetMarker(
        position: LatLng(
            double.parse(userS
                .child("tags")
                .children
                .toList()[i]
                .child('map/latitude')
                .value),
            double.parse(userS
                .child("tags")
                .children
                .toList()[i]
                .child('map/londitude')
                .value)),
        markerId: i.toString(),
        draggable: true,
        // infoWindow: InfoWindow(
        //   title: element.shopName,
        // ),
        widget: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30, color: Colors.red, //width: 80,
              padding: const EdgeInsets.all(2),
              child: Text("shopName"),
            ),
          ),
        ),
        // id: i,
        // latitude: double.parse(userS
        //     .child("tags")
        //     .children
        //     .toList()[i]
        //     .child('map/latitude')
        //     .value),
        // longitude: double.parse(userS
        //     .child("tags")
        //     .children
        //     .toList()[i]
        //     .child('map/londitude')
        //     .value),
        // imgs:
        //     "https://github.com/1developersanju/img/blob/main/marker.png?raw=true",
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
              return Stack(
                children: <Widget>[
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: height,
                    width: width,
                    child: WidgetMarkerGoogleMap(
                      // onTap: ,
                      initialCameraPosition: const CameraPosition(
                          target: LatLng(11.057786, 76.991440), zoom: 12),
                      widgetMarkers: allMarkers,
                      onMapCreated: mapCreated,
                      mapType: MapType.normal,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    child: Container(
                        height: 200,
                        width: width,
                        child: PageView.builder(
                          // controller: _pageController,
                          itemCount: userS.children.toList()[0].key == "tags"
                              ? userS.child("tags").children.toList().length
                              : 1,
                          itemBuilder: (BuildContext context, int index) {
                            var hostid = userS
                                .child("tags")
                                .children
                                .toList()[index]
                                .child('hostId')
                                .value;
                            var membersUid = userS
                                .child("tags")
                                .children
                                .toList()[index]
                                .child('membersUID')
                                .value;

                            var membersTotal = userS
                                .child("tags")
                                .children
                                .toList()[index]
                                .child('membersttl')
                                .value;
                            try {
                              for (int i = 1; i <= membersTotal; i++) {
                                tagMembers.add(userS
                                    .child("users/${membersUid[i]}/UserName")
                                    .value);
                              }
                              print("tagees $tagMembers");
                              for (int i = 1; i <= membersTotal; i++) {
                                tagMembersProfile.add(userS
                                    .child(
                                        "users/${membersUid[i]}/ProfileImage")
                                    .value);
                              }
                              print("tagees $tagMembers");
                            } catch (e) {
                              print("EXCEPTION: : $e");
                            }

                            return userS.children.toList()[0].key == "tags"
                                ? Container(
                                    // margin: const EdgeInsets.all(10.0),
                                    height: height * 0.5,
                                    child: BookClubContainer(
                                      endDate:
                                          "${userS.child("tags").children.toList()[index].child('time/dateto').value}",
                                      endTime:
                                          "${userS.child("tags").children.toList()[index].child('time/to').value}",
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
                                      tagId: userS
                                          .child("tags")
                                          .children
                                          .toList()[index]
                                          .key,
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
                                      tagText: userS
                                          .child("tags")
                                          .children
                                          .toList()[index]
                                          .child('tagname')
                                          .value,
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
                                                .child(
                                                    "users/$hostid/ProfileImage")
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
                                            width: width * 0.9,
                                            height: height * 0.2,
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                            ? DialogBox
                                                                .loginDialog(
                                                                    context)
                                                            : widget
                                                                .changePage(2);
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
                        )),
                  )
                ],
              );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          }),
    );
  }
}
