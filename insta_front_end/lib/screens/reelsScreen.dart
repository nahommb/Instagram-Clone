import 'package:flutter/material.dart';

class ReelsScreen extends StatelessWidget {


  PageController pageController = PageController();



  @override
  Widget build(BuildContext context) {
    List<Widget> pages =[
    Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      color: Colors.blueAccent,
      child: Center(child: Text('Neymar'),),
    ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        color: Colors.yellow,
        child: Center(child: Text('Messi'),),
      ),

      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        color: Colors.greenAccent,
        child: Center(child: Text('Ronaldo'),),
      )
      ];

    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: pageController,
        children: pages,
      ),
    );
  }
}
