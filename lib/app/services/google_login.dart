import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kntag/app/db.dart';

class GoogleLoginProvider extends ChangeNotifier {
  final googleLogin = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleSignIn() async {
    final User? users = auth.currentUser;
    final uid = users?.uid;
    try {
      
      final googleUser = await googleLogin.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User user = await _auth.currentUser!;
      final uid = user.uid;
      login();
      print("working");
      // MngDB().create_tag();
      // u.MngDB().userloged();
      // getCurrentUser();
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  notifyListeners();
  // logout() async {
  //   await googleLogin.disconnect();
  //   FirebaseAuth.instance.signOut();
  //   await _auth.signOut();
  //   print("logged Out");
  // }

   Future<void> logout() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    await _auth.signOut().then((_) {
      GoogleSignIn _googleSignIn = GoogleSignIn();

      //try the following
      _googleSignIn.signOut();
      //try the following

      // Navigator.of().pushNamedAndRemoveUntil("/login", ModalRoute.withName("/home"));
    });
  }
}

// getCurrentUser() async {
//   final User user = await _auth.currentUser!;
//   final uid = user.uid;
//   // Similarly we can get email as well
//   //final uemail = user.email;
//   print("user id printed $uid");
//   //print(uemail);
// }
