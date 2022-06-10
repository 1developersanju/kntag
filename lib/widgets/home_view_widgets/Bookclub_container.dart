import 'package:flutter/material.dart';
import 'package:kntag/core/models/home_tag/home_tag_model.dart';

import '../../core/models/group_tag_list/group_tag_list_model.dart';

class BookClubContainer extends StatefulWidget {
  String tagText;
  String subText;
  String address;

  BookClubContainer({
    required this.tagText,
    required this.subText,
    required this.address,
  });
  @override
  State<BookClubContainer> createState() => _BookClubContainerState();
}

class _BookClubContainerState extends State<BookClubContainer> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(right: 6.0, left: 2.0, bottom: 4),
      child: Stack(
        // alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            child: Container(
              color: Colors.transparent,
              height: currentHeight / 2,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  width: currentWidth - 40,
                  height: currentHeight / 5,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.100),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tagText,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                              fontSize: 15),
                        ),
                        Spacer(),
                        Text("Location: Race Course"),
                        Text("13th Feb 2022 : 07pm to 10pm"),
                        Spacer(),
                        Divider(
                          endIndent: 300,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            buildStackedImages(),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "13 Joined . 12/25 Spot Left",
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        )
                      ]),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 167,
            right: 15,
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage("https://wallpapercave.com/wp/wp4298215.jpg"),
            ),
          ),
          Positioned(
            right: 15,
            bottom: -1,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPrimary: Colors.blue),
                child: Text(
                  "Join",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  // Method for calling StackedWidgets class & for passing image url
  Widget buildStackedImages() {
    final double size = 22;
    final urlImages = [
      "https://c4.wallpaperflare.com/wallpaper/583/178/494/4k-8k-natasha-romanoff-captain-america-civil-war-wallpaper-preview.jpg",
      "https://wallpaperaccess.com/full/2388604.jpg",
      "https://images.wallpapersden.com/image/download/marvel-natasha-romanoff_bGVtZWaUmZqaraWkpJRobWllrWdma2U.jpg"
    ];

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
