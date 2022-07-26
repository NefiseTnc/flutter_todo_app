import 'dart:convert';


class TaskModel {
  int? id;
  String? name;
  String? description;
  DateTime? dateTime;
  String? iconUrl;
  int? isDone;
  TaskModel({
    required this.name,
    required this.description,
    required this.dateTime,
    required this.iconUrl,
    this.isDone = 0,
  });

  TaskModel.withId({
    required this.id,
    required this.name,
    required this.description,
    required this.dateTime,
    required this.iconUrl,
    this.isDone = 0,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (dateTime != null) {
      result.addAll({'dateTime': dateTime!.toString()});
    }
    if (iconUrl != null) {
      result.addAll({'iconUrl': iconUrl});
    }
    if (isDone != null) {
      result.addAll({'isDone': isDone});
    }

    return result;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel.withId(
      id: map['id']?.toInt(),
      name: map['name'],
      description: map['description'],
      dateTime:
          map['dateTime'] != null ? DateTime.parse(map['dateTime']) : null,
      iconUrl: map['iconUrl'],
      isDone: map['isDone']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));
}
