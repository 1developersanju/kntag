import 'package:flutter/material.dart';
import 'package:kntag/drawer.dart';
import 'package:kntag/ui/views/Google%20map/current_location_view.dart';
import 'package:kntag/ui/views/profile_view/profile_view.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:kntag/widgets/group_view_widgets/tag_tile.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';
import 'package:kntag/widgets/home_view_widgets/bookclub_poiter_container.dart';

import '../../../core/models/group_tag_list/group_tag_list_model.dart';
import 'event_details_view/event_details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<GroupTagList> containerDetails = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    containerDetails = tagTileDatas();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(child: Drawerpage()),
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        title: Text(
          "Kntag",
          style: TextStyle(color: titleColor),
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
      body:
          // Container(
          //   width: currentWidth,
          //   height: currentHeight,
          //   padding: EdgeInsets.only(left: 10, right: 10),
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: NetworkImage(
          //               "https://i.pinimg.com/564x/36/08/7c/36087c294ce01fad38d6565f3885b16c.jpg"),
          //           fit: BoxFit.cover)),
          //   child:
          Stack(
        children: [
          CurrentLocation(),
          // Positioned(top: 50, left: 25, child: BookClubPointer()),
          // Positioned(top: 75, left: 250, child: BookClubPointer()),
          // Positioned(top: 150, left: 150, child: BookClubPointer()),
          // Positioned(top: 250, left: 60, child: BookClubPointer()),
          // Positioned(
          //   left: currentWidth / 3.5,
          //   bottom: 250,
          //   height: currentHeight / 24,
          //   width: currentWidth / 2.5,
          //   child: ElevatedButton(
          //       onPressed: () {},
          //       style: ElevatedButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(30)),
          //         padding: const EdgeInsets.all(5),
          //         primary: Colors.red,
          //         onPrimary: Colors.black87,
          //         //minimumSize: Size(currentWidth/8, currentHeight/22)
          //       ),
          //       child: Text("3 upcoming events  >")),
          // ),
          Container(
            height: currentHeight / 4,
            // bottom: 200,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: containerDetails.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventDetailsView()),
            );
                  },
                  child: BookClubContainer(
                    tagText: containerDetails[index].tagText,
                    joined: containerDetails[index].joined,
                    location: containerDetails[index].location,
                    date: containerDetails[index].date,
                    time: containerDetails[index].time,
                    spotsLeft: containerDetails[index].spotLeft,
                    profile: containerDetails[index].myProfile,
                    userProfile: containerDetails[index].userProfileData,
                  ),
                );
              },
            ),
          ),
        ],
        alignment: Alignment.bottomCenter,
      ),
      // )
    );
  }
}
