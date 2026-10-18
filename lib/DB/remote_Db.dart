import 'dart:convert';

import 'package:http/http.dart';
import 'package:taskaty_app/models/taskModel.dart';

class RemoteDb {
  static const String url =
      "https://6ac0038e06bcd2f2067344e3.mockapi.io/api/Taskaty/";

  static Future<bool> addTask(Taskmodel task) async {
    final taskMap = task.toMap();
    final taskJson = jsonEncode(taskMap);

    final results = await post(
      Uri.parse("$url/tasks"),
      body: taskJson,
      headers: {"Content-Type": "application/json"},
    );
    if (results.statusCode == 200 || results.statusCode == 201) {
      final Taskmodel addedTask = Taskmodel.fromMap(jsonDecode(results.body));
      task.id = addedTask.id;
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateTask(Taskmodel task) async {
    final taskMap = task.toMap();
    final taskJson = jsonEncode(taskMap);
    final results = await put(
      Uri.parse("$url/tasks/${task.id}"),
      body: taskJson,
      headers: {"Content-Type": "application/json"},
    );
    if (results.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Taskmodel>> getTasks() async {
    final results = await get(Uri.parse("$url/tasks"));
    if (results.statusCode == 200 || results.statusCode == 201) {
      final tasksJson = results.body;
      final tasksMaps = jsonDecode(tasksJson) as List;
      List<Taskmodel> tasks = [];
      for (var taskMap in tasksMaps) {
        tasks.add(Taskmodel.fromMap(taskMap));
      }
      return tasks;
    } else {
      return [];
    }
  }

  static Future<bool> deleteTask(String id) async {
    final results = await delete(Uri.parse("$url/tasks/$id"));
    if (results.statusCode == 200 || results.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> clearAllTasks(List<Taskmodel> tasks) async {
    for (var task in tasks) {
      await deleteTask(task.id);
    }
  }
}
