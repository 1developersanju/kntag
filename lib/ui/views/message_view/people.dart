import 'package:flutter/material.dart';
import 'package:kntag/core/models/peopleModel.dart';

import '../../../colorAndSize.dart';

class Peopl extends StatefulWidget {
  bool backButtonneeded;
  String peoplecount;
  Peopl({required this.peoplecount, required this.backButtonneeded});
  @override
  State<Peopl> createState() => _PeopleState();
}

class _PeopleState extends State<Peopl> {
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
        appBar: AppBar(
          automaticallyImplyLeading:
              widget.backButtonneeded == true ? true : false,
          leading: widget.backButtonneeded == true
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios))
              : SizedBox(),
          elevation: 2,
          title: Text("People"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        backgroundColor: bgColor,
        body: ListView.builder(
          itemCount: int.parse(widget.peoplecount),
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
            margin: EdgeInsets.all(10.0),
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
                  child: Text(widget.name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
