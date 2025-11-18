import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/signup_page.dart';
import 'package:graduation_project/pages/auth/validators.dart';
import 'package:graduation_project/widgets/auth_button.dart';
import 'package:graduation_project/widgets/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControlelr = TextEditingController();

  void navigateToSignupPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordControlelr.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Text(
                "Welcome back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          
              SizedBox(height: 24),
          
              MyTextfield(hintText: 'Email', obscureText: false,validator: Validators.email,keyboardType: TextInputType.emailAddress,controller: _emailController,),
          
              SizedBox(height: 12),
          
              MyTextfield(hintText: 'Password', obscureText: true,validator: Validators.password,controller: _passwordControlelr,),
          
              SizedBox(height: 12),
          
              AuthButton(text: 'Login', onTap: _login),
          
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
      ),
    );
  }
}
