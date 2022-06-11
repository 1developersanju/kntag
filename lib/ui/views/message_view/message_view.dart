import 'package:flutter/material.dart';
import 'package:kntag/ui/views/message_view/activeMessage.dart';
import 'package:kntag/ui/views/message_view/oldMessage.dart';
import 'package:kntag/ui/views/message_view/upComingMessage.dart';
import 'package:kntag/widgets/colorAndSize.dart';

// ignore_for_file: unused_local_variable, prefer_const_constructors

class MessageView extends StatefulWidget {
  const MessageView({
    Key? key,
  }) : super(key: key);
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabs = [
    OldMessageView(), ActiveMessageView(), UpcomingMessageView(),
    // StockList(),
    // AuctionList(),
  ];

  late TabController _controller;
  var currentIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        TabController(length: 3, vsync: this, initialIndex: currentIndex);
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
          "Messages",
          style: TextStyle(color: blackClr),
        ),
        elevation: 2,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        backgroundColor: appbarClr,
        bottom: TabBar(
          labelColor: Colors.black,
          tabs: const [
            Tab(
              text: "Old",
            ),
            Tab(
              text: "Active",
            ),
            Tab(
              text: "Upcoming",
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
      backgroundColor: bgColor,
      body: Center(
          child: TabBarView(
        children: _tabs,
        controller: _controller,
      )),
    );
  }
}
