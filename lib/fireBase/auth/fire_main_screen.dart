import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'fire_auth_screen.dart';
import 'fire_home_screen.dart';

class FireMainScreen extends StatelessWidget {
  const FireMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context,snapshot){
        if (snapshot.data!=null) {
           return FireHomeScreen(user:snapshot.data!);
           
          
        } else {
        return const FireAuthScreen();
        }

       });
  }
}