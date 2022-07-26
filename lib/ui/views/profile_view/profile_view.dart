import 'dart:io';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:kntag/main.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';

import '../../../core/models/group_tag_list/group_tag_list_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

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
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
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
        child: Container(
          color: Color.fromARGB(255, 88, 108, 125),
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              width: currentWidth,
              height: currentHeight * 0.45,
              color: Colors.white,
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      width: currentWidth,
                      height: currentHeight * 0.36,
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(15)),
                            width: currentWidth,
                            height: currentHeight * 0.27,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Yuva",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: titleColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Morbi eget nisl nisi.",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: greyText),
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                )
                              ],
                            )),
                      ),
                    ),
                    Positioned(
                      left: currentWidth * 0.4,
                      top: currentWidth * 0.02,
                      child: CircleAvatar(
                          radius: 30,
                          child: image != null
                              ? GestureDetector(
                                  onTap: (() {
                                    pickimage();
                                  }),
                                  child: ClipOval(
                                    child: Image.file(
                                      image!,
                                      height: currentHeight / 9.5,
                                      width: currentWidth / 6,
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              : GestureDetector(
                                  onTap: (() {
                                    pickimage();
                                  }),
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                  ))
                          //  backgroundImage: NetworkImage(
                          //    "https://wallpaperaccess.com/full/2024739.jpg"),
                          ),
                    ),
                    Positioned(
                      top: currentHeight * 0.03,
                      left: currentWidth * 0.05,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.orange,
                            child: Icon(
                              Icons.star,
                              color: whiteClr,
                              size: 15,
                            ),
                          ),
                          Text(
                            "5.5",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Text("host rating",
                              style: TextStyle(
                                  color: Colors.grey[850],
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Positioned(
                      top: currentHeight * 0.03,
                      right: currentWidth * 0.05,
                      child: Column(
                        children: [
                          CircleAvatar(
                            child: Icon(
                              Icons.star,
                              color: whiteClr,
                              size: 15,
                            ),
                            radius: 12,
                            backgroundColor: Colors.green,
                          ),
                          Text(
                            "5.5",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          Text("crew rating",
                              style: TextStyle(
                                  color: Colors.grey[850],
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500))
                        ],
                      ),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              textStyle: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                              side: BorderSide(
                                color: greyText,
                              ),
                              primary: greyText,
                              backgroundColor: Colors.white,
                              fixedSize:
                                  Size(currentWidth / 3.5, currentHeight / 17)),
                          child: Text("#Walking")),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              textStyle: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                              side: BorderSide(color: greyText),
                              primary: greyText,
                              backgroundColor: Colors.white,
                              fixedSize:
                                  Size(currentWidth / 3.5, currentHeight / 17)),
                          child: Text("#Dancing")),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            textStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            side: BorderSide(color: greyText),
                            primary: greyText,
                            backgroundColor: Colors.white,
                            fixedSize:
                                Size(currentWidth / 3.5, currentHeight / 17)),
                        child: Text("#Music")),
                  ],
                ),
                Spacer()
              ]),
            ),

            //----------------------------------------------------------------------

            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              width: currentWidth,
              height: currentHeight * 1.2,
              color: bgColor,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return BookClubContainer(
                    tagText: containerDetails[index].tagText,
                    joined: containerDetails[index].joined,
                    location: containerDetails[index].location,
                    date: containerDetails[index].date,
                    time: containerDetails[index].time,
                    spotsLeft: containerDetails[index].spotLeft,
                    profile: containerDetails[index].myProfile,
                    userProfile: containerDetails[index].userProfileData,
                    page: "tags",
                  );
                },
              ),
            )
          ]),
          // margin: const EdgeInsets.all(10),
        ),
      ),
      backgroundColor: bgColor,
    );
  }
}
