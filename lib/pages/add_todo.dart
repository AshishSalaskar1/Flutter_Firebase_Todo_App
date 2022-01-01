// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xff1d1e26), Color(0xff252041)]),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                       Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => HomePage())
                      );
                    },
                    icon: Icon(CupertinoIcons.arrow_left, color: Colors.white)),
                "Add Todo".text.widest.white.bold.xl4.make().px20(),
                SizedBox(height: 20),
                "Task Title".text.semiBold.white.make().px20(),
                TitleField(context),
                SizedBox(height: 10),
                "Task Type".text.semiBold.white.make().px20(),
                Row(
                  children: [
                    ChipElement("Important", Color(0xFF2881B4)),
                    ChipElement("Planned", Color(0xFFC75555))
                  ],
                ).px12(),
                SizedBox(height: 10),
                "Task Description".text.semiBold.white.make().px20(),
                DescriptionField(context),
                SizedBox(height: 10),
                "Category".text.semiBold.white.make().px20(),
                Wrap(children: [
                  ChipElement("Food", Color(0xFF24AD62)),
                  ChipElement("Groceries", Color(0xFFB1AE28)),
                  ChipElement("Work", Color(0xFFB93C66)),
                  ChipElement("Shopping", Color(0xFF2F69B6)),
                  ChipElement("Travel", Color(0xFF2C8588))
                ]).px20().py4(),
                SizedBox(height: 20),
                AddTodoButton(context),
                SizedBox(height:80)
              ],
            ),
          ),
        ).hFull(context).wFull(context),
      ),
    );
  }

  Widget AddTodoButton(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF7712C9), 
          borderRadius: BorderRadius.circular(15)
      ),
      child: "Add Todo".text.bold.wide.white.xl.make().centered(),
    ).wFull(context).px20();
  }

  Widget ChipElement(String label, Color color) {
    return Chip(
      label: label.text.semiBold.white.make(),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
    ).px8();
  }

  Widget TitleField(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xFF494A55), 
          borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ).wFull(context),
    ).wFull(context).px20().py12();
  }

  Widget DescriptionField(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Color(0xFF494A55), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        maxLines: null,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter task desciption",
          fillColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ).wFull(context),
    ).wFull(context).px20().py12();
  }
}
