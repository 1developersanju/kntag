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
import 'package:kntag/ui/views/profile_view/profile_view.dart';
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
    for (var i = 0; i < userS.children.toList().length; i++) {
      markers.add(MarkerItem(
        id: i,
        latitude: double.parse(
            userS.children.toList()[i].child('map/latitude').value),
        longitude: double.parse(
            userS.children.toList()[i].child('map/londitude').value),
        imgs:
            "https://github.com/1developersanju/img/blob/main/marker.png?raw=true",
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

  List<MarkerItem> markers = [];

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    final user = FirebaseAuth.instance.currentUser;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // drawer: Drawer(child: Drawerpage()),
      extendBodyBehindAppBar: true,

      body: FutureBuilder(
          future: dbRef.child("tags").once(),
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
                      itemcount: userS.children.toList().length,
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
                        return markers.length != 0
                            ? Container(
                                // margin: const EdgeInsets.all(10.0),
                                height: currentHeight * 0.5,
                                child: BookClubContainer(
                                  membersUid: userS.children
                                          .toList()[index]
                                          .child('membersUID')
                                          .value ??
                                      [],
                                  uid: user!.uid,
                                  tagDesc: userS.children
                                      .toList()[index]
                                      .child('tagdescription')
                                      .value,
                                  hostName: userS.children
                                      .toList()[index]
                                      .child('hostname')
                                      .value,
                                  hostid: userS.children
                                      .toList()[index]
                                      .child('hostId')
                                      .value,
                                  tagId: userS.children.toList()[index].key,
                                  peopleProfileImg:
                                      containerDetails[index].profileImgs,
                                  peopleName:
                                      containerDetails[index].memberName,
                                  latitude: userS.children
                                      .toList()[index]
                                      .child('map/latitude')
                                      .value,
                                  longitude: userS.children
                                      .toList()[index]
                                      .child('map/londitude')
                                      .value,
                                  tagText: userS.children
                                      .toList()[index]
                                      .child('tagname')
                                      .value,
                                  joined: userS.children
                                      .toList()[index]
                                      .child('membersttl')
                                      .value
                                      .toString(),
                                  location: userS.children
                                      .toList()[index]
                                      .child('map/landmark')
                                      .value,
                                  date: userS.children
                                      .toList()[index]
                                      .child('time/datefrom')
                                      .value,
                                  time:
                                      "${userS.children.toList()[index].child('time/from').value}:${userS.children.toList()[index].child('time/to').value}",
                                  spotsLeft:
                                      "${userS.children.toList()[index].child('totalslots').value.toString()}/25",
                                  profile: "https://kntag.com/images/logo.png",
                                  userProfile:
                                      containerDetails[index].userProfileData,
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
                                                "Be the first person to create a tag in your location",
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
                                                        : widget.changePage(2);
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
