import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.text, required this.onTap});

  final String text;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 32, right: 32),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class SwitchAuthPage extends StatelessWidget {
  const SwitchAuthPage({
    super.key,
    required this.text,
    required this.onTap,
    required this.button,
  });
  final String text;
  final Function()? onTap;
  final String button;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),

        GestureDetector(
          onTap: onTap,
          child: Text(
            button,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
