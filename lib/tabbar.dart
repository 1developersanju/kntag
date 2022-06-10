import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kntag/ui/views/group_view/group_view.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/message_view/message_view.dart';
import 'package:kntag/ui/views/notification_view/notification_view.dart';
import 'package:kntag/ui/views/post_view/create_tag_view.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            this._selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Group"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded), label: "Post"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notification"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Messages")
        ],
      ),
      body: Stack(
        children: [
          renderView(0, HomeView()),
          renderView(1, GroupView()),
          renderView(2, CreateTagView()),
          renderView(3, NotificationView()),
          renderView(4, MessageView())
        ],
      ),
    );
  }

  IgnorePointer renderView(int tabIndex, Widget view) {
    return IgnorePointer(
        ignoring: _selectedTab != tabIndex,
        child: Opacity(
          opacity: _selectedTab == tabIndex ? 1 : 0,
          child: view,),
      );
  }
}
