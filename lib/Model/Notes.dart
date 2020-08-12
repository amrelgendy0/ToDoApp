import 'dart:ui';

import 'package:flutter/material.dart';

class Notes {
  int ID;
  String title;
  String note;
  DateTime dateTime;
  bool isDone;
  Color color;

  Notes({
  this.ID,
    this.color,
    this.isDone,
    this.dateTime,
    this.title,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      "color": color.value,
      "isDone": isDone ? 1 : 0,
      'note': note,
      'title': title,
      'dateTime': dateTime.toString(),
    };
  }

  static Notes FromMap(Map<String, dynamic> map) {
    return Notes(
        title: map['title'],
        note: map['note'],
        dateTime: DateTime.parse(map['dateTime']),
        isDone: map['isDone'] == 1 ? true : false,
        color: Color(map['color']),
        ID: map['ID']);
  }
}
