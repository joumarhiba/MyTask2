
import 'package:intl/intl.dart';

class Task {
  int? id;
  String? title;
  String? note;
  bool? isCompleted = false;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.title,
    this.id,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat
});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['note'] = this.note;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['color'] = this.color;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;

    return data;
  }

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'],
      title: data['title'],
      startTime: data['startTime'],
      endTime: data['endTime'],
      note: data['note'],
      color: data['color'],
      isCompleted: data['isCompleted'],
    );
  }


}