import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:kntag/widgets/message_view_widget/message_tag_tile.dart';

class OldMessageView extends StatefulWidget {
  OldMessageView({Key? key}) : super(key: key);

  @override
  State<OldMessageView> createState() => _OldMessageViewState();
}

class _OldMessageViewState extends State<OldMessageView> {
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
            tagText: containerDetails[index].tagText == 0
                ? containerDetails[index].tagText
                : containerDetails[index].tagText,
            joinedCount: containerDetails[index].joined,
            leftCount: containerDetails[index].spotLeft,
            userProfile: containerDetails[index].userProfileData,
          );
        },
      ),
    );
  }
}
