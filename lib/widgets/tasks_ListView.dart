import 'package:flutter/widgets.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/widgets/taskCard.dart';

class TasksListview extends StatelessWidget {
  const TasksListview({super.key,required this.tasks});
  final List<Taskmodel> tasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
  child: ListView.builder(
    itemCount: tasks.length,
    itemBuilder: (context, index) {
      return Taskcard(task: tasks[index]);
    },
  ),
);
  }
}