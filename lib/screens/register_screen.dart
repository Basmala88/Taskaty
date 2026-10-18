import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskaty_app/screens/addTaskScreen.dart';
import 'package:taskaty_app/screens/login_screen.dart';
import 'package:taskaty_app/screens/yourTasksScreen.dart';
import 'package:taskaty_app/widgets/elevatedButton_widget.dart';
import 'package:taskaty_app/widgets/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
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
                  'Create Your Account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 23, 23, 23),
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'start your journey to a more \norganized and productive day',
                  style: TextStyle(
                    color: Color.fromARGB(255, 87, 90, 94),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20),
                TextfieldWidget(
                  controller: nameController,
                  hintText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                ),
                SizedBox(height: 4),
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
                      color: const Color(0xFF6C7A8E),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordObscure = !isPasswordObscure;
                      });
                    },
                  ),
                ),
                SizedBox(height: 4),
                TextfieldWidget(
                  controller: confirmController,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: isConfirmPasswordObscure,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF6C7A8E),
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordObscure = !isConfirmPasswordObscure;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8),
                ElevatedbuttonWidget(
                  text: 'Sign up',
                  onPressed: () async {
                    String name = nameController.text.trim();
                    String email = emailController.text.trim();
                    String password = passwordController.text;
                    String confirmPassword = confirmController.text;
                    //1_Validate Input
                    if (name.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirmPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }
                    if (!email.contains('@') ||
                        !email.substring(email.indexOf('@')).contains('.')) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enter a valid email')),
                      );
                      return;
                    }

                    if (password.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password must be at least 6 characters',
                          ),
                        ),
                      );
                      return;
                    }
                    if (password != confirmPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match')),
                      );
                      return;
                    }
                    //UserCred

                    final messenger = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                      await userCredential.user!.updateDisplayName(name);
                      if (!mounted) return;
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('Account created successfully'),
                        ),
                      );

                      navigator.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Yourtasksscreen(),
                        ),
                        (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      String message =
                          'Something went wrong\nPlease try again later';
                      if (e.code == 'email-already-in-use') {
                        message = 'This email is already registered';
                      }
                       else if (e.code == 'invalid-email') {
                        message = 'Invalid email address';
                      }

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
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
                      'Already have an account?  ',
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
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 56, 88, 81),
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
