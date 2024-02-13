import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';
 class mainBody extends StatelessWidget {
   const mainBody({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     final userData = Provider.of<data>(context).users;
     double media = MediaQuery.of(context).size.height;
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
                           Text("${userData[index].name}",style: TextStyle(fontWeight: FontWeight.bold),)
                         ],
                       ),
                       SizedBox(height: 10,),
                       Container(
                         width: double.infinity,
                         height: constraints.maxHeight*0.5,
                         color: Colors.orange,
                         child: Image.network('https://picsum.photos/id/23$index/300/200',fit: BoxFit.cover,),
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
                         child: Text("Sign up for the great deliverability, stay for the...",),
                       )

                     ],
                   ),
                 itemCount: userData.length,
               ),
             ),
         ),
          )
       ],
     );
   }
 }

