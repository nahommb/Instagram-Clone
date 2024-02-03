import 'package:flutter/material.dart';
import 'package:leegram/screens/chatListScreen.dart';
import 'package:leegram/screens/searchScreen.dart';
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
    searchScreen()
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
            icon: Icon(Icons.search,color: Colors.lightBlue,),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined,color: Colors.lightBlue),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_outlined,color: Colors.lightBlue),
            label: 'Reel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: Colors.lightBlue),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
