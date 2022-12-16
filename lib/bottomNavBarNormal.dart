import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
// import 'package:kntag/ui/views/home_view/home_view%20copy.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/group_view/group_view.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/message_view/activeMessage.dart';
import 'package:kntag/ui/views/notification_view/notification_view.dart';
import 'package:kntag/ui/views/post_view/create_tag_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'ui/views/message_view/message_page copy.dart';
import 'ui/views/message_view/message_page.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

String profilepic =
    "https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";
String profilepic1 =
    "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";

String profilepic2 =
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";
String profilepic3 =
    "https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";

class _MyNavigationBarState extends State<MyNavigationBar> {
  StreamSubscription? internetconnection;
  bool isoffline = false;
  final user = FirebaseAuth.instance.currentUser;

  late List<Widget> _pages;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late Widget _page4;
  late Widget _page5;
  late int _currentIndex;
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();
    internetconnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
        print("offile");
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    });
    _page1 = HomeMap(changePage: _changeTab);
    // InteractiveMapsMarker(changePage: _changeTab);

    _page2 = MessagePage(
        endDate: "",
        endTime: "",
        membersUid: [],
        desc: "",
        hostName: "",
        hostId: "",
        chatPath: "knchat",
        tagId: "",
        userProfile: [
          profilepic,
          profilepic1,
          profilepic2,
          profilepic3,
          profilepic,
          profilepic1,
          profilepic2,
          profilepic3,
          profilepic,
          profilepic1,
          profilepic2,
          profilepic3,
          profilepic,
          profilepic1,
          profilepic2,
          profilepic3,
          profilepic,
          profilepic1,
          profilepic2,
          profilepic3,
        ],
        index: "knchat",
        title: "knChat",
        joinedCount: "3",
        leftCount: "leftCount",
        host: "host",
        location: "location",
        showcaseImg: [],
        time: "12:49",
        latitude: "latitude",
        longitude: "longitude",
        peopleName: [
          "latitude",
          "latitude",
          "latitude",
          "latitude",
          "latitude",
          "latitude",
          "latitude",
          "latitude",
          "latitude",
          "latitude",
        ],
        peopleProfileImg: []);
    _page3 = CreateTagView(changePage: _changeTab);
    _page4 = NotificationView(
      title: "Notifications",
    );
    _page5 = ActiveMessageView(changePage: _changeTab);
    _pages = user?.uid != null
        ? [_page1, _page2, _page3, _page4, _page5]
        : [_page1, _page2, _page3, _page4, _page5];
    _currentIndex = 0;
    _currentPage = _page1;
  }

  @override
  dispose() {
    super.dispose();
    internetconnection!.cancel();
    //cancel internent connection subscription after you are done
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isoffline == true
          ? Center(child: Text("No Internet Connection Available"))
          : Center(
              child: _currentPage,
            ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          iconSize: 25,
          onTap: (index) {
            _changeTab(index);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: " ",
              activeIcon: Image.asset(
                "assets/SELECTION.png",
                height: 40,
                width: 40,
              ),
              icon: Image.asset(
                "assets/LOCATION selected.png",
                height: 25,
                width: 25,
              ),
            ),
            BottomNavigationBarItem(
              label: " ",
              activeIcon: Image.asset(
                "assets/group_selection.png",
                height: 40,
                width: 40,
              ),
              icon: Image.asset(
                "assets/tags_icon_unselected.png",
                height: 25,
                width: 25,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Image.asset(
                "assets/create_selection.png",
                height: 40,
                width: 40,
              ),
              icon: Image.asset(
                "assets/create_tag_unselected.png",
                height: 25,
                width: 25,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Image.asset(
                "assets/notification_selection.png",
                height: 40,
                width: 40,
              ),
              icon: Image.asset(
                "assets/notification_unselected.png",
                height: 25,
                width: 25,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              activeIcon: Image.asset(
                "assets/chat selection.png",
                height: 40,
                width: 40,
              ),
              icon: Image.asset(
                "assets/chat_unselected.png",
                height: 25,
                width: 25,
              ),
            ),
          ],
          type: BottomNavigationBarType.shifting,
          elevation: 5),
    );
  }
}

Widget errmsg(String text, bool show) {
  //error message widget.
  if (show == true) {
    //if error is true then show error message box
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.black),
          ), // icon for error message

          Text(text, style: TextStyle(color: Colors.black)),
          //show error message text
        ]),
      ),
    );
  } else {
    return Container();
    //if error is false, return empty container.
  }
}
