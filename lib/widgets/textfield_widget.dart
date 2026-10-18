import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
     this.isPassword=false,
    this.suffixIcon,
    this.controller,
  });
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 221, 227, 237), 
          fontSize: 14,
        ),
        prefixIcon: Icon(prefixIcon,
        color: Color.fromARGB(255, 221, 227, 237), 
          size: 20,),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: const Color(0xFF3F7165),
          contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, 
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 57, 92, 84), 
            width: 1.5,)
        )
      ),
      
      

    );
  }
}