import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kntag/colorAndSize.dart';
import 'package:shared_preferences/shared_preferences.dart';

final user = FirebaseAuth.instance.currentUser;
final databaseReference = FirebaseDatabase.instance;

// var random = Random().nextInt(9999);
DatabaseReference userRef = FirebaseDatabase.instance.ref("users/${user?.uid}");
DatabaseReference knchat = FirebaseDatabase.instance.ref("knchat");

// DatabaseReference tagRef = FirebaseDatabase.instance
//     .ref("tags/${(user?.uid).toString() + "Tag" + random.toString()}");

FirebaseDatabase db = FirebaseDatabase.instance;
var notification_count = 0;
createUser() async {
  // chat();

  DatabaseReference notification = FirebaseDatabase.instance
      .ref("users/${user?.uid}")
      .child('Notifications')
      .ref;

  await userRef.set({
    "UserName": "${user?.displayName}",
    "Description": "Something about you...!",
    "ProfileImage": "${user?.photoURL}",
    "createdTags": arrset([]),
    "totaltags": 0,
    "totaljoinedtags": 0,
    "JoinedTags": arrset([]),
    "Notifications": arrset([]),
    "NotificationCount": notification_count,
  });

  print("added");
}

updateUserOnCreate(createdTagId, joinedTagId) async {
  DatabaseReference userRef =
      FirebaseDatabase.instance.ref("users/${user?.uid}");

  DatabaseReference userRefaddCreatedTags =
      FirebaseDatabase.instance.ref("users/${user?.uid}").child('createdTags');

  DatabaseEvent event = await userRef.once();

  var totaltags = event.snapshot.child('totaltags').value;

  var increment = int.parse(totaltags.toString()) + 1;
  print("snapshot: ${increment}");
  userRefaddCreatedTags.update({"$increment": createdTagId});
  userRef.update({
    // "Description": "",
    "totaltags": increment,

    // "JoinedTags": arrset([]),
  });
  print("update");
}

updateUserOnJoin(joinedTagId, hostId) async {
  DatabaseReference userRef =
      FirebaseDatabase.instance.ref("users/${user?.uid}");
  DatabaseReference hostRef =
      FirebaseDatabase.instance.ref("users/${hostId}").child('Notifications');
  DatabaseReference userRefaddCreatedTags =
      FirebaseDatabase.instance.ref("users/${user?.uid}").child('JoinedTags');

  DatabaseEvent event = await userRef.once();

  var totaltags = event.snapshot.child('totaljoinedtags').value;
  var notificount = event.snapshot.child('NotificationCount').value;
  var increment = int.parse(notificount.toString()) + 1;
  print("snapshot: ${increment}");
  userRefaddCreatedTags.update({'$increment r': joinedTagId});
  final snapshot = await userRef.child('users/${user?.uid}').get();
  var Notificationcount = int.parse(notificount.toString()) + 1;

  // userRef.update({
  //   // "Description": "",
  //   "NotificationCount": notification_count,

  //   // "JoinedTags": arrset([]),
  // });
  hostRef.push().set({
    "userId": user?.uid,
    "joinedTag": joinedTagId,
    "status": "joined"
  }).then((value) {
    userRef.update({
      // "Description": "",
      "NotificationCount": Notificationcount,

      // "JoinedTags": arrset([]),
    });
  });

  print("update joined user");
}

updateTagOnJoin() {}
deleteTag() {}
getUsers() {}
getTags() {}
arrset(arra) {
  return (json.encode({'arr': arra}));
}

arrget(arra) {
  return (json.decode(arra.arr));
}

newuser() async {
  print("entered new user function");
  final userRef = FirebaseDatabase.instance.ref();
  final snapshot = await userRef.child('users/${user?.uid}').get();
  // print("USER ID ${user?.uid}");
  if (snapshot.value == null) {
    print("heyyy ${snapshot.value}");

    createUser();
    return true;
  } else {
    print("old user ${snapshot}");

    print("old user ${snapshot.value}");
    return false;
  }
}

login() async {
  print("entered login");
  // Future create_file(String fileName, String text) {
  //   return File(fileName).create().then((File file) {
  //     file.writeAsStringSync(text);
  //     return 'The file "$fileName" has been created with "$text" in its body.';
  //   });
  // }

  final userRef = FirebaseDatabase.instance.ref();

  final snapshot = await userRef.child('users/${user?.uid}').get();

  if (newuser() == true) {
    createUser();
    print("created new user ${newuser()}");
  } else {
    // createUser();
    print("userr found : ${user!.displayName} ${newuser()}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', user!.displayName.toString());

    // saveStringValue("value123");

    // print("logging in ${UserSimplePreferences.getUserName()}");

    print("snapshot value");
  }
}

createTag(values, context) async {
  print("entered create tag ${values['name']}");

  DatabaseReference tagRef = FirebaseDatabase.instance.ref("tags");

  DatabaseReference newPostRef = tagRef.push();

  await newPostRef.set({
    "tagname": values['name'],
    "hostProfile": values['hostProfile'],
    "hostname": values['host'],
    "hostId": values['hostId'],
    "membersttl": 0,
    "membresProflie": {},
    "membersUID": {},
    "totalslots": values['slots'],
    "tagdescription": values['description'],
    "map": {
      "latitude": values['latitude'],
      "londitude": values['longitude'],
      "landmark": values['landmark'],
    },
    "time": {
      "from": values['timefrm'],
      "to": values['timeto'],
      "datefrom": values['datefrm'],
      "dateto": values['dateto'],
    }
  });

  updateUserOnCreate(newPostRef.key, '');
  print("tagrefrence: ${tagRef.key}");
  //return promise
  var snackBar = SnackBar(
    backgroundColor: buttonBlue,
    content: Text('Tag created Successfully...!'),
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  showSnackbar(context) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showSnackbar(context);
}

jointag(tagId, hostId) async {
  DatabaseReference tagRef = FirebaseDatabase.instance.ref("tags/${tagId}");

  DatabaseReference tagRefAdduserUid =
      FirebaseDatabase.instance.ref("tags/${tagId}").child('membersUID');
  DatabaseReference tagRefAdduserProfile =
      FirebaseDatabase.instance.ref("tags/${tagId}").child('memberProfile');
  DatabaseEvent event = await tagRef.once();

  var totalmembers = event.snapshot.child('membersttl').value;
  var totalslots = event.snapshot.child('totalslots').value;

  var increment = int.parse(totalmembers.toString()) + 1;
  tagRefAdduserUid.update({"$increment": user?.uid});
  tagRefAdduserProfile.update({"$increment": user?.photoURL});
  var ttlSlots = int.parse(totalslots.toString()) - 1;
  print("snapshot: ${ttlSlots}");

  await tagRef.update({
    "membersttl": increment,
    "totalslots": ttlSlots,
  });
  updateUserOnJoin(tagId, hostId);
  // DatabaseReference tagRef =
  //     FirebaseDatabase.instance.ref("tags/${values.tagid}");
  // var memttl = tagRef.child("membersttl").get();
  // var tguid = tagRef.child("memberUID").get();
  // print("members total::${memttl}");
  // tagRef.update({
  //   "membersttl": memttl,
  //   "membersUID": tguid,
  // });
  // userRef.update({

  // });
}

sendchat(values, context, chatpath) async {
  print("entered create tag ${values['message']}");

  DatabaseReference tagRef = FirebaseDatabase.instance.ref(chatpath);
  DatabaseReference newPostRef = tagRef.push();

  await newPostRef.set({
    "message": values['message'],
    "time": values['time'],
    "uid": values["uid"],
    "prof": values["prof"],
    "israted": values["israted"],
  });

  print("tagrefrence: ${tagRef.key}");
}
                                     