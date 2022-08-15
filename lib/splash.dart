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

// class Page3 extends StatelessWidget {
//   const Page3({Key? key, required this.changePage}) : super(key: key);
//   final void Function(int) changePage;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(' Page', style: Theme.of(context).textTheme.headline6),
//           ElevatedButton(
//             onPressed: () => changePage(0),
//             child: const Text('Switch to Home Page'),
//           )
//         ],
//       ),
//     );
//   }
// }
