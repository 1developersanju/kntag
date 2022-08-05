import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kntag/colorAndSize.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: splashBlue,
      body: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.height,
        child: Image.asset(
          "assets/Logo.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
