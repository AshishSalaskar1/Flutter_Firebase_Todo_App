// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/services/auth_service.dart';
import 'package:todo_app/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loadCircle = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Login".text.bold.xl4.white.make(),
              SizedBox(height: 50),
              LoginContinueButton(
                  context, "assets/images/google.svg", "Continue with Google",
                  () async {
                await authClass.googleSignIn(context);
              }),
              SizedBox(height: 10),
              LoginContinueButton(context, "assets/images/phone.svg",
                  "Continue with Phone", () {}),
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
                  "Do not have an account yet?".text.white.make(),
                  SizedBox(
                    width: 5,
                  ),
                  "Create Account".text.white.bold.lg.make().onInkTap(
                      () => Navigator.pushNamed(context, MyRoutes.SignupRoute))
                ],
              ),
              SizedBox(height: 10),
              "Forgot Password".text.white.bold.lg.make()
            ],
          ),
        ).wFull(context).hFull(context),
      ),
    );
  }

  Widget LoginContinueButton(BuildContext context, String imagePath,
      String displayText, Function onTapMethod) {
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
    ).wFourFifth(context).onTap(() {
      onTapMethod();
    });
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
            child: "Log In".text.bold.xl.white.makeCentered())
        .wFourFifth(context)
        .onInkTap(() async {
      setState(() {
        loadCircle = true;
      });
      try {
        UserCredential userCredential =
            await firebaseAuth.signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        authClass.storeLoginToken(userCredential);
        final snackBar = SnackBar(content: "Login Successful".text.make());
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          loadCircle = false;
        });
        await Navigator.pushNamed(context, MyRoutes.HomePageRoute);
      } catch (e) {
        final snackBar =
            SnackBar(content: e.toString().split("]")[1].text.make());
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          loadCircle = false;
        });
      }
    });
  }
}
