import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({super.key, required this.hintText, required this.obscureText});
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(left: 32, right: 32, top: 16),
              child: TextField(
                obscureText: obscureText,
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