import 'package:flutter/material.dart';
import 'package:kntag/ui/views/Google%20map/openMap.dart';
import 'package:kntag/ui/views/home_view/event_details_view/event_details_view.dart';
import 'package:kntag/ui/views/message_view/message_page.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageTagTile extends StatefulWidget {
  String tagText;
  String joinedCount;
  String leftCount;
  List userProfile;
  int index;
  String date;
  String host;
  String location;
  String time;
  List showcaseImg;
  String lat;
  String long;

  MessageTagTile({
    required this.tagText,
    required this.joinedCount,
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
  });

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
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessagePage(
                      userProfile: widget.userProfile,
                      index: widget.index,
                      title: widget.tagText,
                      joinedCount: widget.joinedCount,
                      leftCount: widget.leftCount,
                      date: widget.date,
                      showcaseImg: widget.showcaseImg,
                      time: widget.time,
                      location: widget.location,
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
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
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
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 11.sp),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${widget.leftCount} Spot Left",
                              //"13 Joined\n12/25 Spot Left",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 11.sp),
                            ),
                          ),
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
                                MapUtils.openMap(double.parse(widget.lat),
                                    double.parse(widget.long));

                                print("location tapped");
                              },
                              child: CircleAvatar(
                                  backgroundColor: bgColor,
                                  radius: 2.h,
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 2.h,
                                  )),
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            CircleAvatar(
                                backgroundColor: bgColor,
                                radius: 2.h,
                                child: Icon(
                                  Icons.message,
                                  size: 2.h,
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
    final double size = 28;
    final urlImages = widget.userProfile;

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
