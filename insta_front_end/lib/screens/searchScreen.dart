import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class searchScreen extends StatelessWidget {
  const searchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchUser = Provider.of<data>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(child: SearchBar(),width: 350,),
            TextButton(onPressed: (){
              searchUser.searchUser('nahom');
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
              return ListView.builder(
                  itemCount: data.users.length,
                  itemBuilder: (context,index)=>
                ListTile(
                  leading: CircleAvatar(
                      radius: 40,
                      child: Image.network('${data.users[index].storyImageUrl}/300/300')
                  ),
                  title: Text('${data.users[index].name}'),
                  subtitle: Text('abelians'),
                  trailing: ElevatedButton(onPressed: (){},child: Text("Follow"),),)

              );
            },
          )
        )
      ],
    );
  }
}
