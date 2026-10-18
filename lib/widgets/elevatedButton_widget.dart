import 'package:flutter/material.dart';

class ElevatedbuttonWidget extends StatelessWidget {
  const ElevatedbuttonWidget({super.key,
  required this.text,
  required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3F7165), 
          foregroundColor: Colors.white,
          elevation: 0, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), 
          ),
        ),
        child: Text(text,
        style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),)),
    );
  }
}