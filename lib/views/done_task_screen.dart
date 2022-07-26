import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/app_color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/task_controller.dart';

class DoneTaskScreen extends StatelessWidget {
  DoneTaskScreen({Key? key}) : super(key: key);

  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getDoneTaskDatas();
    return Scaffold(
      body: Obx(
        () => Container(
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
                    child: taskListview(),
                  ),
                  controller.isSelected.value
                      ? selectedButtons()
                      : const SizedBox(),
                  _emptyBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
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

  Widget taskListview() {
    return ListView.builder(
      itemCount: controller.doneTaskList.length,
      itemBuilder: (context, index) {
        var task = controller.doneTaskList[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          height: Get.height * .08,
          decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            onLongPress: () {
              controller.isSelected.value = !controller.isSelected.value;
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
            trailing: controller.isSelected.value
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
                    child: task.isDone == 1
                        ? Image.asset("assets/icons/ic_selected.png")
                        : const SizedBox(),
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

  Widget selectedButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            controller.isSelected.value = false;
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
