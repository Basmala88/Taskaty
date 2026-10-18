import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';
import 'package:taskaty_app/widgets/listOfTasksWidget.dart';
import 'package:taskaty_app/widgets/taskWidget.dart';

class Mytasksscreen extends StatefulWidget {
  const Mytasksscreen({super.key});

  @override
  State<Mytasksscreen> createState() => _MytasksscreenState();
}

class _MytasksscreenState extends State<Mytasksscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF7),
      appBar: AppBar(
       
        backgroundColor: Color(0xffFCFAF7),
        title: Column(
          children: [
            Text(
          'Your Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          'Make Today Count',
          style: TextStyle(fontWeight: FontWeight.w600,color: Colors.grey, fontSize: 12),
        ),
          ],
        ),
        actions: [
          Icon(Icons.person_2_rounded)
        ],
      ),
      body: BlocBuilder<Taskscubit, List<Taskmodel>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.task_alt_rounded,
                    size: 70,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'No tasks yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Add your first task!',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }
          return BlocBuilder<Taskscubit, List<Taskmodel>>(
            builder: (context, state) {
              final List<Taskmodel> pendingTasks = state
                  .where((task) => task.isCompleted == false)
                  .toList();
              final List<Taskmodel> completedTasks = state
                  .where((task) => task.isCompleted == true)
                  .toList();
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: const Color(0xffE8F1EC),
                          child: Icon(
                            Icons.pending_actions_outlined,
                            size: 28,
                            color: const Color(0xff2F7D6B),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Pending Tasks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: const Color(0xffD9E7E2),
                          child: Text(
                            '${pendingTasks.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2F7D6B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Listoftaskswidget(
                      tasks: pendingTasks,
                      isPending: true,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 1, indent: 30, endIndent: 30),

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: const Color(0xffE8F1EC),
                          child: Icon(
                            Icons.task_alt_rounded,
                            size: 28,
                            color: const Color(0xff2F7D6B),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Completed Tasks',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(width: 5),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: const Color(0xffD9E7E2),
                          child: Text(
                            '${completedTasks.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2F7D6B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Listoftaskswidget(
                      tasks: completedTasks,
                      isPending: false,
                    ),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: .end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<Taskscubit>().clearAll();
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xff3D6F63),
                          radius: 40,
                          child: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
