import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/signup_page.dart';
import 'package:graduation_project/pages/auth/validators.dart';
import 'package:graduation_project/pages/in_app/home_page.dart';
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
  final TextEditingController _passwordControllelr = TextEditingController();

  void navigateToSignupPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  void _login() async {
  if (_formKey.currentState!.validate()) {
    final email = _emailController.text.trim();
    final password = _passwordControllelr.text.trim();

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Login attempt
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = FirebaseAuth.instance.currentUser;

      // ❌ Check if email is not yet verified
      if (user != null && !user.emailVerified) {
        // optional: send again
        await user.sendEmailVerification();

        // Force logout
        await FirebaseAuth.instance.signOut();

        Navigator.of(context).pop(); // close loader

        // Show an alert
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Email Not Verified"),
            content: const Text(
              "Your email is not verified. We have sent you a new verification email. "
              "Please verify before logging in.",
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );

        return; // stop login flow
      }

      // If verified → proceed to home
      Navigator.of(context).pop(); // close loader
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> const HomePage()));

    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); // close loader

      String message = "";
      if (e.code == 'user-not-found') {
        message = "No user found for this email.";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password.";
      } else {
        message = e.message ?? "Login failed.";
      }

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Login Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Text(
                "Welcome back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 24),

              MyTextfield(
                hintText: 'Email',
                obscureText: false,
                validator: Validators.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),

              SizedBox(height: 12),

              MyTextfield(
                hintText: 'Password',
                obscureText: true,
                validator: Validators.password,
                controller: _passwordControllelr,
              ),

              SizedBox(height: 24),

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
