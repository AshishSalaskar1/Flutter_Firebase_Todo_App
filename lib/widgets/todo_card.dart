// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoCard extends StatefulWidget {
  const TodoCard(
      {Key? key,
      required this.todoTitle,
      required this.check,
      required this.todoTime,
      required this.todoIcon,
      required this.todoIconColor,
      required this.todoIconBgColor,
      required this.todoMap})
      : super(key: key);

  final String todoTitle, todoTime;
  final IconData todoIcon;
  final Color todoIconBgColor, todoIconColor;
  final bool check;
  final Map<String, dynamic> todoMap;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.check;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Theme(
              data: ThemeData(
                  primarySwatch: Colors.blue,
                  unselectedWidgetColor: Color(0xff5e616a)),
              child: Checkbox(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                activeColor: Color(0xFF00FF6E),
                checkColor: Color(0xff0e3e26),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    var updatedTodoData = widget.todoMap;
                    String docId = updatedTodoData["id"];
                    updatedTodoData["completed"] = isChecked;
                    updatedTodoData.remove("id");
                    FirebaseFirestore.instance
                        .collection("/todo")
                        .doc(docId)
                        .update(updatedTodoData);
                  });
                },
              ).scale110()),
          Expanded(
            child: Container(
              height: 70,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xFF3F3C3C),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: widget.todoIconBgColor,
                          borderRadius: BorderRadius.circular(7)),
                      height: 30,
                      width: 30,
                      child: Icon(widget.todoIcon,
                          color: widget.todoIconColor, size: 20),
                    ).px16(),
                    Expanded(
                        child: isChecked
                            ? widget.todoTitle.text.lineThrough.white.lg.make()
                            : widget.todoTitle.text.white.lg.make()),
                    widget.todoTime.text.thin.sm.white.make().px12()
                  ],
                ),
              ),
            ).pLTRB(0, 0, 10, 0),
          )
        ],
      ),
    ).wFull(context).p8();
  }
}
