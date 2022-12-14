import 'package:flutter/material.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/ui/views/Google%20map/openMap.dart';
import 'package:kntag/ui/views/home_view/event_details_view/event_details_view.dart';
import 'package:kntag/ui/views/message_view/message_page.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageTagTile extends StatefulWidget {
  String tagText;
  String joinedCount;
  String endDate;
  String endTime;
  bool hasUnseenMessage;
  String leftCount;
  List userProfile;
  String index;
  String date;
  String hostName;
  String desc;
  String host;
  String tagId;
  String location;
  String time;
  List showcaseImg;
  String lat;
  String long;
  List peopleName;
  List membersUid;
  List peopleProfileImg;
  String chatPath;
  String hostid;
  MessageTagTile(
      {required this.tagText,
      required this.endDate,
      required this.endTime,
      required this.hasUnseenMessage,
      required this.membersUid,
      required this.desc,
      required this.hostName,
      required this.hostid,
      required this.chatPath,
      required this.joinedCount,
      required this.tagId,
      required this.leftCount,
      required this.userProfile,
      required this.index,
      required this.date,
      required this.host,
      required this.location,
      required this.showcaseImg,
      required this.time,
      required this.long,
      required this.lat,
      required this.peopleName,
      required this.peopleProfileImg});

  @override
  State<MessageTagTile> createState() => _MessageTagTileState();
}

class _MessageTagTileState extends State<MessageTagTile> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 6.5, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          viewedMessage({"viewedUid": user!.uid}, context, widget.chatPath);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessagePage(
                      endDate: widget.endDate,
                      endTime: widget.endTime,
                      membersUid: widget.membersUid,
                      desc: widget.desc,
                      hostName: widget.hostName,
                      hostId: widget.hostid,
                      chatPath: widget.chatPath,
                      tagId: widget.tagId,
                      peopleProfileImg: widget.peopleProfileImg,
                      peopleName: widget.peopleName,
                      userProfile: widget.userProfile,
                      index: widget.index,
                      title: widget.tagText,
                      joinedCount: widget.joinedCount,
                      leftCount: widget.leftCount,
                      date: widget.date,
                      showcaseImg: widget.showcaseImg,
                      time: widget.time,
                      location: widget.location,
                      latitude: widget.lat,
                      longitude: widget.long,
                      host: widget.host,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 15),
            width: currentWidth * 0.90,
            height: currentHeight * 0.13,
            decoration: BoxDecoration(
                color: widget.hasUnseenMessage == true
                    ? Colors.white
                    : Colors.amber,
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.tagText,
                              //"#BookClub",
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: Text(
                              "${widget.joinedCount} Joined",
                              //"13 Joined\n12/25 Spot Left",
                              style:
                                  TextStyle(color: greyText, fontSize: 11.sp),
                            ),
                          ),
                          // Expanded(
                          //   child: Text(
                          //     "${widget.leftCount} Spot Left",
                          //     //"13 Joined\n12/25 Spot Left",
                          //     style:
                          //         TextStyle(color: greyText, fontSize: 11.sp),
                          //   ),
                          // ),
                        ]),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                MapsLauncher.launchCoordinates(
                                    double.parse(widget.lat),
                                    double.parse(widget.long),
                                    widget.tagText);

                                print("location tapped");
                              },
                              child: CircleAvatar(
                                  backgroundColor: bgColor,
                                  radius: 2.h,
                                  child: Transform.rotate(
                                      angle: 20,
                                      child: Icon(
                                        Icons.navigation_outlined,
                                        color: greyText,
                                        size: 13.sp,
                                      ))
                                  //  Image.asset(
                                  //   "assets/LOCATION selected.png",
                                  //   height: 3.w,
                                  // )
                                  ),
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            CircleAvatar(
                                backgroundColor: bgColor,
                                radius: 2.h,
                                child: Image.asset(
                                  "assets/chat_unselected.png",
                                  height: 4.w,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(child: buildStackedImages()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStackedImages() {
    final double size = 4.h;
    final urlImages = widget.joinedCount != "0"
        ? widget.peopleProfileImg
        : widget.userProfile;

    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();

    return StackedWidget(
      items: items,
      size: size,
    );
  }

  // Method for providing image $ shape circle
  Widget buildImage(String urlImage) {
    final double borderSize = 0.8;

    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(borderSize),
        color: Colors.white,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// Class to stack circles
class StackedWidget extends StatelessWidget {
  final List<Widget> items;
  final TextDirection direction;
  final double size;
  final double xShift;

  const StackedWidget({
    Key? key,
    required this.items,
    this.direction = TextDirection.ltr,
    this.size = 10,
    this.xShift = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allItems = items
        .asMap()
        .map((index, item) {
          final left = size - xShift;

          final value = Container(
            width: size,
            height: size,
            margin: EdgeInsets.only(left: left * index),
            child: item,
          );

          return MapEntry(index, value);
        })
        .values
        .toList();

    return Center(
      child: Stack(
        children: direction == TextDirection.ltr
            ? allItems.reversed.toList()
            : allItems,
      ),
    );
  }
}
