import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/provider/task_provider.dart';
import 'package:flutter_todo_app/views/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants/app_color.dart';
import '../models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final List iconList = [
    "ic_shopping.png",
    "ic_basketball.png",
    "ic_location.png",
    "ic_party.png",
    "ic_sport.png",
    "ic_other.png",
  ];

  int selectedIconIndex = 0;

  DateTime _selectedDate = DateTime.now();
  final TimeOfDay _selectedTime = TimeOfDay.now();

  TextEditingController nameCntr = TextEditingController();
  TextEditingController descriptionCntr = TextEditingController();

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _emptyBox(),
                appBarText(),
                _emptyBox(),
                const Text(
                  "Icon",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 15,
                ),
                _iconList(size),
                _emptyBox(),
                const Text(
                  "Name",
                  style: TextStyle(fontSize: 14),
                ),
                TextField(
                  controller: nameCntr,
                  cursorColor: Colors.pink,
                  decoration: const InputDecoration(
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
                Container(
                  width: size.width,
                  height: size.height * .001,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff254DDE),
                          Color(0xffFE1E9A),
                        ]),
                  ),
                ),
                _emptyBox(),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descriptionCntr,
                  cursorColor: Colors.pink,
                  maxLines: 5,
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(.5),
                    filled: true,
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: Colors.pink)),
                  ),
                ),
                _emptyBox(),
                _datePiker(),
                _emptyBox(),
                GestureDetector(
                  onTap: () {
                    TaskModel task = TaskModel(
                        name: nameCntr.text,
                        description: descriptionCntr.text,
                        dateTime: _selectedDate,
                        iconUrl: iconList[selectedIconIndex]);
                    Provider.of<TaskProvider>(context, listen: false)
                        .insertData(task)
                        .then((value) {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    });
                  },
                  child: Container(
                    width: size.width * .3,
                    height: size.width * .094,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff254DDE),
                              Color(0xff00FFFF),
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _iconList(Size size) {
    return SizedBox(
      height: size.height * .05,
      child: ListView.builder(
        itemCount: iconList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              selectedIconIndex = index;
              setState(() {});
            },
            child: Image.asset(
              "assets/icons/${iconList[index]}",
              width: size.width * .15,
              scale: selectedIconIndex == index ? 0.8 : 1,
            ),
          );
        },
      ),
    );
  }

  Widget appBarText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        const Text(
          "NEW TASK",
          style: TextStyle(color: AppColor.primaryColor, fontSize: 24),
        ),
      ],
    );
  }

  Widget _emptyBox() {
    return const SizedBox(
      height: 25,
    );
  }

  void _pickDateDialog() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _pickTimeDialog() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }

      DateTime newDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      setState(() {
        _selectedDate = newDateTime;
      });
      log(_selectedDate.toString());
    });
  }

  Widget _datePiker() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _pickDateDialog,
              child: const Text(
                'Date',
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _selectedDate.toString().isEmpty
                  ? 'No date was chosen!'
                  : DateFormat.yMMMd().format(_selectedDate),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: _pickTimeDialog,
              child: const Text(
                'Time',
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _selectedTime.toString().isEmpty
                  ? 'No date was chosen!'
                  : _selectedTime.format(context),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
