import 'package:flutter/material.dart';
import 'package:graduation_project/pages/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graduation_project/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const MainApp(),
    ),);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}
