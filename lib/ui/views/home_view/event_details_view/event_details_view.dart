//This is a file for the [event details page] that navigating from home page

import 'package:flutter/material.dart';
import 'package:kntag/bottomNavBar.dart';
import 'package:kntag/ui/views/message_view/people.dart';
import 'package:kntag/widgets/colorAndSize.dart';

class EventDetailsView extends StatefulWidget {
  String title;
  String location;
  String date;
  String time;
  String host;
  String membersJoined;
  String spotLeft;
  List MembersList;
  List ShowcaseImage;
  EventDetailsView({
    required this.date,
    required this.host,
    required this.location,
    required this.time,
    required this.title,
    required this.MembersList,
    required this.membersJoined,
    required this.spotLeft,
    required this.ShowcaseImage,
  });
  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

List a = [
  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
  "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2017/02/01/22/02/mountain-landscape-2031539_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2014/09/14/18/04/dandelion-445228_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2016/08/09/21/54/yellowstone-national-park-1581879_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2016/07/11/15/43/pretty-woman-1509956_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2016/02/13/12/26/aurora-1197753_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2016/11/08/05/26/woman-1807533_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2013/11/28/10/03/autumn-219972_960_720.jpg",
  // "https://cdn.pixabay.com/photo/2017/12/17/19/08/away-3024773_960_720.jpg",
];

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Tag"),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [PopupMenuItem(child: Text(""))],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              padEnds: false,
              controller: PageController(
                viewportFraction: 4.2 / 6,
              ),
              physics: widget.ShowcaseImage.length == 1
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext ctx, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      width: widget.ShowcaseImage.length == 1
                          ? currentWidth * 0.9
                          : currentWidth * 0.65,
                      height: currentHeight * 0.9,
                      child: Image.network(
                        widget.ShowcaseImage[index],
                        fit: BoxFit.cover,
                      )),
                );
              },
              itemCount: widget.ShowcaseImage.length,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                padding: EdgeInsets.only(left: 10, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    //#Hash tag text
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: titleColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //subText for tag timing & date
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Location : ${widget.location}\n${widget.date} : ${widget.time}",
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
                    Spacer(),

                    //widget for the line after the subText
                    Divider(
                      thickness: 2.5,
                    ),
                    Spacer(),
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
                          backgroundImage: NetworkImage("${widget.host}"),
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

                    //Spacer(),

                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: currentWidth,
                        height: currentHeight * 0.075,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(whiteClr),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ))),
                            onPressed: () {
                              void _showSheet() {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true, // set this to true
                                  builder: (_) {
                                    return DraggableScrollableSheet(
                                      expand: false,
                                      builder: (_, controller) {
                                        return Peopl(
                                            peoplecount: widget.membersJoined);
                                      },
                                    );
                                  },
                                );
                              }

                              _showSheet();
                            },
                            child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                buildStackedImages(),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${widget.membersJoined} Joined",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[850]),
                                    ),
                                    Text(
                                      "${widget.spotLeft} Spot Left",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[850]),
                                    ),
                                  ],
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
    );
  }

  // Method for calling StackedWidgets class & for passing image url
  Widget buildStackedImages() {
    final double size = 22;
    final urlImages = widget.MembersList;

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
