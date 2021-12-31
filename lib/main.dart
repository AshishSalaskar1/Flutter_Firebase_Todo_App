// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/sign_in.dart';
import 'package:todo_app/pages/sign_up.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String homeRoute = MyRoutes.HomePageRoute;
  AuthClass authClass = AuthClass();
  Widget homeRoute = HomePage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getLoginToken();
    setState(() {
      if (token == null)
        homeRoute = SigninPage();
      else
        homeRoute = HomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  AddTodo(),
      routes: {
        MyRoutes.SignupRoute: (context) => SignupPage(),
        MyRoutes.SigninRoute: (context) => SigninPage(),
        MyRoutes.HomePageRoute: (context) => HomePage()
      },
    );
  }
}
