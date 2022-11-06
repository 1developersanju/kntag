import 'package:flutter/material.dart';
// import 'package:kntag/ui/views/home_view/home_view%20copy.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/group_view/group_view.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/message_view/activeMessage.dart';
import 'package:kntag/ui/views/message_view/message_view.dart';
import 'package:kntag/ui/views/notification_view/notification_view.dart';
import 'package:kntag/ui/views/post_view/create_tag_view.dart';

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
    _page1 = HomeMap(changePage: _changeTab);
    // InteractiveMapsMarker(changePage: _changeTab);

    _page2 = MessagePage(
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
    _page5 = ActiveMessageView();
    _pages = [_page1, _page2, _page3, _page4, _page5];
    _currentIndex = 0;
    _currentPage = _page1;
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
      body: Center(
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
