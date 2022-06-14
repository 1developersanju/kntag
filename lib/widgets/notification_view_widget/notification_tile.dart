import 'package:flutter/material.dart';

class NotificationTile extends StatefulWidget {
  String oppProfile;
  String tagText;
  String status;
  // String date;
  String oppName;

  NotificationTile({
    required this.oppProfile,
    required this.tagText,
    required this.status,
    // String date;
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
          padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
          width: currentWidth - 20,
          height: widget.status == "request"
              ? currentHeight / 8
              : currentHeight / 11,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.oppProfile,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.oppName,
                      //"#BookClub",
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    // Spacer(),
                    widget.status == "request"
                        ? Text(
                            "Has ${widget.status}ed to join",
                            //"13 Joined\n12/25 Spot Left",
                            style:
                                TextStyle(color: Colors.black38, fontSize: 15),
                          )
                        : Text(
                            "Has ${widget.status}ed your request",
                            //"13 Joined\n12/25 Spot Left",
                            style:
                                TextStyle(color: Colors.black38, fontSize: 15),
                          ),
                    Text(
                      "${widget.tagText}",
                      //"13 Joined\n12/25 Spot Left",
                      style: TextStyle(color: Colors.black38, fontSize: 11),
                    ),
                  ]),
              Spacer(),
              widget.status == "request"
                  ? ElevatedButton(onPressed: () {}, child: Text("Approve"))
                  : SizedBox(),
              widget.status == "request"
                  ? IconButton(onPressed: () {}, icon: Icon(Icons.close))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
