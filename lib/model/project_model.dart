import 'package:flutter/material.dart';

class ProjectModel {
  int projectId;
  int totalTask;
  int completedTask;
  String deadline;
  String name;

  ProjectModel(
      {required this.projectId,
      required this.totalTask,
      required this.completedTask,
      required this.deadline,
      required this.name});

  static List<ProjectModel> getAllProject() {
    List<ProjectModel> allProject = [];

    allProject.add(ProjectModel(
        projectId: 1,
        totalTask: 5,
        completedTask: 3,
        deadline: "Mon, 7 February",
        name: "Advanced Programming Project"));

    allProject.add(ProjectModel(
        projectId: 2,
        totalTask: 4,
        completedTask: 0,
        deadline: "Sun, 8 May",
        name: "Python Project"));

    allProject.add(ProjectModel(
        projectId: 3,
        totalTask: 7,
        completedTask: 1,
        deadline: "Sun, 9 May",
        name: "UI/UX Task"));
    return allProject;
  }
}
