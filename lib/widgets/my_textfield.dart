import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? suffixIcon; 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32, right: 32, top: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: hintText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
