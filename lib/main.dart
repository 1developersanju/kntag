import 'package:flutter/material.dart';
import 'package:kntag/tabbar.dart';
import 'package:kntag/ui/views/Google%20map/current_location_view.dart';
import 'package:kntag/ui/views/Google%20map/map_display.dart';
import 'package:kntag/ui/views/home_view/event_details_view/event_details_view.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/login_view/login_view.dart';
import 'package:kntag/ui/views/post_view/create_tag_view.dart';
import 'package:kntag/ui/views/post_view/post_setting_view/post_setting_view.dart';
import 'package:kntag/ui/views/profile_view/profile_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white60,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue[900],
                unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.867)),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              titleSpacing: 100,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
        home: CurrentLocation()
        //EventDetailsView(tagName: "#BookClub", location: "Race Course", dateTime: "13th Feb 2022 : 07pm to 10pm", awayTime: "14 mins away", hostedName: "Natasa", hostProfilePic: "https://44.media.tumblr.com/16dbab1567b517ad54ce0906bcd9102c/tumblr_nmrfvdT1zu1u563huo1_500.gif", hostBio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nunc placerat", circleImage1: "https://c4.wallpaperflare.com/wallpaper/583/178/494/4k-8k-natasha-romanoff-captain-america-civil-war-wallpaper-preview.jpg", circleImage2: "https://wallpaperaccess.com/full/2388604.jpg", circleImage3: "https://images.wallpapersden.com/image/download/marvel-natasha-romanoff_bGVtZWaUmZqaraWkpJRobWllrWdma2U.jpg", membersJoined: "13 Joined", spotLeft: '',)
        );
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------