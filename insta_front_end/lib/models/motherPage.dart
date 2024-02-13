import 'package:flutter/material.dart';
import 'package:insta_front_end/screens/chatListScreen.dart';
import 'package:insta_front_end/screens/profileScreen.dart';
import 'package:insta_front_end/screens/searchScreen.dart';
import 'package:provider/provider.dart';
import '../provider/data.dart';
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
  List<Widget> pages=[
    homeScreen(),
    searchScreen(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
  }

  @override
  Widget build(BuildContext context) {
    final getUser = Provider.of<data>(context).getUser;
    final clearUser = Provider.of<data>(context).clearUsers;
    final userData = Provider.of<data>(context);
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
          getUser();
          userData.followingList(userData.currentUser['username']);
          userData.clearfollowUsers();
          clearUser();
        }, icon: Icon(Icons.offline_bolt_outlined,size: 30,)),
            SizedBox(width: 20,),
      ]),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        iconSize: 30,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.lightBlue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore,color: Colors.lightBlue,),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline,color: Colors.lightBlue),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie,color: Colors.lightBlue),
            label: 'Reel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,color: Colors.lightBlue),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
