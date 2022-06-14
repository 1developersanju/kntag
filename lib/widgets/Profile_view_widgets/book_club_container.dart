import 'package:flutter/material.dart';

class BookclubContainer extends StatefulWidget {
  const BookclubContainer({Key? key}) : super(key: key);

  @override
  State<BookclubContainer> createState() => _BookclubContainerState();
}

class _BookclubContainerState extends State<BookclubContainer> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.all(5),
        width: currentWidth,
        height: currentHeight / 5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "#BookClub",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      fontSize: 15),
                ),
                Spacer(),
                Text(
                  "Location : Race Course",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                      fontSize: 12),
                ),
                Text(
                  "13 Feb 2022 : 07pm to 10pm",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                      fontSize: 12),
                ),

                Spacer(),

                //divider is not displaying
                Divider(
                  endIndent: 100,
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
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                          fontSize: 12),
                    )
                  ],
                )
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: currentWidth / 4,
                      height: currentHeight / 5.5,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://wallpaperboat.com/wp-content/uploads/2019/11/cinema-01.jpg"),
                                  fit: BoxFit.cover)),
                          width: currentWidth / 4,
                          height: currentHeight / 8,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 84,
                      right: 22,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://greatloveart.com/wp-content/uploads/2021/06/Spider-Man-4k-wallpaper.jpg"),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
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
