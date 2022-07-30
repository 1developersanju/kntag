import 'package:flutter/material.dart';
import 'package:kntag/ui/maps/street_map.dart';
import 'package:kntag/ui/views/post_view/post_setting_view/post_setting_view.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';

//This is code file for Create Tag Page

class CreateTagView extends StatefulWidget {
  const CreateTagView({Key? key}) : super(key: key);

  @override
  State<CreateTagView> createState() => _CreateTagViewState();
}

Future<void> _openSettings(BuildContext ctx) async {
  await Navigator.push(
      ctx, MaterialPageRoute(builder: (context) => PostSettingView()));
}

class _CreateTagViewState extends State<CreateTagView> {
  DateTime startDate = DateTime(2000, 12, 24);

  TimeOfDay startTime = TimeOfDay(hour: 10, minute: 12);
  String textFromSecondScreen = '';

  DateTime endDate = DateTime(2000, 12, 24);
  TimeOfDay endTime = TimeOfDay(hour: 12, minute: 24);
  @override
  Widget build(BuildContext context) {
    var formattedStartDate =
        "${startDate.year}-${startDate.month}-${startDate.day}";
    var formattedEndDate = "${endDate.year}-${endDate.month}-${endDate.day}";

    TextEditingController txtController = TextEditingController();
    ScreenshotController screenshotController = ScreenshotController();

    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LayoutBuilder(builder: (context, constraint) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: bgColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                // leading: InkWell(
                //   onTap: () {
                // Navigator.pop(context);
                // },
                // child: const Icon(
                //   Icons.arrow_back_ios,
                //   color: Colors.black,
                // ),
                // ),
                // backgroundColor: Colors.transparent,
                centerTitle: true,
                backgroundColor: bgColor,
                title: const Text(
                  "Create Tag",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'settings') {
                        _openSettings(context);
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                          // onTap: () => _openSettings(context),
                          child: Text("Settings"))
                    ],
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 1st TextField for Tag Name
                        Flexible(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 4,
                                  child: Container(
                                    child: TextFormField(
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: new BorderSide(
                                              color: Colors.white),
                                        ),
                                        filled: true,
                                        fillColor: whiteClr,
                                        hintText: "Tag Name",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // 2nd TextField for Tag Description
                                Flexible(
                                  flex: 6,
                                  child: TextField(
                                    maxLines: 8,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                      filled: true,
                                      fillColor: whiteClr,
                                      hintText: "Tag Description",
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                // 3rd TextField for Place
                                Flexible(
                                  flex: 4,
                                  child: Container(
                                    child: TextFormField(
                                        maxLines: 2,
                                        readOnly: true,
                                        enableInteractiveSelection:
                                            false, // will disable paste operation
                                        onTap: () {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          goToSecondScreen(context);
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                          filled: true,
                                          fillColor: whiteClr,
                                          hintText: "place",
                                          labelText: textFromSecondScreen == ""
                                              ? "place"
                                              : textFromSecondScreen,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ), //4th Row TextField for Date & Time Picker
                        Flexible(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start",
                                      style: TextStyle(
                                          fontSize: 13.sp, color: greyText),
                                    ),
                                    // SizedBox(
                                    //   height: 3.5,
                                    // ),
                                    Expanded(
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.start,

                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              width: currentWidth * 0.15,
                                              // height: currentHeight/15,
                                              child: TextFormField(
                                                initialValue:
                                                    "${formattedStartDate}",
                                                style: TextStyle(fontSize: 10),
                                                onTap: () async {
                                                  DateTime? newDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              startDate,
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2022));
                                                  if (newDate == null) {
                                                    return;
                                                  }
                                                  setState(() {
                                                    startDate = newDate;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  filled: true,
                                                  fillColor: whiteClr,
                                                  hintText: "Date",
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              width: currentWidth * 0.15,

                                              //height: currentHeight/15,
                                              child: TextFormField(
                                                onTap: () async {
                                                  TimeOfDay? newTime =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              startTime);

                                                  if (newTime == null) {
                                                    return;
                                                  }
                                                  setState(() {
                                                    startTime = newTime;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  filled: true,
                                                  fillColor: whiteClr,
                                                  hintText:
                                                      "${startTime.hour}:${startTime.minute}",
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "End",
                                      style: TextStyle(
                                          fontSize: 13.sp, color: greyText),
                                    ),
                                    // SizedBox(
                                    //   height: 3.5,
                                    // ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              width: currentWidth * 0.15,
                                              //height: currentHeight/15,
                                              child: TextFormField(
                                                initialValue:
                                                    "$formattedEndDate",
                                                style: TextStyle(fontSize: 10),
                                                onTap: () async {
                                                  DateTime? newEndDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate: endDate,
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2022));

                                                  if (newEndDate == null) {
                                                    return;
                                                  }
                                                  setState(() {
                                                    endDate = newEndDate;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  filled: true,
                                                  fillColor: whiteClr,
                                                  hintText: "DATE",
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: SizedBox(
                                              width: currentWidth * 0.15,
                                              //height: currentHeight/15,
                                              child: TextFormField(
                                                onTap: () async {
                                                  TimeOfDay? newEndTime =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime: endTime);

                                                  if (newEndTime == null) {
                                                    return;
                                                  }
                                                  setState(() {
                                                    endTime = newEndTime;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          borderSide:
                                                              new BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                  filled: true,
                                                  fillColor: whiteClr,
                                                  hintText:
                                                      "${endTime.hour}:${endTime.minute}",
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    child: Container(
                                      color: Colors.white,
                                      height: currentHeight * 0.2,
                                      width: currentWidth * 0.26,
                                      child: Center(
                                          child: Text(
                                        "+image",
                                        style: TextStyle(color: greyText),
                                      )),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Flexible(
                        //       child: ClipRRect(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(6)),
                        //         child: Container(
                        //           color: Colors.white,
                        //           height: currentHeight * 0.3,
                        //           width: currentWidth * 0.3,
                        //           child: Center(
                        //               child: Text(
                        //             "+image",
                        //             style: TextStyle(color: greyText),
                        //           )),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Flexible(
                        //       child: ClipRRect(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(6)),
                        //         child: Container(
                        //           color: Colors.white,
                        //           height: currentHeight * 0.3,
                        //           width: currentWidth * 0.3,
                        //           child: Center(
                        //               child: Text("+image",
                        //                   style: TextStyle(color: greyText))),
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Flexible(
                        //       child: GestureDetector(
                        //         onTap: () => print("upload image"),
                        //         child: ClipRRect(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(6)),
                        //           child: Container(
                        //             color: Colors.white,
                        //             height: currentHeight * 0.3,
                        //             width: currentWidth * 0.3,
                        //             child: Center(
                        //                 child: Text("+image",
                        //                     style:
                        //                         TextStyle(color: greyText))),
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // )
                        // Spacer(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Spacer(),
                        //Button for next function
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        double.infinity, currentHeight / 12),
                                    primary: buttonBlue),
                                onPressed: () {
                                  screenshotController
                                      .captureFromWidget(Container(
                                          padding: const EdgeInsets.all(30.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: buttonBlue, width: 5.0),
                                          ),
                                          child: Text(
                                              "This is an invisible widget")))
                                      .then((capturedImage) {
                                    print("image Captured $capturedImage");
                                    // Handle captured image
                                  });

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PostSettingView()));
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                )),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }

  void goToSecondScreen(BuildContext context) async {
    String dataFromSecondPage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreetMap(),
        ));
    setState(() {
      textFromSecondScreen = dataFromSecondPage;
    });
  }
}
