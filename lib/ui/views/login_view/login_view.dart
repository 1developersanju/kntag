import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kntag/tabbar.dart';
import 'package:kntag/widgets/colorAndSize.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.only(left: 18, right: 18, top: 50, bottom: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "Create\nConnect\nCelebrate",
                        style: TextStyle(
                            fontSize: currentHeight * 0.07,
                            color: loginTextColor),
                      ),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        labelText: "Email/User Name"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Enter Password"),
                  ),
                  SizedBox(
                    height: currentHeight * 0.02,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password",
                          style: TextStyle(
                              color: Colors.black87,
                              decoration: TextDecoration.underline))),
                  SizedBox(
                    height: currentHeight * 0.02,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Tabbar()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: buttonBlue,
                          onPrimary: Color.fromARGB(255, 92, 134, 168),
                          minimumSize: Size(double.infinity, 50)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  SizedBox(height: currentHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black12,
                                minimumSize: Size(currentWidth / 2.3, 50)),
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Color.fromARGB(255, 70, 25, 25),
                            ),
                            label: Text(
                              "Login",
                              style: TextStyle(color: Colors.black87),
                            )),
                      ),
                      SizedBox(
                        width: currentWidth * 0.06,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black12,
                                minimumSize: Size(currentWidth / 2.3, 50)),
                            icon: FaIcon(FontAwesomeIcons.facebook,
                                color: Colors.blue[600]),
                            label: Text(
                              "Login",
                              style: TextStyle(color: Colors.black87),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Register with email",
                        style: TextStyle(color: Colors.black87),
                      ))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
