import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/app_color.dart';
import 'package:flutter_todo_app/provider/task_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoneTaskScreen extends StatefulWidget {
  const DoneTaskScreen({Key? key}) : super(key: key);

  @override
  State<DoneTaskScreen> createState() => _DoneTaskScreenState();
}

class _DoneTaskScreenState extends State<DoneTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<TaskProvider>(context);
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
                appBarText(size),
                _emptyBox(),
                Expanded(
                  child: taskListview(size),
                ),
                provider.isSelected ? selectedButtons(size) : const SizedBox(),
                _emptyBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarText(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        const Text(
          "DONE TASK",
          style: TextStyle(color: AppColor.primaryColor, fontSize: 24),
        ),
      ],
    );
  }

  Widget taskListview(Size size) {
    return ListView.builder(
      itemCount: Provider.of<TaskProvider>(context).doneTaskList.length,
      itemBuilder: (context, index) {
        var task = Provider.of<TaskProvider>(context).doneTaskList[index];
        return Container(
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
              style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.pink),
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.pink),
                      ),
                      Text(
                        DateFormat.Hm().format(task.dateTime ?? DateTime.now()),
                        style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.pink),
                      ),
                    ],
                  ),
          ),
        );
      },
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
