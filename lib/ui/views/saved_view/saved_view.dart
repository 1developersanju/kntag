import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/widgets/Profile_view_widgets/book_club_container.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';

class SavedView extends StatefulWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  void initState() {
    // TODO: implement initState
    super.initState();
    containerDetails = tagTileDatas();
  }

  @override
  List<GroupTagList> containerDetails = [];
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text("Saved"),
        ),
        backgroundColor: bgColor,
        body: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          width: currentWidth,
          height: currentHeight * 1.2,
          color: bgColor,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return BookClubContainer(
                peopleProfileImg: containerDetails[index].profileImgs,
                peopleName: containerDetails[index].memberName,
                latitude: containerDetails[index].latitude,
                longitude: containerDetails[index].latitude,
                tagText: containerDetails[index].tagText,
                joined: containerDetails[index].joined,
                location: containerDetails[index].location,
                date: containerDetails[index].date,
                time: containerDetails[index].time,
                spotsLeft: containerDetails[index].spotLeft,
                profile: containerDetails[index].myProfile,
                userProfile: containerDetails[index].userProfileData,
                page: "tags",
              );
            },
          ),
        ));
  }
}
