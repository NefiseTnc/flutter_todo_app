import 'package:flutter/material.dart';

class TaskModel {
  int id;
  String name;
  String description;
  DateTime dateTime;
  String iconUrl;
  Color iconColor;
  bool isDone;
  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.iconUrl,
    required this.iconColor,
    this.isDone = false,
  });
}
