import 'package:first_mobile/conf/db.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    print(task?.title);
    return 0;
    // return await DataBaseHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DataBaseHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void deleteTask(Task task) {
    DataBaseHelper.delete(task);
  }
}
