import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/login_page.dart';
import 'package:graduation_project/pages/auth/validators.dart';
import 'package:graduation_project/widgets/auth_button.dart';
import 'package:graduation_project/widgets/my_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControlelr = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

            MyTextfield(
              hintText: 'Email',
              obscureText: false,
              validator: Validators.email,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 12),

            MyTextfield(
              hintText: 'Password',
              obscureText: true,
              validator: Validators.password,
              controller: _passwordControlelr,
            ),

            SizedBox(height: 12),

            MyTextfield(
              hintText: 'Confirm password',
              obscureText: true,
              validator: (value) =>
                  Validators.confirmPassword(value, _passwordControlelr.text),
              controller: _confirmPasswordController,
            ),

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
