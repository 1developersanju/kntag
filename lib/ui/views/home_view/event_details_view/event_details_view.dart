//This is a file for the [event details page] that navigating from home page

// ignore_for_file: must_be_immutable

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/ui/views/message_view/people.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/ui/views/profile_view/profile_test.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/models/peopleModel.dart';

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
  String latitude;
  String longitude;
  String hostid;
  List peopleName;
  List peopleProfileImg;
  String tagDesc;
  String hostName;
  List membersUid;
  String tagId;
  EventDetailsView({
    required this.hostName,
    required this.MembersList,
    required this.membersUid,
    required this.tagId,
    required this.date,
    required this.tagDesc,
    required this.host,
    required this.location,
    required this.time,
    required this.title,
    required this.hostid,
    required this.membersJoined,
    required this.spotLeft,
    required this.ShowcaseImage,
    required this.latitude,
    required this.longitude,
    required this.peopleName,
    required this.peopleProfileImg,
  });
  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

List a = [];

class _EventDetailsViewState extends State<EventDetailsView> {
  final dbRef = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Event event = Event(
    //   title: widget.title,
    //   description: "Kntag's Event",
    //   location: widget.location,
    //   startDate: DateTime.parse(widget.date),
    //   endDate: DateTime.parse(widget.date),
    //   androidParams: AndroidParams(
    //     emailInvites: [], // on Android, you can add invite emails to your event.
    //   ),
    // );

    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    List userProfileImgs = [];
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
        // actions: [
        //   PopupMenuButton(
        //     itemBuilder: (context) => [PopupMenuItem(child: Text(""))],
        //   )
        // ],
      ),
      body: StreamBuilder(
          stream: dbRef.child("users/${widget.hostid}").onValue,
          builder: (ctx, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final userS = snapshot.data!.snapshot.value;

              for (var i = 0; i <= widget.membersUid.length - 1; i++) {
                // var profile = dbRef.child("users/")['ProfileImage'][i];
                var name = userS['UserName'][i];
                userProfileImgs.add(name);
              }
              print("userrprofilee  ${widget.MembersList}");
              // addmarkers(userS);
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expanded(
                      //   flex: 3,
                      //   child: PageView.builder(
                      //     padEnds: false,
                      //     controller: PageController(
                      //       viewportFraction: 4.2 / 6,
                      //     ),
                      //     physics: widget.ShowcaseImage.length == 1
                      //         ? NeverScrollableScrollPhysics()
                      //         : BouncingScrollPhysics(),
                      //     scrollDirection: Axis.horizontal,
                      //     itemBuilder: (BuildContext ctx, int index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(5.0),
                      //         child: Container(
                      //             width: widget.ShowcaseImage.length == 1
                      //                 ? currentWidth * 0.9
                      //                 : currentWidth * 0.65,
                      //             height: currentHeight * 0.9,
                      //             child: Image.network(
                      //               widget.ShowcaseImage[index],
                      //               fit: BoxFit.cover,
                      //             )),
                      //       );
                      //     },
                      //     itemCount: widget.ShowcaseImage.length,
                      //   ),
                      // ),
                      Expanded(
                        flex: 4,
                        child: Container(
                            padding: EdgeInsets.only(left: 10, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Spacer(),
                                //#Hash tag text
                                GestureDetector(
                                  onTap: () {
                                    MapsLauncher.launchCoordinates(
                                        double.parse(widget.latitude),
                                        double.parse(widget.longitude),
                                        widget.title);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      widget.title,
                                      style: TextStyle(
                                          color: titleColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    //subText for tag timing & date
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print("location tapped");
                                            // Add2Calendar.addEvent2Cal(event);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              "${widget.date} : ${widget.time}",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: greyText,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            MapsLauncher.launchCoordinates(
                                                double.parse(widget.latitude),
                                                double.parse(widget.longitude),
                                                widget.title);
                                          },
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: AutoSizeText(
                                                  " Location : ${widget.location}",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: greyText,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Spacer(),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          left: 8,
                                          right: 8,
                                        ),
                                        child: Text(
                                          // "14 mins away",
                                          "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: greyText),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // Spacer(),

                                //widget for the line after the subText
                                Divider(
                                  thickness: 2.3,
                                ),
                                // Spacer(),
                                //arrnging
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("hosted by:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp,
                                                color: greyText)),
                                        Text("${widget.hostName}",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w900,
                                                color: greyText))
                                      ],
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileView(
                                                      userId: widget.hostid,
                                                      changePage: (int index) {
                                                        // setState(() {
                                                        //   currentIndexs = index;
                                                        // });
                                                        print(
                                                            "_changeTa2b $index");
                                                      },
                                                    )));
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${userS['ProfileImage']}"),
                                        radius: 2.7.h,
                                      ),
                                    )
                                  ],
                                ),
                                // Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 10),
                                  child: AutoSizeText(
                                    widget.tagDesc,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w300,
                                        color: greyText),
                                    maxLines: 15,
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
                                                MaterialStateProperty.all<
                                                    Color>(whiteClr),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ))),
                                        onPressed: () {
                                          print("peeps:${widget.peopleName}");

                                          void _showSheet() {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled:
                                                  true, // set this to true
                                              builder: (_) {
                                                return DraggableScrollableSheet(
                                                  expand: false,
                                                  builder: (BuildContext
                                                          context,
                                                      ScrollController
                                                          scrollController) {
                                                    return Container(
                                                        color: bgColor,
                                                        child:
                                                            widget.membersJoined ==
                                                                    "0"
                                                                ? Center(
                                                                    child: Text(
                                                                        "No joined users available"),
                                                                  )
                                                                : ListView
                                                                    .builder(
                                                                    controller:
                                                                        scrollController,
                                                                    itemCount: int
                                                                        .parse(widget
                                                                            .membersJoined),
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              "membersuid${widget.membersUid[index]}");
                                                                          print(
                                                                              "membersuid${widget.membersUid[index]}");
                                                                          print(
                                                                              "membersuid${widget.peopleName[index]}");

                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => ProfileView(
                                                                                        userId: widget.membersUid[index],
                                                                                        changePage: (int index) {
                                                                                          // setState(() {
                                                                                          //   currentIndexs = index;
                                                                                          // });
                                                                                          print("_changeTa2b $index");
                                                                                        },
                                                                                      )));
                                                                        },
                                                                        child:
                                                                            Peopleview(
                                                                          name:
                                                                              widget.peopleName[index],
                                                                          profpic:
                                                                              widget.peopleProfileImg[index],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ));
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "${widget.membersJoined} Joined",
                                                  style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: greyText),
                                                ),
                                                // Text(
                                                //   "${widget.spotLeft} Spot Left",
                                                //   style: TextStyle(
                                                //       fontSize: 11.sp,
                                                //       fontWeight:
                                                //           FontWeight.w400,
                                                //       color: greyText),
                                                // ),
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
                                // Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: currentWidth,
                                      height: currentHeight * 0.075,
                                      child: widget.hostid == user?.uid ||
                                              widget.membersUid
                                                  .contains("${user?.uid}")
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<Color>(
                                                          Colors.green),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ))),
                                              onPressed: () {
                                                widget.hostid == user?.uid
                                                    ? print("equal")
                                                    : print("not equal");
                                                // jointag(widget.tagId);
                                                final snackBar = SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text('view tag'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              },
                                              child: Text(
                                                "View Tag",
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ))
                                          : ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(buttonBlue),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ))),
                                              onPressed: () async {
                                                print("sent sussess");
                                                await jointag(widget.tagId,
                                                    widget.hostid);
                                                Navigator.pop(context);
                                                final snackBar = SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: const Text(
                                                      'joined successfully'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              },
                                              child: Text(
                                                "Join Tag",
                                                style:
                                                    TextStyle(fontSize: 13.sp),
                                              ))),
                                )
                              ],
                            )),
                      ),
                    ]),
              );
            }
            return Center(
              child: Text("Something went wrong"),
            );
          }),
    );
  }

  // Method for calling StackedWidgets class & for passing image url
  Widget buildStackedImages() {
    final double size = 9.w;
    final urlImages =
        widget.membersJoined == "0" ? [widget.host] : widget.peopleProfileImg;

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
