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

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordControllelr = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
 
 

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
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );

        // Create the user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // OPTIONAL: send email verification
        await userCredential.user!.sendEmailVerification();

        // Close loader
        Navigator.of(context).pop();

        // Show success message
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Text(
                "Let's create your account !",
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
                obscureText: !_passwordVisible,
                validator: Validators.password,
                controller: _passwordControllelr,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    
                    });
                  },
                ),
              ),

              SizedBox(height: 12),

              MyTextfield(
                hintText: 'Confirm password',
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

              SizedBox(height: 24),

              AuthButton(text: 'Sign up', onTap: _signup),

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
      ),
    );
  }
}
