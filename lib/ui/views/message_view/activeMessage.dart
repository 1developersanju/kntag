import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/message_view_widget/message_tag_tile.dart';

class ActiveMessageView extends StatefulWidget {
  @override
  State<ActiveMessageView> createState() => _ActiveMessageViewState();
}

class _ActiveMessageViewState extends State<ActiveMessageView> {
  void initState() {
    // TODO: implement initState
    super.initState();
    containerDetails = tagTileDatas();
  }

  @override
  List<GroupTagList> containerDetails = [];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView.builder(
        itemCount: containerDetails.length,
        itemBuilder: (context, index) {
          return MessageTagTile(
            tagId: "",
            peopleProfileImg: containerDetails[index].profileImgs,
            index: "1",
            peopleName: containerDetails[index].memberName,
            tagText: containerDetails[index].tagText,
            joinedCount: containerDetails[index].joined,
            leftCount: containerDetails[index].spotLeft,
            userProfile: containerDetails[index].userProfileData,
            date: containerDetails[index].date,
            showcaseImg: containerDetails[index].userProfileData,
            time: containerDetails[index].time,
            location: containerDetails[index].location,
            host: containerDetails[index].myProfile,
            lat: containerDetails[index].latitude,
            long: containerDetails[index].longitude,
          );
        },
      ),
    );
  }
}
