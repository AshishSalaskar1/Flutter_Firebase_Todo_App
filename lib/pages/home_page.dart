// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/sign_in.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/widgets/todo_card.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authClass = AuthClass();
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1A1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1B1A1A),
        title: "Todays Schedule".text.xl3.white.make().p8(),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/male_avatar.png"),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TodoCard(
                todoTitle: "Wake me up",
                todoTime: "12 am",
                todoIcon: Icons.alarm,
                todoIconBgColor: Color(0xFFF8D197)),
            TodoCard(
                todoTitle: "Purchase Groceries from convenience store",
                todoTime: "12 am",
                todoIcon: Icons.shopping_cart,
                todoIconBgColor: Color(0xFFA5ACF3))
          ],
        ).wFull(context).hFull(context),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Color(0xFF1B1A1A), items: [
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.home, color: Colors.white, size: 28)),
            title: Container()),
        BottomNavigationBarItem(
            icon: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.purple])),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => AddTodo()));
                },
                icon: Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
            title: Container()),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings, color: Colors.white, size: 28)),
            title: Container())
      ]),
    );
  }
}


// LOGOUT BUTTON //
// IconButton(
//               onPressed: () async {
//                 await authClass.logOut();
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (builder) => SigninPage()),
//                     (route) => false);
//               },
//               icon: Icon(Icons.logout)
//           )
