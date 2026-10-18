// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:taskaty_app/models/taskModel.dart';

// import 'task_adapter.dart';

// class TaskDB {
//  static final String boxName='task';
//   static Future<void> init() async {
//     await Hive.initFlutter();
//   if (!Hive.isAdapterRegistered(TaskAdapter().typeId)) {
//     Hive.registerAdapter(TaskAdapter());
//   }
  
//   await Hive.openBox<Taskmodel>(boxName);
//   }
//   static Future<void> addTask(Taskmodel task) async {
//     final box = await Hive.openBox<Taskmodel>(boxName);
//     await box.put(task.id, task);
//   }

//   static Future<List<Taskmodel>> getTasks() async {
//     final box = await Hive.openBox<Taskmodel>(boxName);
//     return box.values.toList();
//   }

//   static Future<void> deleteTask(String id) async {
//     final box = await Hive.openBox<Taskmodel>(boxName);
//     await box.delete(id);
//   }
//   static Future<void> clearAllTasks() async {
//     final box = await Hive.openBox<Taskmodel>(boxName);
//     await box.clear();
//   }
//   static Future<void> updateTask(Taskmodel task) async {
//     final box = await Hive.openBox<Taskmodel>(boxName);
//     await box.put(task.id, task);
//   }
// }
