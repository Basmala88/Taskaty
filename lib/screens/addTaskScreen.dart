import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskaty_app/helper/helper_functions.dart';
import 'package:taskaty_app/models/taskModel.dart';
import 'package:taskaty_app/screens/login_screen.dart';
import 'package:taskaty_app/screens/myTasksScreen.dart';
import 'package:taskaty_app/stateMang/tasksCubit.dart';

class Addtaskscreen extends StatefulWidget {
  const Addtaskscreen({super.key});

  @override
  State<Addtaskscreen> createState() => _AddtaskscreenState();
}

class _AddtaskscreenState extends State<Addtaskscreen> {
  @override
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDateTime;
  String selectedPiriority = 'medium';
  String selectedCategory = 'Study';
  final List<String> piriorities = ['Low', 'Medium', 'High'];
  final List<String> categories = ['Study', 'Work', 'Health', 'Personal'];

  Future<void> getDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (date == null) return;
    if (!mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String get formateDateTime => formatDateTime(
    context,
    selectedDateTime,
    emptyText: 'Select date & time',
  );

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAF6ED),
      appBar: AppBar(
        backgroundColor: Color(0xffFAF6ED),
        centerTitle: true,
        title: Text(
          'Add Task',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF305756)),
            onPressed: () async {
              context.read<Taskscubit>().reset();
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 90,
                backgroundImage: AssetImage(
                  'assets/Mint Clipboard Checklist with Leaves.png',
                ),
              ),
              // SizedBox(height: 10),
              // Text(
              //   'Create a New Task',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              // ),
              // SizedBox(height: 5),
              // Text(
              //   'Add a title and description for your task',
              //   style: TextStyle(color: Color(0xff4C5561), fontSize: 16),
              // ),
              // SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'task title',
                  prefixIcon: Icon(Icons.title, color: Color(0xFF305756)),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xffD7D7D7)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'task Description',
                  prefixIcon: Icon(Icons.description, color: Color(0xFF305756)),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xffD7D7D7)),
                  ),
                ),
              ),

              SizedBox(height: 20),

              InkWell(
                onTap: getDateTime,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffD7D7D7)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Color(0xFF305756),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date & Time',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                formateDateTime,
                                style: const TextStyle(
                                  color: Color(0xff4C5561),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xff4C5561),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 80,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag_outlined),
                        SizedBox(width: 12),
                        Text('Piriority'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: piriorities.map((P) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedPiriority == P
                                ? const Color(0xffFFD98A)
                                : Colors.white,

                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Color(0xffD7D7D7)),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedPiriority = P;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(P, style: TextStyle(fontSize: 12)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 80,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.category_outlined),
                        SizedBox(width: 12),
                        Text('Categories'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: categories.map((c) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedCategory == c
                                ? const Color(0xffC2D4B9)
                                : Colors.white,

                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Color(0xffD7D7D7)),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedCategory = c;
                            });
                          },
                          child: Text(c, style: TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F7165),
                  foregroundColor: Color(0xffFAF6ED),
                ),
                onPressed: () {
                  //-----------------------
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please entre a valid information'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                    return;
                  }
                  context.read<Taskscubit>().addTask(
                    Taskmodel(
                      id: DateTime.now().toString(),
                      title: titleController.text,
                      description: descriptionController.text,
                      dueDate: selectedDateTime, 
                      category: selectedCategory, 
                      piriority: selectedPiriority, 
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text('Add Task', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
