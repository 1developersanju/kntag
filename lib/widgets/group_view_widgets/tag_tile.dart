import 'package:flutter/material.dart';

class TagTile extends StatefulWidget {
  String tagText;
  String joinedCount;
  String leftCount;

  TagTile({
    required this.tagText,
    required this.joinedCount,
    required this.leftCount,
  });

  @override
  State<TagTile> createState() => _TagTileState();
}

class _TagTileState extends State<TagTile> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 6.5, left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
          width: currentWidth - 20,
          height: currentHeight / 8,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.tagText,
              //"#BookClub",
              style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  "${widget.joinedCount} Joined\n${widget.leftCount} Spot Left",
                  //"13 Joined\n12/25 Spot Left",
                  style: TextStyle(color: Colors.black87, fontSize: 11),
                ),
                Spacer(),
                buildStackedImages()
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget buildStackedImages() {
    final double size = 28;
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
