import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black, 
          ),
        ),
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: Container(
        color: Color.fromARGB(255, 88, 108, 125),
        child: Stack(children: [
          Column(children: [
            Container(
              color: Color.fromARGB(255, 88, 108, 125),
            ),
          ],)
        ]),
      ),
    );
  }
}
