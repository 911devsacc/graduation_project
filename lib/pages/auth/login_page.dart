import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/signup_page.dart';
import 'package:graduation_project/pages/auth/validators.dart';
import 'package:graduation_project/pages/main_screen.dart';
import 'package:graduation_project/provider/user_provider.dart';
import 'package:graduation_project/widgets/auth_button.dart';
import 'package:graduation_project/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControllelr = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();

    // Auto-generate email from student number
    _studentNumberController.addListener(() {
      final number = _studentNumberController.text.trim();
      _emailController.text = "$number@st.aabu.edu.jo";

      // Keep cursor at end
      _emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: _emailController.text.length),
      );
    });
  }

  void navigateToSignupPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  void _login() async {
  if (_formKey.currentState!.validate()) {
    final studentNumber = _studentNumberController.text.trim();
    final email = "$studentNumber@st.aabu.edu.jo";
    final password = _passwordControllelr.text.trim();

    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      // Attempt login
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Save student number to provider
        Provider.of<UserProvider>(context, listen: false)
            .setStudentNumber(studentNumber);

        // Check email verification
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          await FirebaseAuth.instance.signOut();

          Navigator.of(context).pop(); // Close loader

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Email Not Verified"),
              content: const Text(
                "Your email is not verified. We sent a new verification email. Please verify before logging in.",
              ),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );

          return; // Stop login flow
        }
      }

      // Login success → go to main screen
      Navigator.of(context).pop(); // Close loader
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => const MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(); // Close loader

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
            ),
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),

                // Student Number Field
                MyTextfield(
                  hintText: 'Student Number',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Student number is required";
                    }
                    if (!RegExp(r'^[0-9]{6,10}$').hasMatch(value)) {
                      return "Invalid student number";
                    }
                    return null;
                  },
                  controller: _studentNumberController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 12),

                // Email Field (read-only, auto-generated)
                MyTextfield(
                  hintText: '@st.aabu.edu.jo',
                  obscureText: false,
                  controller: _emailController,
                  readOnly: true,
                ),

                const SizedBox(height: 12),

                // Password
                MyTextfield(
                  hintText: 'Password',
                  obscureText: !_passwordVisible,
                  validator: Validators.password,
                  controller: _passwordControllelr,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                AuthButton(text: 'Login', onTap: _login),

                const SizedBox(height: 8),

                SwitchAuthPage(
                  text: 'Don\'t have an account? ',
                  onTap: () => navigateToSignupPage(context),
                  button: 'Sign up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
