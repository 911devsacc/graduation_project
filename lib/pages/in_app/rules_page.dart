import 'package:flutter/material.dart';
import 'package:graduation_project/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  @override
  Widget build(BuildContext context) {
    final username = Provider.of<UserProvider>(context).studentNumber;

    return Scaffold(
      appBar: AppBar(title: const Text('Rules Page')),
      body: Center(child: Text('Welcome to the Rules Page $username!')),
    );
  }
}
