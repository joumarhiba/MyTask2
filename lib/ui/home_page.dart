import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:first_mobile/controllers/task_controller.dart';
import 'package:first_mobile/models/task.dart';
import 'package:first_mobile/services/notification_service.dart';
import 'package:first_mobile/services/theme_service.dart';
import 'package:first_mobile/ui/addTaskBar.dart';
import 'package:first_mobile/ui/task_tile.dart';
import 'package:first_mobile/ui/theme.dart';
import 'package:first_mobile/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'get_started.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();

  final _taskController = Get.put(TaskController());

  var notifyHelper;
  @override
  void initState() {
    super.initState();

    notifyHelper = NotifyHelper();
    NotifyHelper().initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          const GetStarted(),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _addTaskBar(),
                ],
              )),
          _addDateBar(),
          SizedBox(
            height: 20,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Color.fromARGB(255, 17, 17, 18),
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today",
            style: headingStyle,
          ),
          SizedBox(
            width: 127,
          ),
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            style: subHeadingStyle,
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.only(left: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('images/user-avatar.jpg')),
          ),
          const SizedBox(width: 10),
          const Text(
            'Hi, User !',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              ThemeService().switchTheme();
              NotifyHelper().displayNotification(
                  title: "Theme Changed",
                  body: Get.isDarkMode
                      ? "Activated Light Mode"
                      : "Activated Dark Mode");
              print(Get.isDarkMode);
            },
            child: Icon(
              Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
              size: 20,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        )
      ],
    );
  }

  _showTasks() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('task').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('Loading...');
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (_, index) {
              final task =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              final taskMap = task != null ? Task.fromMap(task) : null;
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showTaskOptions(context, taskMap!);
                            },
                            child: TaskTile(taskMap),
                          )
                        ],
                      ),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }

  _deleteTask() {}

  _showTaskOptions(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == true
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Colors.white,
      child: Column(
          // children: [
          //   Container(
          //     height: 6,
          //     width: 120,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Colors.grey[400]
          //     ),
          //   ),
          //   task.isCompleted == true?
          //       Container():
          //       _taskOptionButton(
          //           label: "Tache completée",
          //           onTap: () {
          //
          //           },
          //           clr: Colors.blueAccent,
          //           context:context
          //           )
          // ],
          ),
    ));
  }

  _taskOptionButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClosed = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
      ),
    );
  }
}
