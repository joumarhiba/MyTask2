

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_mobile/controllers/task_controller.dart';
import 'package:first_mobile/models/task.dart';
import 'package:first_mobile/ui/theme.dart';
import 'package:first_mobile/ui/widgets/button.dart';
import 'package:first_mobile/ui/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../conf/db.dart';

class AddTaskBar extends StatefulWidget {
  const AddTaskBar({Key? key}) : super(key: key);

  @override
  State<AddTaskBar> createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm:a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  String _selectedRepeat = "None";
  List<int> remindList = [
    5,10,15,20];
  List<String> repeatList = [
    "None","Daily","Monthly"
  ];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // backgroundColor:Theme.of(context).backgroundColor,
     appBar:_appBar(context),
       body:Container(
         padding: const EdgeInsets.only(left: 20, right: 20),
         child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
               "Add Task",
               style: headingStyle,
             ),
             InputFiled(
                 title: "Title",
                 hint: "Enter you title",
                 controller: _titleController,),
             InputFiled(
                 title: "Note",
                 hint: "Enter your note",
                 controller: _noteController,),
             InputFiled(title: "Date",
                        hint: DateFormat.yMd().format(_selectedDate),
                        widget: IconButton(
                          icon: Icon(Icons.calendar_today_outlined,
                          color: Colors.grey),
                          color: Colors.blue,
                          onPressed:() {
                            _getDateFromUser();
                          },
                        ),
             ),
             Row(
               children: [
                 Expanded
                   (child: InputFiled(
                       title: "Start Time",
                       hint: _startTime ,
                       widget: IconButton(
                         onPressed: () {
                           _getTimeFromUser(isStartTime: true);
                         },
                         icon: Icon(
                           Icons.access_time_rounded
                         ),
                       ),
                 )),
                 SizedBox(width: 12),
                 Expanded
                   (child: InputFiled(
                   title: "End Time",
                   hint: _endTime ,
                   widget: IconButton(
                     onPressed: () {
                       _getTimeFromUser(isStartTime: false);
                     },
                     icon: Icon(
                         Icons.access_time_rounded
                     ),
                   ),
                 ))
               ],
             ),
             InputFiled(title: "Remind", hint: "$_selectedRemind minutes early",
               widget: DropdownButton(
                 icon: Icon(Icons.keyboard_arrow_down,
                   color: Colors.grey,
                 ),
                 iconSize: 32 ,
                 elevation: 4,
                 style: subtitleStyle,
                 underline: Container(height: 0,),
                 onChanged : (String ?newValue) {
                   setState(() {
                     _selectedRemind = int.parse(newValue!);
                   });
                 },
                 items:  remindList.map<DropdownMenuItem<String>>((int value){
                   return DropdownMenuItem<String>(
                     value: value.toString(),
                     child: Text(
                         value.toString()),
                   );
                 }
                 ).toList(),
                 // onChanged: (Object? value) {  },

               ),
             ),
             InputFiled(title: "Repeat", hint: _selectedRepeat,
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32 ,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(height: 0,),
                  onChanged : (String ?newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:  repeatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!, style: TextStyle(color: Colors.grey)),
                    );
                  }
                  ).toList(),
                  // onChanged: (Object? value) {  },

                ),
              ),
             SizedBox(height: 18),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
               _colorChoice(),
               MyButton(label: "Create Task",
                 onTap: ()  {
                   _validateDate();

                 },
               )
           ],

             )
           ],
          ),
         ),
       ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      // backgroundColor: Theme.of(context).backgroundColor,
      leading: GestureDetector(
        onTap: () {
           Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.black : Colors.white,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/avatar.png",
          ),
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 20)
      ],
    );
  }
  _getDateFromUser() async {
    DateTime ? _datePicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121)
    );
    if (_datePicker != null) {
        setState(() {
          _selectedDate = _datePicker;
          print(_selectedDate);
        });
    }else{
      print("DATE ERROR-ADD TASK");
    }
  }
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimepicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceled");
    } else if (isStartTime) {
      setState(() {
        _startTime =_formatedTime;
      });
    } else {
      setState(() {
        _endTime =_formatedTime;
      });
    }
  }

  _showTimepicker() {
   return showTimePicker(
     initialEntryMode: TimePickerEntryMode.input ,
     context: context,
     initialTime : TimeOfDay(hour: int.parse(_startTime.split(":")[0]),
         minute: int.parse(_startTime.split(":")[1].split(" ")[0]))
     );
  }

  _colorChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",
          style: titleStyle,
        ),
        SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index) {
                return GestureDetector(
                    onTap: (){
                      setState(() {
                        _selectedColor = index;
                      });
                    },

                    child:Padding(
                      padding: const EdgeInsets.only( right: 8.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor:
                        index == 0 ?Colors.blue[900]:
                        index==1?Colors.pink:
                        Colors.yellow[700],
                        child: _selectedColor == index?Icon(Icons.done,
                          color: Colors.white,
                          size: 16,):Container(),
                      ),
                    )
                );
              }
          ),
        )
      ],
    );

  }
  _validateDate() async {
     if(_titleController.text.isNotEmpty) {

       final firestore = FirebaseFirestore.instance;
       await firestore.collection('task').add({
         'note': _noteController.text,
         'title': _titleController.text,
         'date': DateFormat.yMd().format(_selectedDate),
         'startTime': _startTime,
         'endTime': _endTime,
         'remind': _selectedRemind,
         'repeat': _selectedRepeat,
         'color': _selectedColor,
         'isCompleted': false,
       });
       Get.back();
     } else {
        Get.snackbar("Required", "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.pink,
        icon: Icon(Icons.warning_amber_rounded,
        color: Colors.pink,)
        );
     }
  }

  _addTask() async {

    await _taskController.addTask(
      task :Task(
          note: _noteController.text,
          title: _titleController.text,
          date:DateFormat.yMd().format(_selectedDate),
          startTime: _startTime,
          endTime: _endTime,
          remind: _selectedRemind,
          repeat: _selectedRepeat,
          color: _selectedColor,
          isCompleted: false,
        )
    );
  }
}


