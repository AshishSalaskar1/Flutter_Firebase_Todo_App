// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loadCircle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Sign Up".text.bold.xl4.white.make(),
              SizedBox(height: 50),
              LoginContinueButton(
                  context, "assets/images/google.svg", "Continue with Google"),
              SizedBox(height: 10),
              LoginContinueButton(
                  context, "assets/images/phone.svg", "Continue with Phone"),
              SizedBox(height: 25),
              "OR".text.white.bold.make(),
              SizedBox(height: 25),
              LoginTextField(context, "Email", _emailController, false),
              SizedBox(height: 15),
              LoginTextField(context, "Password", _passwordController, true),
              SizedBox(height: 20),
              loadCircle ? CircularProgressIndicator() : SignUpButton(context),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Do you already have an account?".text.white.make(),
                  SizedBox(
                    width: 5,
                  ),
                  "Login".text.white.bold.lg.make().onInkTap(
                      () => Navigator.pushNamed(context, MyRoutes.SigninRoute))
                ],
              )
            ],
          ),
        ).wFull(context).hFull(context),
      ),
    );
  }

  Widget LoginContinueButton(
      BuildContext context, String imagePath, String displayText) {
    return Container(
      height: 55,
      child: Card(
        color: Colors.blueGrey.shade900,
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(width: 1, color: Colors.white)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath, width: 25, height: 25),
            SizedBox(width: 20),
            displayText.text.white.make()
          ],
        ),
      ),
    ).wFourFifth(context);
  }

  Widget LoginTextField(BuildContext context, String label,
      TextEditingController textController, bool isObscure) {
    return Container(
      height: 55,
      child: TextFormField(
        obscureText: isObscure,
        controller: textController,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: "Enter ${label}",
          labelStyle: TextStyle(color: Colors.white, fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
        ),
      ),
    ).wFourFifth(context);
  }

  Widget SignUpButton(BuildContext context) {
    return Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Color(0xfffd746c),
                  Color(0xffff9068),
                  Color(0xfffd746c)
                ])),
            child: "Sign Up".text.bold.xl.white.makeCentered())
        .wFourFifth(context)
        .onInkTap(() async {
          setState(() {loadCircle = true;});
          try {
            UserCredential userCredential =
                await firebaseAuth.createUserWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim());
            final snackBar =
                SnackBar(content: "Account Creation Successful".text.make());
                
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            
            setState(() {loadCircle = false;});
            await Navigator.pushNamed(context,MyRoutes.HomePageRoute);
          } catch (e) {
            final snackBar =
                SnackBar(content: e.toString().split("]")[1].text.make());
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {loadCircle = false;});
          }
        });
  }
}
