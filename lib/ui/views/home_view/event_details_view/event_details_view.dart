//This is a file for the [event details page] that navigating from home page

import 'package:flutter/material.dart';
import 'package:kntag/bottomNavBar.dart';
import 'package:kntag/widgets/colorAndSize.dart';

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({Key? key}) : super(key: key);

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large

      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Tag"),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MyAppp()),
                  (Route<dynamic> route) => true);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [PopupMenuItem(child: Text("Suggest"))],
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 2,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Container(
                  width: currentWidth * 0.6,
                  height: currentHeight * 0.9,
                  color: Colors.deepOrange,
                  child: Image.network(
                    "https://c4.wallpaperflare.com/wallpaper/779/691/639/movies-film-reel-technology-projector-8mm-wallpaper-preview.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 3,
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //#Hash tag text
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "#BookClub",
                          style: TextStyle(
                              color: titleColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //subText for tag timing & date
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Location : Race Course\n13th Feb 2022 : 07pm to 10pm",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: greyText,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "14 mins away",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: greyText),
                            ),
                          )
                        ],
                      ),

                      //widget for the line after the subText
                      Divider(
                        thickness: 2.5,
                      ),
                      // Spacer(),
                      //arrnging
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text("hosted by:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: greyText)),
                              Text("DevarajS",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: greyText))
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://44.media.tumblr.com/16dbab1567b517ad54ce0906bcd9102c/tumblr_nmrfvdT1zu1u563huo1_500.gif"),
                          )
                        ],
                      ),
                      // Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 10),
                        child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc placerat",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: greyText),
                        ),
                      ),

                      Spacer(),

                      //
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: currentWidth,
                          height: currentHeight * 0.075,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          whiteClr),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ))),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  buildStackedImages(),
                                  Spacer(),
                                  Text(
                                    "13 Joined\n12/25 Spot Left",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[850]),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: iconCicle,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: buttonBlue,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: currentWidth,
                          height: currentHeight * 0.075,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          buttonBlue),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ))),
                              onPressed: () {
                                print("sent sussess");
                                final snackBar = SnackBar(
                                  content: const Text('Sent Join Request'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: Text("Send Join Request")),
                        ),
                      )
                    ],
                  )),
            ),
          ]),
        ),
      ),
    );
  }

  // Method for calling StackedWidgets class & for passing image url
  Widget buildStackedImages() {
    final double size = 30;
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
