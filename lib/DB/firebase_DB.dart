import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taskaty_app/models/taskModel.dart';

class FirebaseDb {
  static Future<void> addTask(Taskmodel task) async {
    final taskCollection=getCollectionRef();
    final docRef=taskCollection.doc();
    task.id=docRef.id;
    await docRef.set(task.toMap());
  }

  static Future<void> updateTask(Taskmodel task) async {
    final taskCollection=getCollectionRef();
    await taskCollection.doc(task.id).update(task.toMap());
    
  }

  static Stream<List<Taskmodel>> getTasks()  {
   final taskCollection=getCollectionRef();
   final tasksStream=taskCollection.snapshots();
   final Stream<List<Taskmodel>>tasksList=tasksStream.map((querySnapshot){
    final List<Taskmodel>tasks=[];
    for(var doc in querySnapshot.docs){
      final taskData=doc.data();
      tasks.add(Taskmodel.fromMap(taskData));

    }
    return tasks;

   });
   return tasksList;
  }

  static Future<void> deleteTask(String id) async {
    final taskCollection=getCollectionRef();
    await taskCollection.doc(id).delete();
  }

  static Future<void> clearAllTasks(List<Taskmodel> tasks) async {
    
    final taskCollection=getCollectionRef();
    final querySnapshot=await taskCollection.get();
    for (var doc in querySnapshot.docs){
      await doc.reference.delete();
    }
  }
  static CollectionReference<Map<String, dynamic>> getCollectionRef(){
   final userId=FirebaseAuth.instance.currentUser?.uid;
    final taskCollection=FirebaseFirestore.instance
    .collection("users").doc(userId).collection("tasks");
    return taskCollection; 
  }
}
