import 'package:flutter/cupertino.dart';
import '../database/local_database.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> taskList = [];
  List<TaskModel> doneTaskList = [];
  bool isSelected = false;

  LocalDatabase db = LocalDatabase.instance;

  TaskProvider() {
    getDatas();
  }

  Future<void> getDatas() async {
    List<TaskModel> datas = await db.getTasks();
    for (var element in datas) {
      if (element.isDone == 1) {
        doneTaskList.add(element);
      } else {
        taskList.add(element);
      }
    }
    notifyListeners();
  }

  void isSelectedCheck() {
    isSelected = !isSelected;
    notifyListeners();
  }

  Future<void> getDoneTaskDatas() async {
    taskList.where((element) => element.isDone == 1).toList();
    notifyListeners();
  }

  Future<TaskModel> insertData(TaskModel task) async {
    await db.insert(task);
    taskList.add(task);
    notifyListeners();
    return task;
  }

  Future<TaskModel> updateData(TaskModel task) async {
    if (task.isDone == 1) {
      task.isDone = 0;
      taskList.add(task);
      doneTaskList.remove(task);
    } else {
      task.isDone = 1;
      taskList.remove(task);
      doneTaskList.add(task);
    }
    await db.update(task);
    notifyListeners();
    return task;
  }

  Future<void> deleteData(TaskModel task) async {
    notifyListeners();
    await db.delete(task.id!);
  }

  List<TaskModel> filterDatas(DateTime selectedDateTime) {
    List<TaskModel> list = [];

    list = taskList
        .where((element) => element.dateTime!.day == selectedDateTime.day)
        .toList();
    notifyListeners();

    return list;
  }
}
