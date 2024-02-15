import 'package:flutter/material.dart';
class RandomPosts extends StatefulWidget {
  const RandomPosts({Key? key}) : super(key: key);

  @override
  State<RandomPosts> createState() => _RandomPostsState();
}

class _RandomPostsState extends State<RandomPosts> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
       // crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
        childAspectRatio: 1.0,
        maxCrossAxisExtent: 250,
        mainAxisExtent: 250// Aspect ratio of each grid item
      ),
      itemCount: 10, // Total number of items in the grid
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue,
         height: 100,
          width: 100,
          child: Center(
            child: Text('Item $index'),
          ),
        );
      },
    );
  }
}
