import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kntag/bottomNavBar.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:kntag/ui/views/login_view/login_view.dart';

// ignore_for_file: file_names, use_key_in_widget_constructors

class DecideLogin extends StatelessWidget {
  const DecideLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: buttonBlue,
              ));
            } else if (snapshot.hasData) {
              return MyAppp();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something Went wrong"),
              );
            } else {
              return const LoginView();
            }
          }),
    );
  }
}
