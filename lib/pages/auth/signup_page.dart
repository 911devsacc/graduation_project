import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/login_page.dart';
import 'package:graduation_project/widgets/auth_button.dart';
import 'package:graduation_project/widgets/my_textfield.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  void navigateToLoginPage(BuildContext context) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
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
              "Sign Up",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 24),

            MyTextfield(hintText: 'Email', obscureText: false),

            SizedBox(height: 12),

            MyTextfield(hintText: 'Password', obscureText: true),

            SizedBox(height: 12),

            MyTextfield(hintText: 'Confirm password', obscureText: true),

            SizedBox(height: 12),

            AuthButton(text: 'Sign up', onTap: () {}),

            SizedBox(height: 8),

            SwitchAuthPage(
              text: 'Already have an account? ',
              onTap: () {
                navigateToLoginPage(context);
              },
              button: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
