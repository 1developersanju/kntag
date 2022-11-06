import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/message_view_widget/message_tag_tile.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final dbRef = FirebaseDatabase.instance.ref();

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    List tagMembers = [];
    List tagMembersProfile = [];

    // List<MarkerItem> markers = [];

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
              return ListView.builder(
                itemCount: userS.child("tags").children.toList().length,
                itemBuilder: (context, index) {
                  var hostid;
                  var membersUid;
                  List participantsUid = [];
                  var membersTotal;
                  try {
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
                    print("tagees $tagMembers");
                    tagMembersProfile.clear();

                    for (var element in membersUid) {
                      tagMembersProfile.add(
                          userS.child("users/${element}/ProfileImage").value);
                      tagMembersProfile.remove(null);
                      print("name::${tagMembersProfile}");
                    }
                    tagMembers.clear();

                    for (var element in membersUid) {
                      tagMembers
                          .add(userS.child("users/${element}/UserName").value);
                      tagMembers.remove(null);
                      print("name::${tagMembers}");
                    }
                  } catch (e) {
                    print("EXCEPTION: : $e");
                  }
                  return hostid == user?.uid ||
                          participantsUid.contains("${user?.uid}")
                      ? MessageTagTile(
                          desc: userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('tagdescription')
                              .value,
                          hostName: userS.child("users/$hostid/UserName").value,
                          hostid: hostid,
                          chatPath:
                              "tagchat/${userS.child("tags").children.toList()[index].key}",
                          tagId:
                              "${userS.child("tags").children.toList()[index].key}",
                          peopleProfileImg: tagMembersProfile,
                          index: "1",
                          peopleName: tagMembers,
                          tagText:
                              "#${userS.child("tags").children.toList()[index].child('tagname').value}",
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
                                    .child("users/${membersUid}/ProfileImage")
                                    .value ??
                                userS.child("users/$hostid/ProfileImage").value,
                          ],
                          date:
                              "${userS.child("tags").children.toList()[index].child('time/datefrom').value}, ${userS.child("tags").children.toList()[index].child('time/from').value}",
                          showcaseImg: [],
                          time:
                              " ${userS.child("tags").children.toList()[index].child('time/dateto').value}, ${userS.child("tags").children.toList()[index].child('time/to').value}",
                          location: userS
                              .child("tags")
                              .children
                              .toList()[index]
                              .child('map/landmark')
                              .value,
                          host: userS.child("users/$hostid/ProfileImage").value,
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
              );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          }),
    );
  }
}
