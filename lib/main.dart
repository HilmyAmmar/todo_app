import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_application/model/sub_task_model.dart';
import 'package:todo_application/model/task_model.dart';
import 'package:todo_application/model/project_model.dart';
import 'package:todo_application/page/home.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(ProjectModelAdapter());
  Hive.registerAdapter(SubTaskModelAdapter());

  await Hive.openBox<TaskModel>('tasks');
  await Hive.openBox<ProjectModel>('projects');
  await Hive.openBox<SubTaskModel>('subTasks');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo Application",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage());
  }
}
