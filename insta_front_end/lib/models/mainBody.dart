import 'package:flutter/material.dart';
import 'package:insta_front_end/provider/post.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';
 class mainBody extends StatelessWidget {
   const mainBody({Key? key}) : super(key: key);
   final image = 'http://192.168.56.1:3001/previousworks/20220106_144116.jpg';
   @override
   Widget build(BuildContext context) {
     final userData = Provider.of<data>(context).users;
     final currentUser = Provider.of<data>(context).currentUser;
     double media = MediaQuery.of(context).size.height;
     Provider.of<Post>(context).getPost(currentUser['username']);
     final postData = Provider.of<Post>(context).posts;
     return Column(
       children: [
          Expanded(
            child: Container(
             padding: EdgeInsets.symmetric(horizontal:10),
             // height: media*0.67,
             child: LayoutBuilder(
               builder: (context ,constraints)=>
                ListView.builder(
                   itemBuilder: (context,index)=>Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           CircleAvatar(
                             radius:25,
                             child: ClipOval(child: Image.network("${userData[index].storyImageUrl}$index/200/200",fit: BoxFit.cover,),),),
                           SizedBox(width: 8,),
                           Text("${postData[index]['username']}",style: TextStyle(fontWeight: FontWeight.bold),)
                         ],
                       ),
                       SizedBox(height: 10,),
                       Container(
                         width: double.infinity,
                         // height: constraints.maxHeight*0.5,
                         color: Colors.orange,
                         child: Image.network('http://192.168.56.1:3000/${postData[index]['image_url']}',fit: BoxFit.cover,),
                       ),
                       Container(
                         height: 40,
                         margin: EdgeInsets.only(bottom: 10),
                         //color: Colors.lightBlueAccent,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             IconButton(onPressed: (){},icon: Icon(Icons.favorite_border,size: 25,),),
                             IconButton(onPressed: (){},icon: Icon(Icons.mode_comment_outlined,size: 25,),),
                             IconButton(onPressed: (){},icon: Icon(Icons.send,size: 25,),),
                             Spacer(),
                             IconButton(onPressed: (){},icon: Icon(Icons.bookmark_border,size: 25,),),

                           ],
                         ),
                       ),
                       Container(
                         margin:EdgeInsets.only(left: 10,bottom: 20),
                         child: Text('${postData[index]['caption']}'),
                       )

                     ],
                   ),
                 itemCount: postData.length,
               ),
             ),
         ),
          )
       ],
     );
   }
 }

