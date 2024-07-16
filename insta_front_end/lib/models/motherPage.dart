import 'package:flutter/material.dart';
import 'package:insta_front_end/provider/post.dart';
import 'package:insta_front_end/screens/chatListScreen.dart';
import 'package:insta_front_end/screens/profileScreen.dart';
import 'package:insta_front_end/screens/reelsScreen.dart';
import 'package:insta_front_end/screens/searchScreen.dart';
import 'package:provider/provider.dart';
import '../provider/data.dart';
import '../screens/addPostScreen.dart';
import '../screens/homeSceen.dart';
import 'headBar.dart';
import 'mainBody.dart';
class homePage extends StatefulWidget {
  static String routName = 'homepade';
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _currentIndex = 0;
  List<dynamic> pages=[
    homeScreen(),
    searchScreen(),
    Text(''),
    ReelsScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    // final getUser = Provider.of<data>(context).getUser;
    final clearUser = Provider.of<data>(context).clearUsers;
    final userData = Provider.of<data>(context);
    //userData.followingAndFollowers(userData.currentUser['username']);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Instagram',style: TextStyle(fontFamily: 'LobsterTwo-Regular',fontSize: 30),),
          backgroundColor: Colors.black,
          actions: [
        IconButton(onPressed: (){

        }, icon: Icon(Icons.favorite_border,size: 30,)),
        SizedBox(width: 8,),
        IconButton(onPressed: (){
          Navigator.pushNamed(context, ChatListScreen.routName,);
          // getUser();
          userData.followingList(userData.currentUser['username']);
          // userData.clearfollowUsers();
          clearUser();
        }, icon: Icon(Icons.offline_bolt_outlined,size: 30,)),
            SizedBox(width: 20,),
      ]),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        iconSize: 30,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore,color: Colors.white,),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: IconButton(onPressed: () {
              Provider.of<Post>(context,listen: false).getImage();
              print('addddddd');},icon: Icon(Icons.add,color: Colors.white,),),
            label: 'Add',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie,color: Colors.white),
            label: 'Reel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
