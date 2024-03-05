import 'package:hive/hive.dart';
import 'package:todo_application/model/sub_task_model.dart';
import 'package:todo_application/model/task_model.dart';
part 'project_model.g.dart';

@HiveType(typeId: 1)
class ProjectModel {
  @HiveField(0)
  int totalTask;

  @HiveField(1)
  int completedTask;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  String title;

  @HiveField(4)
  String description;

  @HiveField(5)
  String category;

  @HiveField(6)
  List<SubTaskModel> taskList;

  @HiveField(7)
  int id;

  ProjectModel(
      {required this.totalTask,
      required this.completedTask,
      required this.dueDate,
      required this.title,
      required this.description,
      required this.category,
      required this.taskList,
      required this.id});

  void addTask(SubTaskModel task) {
    taskList.add(task);
  }

  void removeTask(SubTaskModel task) {
    taskList.remove(task);
  }
}
