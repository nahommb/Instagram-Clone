import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class searchScreen extends StatelessWidget {

  var nameOfUser;
  var unfoundedUser;

  @override
  Widget build(BuildContext context) {
    final searchUser = Provider.of<data>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(child: SearchBar(
              onChanged: (value){
                nameOfUser =value;
                unfoundedUser = value;
              },
            ),width: 350,),
            TextButton(
                onPressed: (){
              if(nameOfUser!=null){
                searchUser.clearSearch();
                searchUser.searchUser(nameOfUser);
                nameOfUser = null;
              }

            }, child: Text("Search"))
          ],
        ),
        SizedBox(height: 20,),
        Container(
          width: double.infinity,
          height: 300,
         // color: Colors.cyanAccent,
          padding: EdgeInsets.all(10),
          child: Consumer<data>(
            builder: (context,data,child){
              return data.findedUser.length>0? ListView.builder(
                  itemCount: data.findedUser.length,
                  itemBuilder: (context,index)=>
                ListTile(
                  leading: CircleAvatar(
                      radius: 40,
                      child: Image.network('${data.users[index].storyImageUrl}/300/300')
                  ),
                  title: Text('${data.findedUser[0]['username']}'),
                  subtitle: Text('abelians'),
                  trailing: ElevatedButton(onPressed: (){},child: Text("Follow"),),)

              ):Center(child: Text("user named $unfoundedUser is not found"),);
            },
          )
        )
      ],
    );
  }
}
