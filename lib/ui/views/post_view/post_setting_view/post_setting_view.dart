import 'package:flutter/material.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:sizer/sizer.dart';

class PostSettingView extends StatefulWidget {
  String title;
  String place;
  String StartDate;
  String endDate;
  String starttime;
  String endTime;
  String latitude;
  String longitude;
  String description;
  PostSettingView({
    required this.title,
    required this.place,
    required this.StartDate,
    required this.endDate,
    required this.starttime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
    required this.description,
  });
  @override
  State<PostSettingView> createState() => _PostSettingViewState();
}

class _PostSettingViewState extends State<PostSettingView> {
  List<bool> isCardEnabled = [];
  List<bool> isSecondCardEnabled = [];
  List showTo = ['All', 'Male', 'female'];
  List joinSettings = ['Anyone can join', 'Request to join'];
  int _counter = 5;
  void incrementcounter() {
    setState(() {
      _counter++;
    });
  }

  void decrementcounter() {
    setState(() {
      _counter--;
    });
    if (_counter == -1) {
      setState(() {
        _counter = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Post Settings"),
        // actions: [
        //   PopupMenuButton(
        //     itemBuilder: (context) => [PopupMenuItem(child: Text("change"))],
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                    width: currentWidth,
                    height: currentHeight * 0.25,
                    decoration: BoxDecoration(
                      color: bgColor,
                    ),
                    child: Container(
                        width: currentWidth,
                        height: currentHeight * 0.30,
                        color: transparent,
                        child: Image.asset("assets/SETTING ICON.png"))),
              ),

              Spacer(),
              //-------------------------
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Show to",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: greyText),
                    ),
                    ButtonWidget(showTo, 6.5, 29, isCardEnabled),
                  ],
                ),
              ),

              //------------------------------------------------------------------
              // SizedBox(
              //   height: 20,
              // ),

              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Join Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: greyText,
                      ),
                    ),
                    ButtonWidget(joinSettings, 6.5, 45, isSecondCardEnabled),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'No of Spots',
                        style: TextStyle(color: greyText),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 5.h,
                      width: 60.w,

                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                decrementcounter();
                              },
                              icon: Icon(Icons.remove)),
                          Spacer(),
                          Center(
                              child: Text(
                            '$_counter',
                            style: TextStyle(color: greyText),
                          )),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                incrementcounter();
                              },
                              icon: Icon(Icons.add)),
                        ],
                      ),
                      // padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: whiteClr,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

              //-------------------------------------------------------------------

              // SizedBox(
              //   height: 20,
              // ),

              // Expanded(
              //   flex: 1,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(
              //         child: Text(
              //           "No. of Spots",
              //           style: TextStyle(
              //               color: greyText, fontWeight: FontWeight.w500),
              //         ),
              //       ),
              //       Expanded(
              //         child: Container(
              //           decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(5)),
              //           width: currentWidth / 1.7,
              //           height: currentHeight / 17,
              //           child: Row(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Expanded(
              //                   child: IconButton(
              //                       iconSize: 18,
              //                       onPressed: () {},
              //                       icon: Icon(Icons.remove)),
              //                 ),
              //                 Spacer(),
              //                 Expanded(
              //                   child: Text(
              //                     "05",
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.w500,
              //                         color: greyText),
              //                   ),
              //                 ),
              //                 Spacer(),
              //                 Expanded(
              //                   child: IconButton(
              //                       iconSize: 18,
              //                       onPressed: () {},
              //                       icon: Icon(Icons.add)),
              //                 )
              //               ]),
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              //--------------------------------------------------------------------

              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      DialogBox.showLoading(context, "Creating Tag");
                      MngDB().updateItem(
                          title: widget.title,
                          place: widget.place,
                          StartDate: widget.StartDate,
                          endDate: widget.endDate,
                          starttime: widget.starttime,
                          endTime: widget.endDate,
                          latitude: widget.latitude,
                          longitude: widget.longitude,
                          maxmembers: _counter,
                          description: widget.description,
                          userId: []);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: buttonBlue,
                      fixedSize: Size(currentWidth, currentHeight / 14),
                    ),
                    child: Text("POST")),
              )
            ]),
      ),
    );
  }

  ButtonWidget(List title, double he, int wi, List<bool> cardEnabled) {
    return Container(
      height: he.h,
      //  width: 100.w,
      child: ListView.builder(
          // padding: const EdgeInsets.all(15),
          itemCount: title.length,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            cardEnabled.add(false);

            return GestureDetector(
                onTap: () {
                  cardEnabled.replaceRange(0, cardEnabled.length,
                      [for (int i = 0; i < cardEnabled.length; i++) false]);
                  cardEnabled[index] = true;
                  setState(() {});
                },
                child: SizedBox(
                  height: he.h,
                  width: wi.w,
                  child: Card(
                    color: whiteClr,
                    shape: RoundedRectangleBorder(
                        side: cardEnabled[index]
                            ? BorderSide(color: buttonBlue)
                            : BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        title[index],
                        style: TextStyle(
                            color:
                                cardEnabled[index] ? Colors.black : Colors.grey,
                            fontSize: 11.sp),
                      ),
                    ),
                  ),
                ));
          }),
    );
  }
}
