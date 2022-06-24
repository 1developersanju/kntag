import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kntag/ui/views/profile_view/profile_view.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({Key? key}) : super(key: key);

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(
        255,
        10,
        76,
        205,
      ),
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              'Kntag',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          SizedBox(height: 30),
          Center(
              child: TextButton(
                onPressed: (){
                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileView()),
            );
                },
                  child: Text(
            'Profile',
            style: TextStyle(color: Colors.white),
          ))),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            'Saved',
            style: TextStyle(color: Colors.white),
          )),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          )),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/kntag.jpeg',
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 3),
          )
        ],
      ),
    );
  }
}
