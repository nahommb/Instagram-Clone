import 'package:flutter/material.dart';
import 'package:insta_front_end/screens/login.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static String routName ='profile_screen';

  @override
  Widget build(BuildContext context) {
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
                     Text("User name"),
                     Text("Nahom")
                   ],
                 ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Followers"),
                    Text("2303")
                  ],
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Following"),
                    Text("490")
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
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, Login.routName);
                  },child: Text("Log out"),),
                ],
              )
          ),

        ],
      ),
    );
  }
}
