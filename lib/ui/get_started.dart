import 'package:first_mobile/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'addTaskBar.dart';
import 'package:first_mobile/controllers/task_controller.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final _taskController = Get.put(TaskController());

    // ignore: avoid_unnecessary_containers
    return Container(
        child: Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(10),
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey[700], shape: BoxShape.circle),
                child: const Icon(
                  Icons.star_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Plan your tasks every day',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Plan, Manage and track all your \nteam\'s task in one flexible app',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
        // const SizedBox(height: 11),
        Positioned(
          bottom: 26,
          left: 140,
          child: Container(
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(15), color: Colors.white
                ),
            padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MyButton(
                  label: "+ Add Task",
                  onTap: () async {
                    await Get.to(AddTaskBar());
                    _taskController.getTasks();
                  }),
            ]),
          ),
        )
      ],
    ));
  }
}
