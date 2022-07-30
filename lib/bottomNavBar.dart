import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kntag/ui/views/group_view/group_view.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/notification_view/notification_view.dart';
import 'package:kntag/ui/views/post_view/create_tag_view.dart';
import 'package:kntag/ui/views/profile_view/profile_view.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'ui/views/message_view/message_view.dart';

class MyAppp extends StatelessWidget {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomeMap(),
      GroupView(),
      CreateTagView(),
      NotificationView(
        title: "Notifications",
      ),
      MessageView()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        // title: ("Home"),

        activeColorPrimary: titleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        icon: Image.asset(
          "assets/SELECTION.png",
          height: 30,
          width: 30,
        ),

        inactiveIcon: Image.asset(
          "assets/LOCATION selected.png",
          height: 20,
          width: 20,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/group_selection.png",
          height: 30,
          width: 30,
        ),
        inactiveIcon: Image.asset(
          "assets/tags_icon_unselected.png",
          height: 23,
          width: 23,
        ),
        // title: ("Group"),
        activeColorPrimary: titleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/create_selection.png",
          height: 30,
          width: 30,
        ),
        inactiveIcon: Image.asset(
          "assets/create_tag_unselected.png",
          height: 23,
          width: 23,
        ),
        // title: ("Post"),
        activeColorPrimary: titleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/notification_selection.png",
          height: 30,
          width: 30,
        ),
        inactiveIcon: Image.asset(
          "assets/notification_unselected.png",
          height: 23,
          width: 23,
        ),
        // title: ("Notifications"),
        activeColorPrimary: titleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/chat selection.png",
          height: 30,
          width: 30,
        ),
        inactiveIcon: Image.asset(
          "assets/chat_unselected.png",
          height: 23,
          width: 23,
        ),
        // title: ("Settings"),
        activeColorPrimary: titleColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,

      // navBarHeight: 40,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 150),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 150),
      ),

      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
