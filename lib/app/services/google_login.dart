import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginProvider extends ChangeNotifier {
  final googleLogin = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleSignIn() async {
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
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  notifyListeners();
  Future logout() async {
    await googleLogin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
