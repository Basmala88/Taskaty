import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/screens/addTaskScreen.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';

class FireHomeScreen extends StatefulWidget {
  final User user;
  const FireHomeScreen({super.key, required this.user});

  @override
  State<FireHomeScreen> createState() => _FireHomeScreenState();
}

class _FireHomeScreenState extends State<FireHomeScreen> {
 
  
  @override
  Widget build(BuildContext context) {
    return Addtaskscreen();
  }
}