import 'package:flutter/material.dart';
import 'package:kntag/widgets/home_view_widgets/Bookclub_container.dart';
import 'package:kntag/widgets/home_view_widgets/bookclub_poiter_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          title: Text("Kntag"),
          actions: [
            CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://wallpaperaccess.com/full/2024739.jpg")),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Container(
          width: currentWidth,
          height: currentHeight,
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://fiorecommunications.com/wp-content/uploads/2019/02/image-maps.jpg"),
                  fit: BoxFit.cover)),
          child: Stack(children: [
            Positioned(
              top: 50,
              left: 25,
              child: BookClubPointer()),
              Positioned(
              top: 75,
              left: 250,
              child: BookClubPointer()),
            Positioned(
              top: 150,
              left: 150,
              child: BookClubPointer()),
              Positioned(
              top: 250,
              left: 60,
              child: BookClubPointer()),
            

            Positioned(
              bottom: 25,
              child: BookClubContainer())
          ]),
        ));
  }
}
