import 'package:flutter/material.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/ui/views/profile_view/profile_test.dart';
import 'package:sizer/sizer.dart';

class NotificationTile extends StatefulWidget {
  String oppProfile;
  String tagText;
  String status;
  // String date;
  String oppName;
  String hostId;

  NotificationTile({
    required this.oppProfile,
    required this.tagText,
    required this.status,
    // String date;
    required this.hostId,
    required this.oppName,
  });

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 6.5, left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          width: currentWidth * 0.2,
          height: widget.status == "request"
              ? currentHeight / 8
              : currentHeight / 11,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileView(
                                userId: widget.hostId,
                                changePage: (int index) {
                                  // setState(() {
                                  //   currentIndexs = index;
                                  // });
                                  print("_changeTa2b $index");
                                },
                              )));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.oppProfile,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.oppName,
                          //"#BookClub",
                          style: TextStyle(
                              color: blackClr,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp),
                        ),
                      ),
                      // Spacer(),
                      widget.status == "request"
                          ? Expanded(
                              child: Text(
                                "Has ${widget.status}ed to join",
                                //"13 Joined\n12/25 Spot Left",
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 10.sp),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                "Has ${widget.status}ed your Tag",
                                //"13 Joined\n12/25 Spot Left",
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 10.sp),
                              ),
                            ),
                      Expanded(
                        child: Text(
                          "${widget.tagText}",
                          //"13 Joined\n12/25 Spot Left",
                          style:
                              TextStyle(color: Colors.black38, fontSize: 11.sp),
                        ),
                      ),
                    ]),
              ),
              Spacer(),
              widget.status == "request"
                  ? Expanded(
                      flex: 3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: buttonBlue,
                          ),
                          onPressed: () {
                            print("approve");
                          },
                          child: Text(
                            "Approve",
                            style: TextStyle(fontSize: 10.sp),
                          )))
                  : SizedBox(),
              SizedBox(
                width: 4,
              ),
              widget.status == "request"
                  ? Expanded(
                      child: GestureDetector(
                          onTap: () {
                            print("cancel");
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                                width: 5,
                                height: currentWidth * 0.08,
                                color: greyText.withOpacity(0.2),
                                child: Icon(Icons.close)),
                          )),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestTile extends StatefulWidget {
  String oppProfile;
  String tagText;
  String status;
  // String date;
  String oppName;

  RequestTile({
    required this.oppProfile,
    required this.tagText,
    required this.status,
    // String date;
    required this.oppName,
  });

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 6.5, left: 10, right: 10),
      child: GestureDetector(
          child: widget.status == "request"
              ? Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  width: currentWidth * 0.2,
                  height: currentHeight / 8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.oppProfile,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.oppName,
                                  //"#BookClub",
                                  style: TextStyle(
                                      color: blackClr,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                ),
                              ),
                              // Spacer(),
                              Expanded(
                                child: Text(
                                  "Has ${widget.status}ed to join",
                                  //"13 Joined\n12/25 Spot Left",
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 10.sp),
                                ),
                              ),

                              Expanded(
                                child: Text(
                                  "${widget.tagText}",
                                  //"13 Joined\n12/25 Spot Left",
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 11.sp),
                                ),
                              ),
                            ]),
                      ),
                      Spacer(),
                      widget.status == "request"
                          ? Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: buttonBlue,
                                  ),
                                  onPressed: () {
                                    print("approve");
                                  },
                                  child: Text(
                                    "Approve",
                                    style: TextStyle(fontSize: 10.sp),
                                  )))
                          : SizedBox(),
                      SizedBox(
                        width: 4,
                      ),
                      widget.status == "request"
                          ? Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    print("cancel");
                                  },
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    child: Container(
                                        width: 5,
                                        height: currentWidth * 0.08,
                                        color: greyText.withOpacity(0.2),
                                        child: Icon(Icons.close)),
                                  )),
                            )
                          : SizedBox(),
                    ],
                  ),
                )
              : SizedBox()),
    );
  }
}
