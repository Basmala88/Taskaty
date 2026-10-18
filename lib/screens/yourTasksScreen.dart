import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/screens/addTaskScreen.dart';
import 'package:taskaty_app/screens/login_screen.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';
import 'package:taskaty_app/widgets/taskCard.dart';
import 'package:taskaty_app/widgets/tasks_ListView.dart';

class Yourtasksscreen extends StatefulWidget {
  const Yourtasksscreen({super.key});

  @override
  State<Yourtasksscreen> createState() => _YourtasksscreenState();
}

class _YourtasksscreenState extends State<Yourtasksscreen> {
  String selectedFilter = 'All';
  List<String> filters = ['All', 'Active', 'Done'];
  List<Taskmodel> filterTasks(List<Taskmodel> tasks) {
    if (selectedFilter == 'Active') {
      return tasks.where((t) => !t.isCompleted).toList();
    } else if (selectedFilter == 'Done') {
      return tasks.where((t) => t.isCompleted).toList();
    }
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF6ED),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: const Color(0xffFAF6ED),
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Tasks',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3),
              Text(
                'Make today count',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: const Color(0xFFE5ECE2),
              shape: const CircleBorder(),
              child: IconButton(
                tooltip: 'Clear all tasks',
                onPressed: () {
                  context.read<Taskscubit>().clearAll();
                },
                icon: const Icon(
                  Icons.delete_sweep_rounded,
                  color: Color(0xFF305B4D),
                  size: 23,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: filters.map((F) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedFilter == F
                        ? const Color(0xff305B4D)
                        : Colors.white,

                    foregroundColor: selectedFilter == F
                        ? Colors.white
                        : Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Color(0xffD7D7D7)),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedFilter = F;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(F, style: TextStyle(fontSize: 16)),
                  ),
                );
              }).toList(),
            ),

            Expanded(
              child: BlocBuilder<Taskscubit, List<Taskmodel>>(
                builder: (context, state) {
                  List<Taskmodel> selected = filterTasks(state);
                  if (selected.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                            width: 250,
                            height: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/Green Task Planning Illustration.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'Ready to plan your day?',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            'Add your first task and make\ntoday count.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return TasksListview(tasks: filterTasks(state));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff305B4D),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addtaskscreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add task'),
      ),
    );
  }
}
