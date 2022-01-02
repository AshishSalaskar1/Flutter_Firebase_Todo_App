// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/sign_in.dart';
import 'package:todo_app/pages/view_todo.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/utils/category_themes.dart';
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
  final Stream<QuerySnapshot<Map<String, dynamic>>> _firestoreStream = 
      FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.email.toString())
      .collection("/todo")
      .snapshots();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1A1A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1B1A1A),
        title: "My Todos".text.xl3.white.make().p8(),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/male_avatar.png"),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreStream,
        builder: (context, snapshot) {
          if ((!snapshot.hasData)) {
            return CircularProgressIndicator().centered();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> todoMap =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                // Extract Document ID
                todoMap["id"] = snapshot.data!.docs[index].id;
                CategoryIcon? categoryIcon =
                    CategoryIcons.catMap[todoMap["category"]] ??
                        CategoryIcons.catMap["other"];
                return TodoCard(
                  todoTitle: todoMap["title"] ?? "check",
                  check: todoMap["completed"] ?? false,
                  todoTime: todoMap["time"] ?? "11 am",
                  todoIcon: categoryIcon?.icon ?? Icons.other_houses,
                  todoIconColor: Colors.white,
                  todoIconBgColor:
                      categoryIcon?.iconBgColor ?? Colors.grey.shade300,
                  todoMap: todoMap,
                ).onInkTap(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => ViewTodo(todoMap: todoMap)));
                });
              },
            );
          }
        },
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Color(0xFF1B1A1A), items: [
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () async {
                  await authClass.logOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => SigninPage()),
                      (route) => false);
                },
                icon: Icon(Icons.logout, color: Colors.white, size: 28)),
            title: Container(child: "Logout".text.white.sm.make())),
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
            title: Container(
              child: "Settings".text.white.sm.make(),
            ))
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
