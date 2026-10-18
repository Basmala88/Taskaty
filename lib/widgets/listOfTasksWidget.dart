import 'package:flutter/material.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/widgets/taskWidget.dart';

class Listoftaskswidget extends StatelessWidget {
  const Listoftaskswidget({super.key,required this.tasks,required this.isPending});
  final List<Taskmodel>tasks;
  final bool isPending;
  @override
  Widget build(BuildContext context) {
    if(tasks.isEmpty){
      return isPending? Center(
  child: Text(
    'No pending tasks',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade700,
    ),
  ),
):Center(
  child: Text(
    'No completed tasks',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade700,
    ),
  ),);
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder:(context, int index){
      return TaskWidget(task: tasks[index]);
    });
  }
}