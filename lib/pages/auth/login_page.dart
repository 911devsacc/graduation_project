import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/signup_page.dart';
import 'package:graduation_project/widgets/auth_button.dart';
import 'package:graduation_project/widgets/my_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void navigateToSignupPage(BuildContext context) {
  
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupPage()),
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Text(
              "Welcome back!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 24),

            MyTextfield(hintText: 'Email', obscureText: false),

            SizedBox(height: 12),

            MyTextfield(hintText: 'Password', obscureText: true),

            SizedBox(height: 12),

            AuthButton(text: 'Login', onTap: () {}),

            SizedBox(height: 8),

            SwitchAuthPage(
              text: 'Don\'t have an account? ',
              onTap: () {
                navigateToSignupPage(context);
              },
              button: 'Sign up',
            ),
          ],
        ),
      ),
    );
  }
}
