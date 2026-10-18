import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/firebase_options.dart';
import 'package:taskaty_app/screens/login_screen.dart';
import 'package:taskaty_app/screens/register_screen.dart';
import 'package:taskaty_app/screens/yourTasksScreen.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Taskscubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(), 
      ),
    );
  }
}