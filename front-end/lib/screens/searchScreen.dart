import 'package:flutter/material.dart';

class searchScreen extends StatelessWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(),
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.cyanAccent,
        )
      ],
    );
  }
}
