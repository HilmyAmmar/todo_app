class TaskModel {
  int taskId;
  String name;
  String deadline;
  bool isDone;

  TaskModel(
      {required this.taskId,
      required this.name,
      required this.deadline,
      required this.isDone});

  static List<TaskModel> getAllTask() {
    List<TaskModel> allTask = [];

    allTask.add(TaskModel(
        taskId: 1,
        name: "Go to gym",
        deadline: "Mon, 7 February",
        isDone: false));

    allTask.add(TaskModel(
        taskId: 2,
        name: "Complete homework",
        deadline: "Tue, 8 February",
        isDone: false));

    allTask.add(TaskModel(
        taskId: 3,
        name: "Attend meeting",
        deadline: "Wed, 9 February",
        isDone: true));

    allTask.add(TaskModel(
        taskId: 3,
        name: "Attend meeting",
        deadline: "Wed, 9 February",
        isDone: true));

    return allTask;
  }
}
