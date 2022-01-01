// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.todoTitle,
    required this.todoTime, 
    required this.todoIcon,
    required this.todoIconBgColor
  }) : super(key: key);

  final String todoTitle, todoTime;
  final IconData todoIcon;
  final Color todoIconBgColor;

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
                value: true,
                onChanged: (value) {},
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
                          color: todoIconBgColor,
                          borderRadius: BorderRadius.circular(7)),
                      height: 30,
                      width: 30,
                      child: Icon(todoIcon, color: Colors.black),
                    ).px12(),
                    Expanded(child: todoTitle.text.white.xl.make()),
                    todoTime.text.white.make().px12()
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
