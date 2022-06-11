import 'package:flutter/material.dart';
import 'package:kntag/widgets/colorAndSize.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: bgColor, body: Text("Notification View"));
  }
}
