import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 9, 76, 205),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child:  Image.asset("assets/kntag.jpeg"),
    );
  }
}
