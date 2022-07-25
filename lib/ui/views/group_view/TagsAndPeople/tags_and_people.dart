import 'package:flutter/material.dart';
import 'package:kntag/core/models/peopleModel.dart';
import 'package:kntag/ui/views/group_view/TagsAndPeople/tags.dart';
import 'package:kntag/ui/views/message_view/activeMessage.dart';
import 'package:kntag/ui/views/message_view/oldMessage.dart';
import 'package:kntag/ui/views/message_view/upComingMessage.dart';
import 'package:kntag/widgets/colorAndSize.dart';
import 'package:sizer/sizer.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class TagsAndPeopleView extends StatefulWidget {
  String title;
  String memberCount;
  TagsAndPeopleView({required this.title, required this.memberCount});
  @override
  _TagsAndPeopleViewState createState() => _TagsAndPeopleViewState();
}

class _TagsAndPeopleViewState extends State<TagsAndPeopleView>
    with SingleTickerProviderStateMixin {
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
    final List<Widget> _tabs = [
      Tags(),
      People(
        itemCount: widget.memberCount,
      ) // AuctionList(),
    ];
    int index = currentIndex;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: blackClr, fontSize: 14.sp),
        ),
        elevation: 2,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        backgroundColor: appbarClr,
        bottom: TabBar(
          unselectedLabelColor: blackClr,
          labelColor: titleColor,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          tabs: const [
            Tab(
              text: "Tags",
            ),
            Tab(text: "People"),
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

class People extends StatefulWidget {
  String itemCount;
  People({required this.itemCount});
  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  List<GrpPeopledata> containerDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    containerDetails = groupPeope();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: ListView.builder(
          itemCount: int.parse(widget.itemCount),
          itemBuilder: (context, index) {
            return Peopleview(
              name: containerDetails[index].name,
              profpic: containerDetails[index].profpic,
            );
          },
        ));
  }
}

class Peopleview extends StatefulWidget {
  String name;
  String profpic;

  Peopleview({required this.name, required this.profpic, Key? key});

  @override
  State<Peopleview> createState() => _PeopleviewState();
}

class _PeopleviewState extends State<Peopleview> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                    backgroundImage: NetworkImage(
                  widget.profpic,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.name,
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
