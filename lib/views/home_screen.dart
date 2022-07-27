import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/app_color.dart';
import 'package:flutter_todo_app/provider/task_provider.dart';
import 'package:flutter_todo_app/views/calender_mode_screen.dart';
import 'package:flutter_todo_app/views/create_task_screen.dart';
import 'package:flutter_todo_app/views/done_task_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

    @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                _emptyBox(),
                appBarText(),
                _emptyBox(),
                Expanded(
                    child: Stack(
                  children: [taskListsview(size,context), bottomButtons(size,context)],
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

  Widget taskListsview(Size size,BuildContext context) {
    return ListView.builder(
      itemCount: Provider.of<TaskProvider>(context).taskList.length,
      itemBuilder: (context, index) {
        var task = Provider.of<TaskProvider>(context).taskList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: size.height * .08,
          decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            onTap: () {},
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
              style: task.isDone == 1
                  ? const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.pink)
                  : null,
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
                              color: const Color(0xffFE1E9A).withOpacity(.2),
                              offset: const Offset(0, 2),
                              blurRadius: 4)
                        ],
                      ),
                      child: task.isDone == 1
                          ? Image.asset("assets/icons/ic_selected.png")
                          : const SizedBox(),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.MMMd()
                            .format(task.dateTime ?? DateTime.now()),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.Hm().format(task.dateTime ?? DateTime.now()),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget bottomButtons(Size size,BuildContext context) {
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
                  ? selectedButtons(size,context)
                  : unSelectedBottons(size,context),
            ),
            _emptyBox(),
          ],
        ),
      ),
    );
  }

  Widget unSelectedBottons(Size size,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DoneTaskScreen(),
            ));
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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CalendarModeScreen(),
            ));
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
            child: Image.asset("assets/icons/ic_calendar.png"),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateTaskScreen(),
            ));
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

  Widget selectedButtons(Size size,BuildContext context) {
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
