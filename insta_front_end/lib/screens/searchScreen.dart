import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/userSuggestion.dart';
import '../provider/data.dart';

class searchScreen extends StatefulWidget {

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  var nameOfUser;

  var unfoundedUser;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<data>(context);
    userData.followingAndFollowers(userData.currentUser['username']);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: SearchBar(
              onChanged: (value){
                nameOfUser =value;
                unfoundedUser = value;
              },
            ),width: 350,),
            TextButton(
                onPressed: (){
              if(nameOfUser!=null && nameOfUser!='' && nameOfUser != userData.currentUser['username']){
                userData.clearSearch();
                userData.searchUser(nameOfUser);
                nameOfUser = null;
              }
              setState(() {

              });

            }, child: Text("Search"))
          ],
        ),
        SizedBox(height: 20,),
        Expanded(
          child: Container(
            width: double.infinity,
           // height: 300,
           // color: Colors.cyanAccent,
            padding: EdgeInsets.all(10),
            child: Consumer<data>(
              builder: (context,data,child){
                return data.findedUser.length>0? (data.findedUser[0]['response']=='nothing'?Center(child: Text('leeee'),):
                ListView.builder(
                    itemCount: data.findedUser.length,
                    itemBuilder: (context,index)=>
                  ListTile(
                    leading: CircleAvatar(
                        radius: 40,
                        child: Image.network('${data.users[index].storyImageUrl}/300/300')
                    ),
                    title: Text('${data.findedUser[0]['username']}'),
                    subtitle: Text('abelians'),
                    trailing: ElevatedButton(onPressed: (){
                      userData.followUSer(userData.currentUser['username'], data.findedUser[0]['username']);
                    },child: Text("Follow"),),)

                 )):userSuggestion();
              },
            )
          ),
        )
      ],
    );
  }
}
