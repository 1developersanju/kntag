import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/core/models/group_tag_list/usertag/user_notification.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:kntag/widgets/notification_view_widget/notification_tile.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  List<UserTagList> tileDetails = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    tileDetails = userTagTileDatas();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notification",
          style: TextStyle(color: blackClr),
        ),
      ),
      body: ListView.builder(
        itemCount: tileDetails.length,
        itemBuilder: (context, index) {
          return NotificationTile(
            tagText: tileDetails[index].tagText,
            oppName: tileDetails[index].oppName,
            oppProfile: tileDetails[index].oppProfile,
            status: tileDetails[index].status,
          );
        },
      ),
    );
  }
}

class RequestView extends StatefulWidget {
  const RequestView({Key? key}) : super(key: key);

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  @override
  List<UserTagList> tileDetails = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    tileDetails = userTagTileDatas();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notification",
          style: TextStyle(color: blackClr),
        ),
      ),
      body: ListView.builder(
        itemCount: tileDetails.length,
        itemBuilder: (context, index) {
          return RequestTile(
            tagText: tileDetails[index].tagText,
            oppName: tileDetails[index].oppName,
            oppProfile: tileDetails[index].oppProfile,
            status: tileDetails[index].status,
          );
        },
      ),
    );
  }
}
