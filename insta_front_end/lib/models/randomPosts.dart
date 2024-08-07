import 'package:flutter/material.dart';
import 'package:insta_front_end/provider/post.dart';
import 'package:provider/provider.dart';
class RandomPosts extends StatefulWidget {
  const RandomPosts({Key? key}) : super(key: key);

  @override
  State<RandomPosts> createState() => _RandomPostsState();
}

class _RandomPostsState extends State<RandomPosts> {
  final image = 'http://192.168.56.1:3001/previousworks/20220106_144116.jpg';

  @override
  Widget build(BuildContext context) {

    Provider.of<Post>(context).getAllPost();
    final postData = Provider.of<Post>(context).allposts;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
        childAspectRatio: 1.0,
        maxCrossAxisExtent: 150,
        mainAxisExtent: 130// Aspect ratio of each grid item
      ),
      itemCount: postData.length, // Total number of items in the grid
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue,
         height: 60,
          width: 60,
           child: Image.network('http://192.168.56.1:3000/${postData[index]['image_url']}',fit: BoxFit.cover,)//Center(
          //   child: Text('Item $index'),
          // ),
        );
      },
    );
  }
}
