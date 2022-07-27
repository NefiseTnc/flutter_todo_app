import 'dart:developer';

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/task_model.dart';
import 'package:flutter_todo_app/provider/task_provider.dart';
import 'package:flutter_todo_app/views/create_task_screen.dart';
import 'package:flutter_todo_app/views/done_task_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarModeScreen extends StatefulWidget {
  const CalendarModeScreen({Key? key}) : super(key: key);

  @override
  State<CalendarModeScreen> createState() => _CalendarModeScreenState();
}

class _CalendarModeScreenState extends State<CalendarModeScreen> {
  List<TaskModel> taskList = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CalendarAppBar(
        onDateChanged: (DateTime value) {
          taskList = Provider.of<TaskProvider>(context, listen: false)
              .filterDatas(value);
        },
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        lastDate: DateTime.now(),
        backButton: true,
        accent: const Color(0xff12A8EF),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xffFEA64C).withOpacity(.2),
              const Color(0xff254DDE).withOpacity(.2),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Column(
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    taskList.isNotEmpty
                        ? taskListview(size)
                        : const Center(
                            child: Text("Not found task"),
                          ),
                    bottomButtons(size),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget taskListview(Size size) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        var task = taskList[index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.Hm().format(task.dateTime ?? DateTime.now()),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                height: size.height * .08,
                decoration: const BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  onLongPress: () {
                    Provider.of<TaskProvider>(context, listen: false)
                        .isSelectedCheck();
                  },
                  leading: Image.asset(
                    "assets/icons/${task.iconUrl}",
                  ),
                  title: Text(
                    task.name ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  trailing: Provider.of<TaskProvider>(context).isSelected
                      ? GestureDetector(
                          onTap: () {
                            Provider.of<TaskProvider>(context, listen: false)
                                .updateData(task);
                          },
                          child: Container(
                            width: size.width * .06,
                            height: size.width * .06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xff181743),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color(0xffFE1E9A).withOpacity(.2),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4)
                              ],
                            ),
                            child: task.isDone == 1
                                ? Image.asset("assets/icons/ic_selected.png")
                                : const SizedBox(),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget bottomButtons(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.height * .19,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Expanded(
              child: Provider.of<TaskProvider>(context).isSelected
                  ? selectedButtons(size)
                  : unSelectedBottons(size),
            ),
            _emptyBox(),
          ],
        ),
      ),
    );
  }

  Widget unSelectedBottons(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DoneTaskScreen()));
          },
          child: Container(
              width: size.width * .12,
              height: size.width * .12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xff254DDE),
                      Color(0xffFE1E9A),
                    ]),
                color: Colors.purple,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff707070),
                      offset: Offset(0, 1),
                      blurRadius: 7)
                ],
              ),
              child: Image.asset("assets/icons/ic_check.png")),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: size.width * .15,
            height: size.width * .15,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff707070).withOpacity(.3),
                    offset: const Offset(0, 1),
                    blurRadius: 7)
              ],
            ),
            child: Image.asset("assets/icons/ic_list.png"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateTaskScreen()));
          },
          child: Container(
            width: size.width * .12,
            height: size.width * .12,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff254DDE),
                    Color(0xff00FFFF),
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff707070),
                    offset: Offset(0, 1),
                    blurRadius: 7)
              ],
            ),
            child: Image.asset("assets/icons/ic_add.png"),
          ),
        ),
      ],
    );
  }

  Widget selectedButtons(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<TaskProvider>(context, listen: false).isSelectedCheck();
          },
          child: Container(
              width: size.width * .14,
              height: size.width * .14,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.blueGrey,
                      Colors.black,
                    ]),
                color: Colors.purple,
              ),
              child: Image.asset("assets/icons/ic_close.png")),
        ),
      ],
    );
  }

  Widget _emptyBox() {
    return const SizedBox(
      height: 25,
    );
  }
}
