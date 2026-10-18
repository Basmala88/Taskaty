import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/helper/helper_functions.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/screens/task_detailsscreen.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';

class Taskcard extends StatelessWidget {
  const Taskcard({super.key, required this.task});
  final Taskmodel task;

  Color chooseCategoryColor() {
    if (task.category == 'Study') {
      return const Color.fromARGB(255, 3, 190, 128);
    } else if (task.category == 'Work') {
      return const Color.fromARGB(255, 144, 137, 216);
    } else if (task.category == 'Health') {
      return const Color.fromARGB(255, 87, 54, 234);
    } else {
      return const Color.fromARGB(255, 216, 164, 42);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsscreen(taskToDisplay: task),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          color: Colors.white,
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: GestureDetector(
              onTap: () => context.read<Taskscubit>().changeState(task),
              child: Icon(
                task.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: const Color(0xff305B4D),
                size: 28,
              ),
            ),
            title: Text(
              task.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            subtitle: Text(formatDateTime(context, task.dueDate)),

            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: chooseCategoryColor(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      task.category,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                Material(
                  color: const Color(0xFFF9E9E6),
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: 'Delete task',
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Delete Task?'),
                          content: const Text(
                            'Are you sure you want to delete this task?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(dialogContext, true),
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Color(0xFFB94B43)),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true && context.mounted) {
                        context.read<Taskscubit>().deleteTask(task);
                      }
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFFB94B43),
                      size: 20,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 38,
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
