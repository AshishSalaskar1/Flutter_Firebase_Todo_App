import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/sign_in.dart';
import 'package:todo_app/pages/sign_up.dart';
import 'package:todo_app/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/signup",
      routes: {
        "/": (context) => HomePage(),
        MyRoutes.SignupRoute : (context) => SignupPage(),
        MyRoutes.SigninRoute : (context) => SigninPage(),
        MyRoutes.HomePageRoute : (context) => HomePage() 
      },
    );
  }
}
