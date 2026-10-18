import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key,required this.task});
  final Taskmodel task;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      child: Card(
        color: Color(0xffFDFCF9),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            
            leading: task.isCompleted?
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xffE8F1EC),
              child: Icon(
                Icons.task_alt_rounded,
                size: 28,
                color: const Color(0xff2F7D6B),
              ),
            ):Icon(Icons.circle_outlined),
            title: Text(task.title,
            style: TextStyle(
               decoration: task.isCompleted
              ?TextDecoration.lineThrough:TextDecoration.none,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),),
            subtitle: Text(task.description,
            style: TextStyle(
             

              color: Color(0xff474D59),
              fontSize: 14
            ),),
            trailing: Row(
                mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: (){
                    context.read<Taskscubit>().deleteTask(task);
                  },
                  icon: Icon(Icons.delete_forever_outlined,
                  color: Colors.red.shade700,
                  ),
                ),
                SizedBox(width: 10,),
                Checkbox(
                  
                  value: task.isCompleted,
                  activeColor: const Color(0xff2F7D6B),
                 onChanged:(value){
                  context.read<Taskscubit>().changeState(task);
                 } )
              ],
            ),
          ),
        ),
      ),
    );
  }
}