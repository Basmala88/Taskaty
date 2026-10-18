import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskaty_app/screens/addTaskScreen.dart';
import 'package:taskaty_app/screens/register_screen.dart';
import 'package:taskaty_app/screens/yourTasksScreen.dart';
import 'package:taskaty_app/widgets/elevatedButton_widget.dart';
import 'package:taskaty_app/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFAF7),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   radius: 100,
                //   backgroundColor: Colors.transparent,
                //   backgroundImage: AssetImage('assets/Open Book and Botanical Emblem.png'),
                // ),
                // SizedBox(height: 10),
                Text(
                  'Taskaty',
                  style: TextStyle(
                    color: const Color(0xFF3F7165),
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome Back\nSign in to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 17, 18),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20),

                TextfieldWidget(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                ),
                SizedBox(height: 4),
                TextfieldWidget(
                  controller: passwordController,
                  hintText: 'Password',

                  prefixIcon: Icons.lock_outline,
                  isPassword: isPasswordObscure,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color.fromARGB(255, 233, 236, 240),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordObscure = !isPasswordObscure;
                      });
                    },
                  ),
                ),

                SizedBox(height: 8),
                ElevatedbuttonWidget(
                  text: 'Sign in',
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text;
                    if (password.isEmpty || email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (!mounted) return;

                      // 3. Navigate after successful login
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Yourtasksscreen(),
                        ),
                        (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.message ?? 'Login failed')),
                      );
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Don't have an account  ",
                      style: TextStyle(
                        color: const Color(0xFF6C7A8E),
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      mouseCursor: SystemMouseCursors.click,
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 56, 88, 81),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
