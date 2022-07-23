import 'package:flutter/material.dart';
import 'package:kntag/ui/views/home_view/event_details_view/event_details_view.dart';
import 'package:kntag/ui/views/message_view/message_page.dart';
import 'package:kntag/widgets/colorAndSize.dart';

class MessageTagTile extends StatefulWidget {
  String tagText;
  String joinedCount;
  String leftCount;
  List userProfile;
  int index;

  MessageTagTile(
      {required this.tagText,
      required this.joinedCount,
      required this.leftCount,
      required this.userProfile,
      required this.index});

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
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 15),
            width: currentWidth - 20,
            height: currentHeight / 8,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tagText,
                          //"#BookClub",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "${widget.joinedCount} Joined\n${widget.leftCount} Spot Left",
                          //"13 Joined\n12/25 Spot Left",
                          style: TextStyle(color: Colors.black87, fontSize: 11),
                        ),
                      ]),
                ),
                Spacer(),
                Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: bgColor,
                              radius: 13,
                              child: Icon(
                                Icons.location_pin,
                                size: 14,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                              backgroundColor: bgColor,
                              radius: 13,
                              child: Icon(
                                Icons.message,
                                size: 13,
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
