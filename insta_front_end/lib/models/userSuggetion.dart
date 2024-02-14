import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class userSuggetion extends StatelessWidget {
  const userSuggetion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allUsers = Provider.of<data>(context).nonFollowers;
    return Container(
     child: ListView.builder(
       itemBuilder: (context,index)=>
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
          ),
          title: Text('${allUsers[index]['username']}'),
          subtitle: Text('leeeiopia'),
          trailing: ElevatedButton(onPressed: (){},child: Text('Follow'),),
        ),
       itemCount: allUsers.length,
     ),
    );
  }
}
