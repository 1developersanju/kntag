import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kntag/tabbar.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 229, 236),
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
                            fontSize: 35, color: Color.fromARGB(255, 98, 41, 37)),
                      ),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: "Email/User Name"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        labelText: "Enter Password"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password",
                          style: TextStyle(
                              color: Colors.black87,
                              decoration: TextDecoration.underline))),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Tabbar()),
            );},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                          onPrimary: Color.fromARGB(255, 92, 134, 168),
                          minimumSize: Size(double.infinity, 50)),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
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
                      SizedBox(
                        width: 12,
                      ),
                      ElevatedButton.icon(
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
