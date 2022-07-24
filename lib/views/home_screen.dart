import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/app_color.dart';
import 'package:flutter_todo_app/data/task_data.dart';
import 'package:flutter_todo_app/views/calender_mode_screen.dart';
import 'package:flutter_todo_app/views/create_task_screen.dart';
import 'package:flutter_todo_app/views/done_task_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _emptyBox(),
                appBarText(),
                _emptyBox(),
                Expanded(
                    child: Stack(
                  children: [taskListview(), bottomButtons()],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarText() {
    return const Text(
      "TODO",
      style: TextStyle(color: AppColor.primaryColor, fontSize: 24),
    );
  }

  Widget taskListview() {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        var task = taskList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: Get.height * .08,
          decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            onLongPress: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            leading: Image.asset(
              "assets/icons/${task.iconUrl}",
            ),
            title: Text(
              task.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            trailing: isSelected
                ? Container(
                    width: Get.width * .06,
                    height: Get.width * .06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xff181743),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xffFE1E9A).withOpacity(.2),
                            offset: const Offset(0, 2),
                            blurRadius: 4)
                      ],
                    ),
                    child: task.isDone
                        ? Image.asset("assets/icons/ic_selected.png")
                        : const SizedBox(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.MMMd().format(task.dateTime),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.Hm().format(task.dateTime),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget bottomButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * .19,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Expanded(
              child: isSelected ? selectedButtons() : unSelectedBottons(),
            ),
            _emptyBox(),
          ],
        ),
      ),
    );
  }

  Widget unSelectedBottons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => const DoneTaskScreen());
          },
          child: Container(
              width: Get.width * .12,
              height: Get.width * .12,
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
            Get.to(() => const CalendarModeScreen());
          },
          child: Container(
            width: Get.width * .15,
            height: Get.width * .15,
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
            child: Image.asset("assets/icons/ic_calendar.png"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(const CreateTaskScreen());
          },
          child: Container(
            width: Get.width * .12,
            height: Get.width * .12,
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

  Widget selectedButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSelected = false;
            });
          },
          child: Container(
              width: Get.width * .14,
              height: Get.width * .14,
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
        const SizedBox(
          width: 15,
        ),
        Container(
            width: Get.width * .14,
            height: Get.width * .14,
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
            ),
            child: Image.asset("assets/icons/ic_double_check.png")),
      ],
    );
  }

  Widget _emptyBox() {
    return const SizedBox(
      height: 25,
    );
  }
}
