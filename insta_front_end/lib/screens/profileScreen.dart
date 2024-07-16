import 'package:flutter/material.dart';
import 'package:insta_front_end/screens/login.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routName ='profile_screen';


  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<data>(context);
    userData.followingAndFollowers(userData.currentUser['username']);
    //userData.followed(userData.currentUser['username']);
    //userData.followsList.clear();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  radius: 60,
                ),
                 SizedBox(width: 10,),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                    // Text("User name"),
                     Text("${userData.currentUser['username']}",style: TextStyle(fontSize: 20),)
                   ],
                 ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${userData.followers}"),
                    Text("Followers"),
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${userData.following}"),
                    Text("Following")
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  ElevatedButton(onPressed: (){}, child: Text("Followers")),
                  TextButton(
                    onPressed: (){
                    // userData.clearSuggestion();
                    userData.clearSearch();
                    // userData.clearfollowUsers();
                    userData.clearUsers();
                    Navigator.pushReplacementNamed(context, Login.routName);
                  },child: Text("Log out"),),
                ],
              )
          ),
        SizedBox(height: 20,),
        Container(
          color: Colors.lightBlue,
          height: 200,
          width: double.infinity,
          child: Text('lee'),
        )
        ],
      ),
    );
  }
}
