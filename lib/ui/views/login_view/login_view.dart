import 'dart:io';
import 'dart:ui';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kntag/app/services/google_login.dart';
import 'package:kntag/bottomNavBar.dart';
import 'package:kntag/tabbar.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/login_view/forgetpassword_view.dart';
import 'package:kntag/ui/views/login_view/create_account.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(exit(0)),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: LayoutBuilder(builder: (context, constraints) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: transparent,
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyAppp()));
                      },
                      child: Text("Skip", style: TextStyle(fontSize: 11.sp)))
                ],
              ),
              backgroundColor: bgColor,
              resizeToAvoidBottomInset: false,
              extendBodyBehindAppBar: true,
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image-5.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          blackClr.withOpacity(0.3), BlendMode.darken)),
                ),
                child: Container(
                  margin: new EdgeInsets.symmetric(horizontal: 20.0),
                  // color: bgColor,
                  padding:
                      EdgeInsets.only(left: 18, right: 18, top: 20, bottom: 15),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Spacer(),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  "Create\nConnect\nCelebrate",
                                  style: TextStyle(
                                      fontSize: 35.sp, color: loginTextColor),
                                ),
                              ),
                              // Spacer()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),

                        SizedBox(height: currentHeight * 0.04),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: GoogleAuthButton(
                                onPressed: () {
                                  final provider =
                                      Provider.of<GoogleLoginProvider>(context,
                                          listen: false);
                                  provider.googleSignIn();

                                  provider.googleLogin;
                                  // your implementation
                                },
                                text: 'Login with Google',
                                style: AuthButtonStyle(
                                  buttonColor: whiteClr,
                                  height: currentHeight * 0.06,
                                  textStyle: TextStyle(fontSize: 14.sp),
                                  //   buttonType: AuthButtonType.secondary,
                                  iconType: AuthIconType.secondary,
                                  margin: const EdgeInsets.only(bottom: 18),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
