import 'package:flutter/material.dart';
import 'package:kntag/ui/views/post_view/post_setting_view/post_setting_view.dart';
import 'package:kntag/widgets/colorAndSize.dart';

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

  DateTime endDate = DateTime(2000, 12, 24);
  TimeOfDay endTime = TimeOfDay(hour: 12, minute: 24);
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Large

        child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  // Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.transparent,
              centerTitle: true,
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
              child: Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1st TextField for Tag Name
                    Container(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          enabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: whiteClr,
                          hintText: "Tag Name",
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // 2nd TextField for Tag Description
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: whiteClr,
                        hintText: "Tag Description",
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // 3rd TextField for Place
                    TextFormField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      enabledBorder: InputBorder.none,
                      filled: true,
                      fillColor: whiteClr,
                      hintText: "Place",
                    )),

                    SizedBox(
                      height: 16,
                    ),

                    //4th Row TextField for Date & Time Picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start"),
                            SizedBox(
                              height: 3.5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: currentWidth / 5.6,
                                  // height: currentHeight/15,
                                  child: TextFormField(
                                    initialValue: "$startDate",
                                    style: TextStyle(fontSize: 10),
                                    onTap: () async {
                                      DateTime? newDate = await showDatePicker(
                                          context: context,
                                          initialDate: startDate,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2022));
                                      if (newDate == null) {
                                        return;
                                      }
                                      setState(() {
                                        startDate = newDate;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: whiteClr,
                                      hintText: "Date",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width: currentWidth / 5.6,
                                  //height: currentHeight/15,
                                  child: TextFormField(
                                    onTap: () async {
                                      TimeOfDay? newTime = await showTimePicker(
                                          context: context,
                                          initialTime: startTime);

                                      if (newTime == null) {
                                        return;
                                      }
                                      setState(() {
                                        startTime = newTime;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: whiteClr,
                                      hintText:
                                          "${startTime.hour}:${startTime.minute}",
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("End"),
                            SizedBox(
                              height: 3.5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: currentWidth / 5.6,
                                  //height: currentHeight/15,
                                  child: TextFormField(
                                    initialValue: "$endDate",
                                    style: TextStyle(fontSize: 10),
                                    onTap: () async {
                                      DateTime? newEndDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: endDate,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2022));

                                      if (newEndDate == null) {
                                        return;
                                      }
                                      setState(() {
                                        endDate = newEndDate;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: whiteClr,
                                      hintText: "DATE",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width: currentWidth / 5.6,
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
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      enabledBorder: InputBorder.none,
                                      filled: true,
                                      fillColor: whiteClr,
                                      hintText:
                                          "${endTime.hour}:${endTime.minute}",
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),

                    SizedBox(
                      height: 18,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          height: currentHeight / 7,
                          width: currentWidth / 4,
                          child: Center(child: Text("+image")),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          color: Colors.white,
                          height: currentHeight / 7,
                          width: currentWidth / 4,
                          child: Center(child: Text("+image")),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => print("upload image"),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.white,
                              height: currentHeight / 7,
                              width: currentWidth / 4,
                              child: Center(child: Text("+image")),
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //Button for next function
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(double.infinity, currentHeight / 12),
                              primary: Colors.blue[900]),
                          onPressed: () {},
                          child: Text("Next")),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
