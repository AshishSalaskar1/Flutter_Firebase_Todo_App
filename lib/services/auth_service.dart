// ignore_for_file: unused_field, prefer_final_fields, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/utils/routes.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  FirebaseAuth auth = FirebaseAuth.instance;
  final secureStorage = FlutterSecureStorage();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> googleSignIn(BuildContext context) async {
    try {
      // Shows pop-up window where user signs in
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // get auth details from signined in G-accounts
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Get credentials from G-account
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        // FireBase Auth with receive G-account credentials
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        //store token
        storeLoginToken(userCredential);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomePage()),
            (route) => false);
      }
    } catch (e) {
      final snackBar = SnackBar(content: e.toString().text.make());
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> storeLoginToken(UserCredential userCredential) async {
    await secureStorage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await secureStorage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String?> getLoginToken() async {
    return await secureStorage.read(key: "token");
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await auth.signOut();
    await secureStorage.delete(key: "token");
  }
}
