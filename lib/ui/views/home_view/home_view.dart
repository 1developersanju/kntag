// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kntag/app/services/dialog.dart';
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
  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  List<GroupTagList> containerDetails = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    containerDetails = tagTileDatas();

    var i = {"id": 9};

    // for (var i = 0; i < containerDetails.length - 1; i++) {
    //   markers.add(MarkerItem(
    //     id: i + 1,
    //     latitude: double.parse(containerDetails[i].latitude),
    //     longitude: double.parse(containerDetails[i].longitude),
    //     imgs:
    //         "https://github.com/1developersanju/img/blob/main/marker.png?raw=true",
    //   ));
    // }
  }

  List<MarkerItem> markers = [];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // drawer: Drawer(child: Drawerpage()),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        title: Text(
          "Kntag",
          style: TextStyle(
              color: titleColor,
              fontSize: 25.sp,
              fontFamily: "Singolare",
              fontStyle: FontStyle.normal),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  print(user?.displayName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileView()),
                  );
                },
                child: Hero(
                  tag: "profile",
                  child: FirebaseAuth.instance.currentUser != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage("${user?.photoURL}"))
                      : GestureDetector(
                          onTap: () => DialogBox.loginDialog(context),
                          child: CircleAvatar(child: Icon(Icons.person))),
                )),
          ),
        ],
      ),
      body: InteractiveMapsMarker(
        items: markers,
        center: LatLng(11.015173366279953, 76.95900345442489),
        imgs: markers,

        // itemContent: (context, index) {
        //   MarkerItem item = markers[index];
        //   return BottomTile(item: item);
        // },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // margin: const EdgeInsets.all(10.0),
            height: currentHeight * 0.5,
            child: BookClubContainer(
              peopleProfileImg: containerDetails[index].profileImgs,
              peopleName: containerDetails[index].memberName,
              latitude: containerDetails[index].latitude,
              longitude: containerDetails[index].longitude,
              tagText: containerDetails[index].tagText,
              joined: containerDetails[index].joined,
              location: containerDetails[index].location,
              date: containerDetails[index].date,
              time: containerDetails[index].time,
              spotsLeft: containerDetails[index].spotLeft,
              profile: containerDetails[index].myProfile,
              userProfile: containerDetails[index].userProfileData,
              page: "Home",
            ),
          );
        },
      ),
    );
  }
}
