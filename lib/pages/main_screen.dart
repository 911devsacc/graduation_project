import 'package:flutter/material.dart';
import 'package:graduation_project/pages/in_app/chats_page.dart';
import 'package:graduation_project/pages/in_app/home_page.dart';
import 'package:graduation_project/pages/in_app/posting_page.dart';
import 'package:graduation_project/pages/in_app/rules_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Center(child: HomePage()),
    Center(child: PostingPage()),
    Center(child: ChatsPage()),
    Center(child: RulesPage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.rule), label: 'Rules'),
        ],
      ),
    );
  }
}
