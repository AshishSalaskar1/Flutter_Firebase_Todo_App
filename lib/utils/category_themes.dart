// ignore_for_file: prefer_collection_literals, prefer_const_constructors, prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CategoryIcons {
  static var catMap = {
    "Food": CategoryIcon.init(Icons.restaurant, Color(0xFF397AC4)),
    "Work": CategoryIcon.init(Icons.work, Color(0xFFBB7247)),
    "Other": CategoryIcon.init(Icons.push_pin, Color(0xFF7F4BB9)),
    "Shopping": CategoryIcon.init(Icons.shopping_cart, Color(0xFF51C779)),
    "Personal": CategoryIcon.init(Icons.person, Color(0xFFD45CAC)),
    "Travel": CategoryIcon.init(Icons.airplanemode_on, Color(0xFF0E8191))
  };
}

class CategoryIcon {
  IconData icon = Icons.person;
  Color iconBgColor = Colors.red;

  CategoryIcon.init(IconData iconData, Color iconBgColorData) {
    icon = iconData;
    iconBgColor = iconBgColorData;
  }
}
