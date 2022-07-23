import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kntag/core/models/message_status.dart';
import 'package:kntag/ui/views/message_view/activeMessage.dart';
import 'package:kntag/ui/views/message_view/oldMessage.dart';
import 'package:kntag/ui/views/message_view/upComingMessage.dart';
import 'package:kntag/widgets/colorAndSize.dart';

import '../../../core/models/group_tag_list/group_tag_list_model.dart';

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
        print("active ${old.length}");
      }

      if (formattedDate.compareTo(getdate) < 0) {
        old.add(containerDetails[i]);
      }

      if (formattedDate.compareTo(getdate) > 0) {
        upcoming.add(containerDetails[i]);
      }
    }
  }

  final List<Widget> _tabs = [];

  @override
  Widget build(BuildContext context) {
    int index = currentIndex;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.25), // Large

      child: Scaffold(
        appBar: AppBar(
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
        backgroundColor: Colors.amber,
        body: Center(
            child: TabBarView(
          children: [
            OldMessageView(),
            ActiveMessageView(),
            UpcomingMessageView(),
          ],
          controller: _controller,
        )),
      ),
    );
  }
}
