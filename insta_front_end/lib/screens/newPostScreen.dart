import 'package:flutter/material.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Post'),),
      body: Column(
        children: [
          Container(),
          TextField(
            decoration: InputDecoration(
              hintText: 'Write Caption',
            ),
          ),
        ],
      ),
    );
  }
}

