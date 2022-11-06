import 'package:flutter/material.dart';
import 'package:kntag/ui/views/login_view/login_view.dart';

class DialogBox {
  static Future<void> loginDialog(
    parentContext,
  ) {
    return showDialog(
      context: parentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          title: const Text('Hey Guest!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Kindly login to get all access...'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginView()));
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showLoading(parentContext, String title) {
    return showDialog(
      context: parentContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[LinearProgressIndicator()],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
