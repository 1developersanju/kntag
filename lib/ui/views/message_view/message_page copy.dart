import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final DateTime now = DateTime.now();
  List<Message> messages = [
    Message(
      text: 'First message',
      date: DateTime.now().subtract(Duration(days: 2)),
      isSentByMe: true,
    ),
    Message(
      text: 'First message',
      date: DateTime.now().subtract(Duration(days: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'second message',
      date: DateTime.now().subtract(Duration(days: 3)),
      isSentByMe: true,
    ),
    Message(
      text: 'third message',
      date: DateTime.now().subtract(Duration(days: 1)),
      isSentByMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    TextEditingController crtolr = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
              child: GroupedListView<Message, DateTime>(
            padding: EdgeInsets.all(10),
            elements: messages,
            groupBy: (Message message) => DateTime(
                message.date.day, message.date.month, message.date.year),
            groupHeaderBuilder: (Message message) => SizedBox(
              child: Center(
                  child: Card(
                      child:
                          Text(DateFormat('dd-MM-yyyy').format(message.date)))),
            ),
            itemBuilder: (context, Message message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(message.text),
                ),
              ),
            ),
          )),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: TextField(
                      controller: crtolr,
                      decoration:
                          InputDecoration(hintText: 'typr your message here'),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          // add to the first of the list
                          messages.add(Message(
                            date: DateTime.now(),
                            isSentByMe: true,
                            text: crtolr.text,
                          ));
                        });
                      },
                      icon: Icon(Icons.send)))
            ],
          )
        ],
      ),
    );
  }
}

class Message extends StatefulWidget {
  String text;
  DateTime date;
  bool isSentByMe;

  Message({required this.date, required this.isSentByMe, required this.text});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
