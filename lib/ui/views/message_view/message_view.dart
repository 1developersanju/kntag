import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kntag/core/models/message_status.dart';
import 'package:kntag/ui/views/message_view/activeMessage.dart';
import 'package:kntag/ui/views/message_view/oldMessage.dart';
import 'package:kntag/ui/views/message_view/upComingMessage.dart';
import 'package:kntag/colorAndSize.dart';

import '../../../core/models/group_tag_list/group_tag_list_model.dart';
import '../../../widgets/message_view_widget/message_tag_tile.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView>
    with SingleTickerProviderStateMixin {
  List<GroupTagList> containerDetails = [];
  List<GroupTagList> old = [];
  List<GroupTagList> active = [];
  List<GroupTagList> upcoming = [];

  late TabController _controller;
  var currentIndex = 1;
  @override
  void initState() {
    containerDetails = tagTileDatas();
    messagesSplit();
    // TODO: implement initState
    super.initState();
    _controller =
        TabController(length: 3, vsync: this, initialIndex: currentIndex);
    _controller.addListener(() {
      print("index::${_controller.index}");
    });
  }

  messagesSplit() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    for (var i = 0; i <= containerDetails.length - 1; i++) {
      var getdate = containerDetails[i].date;
      if (formattedDate.compareTo(getdate) == 0) {
        active.add(containerDetails[i]);
        // print("active ${active[i].tagText}");
      }

      if (formattedDate.compareTo(getdate) < 0) {
        old.add(containerDetails[i]);
        // print("old ${old[i].tagText}");
      }

      if (formattedDate.compareTo(getdate) > 0) {
        upcoming.add(containerDetails[i]);
        // print("upcoming ${upcoming[i].tagText}");
      }
    }
  }

  final List<Widget> _tabs = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    int index = currentIndex;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Messages",
          style: TextStyle(color: blackClr),
        ),
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () => messagesSplit(), icon: Icon(Icons.more_vert))
        ],
        backgroundColor: appbarClr,
        bottom: TabBar(
          indicatorColor: buttonBlue,
          indicatorWeight: 4,
          unselectedLabelColor: greyText,
          labelColor: titleColor,
          tabs: const [
            Tab(
              text: "Old",
            ),
            Tab(
              text: "Active",
            ),
            Tab(
              text: "Upcoming",
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          controller: _controller,
        ),
      ),
      backgroundColor: bgColor,
      body: Center(
          child: TabBarView(
        children: [
          old.length != 0
              ? ListView.builder(
                  itemCount: old.length,
                  itemBuilder: (context, index) {
                    return MessageTagTile(
                      tagText: old[index].tagText,
                      joinedCount: old[index].joined,
                      leftCount: old[index].spotLeft,
                      userProfile: old[index].userProfileData,
                      date: old[index].date,
                      showcaseImg: old[index].userProfileData,
                      time: old[index].time,
                      location: old[index].latitude,
                      lat: old[index].latitude,
                      long: old[index].latitude,
                      host: old[index].myProfile,
                      index: 0,
                    );
                  },
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'You do not have any old chats available',
                            style: theme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          active.length != 0
              ? ListView.builder(
                  itemCount: active.length,
                  itemBuilder: (context, index) {
                    return MessageTagTile(
                      tagText: active[index].tagText,
                      joinedCount: active[index].joined,
                      leftCount: active[index].spotLeft,
                      userProfile: active[index].userProfileData,
                      date: active[index].date,
                      showcaseImg: active[index].userProfileData,
                      time: active[index].time,
                      location: active[index].location,
                      lat: active[index].latitude,
                      long: active[index].latitude,
                      host: active[index].myProfile,
                      index: 1,
                    );
                  },
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No active chats available',
                            style: theme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          upcoming.length != 0
              ? ListView.builder(
                  itemCount: upcoming.length,
                  itemBuilder: (context, index) {
                    return MessageTagTile(
                      tagText: upcoming[index].tagText,
                      joinedCount: upcoming[index].joined,
                      leftCount: upcoming[index].spotLeft,
                      userProfile: upcoming[index].userProfileData,
                      date: upcoming[index].date,
                      showcaseImg: upcoming[index].userProfileData,
                      time: upcoming[index].time,
                      location: upcoming[index].location,
                      lat: upcoming[index].latitude,
                      long: upcoming[index].longitude,
                      host: upcoming[index].myProfile,
                      index: 2,
                    );
                  },
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No Upcoming chats available',
                            style: theme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
        controller: _controller,
      )),
    );
  }
}
