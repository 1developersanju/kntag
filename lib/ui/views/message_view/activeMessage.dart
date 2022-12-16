import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/message_view_widget/message_tag_tile.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActiveMessageView extends StatefulWidget {
  final void Function(int) changePage;
  ActiveMessageView({required this.changePage});
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
  final dbRef = FirebaseDatabase.instance.ref();

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // List<MarkerItem> markers = [];
    void _changeTab(int index) {
      // setState(() {
      //   currentIndex = index;
      // });
      widget.changePage(index);
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: AutoSizeText(
          "Chat",
          style: TextStyle(
              color: titleColor,
              fontSize: 25.sp,
              fontFamily: "Singolare",
              fontStyle: FontStyle.normal),
          maxLines: 1,
        ),
      ),
      body: StreamBuilder(
          stream: dbRef.onValue,
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Stack(
                children: [
                  const Center(child: CircularProgressIndicator()),
                ],
              );
            }
            if (snapshot.hasData) {
              final userS = snapshot.data.snapshot;

              // addmarkers(userS);
              return userS.child("tags").children.toList().length != 0
                  ? ListView.builder(
                      itemCount: userS.child("tags").children.toList().length,
                      itemBuilder: (context, index) {
                        print(
                            "ter: ${userS.child("tagchat/${userS.child("tagchat/${userS.child("tags").children.toList()[index].key}/lastMessageid").value}").key}");
                        print(
                            "ideaa: ${userS.child("tagchat/${userS.child("tags").children.toList()[index].key}/${userS.child("tagchat/${userS.child("tagchat/${userS.child("tags").children.toList()[index].key}/lastMessageid").value}").key}/date").key}");
                        List tagMembers = [];
                        List tagMembersProfile = [];

                        var hostid;
                        var membersUid;
                        List participantsUid = [];
                        var membersTotal;
                        try {
                          tagMembersProfile.clear();

                          hostid = userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('hostId')
                              .value;
                          membersUid = userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('membersUID')
                              .value;

                          membersTotal = userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('membersttl')
                              .value;

                          participantsUid.clear();

                          // TODO: implement initState
                          for (var element in membersUid) {
                            participantsUid.add(element);
                            participantsUid.remove(null);
                            // print("namee:${widget.peopleName}");

                            // name.removeAt(0);
                            // peoplename.add(name);
                          }

                          for (var element in membersUid) {
                            tagMembersProfile.add(userS
                                .child("users/${element}/ProfileImage")
                                .value);
                            tagMembersProfile.remove(null);
                            print("name::${tagMembersProfile}");
                          }
                          tagMembers.clear();

                          for (var element in membersUid) {
                            tagMembers.add(
                                userS.child("users/${element}/UserName").value);
                            tagMembers.remove(null);
                            print("name::${tagMembers}");
                          }
                        } catch (e) {
                          print("EXCEPTION: : $e");
                        }
                        return hostid == user?.uid ||
                                participantsUid.contains("${user?.uid}")
                            ? MessageTagTile(
                                hasUnseenMessage:
                                    // "${userS.child("tagchat/${userS.child("tags").children.toList()[index].key}/lastMessageid").value}" ==
                                    //             "-NJ1Ar2uQgML9_P49JYI" ||
                                    //         userS
                                    //                 .child(
                                    //                     "tagchat/${userS.child("tagchat/${userS.child("tags").children.toList()[index].key}/lastMessageid").value}/${userS.child("${userS.child("tags").children.toList()[index].key}/date").value}")
                                    //                 .key ==
                                    //             "2022-12-11"
                                    //     ? true
                                    true,
                                membersUid: participantsUid,
                                endDate: "${userS.child("tags").children.toList()[index].child('time/dateto').value}",
                                endTime: "${userS.child("tags").children.toList()[index].child('time/to').value}",
                                desc: userS
                                    .child("tags")
                                    .children
                                    .toList()[index]
                                    .child('tagdescription')
                                    .value,
                                hostName:
                                    userS.child("users/$hostid/UserName").value,
                                hostid: hostid,
                                chatPath:
                                    "tagchat/${userS.child("tags").children.toList()[index].key}",
                                tagId:
                                    "${userS.child("tags").children.toList()[index].key}",
                                peopleProfileImg: tagMembersProfile,
                                index: "1",
                                peopleName: tagMembers,
                                tagText:
                                    "${userS.child("tags").children.toList()[index].child('tagname').value}",
                                joinedCount: userS
                                    .child("tags")
                                    .children
                                    .toList()[index]
                                    .child('membersttl')
                                    .value
                                    .toString(),
                                leftCount:
                                    "${userS.child("tags").children.toList()[index].child('totalslots').value.toString()}/25",
                                userProfile: [
                                  userS
                                          .child(
                                              "users/${membersUid}/ProfileImage")
                                          .value ??
                                      userS
                                          .child("users/$hostid/ProfileImage")
                                          .value,
                                ],
                                date:
                                    "${userS.child("tags").children.toList()[index].child('time/datefrom').value}",
                                showcaseImg: [],
                                time:
                                    " ${userS.child("tags").children.toList()[index].child('time/dateto').value}",
                                location: userS
                                    .child("tags")
                                    .children
                                    .toList()[index]
                                    .child('map/landmark')
                                    .value,
                                host: userS
                                    .child("users/$hostid/ProfileImage")
                                    .value,
                                lat: (userS
                                        .child("tags")
                                        .children
                                        .toList()[index]
                                        .child('map/latitude')
                                        .value)
                                    .toString(),
                                long: (userS
                                        .child("tags")
                                        .children
                                        .toList()[index]
                                        .child('map/londitude')
                                        .value)
                                    .toString(),
                              )
                            : SizedBox();
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _changeTab(2);
                            },
                            child: Icon(
                              Icons.chat,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Do not have chats..',
                            style: TextStyle(color: greyText),
                          ),
                          Text(
                            'Create/Join tag to chat',
                            style: TextStyle(color: greyText),
                          ),
                        ],
                      ),
                    );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          }),
    );
  }
}
