import 'package:flutter/material.dart';
import 'package:kntag/ui/views/group_view/TagsAndPeople/tags.dart';
import 'package:kntag/ui/views/message_view/activeMessage.dart';
import 'package:kntag/ui/views/message_view/oldMessage.dart';
import 'package:kntag/ui/views/message_view/upComingMessage.dart';
import 'package:kntag/widgets/colorAndSize.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class TagsAndPeopleView extends StatefulWidget {
  const TagsAndPeopleView({
    Key? key,
  }) : super(key: key);
  @override
  _TagsAndPeopleViewState createState() => _TagsAndPeopleViewState();
}

class _TagsAndPeopleViewState extends State<TagsAndPeopleView>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabs = [
    Tags(),
    People() // AuctionList(),
  ];

  late TabController _controller;
  var currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        TabController(length: 2, vsync: this, initialIndex: currentIndex);
    _controller.addListener(() {
      print("index::${_controller.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    int index = currentIndex;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Book Club",
          style: TextStyle(color: blackClr),
        ),
        elevation: 2,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        backgroundColor: appbarClr,
        bottom: TabBar(
          unselectedLabelColor: greyText,
          labelColor: titleColor,
          tabs: const [
            Tab(
              text: "Tags",
            ),
            Tab(
              text: "People",
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          controller: _controller,
        ),
      ),
      backgroundColor: Colors.amber,
      body: Center(
          child: TabBarView(
        children: _tabs,
        controller: _controller,
      )),
    );
  }
}

class People extends StatelessWidget {
  const People({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String profilepic =
        "https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80";

    return Scaffold(
        backgroundColor: bgColor,
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                color: whiteClr,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(profilepic),
                  ),
                  title: Container(child: Text("Manobala Namachiva")),
                ),
              ),
            );
          },
        ));
  }
}
