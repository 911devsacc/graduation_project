import 'package:flutter/material.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({super.key});

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posting Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Posting Page!'),
      ),
    );
  }
}