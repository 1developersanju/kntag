// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:interactive_maps_marker/interactive_maps_marker.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/drawer.dart';
import 'package:kntag/ui/maps/Maps/interactive_maps_marker.dart';
import 'package:kntag/ui/views/profile_view/profile_view.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';
import 'package:sizer/sizer.dart';

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

    for (var i = 0; i < containerDetails.length - 1; i++) {
      markers.add(MarkerItem(
          id: i + 1,
          latitude: double.parse(containerDetails[i].latitude),
          longitude: double.parse(containerDetails[i].longitude)));
    }
  }

  List<MarkerItem> markers = [];

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(child: Drawerpage()),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        title: Text(
          "Kntag",
          style: TextStyle(color: titleColor, fontSize: 20.sp),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileView()),
              );
            },
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://wallpaperaccess.com/full/2024739.jpg")),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: InteractiveMapsMarker(
        items: markers,
        center: LatLng(11.015173366279953, 76.95900345442489),

        // itemContent: (context, index) {
        //   MarkerItem item = markers[index];
        //   return BottomTile(item: item);
        // },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // margin: const EdgeInsets.all(10.0),
            height: currentHeight * 0.5,
            child: BookClubContainer(
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
