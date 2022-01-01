// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewTodo extends StatefulWidget {
  ViewTodo({Key? key, required this.todoMap}) : super(key: key);

  final Map<String, dynamic> todoMap;

  @override
  _ViewTodoState createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {
  final FirebaseFirestore firestoreAuth = FirebaseFirestore.instance;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String selType = "";
  String selCategory = "";

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todoMap["title"];
    _descriptionController.text = widget.todoMap["description"];
    selType = widget.todoMap["type"];
    selCategory = widget.todoMap["category"];
  }

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
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.arrow_left, color: Colors.white)),
                Row(
                  children: [
                    "Edit Todo".text.widest.white.bold.xl4.make().px20(),
                    Expanded(child: Container()),
                    IconButton(
                            onPressed: () {
                              try {
                                firestoreAuth.collection("/todo").doc(widget.todoMap["id"]).delete();
                              }
                              catch (e) {
                                final snackBar = SnackBar(content: e.toString().text.make());
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              Navigator.push(context,
                                MaterialPageRoute(builder: (builder) => HomePage()));
                            },
                            icon: Icon(Icons.delete_forever,
                                color: Colors.white, size: 30)
                        ).px12()
                  ],
                ),
                SizedBox(height: 20),
                "Title".text.semiBold.white.make().px20(),
                TitleField(context),
                SizedBox(height: 10),
                "Task Type".text.semiBold.white.make().px20(),
                Row(
                  children: [
                    TypeChipElement("Important", Color(0xFF2881B4)),
                    TypeChipElement("Planned", Color(0xFFC75555))
                  ],
                ).px12(),
                SizedBox(height: 10),
                "Task Description".text.semiBold.white.make().px20(),
                DescriptionField(context),
                SizedBox(height: 10),
                "Category".text.semiBold.white.make().px20(),
                Wrap(children: [
                  CategoryChipElement("Personal", Color(0xFFC2BF1A)),
                  CategoryChipElement("Work", Color(0xFFB93C66)),
                  CategoryChipElement("Shopping", Color(0xFF2F69B6)),
                  CategoryChipElement("Food", Color(0xFF24AD62)),
                  CategoryChipElement("Other", Color(0xFF2C8588))
                ]).px20().py4(),
                SizedBox(height: 20),
                AddTodoButton(context),
                SizedBox(height: 80)
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
          color: Color(0xFF7712C9), borderRadius: BorderRadius.circular(15)),
      child: "Update".text.bold.wide.white.xl.make().centered(),
    ).wFull(context).px20().onInkTap(() {
      try {
        var todoData = {
          "title": _titleController.text,
          "description": _descriptionController.text,
          "type": selType.isNotEmpty ? selType : "Important",
          "category": selCategory.isNotEmpty ? selCategory : "Other",
          "completed": false
        };
        if (_titleController.text.isNotEmpty) {
          firestoreAuth.collection("/todo").doc(widget.todoMap["id"]).update(todoData);
          Navigator.pop(context);
        } else {
          final snackBar = SnackBar(
              content: "Please enter a Title for the Todo".text.make());
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        final snackBar = SnackBar(content: e.toString().text.make());
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  Widget TypeChipElement(String label, Color color) {
    return Chip(
      label: label.text.semiBold.white.make(),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              width: 3,
              color: Colors.white,
              style: selType == label ? BorderStyle.solid : BorderStyle.none)),
      elevation: 10,
    ).px8().onInkTap(() {
      setState(() {
        selType = label;
      });
    });
  }

  Widget CategoryChipElement(String label, Color color) {
    return Chip(
      label: label.text.semiBold.white.make(),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              width: 3,
              color: Colors.white,
              style:
                  selCategory == label ? BorderStyle.solid : BorderStyle.none)),
      elevation: 10,
    ).px8().onInkTap(() {
      setState(() {
        selCategory = label;
      });
    });
  }

  Widget TitleField(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xFF494A55), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _titleController,
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
        controller: _descriptionController,
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