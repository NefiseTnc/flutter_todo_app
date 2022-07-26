import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/task_model.dart';
import 'package:flutter_todo_app/database/local_database.dart';

class TaskController extends GetxController {
  RxList<TaskModel> taskList = RxList(<TaskModel>[]);
  RxList<TaskModel> doneTaskList = RxList(<TaskModel>[]);
  RxBool isSelected = RxBool(false);

  LocalDatabase db = LocalDatabase.instance;

  TextEditingController nameCntr = TextEditingController();
  TextEditingController descriptionCntr = TextEditingController();

  TaskController() {
    getDatas();
  }

  Future<void> getDatas() async {
    taskList.value = await db.getTasks();
  }

  Future<void> getDoneTaskDatas() async {
    doneTaskList.value =
        taskList.where((element) => element.isDone == 1).toList();
  }

  Future<TaskModel> insertData(String name, String description,
      DateTime dateTime, String iconUrl) async {
    TaskModel task = TaskModel(
        name: name,
        description: description,
        dateTime: dateTime,
        iconUrl: iconUrl);
    await db.insert(task);
    return task;
  }

  Future<TaskModel> updateData(TaskModel task) async {
    await db.update(task);
    return task;
  }

  Future<void> deleteData(TaskModel task) async {
    await db.delete(task.id!);
  }
}
