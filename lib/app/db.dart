import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kntag/app/services/google_login.dart';
import 'dart:math' as math;

FirebaseFirestore db = FirebaseFirestore.instance;

final FirebaseAuth auth = FirebaseAuth.instance;
final CollectionReference _mainCollection = db.collection('Users');

final CollectionReference _tagCollection = db.collection('Tags');
final user = FirebaseAuth.instance.currentUser;
var randomId = math.Random().nextInt(99999).toString();
// print("randomID::$randomId");
var tagId = user!.uid + "Tag" + randomId;

class MngDB {
  void getStarted_addData() async {
    final user = <String, dynamic>{
      "UID1": {
        "username": "",
        "profileimage": "",
        "about": "",
        "createdtags": {
          "tagID1": {
            "tagname": "",
            "hostname": "",
            "membersUID": [],
            "totalslots": 0,
            "tagdescription": "",
            "map": {"lattitude": 0.0, "longditude": 0.0, "landmark": ""},
            "time": {"from": "", "to": "", "datefrom": "", "dateto": ""}
          }
        },
        "joinedtags": {"tagID1": ""}
      },
      "tags": {"tagID1": "#uidof user"}
    };

    // Add a new document with a generated ID
    db.collection("kntag_test_data").doc("test1").set(user);

    // [END get_started_add_data_1]
  }

  void userloged() {
    print("uid: ${user?.uid}");

    final docRef = db.doc("users/${user?.uid}");

    docRef.get().then(
          (res) => (res.data() == null) ? newUser(user!.uid) : oldUser(),
          onError: (e) => print("Error completing: $e"),
        );
  }

  void newUser(String userId) async {
    print('newUser');
    var data = {
      "username": user?.displayName,
      "profileimg": user?.photoURL,
      "about": 'I dont like events. Events like me',
      "joinedtags": [],
      "createdtags": []
    };

    DocumentReference documentReferencer = _mainCollection.doc(userId);
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  void oldUser() {
    print('oldUser');
  }

  create_tag() async {
    var data = {
      "TagName": '',
      "TagDescription": '',
      "Place": '',
      "StartDate": "",
      "EndDate": "",
      "StartTime": "",
      "EndTime": "",
      "Latitude": "",
      "Longitude": "",
      "MaxMembers": 5,
      "HostId": "",
      "MembersList": [],
    };

    DocumentReference documentReferencer = _tagCollection.doc(tagId);
    await documentReferencer
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));
  }

  void updateItem({
    required String title,
    required String place,
    required String StartDate,
    required String endDate,
    required String starttime,
    required String endTime,
    required String latitude,
    required String longitude,
    required int maxmembers,
    required String description,
    required List userId,
    // required String docId,
  }) async {
    DocumentReference documentReferencer = _tagCollection.doc(tagId);

    Map<String, dynamic> data = <String, dynamic>{
      "TagName": title,
      "TagDescription": description,
      "Place": place,
      "StartDate": StartDate,
      "EndDate": endDate,
      "StartTime": starttime,
      "EndTime": endTime,
      "Latitude": latitude,
      "Longitude": longitude,
      "MaxMembers": 5,
      "HostId": "${user?.uid}",
      "MembersList": [],
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(user?.uid).collection('Users');

    // return notesItemCollection.snapshots();

    var userData =
        FirebaseFirestore.instance.collection("Users").doc(user?.uid).get();
    return userData;
  }
}
