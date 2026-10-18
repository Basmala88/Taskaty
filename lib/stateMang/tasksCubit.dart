import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/DB/firebase_DB.dart';
import 'package:taskaty_app/DB/remote_Db.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/stateMang/task_DB.dart';

class Taskscubit extends Cubit<List<Taskmodel>> {
   Taskscubit() : super([]){
    init();
   }
   Future<void> init() async {
   final tasksStream = FirebaseDb.getTasks();
   tasksStream.listen((tasks) {
     emit(tasks);
   },);
    
  }
   Future<void> addTask(Taskmodel task)async{
     await FirebaseDb.addTask(task);
    List<Taskmodel>newList=[...state,task];
    
   
   }
   void reset() => emit([]);
   Future<void> deleteTask(Taskmodel task)async{
    List<Taskmodel>newList=[...state];
    newList.remove(task);
    
    await FirebaseDb.deleteTask(task.id);
   }
   Future<void> changeState(Taskmodel task)async{
    task.isCompleted=!task.isCompleted;
      emit([...state]);
       await FirebaseDb.updateTask(task);
    
   }
   Future<void> clearAll()async{
    emit([]);
    await FirebaseDb.clearAllTasks(state);
   }

}