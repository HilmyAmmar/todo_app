import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime? date;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  String category;

  TaskModel(
      {required this.title,
      required this.date,
      required this.isDone,
      required this.category});
}
