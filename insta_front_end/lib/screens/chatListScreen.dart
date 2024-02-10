import 'package:flutter/material.dart';
import 'package:insta_front_end/provider/chatHistory.dart';
import 'package:insta_front_end/screens/cc.dart';
import 'package:insta_front_end/screens/individualChatScreen.dart';
import 'package:provider/provider.dart';

import '../models/headBar.dart';
import '../provider/data.dart';
class ChatListScreen extends StatelessWidget {

  static String routName = 'chatlistscreen';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<data>(context).allUSers;
    final currentUser = Provider.of<data>(context).currentUser;
    final clearUser = Provider.of<data>(context).clearUsers;
    final messageHandler =Provider.of<ChatHistory>(context);
    double media = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('${currentUser['username']}'),
        backgroundColor: Colors.black,
        actions: [
          Icon(Icons.linear_scale_outlined),
          SizedBox(width: 20,),
          Icon(Icons.topic),
          SizedBox(width: 20,),
          Icon(Icons.edit),
          SizedBox(width: 20,),
        ],
      ),
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox( width:350, child: SearchBar(hintText: "search",)),
              TextButton(onPressed: (){}, child: Text('Filter'))
            ],
          ),
          SizedBox(height: 10,),
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 20),
            // color: Colors.lightBlueAccent,
            child:HeadBar(),
          ),
          Container(
            height: media*0.6,
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              itemBuilder: (context,index)=>
                  ListTile(
                    onTap: (){
                      messageHandler.getMessage('${currentUser['username']}',"${userData[index]['username']}");
                      messageHandler.clearChat();
                      Navigator.pushNamed(context, IndividualChatScreen.routName,arguments: {'name': userData[index]['username']});
                      //Navigator.pushNamed(context, YourWidget.routName);
                      //clearUser();
                    },
                    leading: CircleAvatar(
                     radius: 30,
                      child: ClipOval(
                      //  child: Image.network("${userData[index].storyImageUrl}$index/300/300",fit:BoxFit.cover),
                      ),
                    ),
                    title: Text('${userData[index]['username']}'),
                    subtitle: Text('active now'),
                    trailing: Icon(Icons.camera_alt_outlined),
                  ),
              itemCount: userData.length,),
          )
        ],
      ),
    );
  }
}
