import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControllelr = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    // Automatically build the email from student number
    _studentNumberController.addListener(() {
      final number = _studentNumberController.text.trim();

      // Auto-generate the full university email
      _emailController.text = "$number@st.aabu.edu.jo";

      // Keep cursor at the end of the email field when updated
      _emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: _emailController.text.length),
      );
    });
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordControllelr.text.trim();

      try {
        // Loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );

        // Create the user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // After createUserWithEmailAndPassword
        User? user = userCredential.user;

        // Save student number as username in Firestore
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
                'studentNumber': _studentNumberController.text.trim(),
                'email': _emailController.text.trim(),
                'createdAt': FieldValue.serverTimestamp(),
              });
        }

        // Optional: email verification
        await userCredential.user!.sendEmailVerification();

        // Close loader
        Navigator.of(context).pop();

        // Success pop-up
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Account Created"),
            content: const Text(
              "Your account has been created. Please verify your email before logging in.",
            ),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  navigateToLoginPage(context);
                },
              ),
            ],
          ),
        );
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop(); // close loader

        String errorMessage = "";

        if (e.code == 'email-already-in-use') {
          errorMessage = "This email is already registered.";
        } else if (e.code == 'invalid-email') {
          errorMessage = "Invalid email format.";
        } else if (e.code == 'weak-password') {
          errorMessage = "Password is too weak.";
        } else {
          errorMessage = e.message ?? "Signup failed.";
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Signup Error"),
            content: Text(errorMessage),
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
                  "Let's create your account!",
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
                    // Accept 6–10 digit numbers
                    if (!RegExp(r'^[0-9]{6,10}$').hasMatch(value)) {
                      return "Invalid student number";
                    }
                    return null;
                  },
                  controller: _studentNumberController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 12),

                // Auto-generated Email (read only)
                MyTextfield(
                  hintText: '@st.aabu.edu.jo',
                  obscureText: false,

                  controller: _emailController,
                  readOnly: true, // 🔥 important
                ),

                const SizedBox(height: 12),

                // Password Field
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

                const SizedBox(height: 12),

                // Confirm Password
                MyTextfield(
                  hintText: 'Confirm Password',
                  obscureText: !_confirmPasswordVisible,
                  validator: (value) => Validators.confirmPassword(
                    value,
                    _passwordControllelr.text,
                  ),
                  controller: _confirmPasswordController,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                AuthButton(text: 'Sign up', onTap: _signup),

                const SizedBox(height: 8),

                SwitchAuthPage(
                  text: 'Already have an account? ',
                  onTap: () => navigateToLoginPage(context),
                  button: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
