import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/app/services/notif_api.dart';
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
  final TextEditingController startDateController = TextEditingController(),
      endDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController(),
      endTimeController = TextEditingController();
  DateTime? startDate, endData;
  TimeOfDay? startTime, endTime;
  String place = 'place';
  String latitude = '';
  String longitude = '';
  var textFromSecondScreen = "place";

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 120)),
    );
  }

  Future<TimeOfDay?> pickTime() async {
    return showTimePicker(initialTime: TimeOfDay.now(), context: context);
  }

  String _displayText(String begin, DateTime? date) {
    if (date != null) {
      return '${date.toString().split(' ')[0]}';
    } else {
      return 'Choose The Date';
    }
  }

  String _displayTimeText(String begin, TimeOfDay? time) {
    if (time != null) {
      return '${time.format(context).toString()}';
    } else {
      return 'Choose The Date';
    }
  }

  String? startDateValidator(value) {
    if (startDate == null || startDate!.isBefore(DateTime.now()))
      return "select the date";

    /// play with logicr
  }

  String? startTimeValidator(value) {
    double toDouble(TimeOfDay timePicked) =>
        timePicked.hour + timePicked.minute / 60.0;

    if (startTime == null ||
        (startDate!.isBefore(DateTime.now()) &&
            toDouble(startTime!) == TimeOfDay.now())) {
      return "time the date";
    }

    /// play with logic
  }

  String? endTimeValidator(value) {
    double toDouble(TimeOfDay timePicked) =>
        timePicked.hour + timePicked.minute / 60.0;

    if (endTime == null) {
      return "time the date";
    }

    /// play with logic
  }

  String? endDateValidator(value) {
    if (startDate != null && endData == null) {
      return "select Both data";
    }
    if (endData == null) return "select the date";
    if (endData!.isBefore(startDate!)) {
      return "End date must be after startDate";
    }

    return null; // optional while already return type is null
  }

  @override
  void initState() {
    NotificationApi.init();

    _loadCounter();

    setState(() {});
    //dateController.text = '';

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
  bool showTooltip = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController txtController = TextEditingController();
    ScreenshotController screenshotController = ScreenshotController();

    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LayoutBuilder(builder: (context, constraint) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: GestureDetector(
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
                                                        BorderRadius.circular(
                                                            6),
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
                                                    controller:
                                                        startDateController,
                                                    keyboardType:
                                                        TextInputType.none,
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                    validator:
                                                        startDateValidator,
                                                    // validator:,
                                                    onTap: () async {
                                                      startDate =
                                                          await pickDate();
                                                      startDateController.text =
                                                          _displayText("start",
                                                              startDate);
                                                      setState(() {});
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
                                                    controller:
                                                        startTimeController,
                                                    keyboardType:
                                                        TextInputType.none,
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                    readOnly: true,
                                                    validator:
                                                        startTimeValidator,
                                                    onTap: () async {
                                                      startTime =
                                                          await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  TimeOfDay
                                                                      .now());
                                                      startTimeController.text =
                                                          _displayTimeText(
                                                              "Start",
                                                              startTime);
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
                                                      hintText: "Time",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                    controller:
                                                        endDateController,
                                                    readOnly: true,
                                                    keyboardType:
                                                        TextInputType.none,
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                    validator: endDateValidator,
                                                    onTap: () async {
                                                      endData =
                                                          await pickDate();

                                                      endDateController.text =
                                                          _displayText(
                                                              "end", endData);
                                                      setState(() {});
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
                                                    controller:
                                                        endTimeController,
                                                    validator: endTimeValidator,
                                                    keyboardType:
                                                        TextInputType.none,
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                    onTap: () async {
                                                      endTime =
                                                          await showTimePicker(
                                                              context: context,
                                                              initialTime:
                                                                  TimeOfDay
                                                                      .now());
                                                      endTimeController.text =
                                                          _displayTimeText(
                                                              "end", endTime);

                                                      if (pickTime != null) {
                                                        // print(pickeDate);
                                                        //                                                       //  print(formatedDate);
                                                        setState(() {});
                                                      } else {
                                                        print(
                                                            'Time is not selected');
                                                      }
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
                                                      hintText: "Time",
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
                                        minimumSize: Size(double.infinity,
                                            currentHeight / 12),
                                        primary: buttonBlue),
                                    onPressed: FirebaseAuth
                                                .instance.currentUser !=
                                            null
                                        ? () async {
                                            Map<String, dynamic> obj = {
                                              "name":
                                                  "???${titleController.text}",
                                              "host": user?.displayName,
                                              "hostProfile": user?.photoURL,
                                              "slots": 25,
                                              "description":
                                                  descriptionController.text,
                                              "latitude": latitude,
                                              "landmark": place,
                                              "hostId": user!.uid,
                                              "longitude": longitude,
                                              "timefrm": startTimeController
                                                  .text
                                                  .toString(),
                                              "timeto": endTimeController.text
                                                  .toString(),
                                              "datefrm":
                                                  startDateController.text,
                                              "dateto": endDateController.text,
                                            };

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

                                              widget.changePage(0);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Fill details properly.')));
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
          ),
        );
      }),
    );
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PlacePicker(googleMapApi)));

    // Handle the result in your way
    setState(() {
      place = "${result!.name.toString()},${result.locality.toString()}";
      latitude = result.latLng!.latitude.toString();
      longitude = result.latLng!.longitude.toString();
    });
    print("heyyy ${result?.latLng!.latitude.toString()}");
  }

  // void goToSecondScreen(BuildContext context) async {
  //   String dataFromSecondPage = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => StreetMap(),
  //       ));
  //   setState(() {
  //     textFromSecondScreen = dataFromSecondPage;
  //   });
  // }
}
