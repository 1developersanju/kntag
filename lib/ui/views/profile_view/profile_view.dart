import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:kntag/app/db.dart';
import 'package:kntag/app/services/decide_login.dart';
import 'package:kntag/app/services/dialog.dart';
import 'package:kntag/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../app/services/google_login.dart';
import '../../../core/models/group_tag_list/group_tag_list_model.dart';

class ProfileView extends StatefulWidget {
  final void Function(int) changePage;

  ProfileView({required this.changePage});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void initState() {
    // TODO: implement initState
    super.initState();
    containerDetails = tagTileDatas();
  }

  @override
  List<GroupTagList> containerDetails = [];
  File? image;
  Future pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final temporaryImage = File(image.path);
      setState(() {
        this.image = temporaryImage;
      });
    } on PlatformException catch (e) {
      print('unable to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    final dbRef = FirebaseDatabase.instance.ref().child("users/${user!.uid}");
    final dbTagRef = FirebaseDatabase.instance.ref().child("tags");

    return
        // wrong call in wrong place!

        Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: FirebaseAuth.instance.currentUser != null
                        ? () {
                            final provider = Provider.of<GoogleLoginProvider>(
                                context,
                                listen: false);
                            provider.logout();

                            provider.googleLogin;
                            Navigator.pop(context);
                          }
                        : () {
                            DialogBox.loginDialog(context);
                          },
                    icon: Icon(Icons.logout))
              ],
              backgroundColor: bgColor,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              title: Text("Profile"),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Color.fromARGB(255, 88, 108, 125),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      FutureBuilder(
                          future: dbRef.once(),
                          builder: (ctx, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              final userS = snapshot.data!.snapshot.value;
                              return Container(
                                // padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                                width: currentWidth,
                                height: 40.h,
                                color: Colors.white,
                                child: Column(children: [
                                  Flexible(
                                    child: Stack(
                                      children: [
                                        Container(
                                          color: whiteClr,
                                          width: currentWidth,
                                          height: 30.h,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 6.0.h,
                                                left: 3.5.h,
                                                right: 3.5.h),
                                            child: Column(
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color: bgColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    width: currentWidth,
                                                    height: 22.h,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          userS['UserName'] ??
                                                              "Your Name?",
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  titleColor),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: AutoSizeText(
                                                            "${userS['Description']}",
                                                            style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    greyText),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 18,
                                                        )
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 42.w,
                                          top: 2.h,
                                          child:
                                              // image != null
                                              // ? CircleAvatar(
                                              //     radius: 30,
                                              //     child: GestureDetector(
                                              //         onTap: (() {
                                              //           pickimage();
                                              //         }),
                                              //         child: ClipOval(
                                              //           child: Image.file(
                                              //             image!,
                                              //             height: currentHeight / 9.5,
                                              //             width: currentWidth / 6,
                                              //             fit: BoxFit.cover,
                                              //           ),
                                              //         ))

                                              //     //  backgroundImage: NetworkImage(
                                              //     //    "https://wallpaperaccess.com/full/2024739.jpg"),
                                              //     )
                                              // :
                                              Hero(
                                            tag: "profile",
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundImage: NetworkImage(
                                                  "${userS['ProfileImage']}"),
                                              //  backgroundImage: NetworkImage(
                                              //    "https://wallpaperaccess.com/full/2024739.jpg"),
                                            ),
                                          ),
                                        ),
                                        // Positioned(
                                        //   top: 5.h,
                                        //   left: 20.w,
                                        //   child: Column(
                                        //     children: [
                                        //       Image.asset(
                                        //         "assets/yellow_star.png",
                                        //         height: 4.7.w,
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets.all(2.0),
                                        //         child: Text(
                                        //           "5.5",
                                        //           style: TextStyle(
                                        //               color: blackClr,
                                        //               fontWeight: FontWeight.bold,
                                        //               fontSize: 11.sp),
                                        //         ),
                                        //       ),
                                        //       Text("host rating",
                                        //           style: TextStyle(
                                        //               color: greyText,
                                        //               fontSize: 8.sp,
                                        //               fontWeight: FontWeight.w500))
                                        //     ],
                                        //   ),
                                        // ),
                                        // Positioned(
                                        //   top: 5.h,
                                        //   right: 20.w,
                                        //   child: Column(
                                        //     children: [
                                        //       Image.asset(
                                        //         "assets/green_star.png",
                                        //         height: 4.7.w,
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets.all(2.0),
                                        //         child: Text(
                                        //           "5.5",
                                        //           style: TextStyle(
                                        //               color: blackClr,
                                        //               fontWeight: FontWeight.bold,
                                        //               fontSize: 11.sp),
                                        //         ),
                                        //       ),
                                        //       Text("host rating",
                                        //           style: TextStyle(
                                        //               color: greyText,
                                        //               fontSize: 8.sp,
                                        //               fontWeight: FontWeight.w500))
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  //Spacer(),
                                  // SizedBox(
                                  //   height: 7.h, width: 100.w,
                                  //   // flex: 2,
                                  //   child: ListView.builder(
                                  //       scrollDirection: Axis.horizontal,
                                  //       itemCount: 5,
                                  //       itemBuilder: (BuildContext context, int index) {
                                  //         return Padding(
                                  //           padding: EdgeInsets.all(8),
                                  //           child: ConstrainedBox(
                                  //             constraints: const BoxConstraints.tightFor(
                                  //                 width: 100, height: 20),
                                  //             child: OutlinedButton(
                                  //               style: ButtonStyle(
                                  //                   shape: MaterialStateProperty.all<
                                  //                           RoundedRectangleBorder>(
                                  //                       RoundedRectangleBorder(
                                  //                 side: BorderSide(color: greyText),
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(600.0),
                                  //               ))),
                                  //               onPressed: () {},
                                  //               child: Text(
                                  //                 "Submit",
                                  //                 style: TextStyle(
                                  //                     color: greyText,
                                  //                     fontWeight: FontWeight.bold),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         );
                                  //       }),
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: OutlinedButton(
                                  //           onPressed: () {},
                                  //           style: OutlinedButton.styleFrom(
                                  //               shape: RoundedRectangleBorder(
                                  //                 borderRadius: BorderRadius.circular(30.0),
                                  //               ),
                                  //               textStyle: TextStyle(
                                  //                   fontSize: 13, fontWeight: FontWeight.w500),
                                  //               side: BorderSide(
                                  //                 color: greyText,
                                  //               ),
                                  //               primary: greyText,
                                  //               backgroundColor: Colors.white,
                                  //               fixedSize:
                                  //                   Size(currentWidth / 3.5, currentHeight / 17)),
                                  //           child: Text("#Walking")),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 3,
                                  //     ),
                                  //     Expanded(
                                  //       child: OutlinedButton(
                                  //           onPressed: () {},
                                  //           style: OutlinedButton.styleFrom(
                                  //               shape: RoundedRectangleBorder(
                                  //                 borderRadius: BorderRadius.circular(30.0),
                                  //               ),
                                  //               textStyle: TextStyle(
                                  //                   fontSize: 13, fontWeight: FontWeight.w500),
                                  //               side: BorderSide(color: greyText),
                                  //               primary: greyText,
                                  //               backgroundColor: Colors.white,
                                  //               fixedSize:
                                  //                   Size(currentWidth / 3.5, currentHeight / 17)),
                                  //           child: Text("#Dancing")),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     OutlinedButton(
                                  //         onPressed: () {},
                                  //         style: OutlinedButton.styleFrom(
                                  //             shape: RoundedRectangleBorder(
                                  //               borderRadius: BorderRadius.circular(30.0),
                                  //             ),
                                  //             textStyle: TextStyle(
                                  //                 fontSize: 13, fontWeight: FontWeight.w500),
                                  //             side: BorderSide(color: greyText),
                                  //             primary: greyText,
                                  //             backgroundColor: Colors.white,
                                  //             fixedSize:
                                  //                 Size(currentWidth / 3.5, currentHeight / 17)),
                                  //         child: Text("#Music")),
                                  //   ],
                                  // ),
                                  // Spacer()
                                ]),
                              );
                            }
                            return const Center(
                              child: Text('There is something wrong!'),
                            );
                          }),

                      //----------------------------------------------------------------------

                      FutureBuilder(
                          future: dbRef.once(),
                          builder: (ctx, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              final userS = snapshot.data!.snapshot.value;
                              return Container(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                ),
                                width: currentWidth,
                                // height: currentHeight,
                                color: bgColor,
                                child: userS['totaltags'] != 0
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: userS['totaltags'],
                                        itemBuilder: (context, index) {
                                          return BookClubContainer(
                                            membersUid: [],
                                            uid: "",
                                            tagDesc: "",
                                            hostName: "",
                                            hostid: "",
                                            tagId: "",
                                            peopleProfileImg:
                                                containerDetails[index]
                                                    .profileImgs,
                                            peopleName: containerDetails[index]
                                                .memberName,
                                            latitude: containerDetails[index]
                                                .latitude,
                                            longitude: containerDetails[index]
                                                .longitude,
                                            tagText:
                                                containerDetails[index].tagText,
                                            joined:
                                                containerDetails[index].joined,
                                            location: containerDetails[index]
                                                .location,
                                            date: containerDetails[index].date,
                                            time: containerDetails[index].time,
                                            spotsLeft: containerDetails[index]
                                                .spotLeft,
                                            profile: containerDetails[index]
                                                .myProfile,
                                            userProfile: containerDetails[index]
                                                .userProfileData,
                                            page: "tags",
                                          );
                                        },
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "You have not yet created a tag...",
                                            style: TextStyle(
                                                fontFamily: "Singolare",
                                                fontSize: 15.sp),
                                          ),
                                          OutlinedButton(
                                              onPressed:
                                                  FirebaseAuth.instance
                                                              .currentUser ==
                                                          null
                                                      ? () {
                                                          // () => widget.changePage(0);

                                                          DialogBox.loginDialog(
                                                              context);
                                                        }
                                                      : () {
                                                          widget.changePage(2);
                                                          print("object");
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                              child: Text("Create Tag"),
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .red)))))
                                        ],
                                      ),
                              );
                            }
                            return const Center(
                              child: Text('There is something wrong!'),
                            );
                          })
                    ]),
                    // margin: const EdgeInsets.all(10),
                  ),
                ],
              ),
            ));

    // : Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Card(
    //         color: bgColor,
    //         elevation: 10,
    //         child: Container(
    //             decoration: BoxDecoration(
    //                 color: bgColor,
    //                 borderRadius: BorderRadius.circular(15)),
    //             width: currentWidth,
    //             height: 22.h,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   "Login to view more",
    //                   style: TextStyle(
    //                       fontSize: 18.sp,
    //                       fontWeight: FontWeight.bold,
    //                       color: titleColor),
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: ElevatedButton(
    //                       child: Text("Login"),
    //                       onPressed: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => DecideLogin()));
    //                       },
    //                     )),
    //                 SizedBox(
    //                   height: 18,
    //                 )
    //               ],
    //             )),
    //       ),
    //     ),
    //   ),
    // backgroundColor: bgColor,
  }
}
