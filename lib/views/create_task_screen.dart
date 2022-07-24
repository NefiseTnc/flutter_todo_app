import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/app_color.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final List iconList = [
    "shopping",
    "basketball",
    "location",
    "party",
    "sport",
    "other",
  ];

  int selectedIconIndex = 0;
  DateTime _selectedDate = DateTime.now();

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
                SizedBox(
                  height: Get.height * .05,
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
                          "assets/icons/ic_${iconList[index]}.png",
                          width: Get.width * .15,
                          scale: selectedIconIndex == index ? 0.8 : 1,
                        ),
                      );
                    },
                  ),
                ),
                _emptyBox(),
                const Text(
                  "Name",
                  style: TextStyle(fontSize: 14),
                ),
                const TextField(
                  cursorColor: Colors.pink,
                  decoration: InputDecoration(
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
                Container(
                  width: Get.width,
                  height: Get.height * .001,
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
                DatePicker(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarText() {
    return const Text(
      "NEW TASK",
      style: TextStyle(color: AppColor.primaryColor, fontSize: 24),
    );
  }

  Widget _emptyBox() {
    return const SizedBox(
      height: 25,
    );
  }
}

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(child: Text('Add Date'), onPressed: _pickDateDialog),
        SizedBox(height: 20),
        Text(_selectedDate == null //ternary expression to check if date is null
            ? 'No date was chosen!'
            : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
      ],
    );
  }
}
