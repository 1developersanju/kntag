import 'package:flutter/material.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/ui/maps/street_map.dart';
import 'package:kntag/ui/views/post_view/post_setting_view/post_setting_view.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:place_picker/place_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

//This is code file for Create Tag Page

class CreateTagView extends StatefulWidget {
  final void Function(int) changePage;

  CreateTagView({required this.changePage});
  @override
  State<CreateTagView> createState() => _CreateTagViewState();
}

class _CreateTagViewState extends State<CreateTagView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  DateTime startDate = DateTime.now();

  var startTime = TimeOfDay.now();
  DateTime endDate = DateTime.now().add(Duration(days: 60, hours: 23));
  var endTime = TimeOfDay.now();
  String place = 'place';
  String latitude = '';
  String longitude = '';
  var textFromSecondScreen = "place";
  @override
  void initState() {
    _loadCounter();

    setState(() {});

    reload() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.reload();
    }

    reload();
    // TODO: implement initState
    super.initState();
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = titleController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    setState(() {
      // place = (prefs.getString('place') ?? '');
      // latitude = (prefs.getDouble('latitude') ?? '').toString();
      // longitude = (prefs.getDouble('longitude') ?? '').toString();
    });
  }

  final formGlobalKey = GlobalKey<FormState>();

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
                title: Text(
                  "Create Tag",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                // actions: [
                //   PopupMenuButton(
                //     onSelected: (value) {
                //       if (value == 'settings') {
                //         // _openSettings(context);
                //       }
                //     },
                //     itemBuilder: (BuildContext context) => [
                //       PopupMenuItem(
                //           // onTap: () => _openSettings(context),
                //           child: Text("Settings"))
                //     ],
                //   )
                // ],
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    // height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: formGlobalKey,
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
                                        textCapitalization:
                                            TextCapitalization.sentences,

                                        style: TextStyle(
                                            fontSize: 15.sp), // <-- SEE HERE
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter the tag name.';
                                          }
                                        },
                                        controller: titleController,
                                        maxLines: 1,
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
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      style: TextStyle(fontSize: 15.sp),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Say something about your tag';
                                        }
                                      },
                                      controller: descriptionController,
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
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          style: TextStyle(fontSize: 15.sp),
                                          controller: placeController,
                                          validator: (value) {
                                            if (place == "place" ||
                                                latitude == "" ||
                                                longitude == "") {
                                              return 'choose your tag place';
                                            }
                                          },
                                          maxLines: 2,
                                          readOnly: true,
                                          enableInteractiveSelection:
                                              false, // will disable paste operation
                                          onTap: FirebaseAuth
                                                      .instance.currentUser !=
                                                  null
                                              ? () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  showPlacePicker();
                                                  // goToSecondScreen(context);
                                                }
                                              : () => DialogBox.loginDialog(
                                                  context),
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  borderSide: new BorderSide(
                                                      color: Colors.white)),
                                              filled: true,
                                              fillColor: whiteClr,
                                              hintText: place,
                                              labelText: place)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  keyboardType:
                                                      TextInputType.none,
                                                  initialValue:
                                                      "${formattedStartDate} ",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  onTap: () async {
                                                    // validator:
                                                    // (val) {
                                                    //   if (val != null) {
                                                    //     return null;
                                                    //   } else {
                                                    //     return 'Date Field is Empty';
                                                    //   }
                                                    // };
                                                    DateTime? newDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                startDate,
                                                            firstDate:
                                                                DateTime.now(),
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
                                                                    .circular(
                                                                        6),
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
                                                  keyboardType:
                                                      TextInputType.none,
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
                                                                    .circular(
                                                                        6),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  keyboardType:
                                                      TextInputType.none,
                                                  initialValue:
                                                      "$formattedEndDate",
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                  onTap: () async {
                                                    DateTime? newEndDate =
                                                        await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                endDate,
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
                                                                    .circular(
                                                                        6),
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
                                                  keyboardType:
                                                      TextInputType.none,
                                                  onTap: () async {
                                                    TimeOfDay? newEndTime =
                                                        await showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                endTime);

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
                                                                    .circular(
                                                                        6),
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
                          // Expanded(
                          //   flex: 3,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: 5,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: ClipRRect(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6)),
                          //             child: Container(
                          //               color: Colors.white,
                          //               height: currentHeight * 0.2,
                          //               width: currentWidth * 0.26,
                          //               child: Center(
                          //                   child: Text(
                          //                 "+image",
                          //                 style: TextStyle(color: greyText),
                          //               )),
                          //             ),
                          //           ),
                          //         );
                          //       }),
                          // ),

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
                          // SizedBox(
                          //   height: 20,
                          // ),
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
                                  onPressed:
                                      FirebaseAuth.instance.currentUser != null
                                          ? () async {
                                              Map<String, dynamic> obj = {
                                                "name": titleController.text,
                                                "host": user?.displayName,
                                                "hostProfile": user?.photoURL,
                                                "slots": 25,
                                                "description":
                                                    descriptionController.text,
                                                "latitude": latitude,
                                                "landmark": place,
                                                "hostId": user!.uid,
                                                "longitude": longitude,
                                                "timefrm": startTime
                                                    .format(context)
                                                    .toString(),
                                                "timeto": endTime
                                                    .format(context)
                                                    .toString(),
                                                "datefrm": formattedStartDate
                                                    .toString(),
                                                "dateto":
                                                    formattedEndDate.toString(),
                                              };

                                              print("$endTime");

                                              // MngDB().create_tag();
                                              // print("placeee :: $place");

                                              // screenshotController
                                              //     .captureFromWidget(Container(
                                              //         padding:
                                              //             const EdgeInsets.all(30.0),
                                              //         decoration: BoxDecoration(
                                              //           border: Border.all(
                                              //               color: buttonBlue,
                                              //               width: 5.0),
                                              //         ),
                                              //         child: Text(
                                              //             "This is an invisible widget")))
                                              //     .then((capturedImage) {
                                              //   print(
                                              //       "image Captured $capturedImage");
                                              //   // Handle captured image
                                              // });

                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           PostSettingView(
                                              //         description:
                                              //             descriptionController.text,
                                              //         StartDate:
                                              //             DateTime.now().toString(),
                                              //         endDate:
                                              //             DateTime.now().toString(),
                                              //         endTime: "00:00",
                                              //         place: place,
                                              //         latitude: longitude,
                                              //         longitude: latitude,
                                              //         starttime: "00:00",
                                              //         title: titleController.text,
                                              //       ),
                                              //     ));

                                              if (formGlobalKey.currentState!
                                                  .validate()) {
                                                await createTag(obj, context);
                                                (Route<dynamic> route) => false;
                                                setState(() {});
                                                titleController.clear();
                                                descriptionController.clear();
                                                setState(() {});
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            'Successfully Added')));
                                                widget.changePage(0);
                                              } else {
                                                print("validate form");
                                                (Route<dynamic> route) => false;
                                                setState(() {});
                                              }
                                            }
                                          : () {
                                              DialogBox.loginDialog(context);
                                            },
                                  child: Text(
                                    "Create",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  )),
                            ),
                          ),
                          // Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        );
      }),
    );
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlacePicker(googleMapApi)));

    // Handle the result in your way
    setState(() {
      place = result!.locality..toString();
      latitude = result.latLng.latitude.toString();
      longitude = result.latLng.longitude.toString();
    });
    print("heyyy ${result?.latLng.latitude.toString()}");
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
