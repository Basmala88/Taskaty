import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/helper/helper_functions.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';

class TaskDetailsscreen extends StatelessWidget {
  const TaskDetailsscreen({super.key, required this.taskToDisplay});
  final Taskmodel taskToDisplay;
  Color choosePriColor(){
    if(taskToDisplay.piriority=='Low'){
      return Color(0xffFBE193);
    }
    else if(taskToDisplay.piriority=='Medium'){
      return Color.fromARGB(255, 12, 174, 120);
    }
    else{
      return Color.fromARGB(255, 211, 29, 19);
    }
  }
  Color chooseCategoryColor(){
    if(taskToDisplay.category=='Study'){
      return Color.fromARGB(255, 2, 148, 99);
    }
    else if(taskToDisplay.category=='Work'){
      return Color.fromARGB(255, 144, 137, 216);
    }
    else if (taskToDisplay.category=='Health'){
     return Color.fromARGB(255, 165, 117, 115);
    }
    else{
      return Color.fromARGB(255, 216, 164, 42);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF6ED),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF6ED),
        centerTitle: true,
        title: Text(
          'Task Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 1,),
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 90,
                backgroundImage: AssetImage(
                  'assets/Open Book and Botanical Emblem.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(taskToDisplay.title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
            ),
            const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  taskToDisplay.description,
                  style: const TextStyle(fontSize: 16, color: Color(0xff4C5561)),
                ),
              ),
              const SizedBox(height: 20),
            ListTile(
                leading: const Icon(Icons.calendar_today_outlined),
                title: const Text('Date & Time'),
                trailing: Text(formatDateTime(context, taskToDisplay.dueDate),
                style: TextStyle(fontSize: 16),),
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined),
                title: const Text('Priority'),
                trailing: Chip(
                  backgroundColor:choosePriColor(),
                  label: Text(taskToDisplay.piriority)),
              ),
              ListTile(
                leading: const Icon(Icons.category_outlined),
                title: const Text('Category'),
                trailing: Chip(
                  backgroundColor:chooseCategoryColor(),
                  label: Text(taskToDisplay.category)),
              ),
        
              const Spacer(flex: 2,),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3F7165),
                      foregroundColor: const Color(0xffFAF6ED),
                      padding: const EdgeInsets.all(14),
                    ),
                    onPressed: () {
                      context.read<Taskscubit>().changeState(taskToDisplay);
                      Navigator.pop(context);
                    },
                    child: Text(
                      taskToDisplay.isCompleted ? 'Mark as Pending' : 'Mark as Complete',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Spacer(flex: 1,)
          ],
        ),
      ),
    );
  }
}
