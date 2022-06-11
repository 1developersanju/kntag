import 'package:flutter/material.dart';
import 'package:kntag/tabbar.dart';
import 'package:kntag/ui/views/home_view/event_details_view/event_details_view.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/login_view/login_view.dart';

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
        home: EventDetailsView());
  }
}
