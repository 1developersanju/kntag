import 'package:flutter/material.dart';
import 'package:kntag/main.dart';
import 'package:kntag/widgets/Profile_view_widgets/book_club_container.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
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
              height: currentHeight / 2.18,
              color: Colors.white,
              child: Column(children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.transparent,
                      width: currentWidth,
                      height: currentHeight / 2.8,
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 194, 204, 212),
                                borderRadius: BorderRadius.circular(15)),
                            width: currentWidth,
                            height: currentHeight / 3.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Yuva",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Morbi eget nisl nisi.",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[850]),
                                ),
                                SizedBox(
                                  height: 18,
                                )
                              ],
                            )),
                      ),
                    ),
                    Positioned(
                      left: currentWidth / 2 - 50,
                      top: 0,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            "https://wallpaperaccess.com/full/2024739.jpg"),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: currentWidth / 12,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.orange,
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
                      top: 8,
                      right: currentWidth / 12,
                      child: Column(
                        children: [
                          CircleAvatar(
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
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            side: BorderSide(color: Colors.black),
                            primary: Colors.grey[850],
                            backgroundColor: Colors.white,
                            fixedSize:
                                Size(currentWidth / 3.5, currentHeight / 17)),
                        child: Text("#Walking")),
                    SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            side: BorderSide(color: Colors.black),
                            primary: Colors.grey[850],
                            backgroundColor: Colors.white,
                            fixedSize:
                                Size(currentWidth / 3.5, currentHeight / 17)),
                        child: Text("#Dancing")),
                    SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            side: BorderSide(color: Colors.black),
                            primary: Colors.grey[850],
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
                left: 15,
                right: 15,
                top: 20,
              ),
              width: currentWidth,
              height: currentHeight / 2.18,
              color: Color.fromARGB(255, 194, 204, 212),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return BookclubContainer();
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

}