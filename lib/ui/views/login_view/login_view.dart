import 'dart:ui';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kntag/bottomNavBar.dart';
import 'package:kntag/tabbar.dart';
import 'package:kntag/ui/views/home_view/home_view.dart';
import 'package:kntag/ui/views/login_view/forgetpassword_view.dart';
import 'package:kntag/ui/views/login_view/create_account.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:sizer/sizer.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: bgColor,
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
            extendBody: true,
            body: Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              color: bgColor,
              padding:
                  EdgeInsets.only(left: 18, right: 18, top: 20, bottom: 15),
              child: Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
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
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: new BorderSide(color: Colors.white)),
                          filled: true,
                          fillColor: whiteClr,
                          labelText: "Email/User Name",
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: whiteClr,
                            labelText: "Enter Password"),
                      ),
                    ),
                    SizedBox(
                      height: currentHeight * 0.02,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ResetPasswordtPage()),
                            );
                          },
                          child: Text("Forgot Password",
                              style: TextStyle(
                                  color: greyText,
                                  decoration: TextDecoration.underline,
                                  fontSize: 11.sp))),
                    ),
                    SizedBox(
                      height: currentHeight * 0.02,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyAppp()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: buttonBlue,
                              onPrimary: Color.fromARGB(255, 92, 134, 168),
                              minimumSize: Size(double.infinity, 50)),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
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
                              // your implementation
                            },
                            text: 'Login',
                            style: AuthButtonStyle(
                              buttonColor: whiteClr,
                              height: currentHeight * 0.06,
                              textStyle: TextStyle(fontSize: 14.sp),
                              //   buttonType: AuthButtonType.secondary,
                              iconType: AuthIconType.secondary,
                              margin: const EdgeInsets.only(bottom: 18),
                            ),
                          )),
                          SizedBox(
                            width: currentWidth * 0.06,
                          ),
                          Expanded(
                            child: FacebookAuthButton(
                                onPressed: () {
                                  // your implementation
                                },
                                text: 'Login',
                                style: AuthButtonStyle(
                                  textStyle: TextStyle(fontSize: 14.sp),
                                  height: currentHeight * 0.06,
                                  buttonColor: whiteClr,
                                  // buttonType: AuthButtonType.icon,
                                  iconType: AuthIconType.secondary,
                                  margin: const EdgeInsets.only(bottom: 18),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreatAccountPage()),
                            );
                          },
                          child: Text(
                            "Register with email",
                            style: TextStyle(color: greyText, fontSize: 18),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
