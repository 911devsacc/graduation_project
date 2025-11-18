import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({super.key, required this.hintText, required this.obscureText, required this.controller,  this.keyboardType = TextInputType.text, required this.validator});
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(left: 32, right: 32, top: 16),
              child: TextFormField(
                obscureText: obscureText,
                validator: validator,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: hintText,
                  
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,

                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            );
  }
}