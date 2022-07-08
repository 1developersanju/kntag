import 'package:flutter/material.dart';
import 'package:kntag/core/models/group_tag_list/group_tag_list_model.dart';
import 'package:kntag/widgets/colorAndSize.dart';

import '../../ui/views/home_view/event_details_view/event_details_view.dart';

class BookClubContainer extends StatefulWidget {
  String tagText;
  String location;
  String date;
  String time;
  String joined;
  String spotsLeft;
  String profile;
  List userProfile;

  BookClubContainer({
    required this.tagText,
    required this.location,
    required this.date,
    required this.time,
    required this.spotsLeft,
    required this.joined,
    required this.profile,
    required this.userProfile,
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
              height: currentHeight,
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
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
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
                              Text("Location: ${widget.location}"),
                              Text("${widget.date} : ${widget.time}"),
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
                                    "${widget.joined} Joined . ${widget.spotsLeft} Spot Left",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              )
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Container(
                              height: currentHeight * 0.1,
                              width: currentWidth * 0.20,
                              child: Image.network(profilepic1,fit: BoxFit.cover,),
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: currentHeight * 0.2,
            right: currentWidth * 0.1,
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.profile),
            ),
          ),
          Positioned(
            bottom: currentHeight * -0.001,
            right: currentWidth * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  print("datee: ");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EventDetailsView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPrimary: buttonBlue),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 7,
                    right: 7,
                  ),
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }

  //Method for calling StackedWidgets class & for passing image url
  Widget buildStackedImages() {
    final double size = 22;
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
