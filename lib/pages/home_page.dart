import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  void SignUp() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: "ash@gmail.com", password: "test123");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: "Todo App".text.make(),
          backgroundColor: Colors.purple.shade900),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: ()  => SignUp(),
            child: "SignUp".text.make()
        )
        ),
      ),
    );
  }
}
