import 'package:flutter/material.dart';
import 'package:insta_front_end/provider/data.dart';
import 'package:insta_front_end/provider/post.dart';
import 'package:provider/provider.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});
  static final  routName = 'new_post_screen';
  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {

  @override
  Widget build(BuildContext context) {
  final currentuser = Provider.of<data>(context).currentUser['username'];
  final postImage = Provider.of<Post>(context);

  var caption = null;

    final Map<String, dynamic> args =  ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('New Post'),),
      body: Column(
        children: [
          Container(
            height: 300,
           width: double.infinity,
           padding: EdgeInsets.all(10),
           // color: Colors.lightBlue,
            child: Image.file(args['imageUrl'],fit: BoxFit.cover,),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val){
                caption = val;
              },
              decoration: InputDecoration(
                hintText: 'Write Caption',

              ),
            ),
          ),
          Spacer(),
          ElevatedButton(onPressed: (){
            postImage.postImage(currentuser, caption);
            Navigator.pop(context);
          },child: Text("Share"),)
        ],
      ),
    );
  }
}

