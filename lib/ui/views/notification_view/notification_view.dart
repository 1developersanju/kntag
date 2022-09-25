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
  final dbRef = FirebaseDatabase.instance.ref();

  void initState() {
    // TODO: implement initState
    super.initState();
    tileDetails = userTagTileDatas();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    var itemCount = 2;
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

                return ListView.builder(
                  itemCount: membersTotal,
                  itemBuilder: (context, index) {
                    var membersUid;
                    membersTotal = userS
                        .child("tags")
                        .children
                        .toList()[index]
                        .child('membersttl')
                        .value;
                    try {
                      membersUid = userS
                          .child("tags")
                          .children
                          .toList()[index]
                          .child('membersUID')
                          .value;

                      for (int i = 1; i <= membersTotal; i++) {
                        tagMembers.add(userS
                            .child("users/${membersUid[i]}/UserName")
                            .value);
                      }
                    } catch (e) {
                      print("EXCEPTION: : $e");
                    }
                    return itemCount != 0
                        ? NotificationTile(
                            tagText: tileDetails[index].oppName,
                            oppName: tileDetails[index].oppName,
                            oppProfile: tileDetails[index].oppProfile,
                            status: tileDetails[index].status,
                          )
                        : Center(
                            child:
                                Text("You have'nt received any notifications"),
                          );
                  },
                );
              }
              return Center(
                child: Text("Something went wrong"),
              );
            }));
  }
}
