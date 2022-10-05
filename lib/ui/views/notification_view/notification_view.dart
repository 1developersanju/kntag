import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/core/models/group_tag_list/usertag/user_notification.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/notification_view_widget/notification_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationView extends StatefulWidget {
  String title;

  NotificationView({required this.title});
  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  List<UserTagList> tileDetails = [];
  final user = FirebaseAuth.instance.currentUser;

  void initState() {
    // TODO: implement initState
    super.initState();
    tileDetails = userTagTileDatas();
  }

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance.ref();

    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    // var itemCount = 2;
    var tagMembers = [];
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(color: blackClr),
          ),
        ),
        body: StreamBuilder(
            stream: dbRef.onValue,
            builder: (ctx, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                final userS = snapshot.data.snapshot;
                var membersTotal;

                return userS
                            .child("users/${user?.uid}/Notifications")
                            .children
                            .toList()
                            .length !=
                        0
                    ? ListView.builder(
                        itemCount:1,
                        //  userS
                        //     .child("users/${user?.uid}/Notifications")
                        //     .children
                        //     .toList()
                        //     .length,
                        itemBuilder: (context, index) {
                          var membersUid;
                          membersTotal = userS
                              .child("users")
                              .children
                              .toList()[index]
                              .child('membersttl')
                              .value;
                          try {
                            // membersUid = userS
                            //     .child("users/${{user?.uid}[i]}/Notifications")
                            //     .children
                            //     .toList()
                            //     .key;

                            for (int i = 1; i <= membersTotal; i++) {
                              var x = userS
                                  .child("users/${user?.uid}/Notifications")
                                  .key;
                              tagMembers.add(userS
                                  .child("users/${membersUid[i]}/UserName")
                                  .value);
                              membersUid = userS.children
                                  .toList()[index]
                                  .child("tags/${x}}/tagname")
                                  .value;
                            }
                          } catch (e) {
                            print("EXCEPTION: : $e");
                          }
                          var itemCount = userS
                              .child("users/${user?.uid}/Notifications")
                              .children
                              .toList()
                              .length;
                          return itemCount != 0
                              ? NotificationTile(
                                  hostId: userS
                                      .child("users/${user?.uid}/Notifications")
                                      .children
                                      .toList()[index]
                                      .child("userId")
                                      .value,
                                  tagText: userS
                                      .child(
                                          "tags/${userS.child("users/${user?.uid}/Notifications").children.toList()[index].child("joinedTag").value.toString()}/tagname")
                                      .value
                                      .toString(),
                                  oppName: userS
                                      .child(
                                          "users/${userS.child("users/${user?.uid}/Notifications").children.toList()[index].child("userId").value.toString()}/UserName")
                                      .value
                                      .toString(),
                                  oppProfile: userS
                                      .child(
                                          "users/${userS.child("users/${user?.uid}/Notifications").children.toList()[index].child("userId").value.toString()}/ProfileImage")
                                      .value
                                      .toString(),
                                  status: userS
                                      .child("users/${user?.uid}/Notifications")
                                      .children
                                      .toList()[index]
                                      .child("status")
                                      .value
                                      .toString(),
                                )
                              : Center(
                                  child: Text(
                                      "You have'nt received any notifications"),
                                );
                        },
                      )
                    : Center(
                        child: Text("You have'nt received any notifications"),
                      );
              }
              return Center(
                child: Text("Something went wrong"),
              );
            }));
  }
}
