import 'package:flutter/material.dart';
import 'package:insta_front_end/screens/storyScreen.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class HeadBar extends StatefulWidget {



  @override
  State<HeadBar> createState() => _HeadBarState();
}

class _HeadBarState extends State<HeadBar> {

  bool isInit = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(isInit){
      final username = Provider.of<data>(context).currentUser['username'];
      Provider.of<data>(context).followingList(username);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
   final userData = Provider.of<data>(context);
    final change = Provider.of<data>(context).change;

    //final userData = Provider.of<data>(context).allUSers;
    return Container(
      // color: Colors.lightBlueAccent,
      height: 100,
      margin: EdgeInsets.only(top: 7,left: 5),
      // padding: EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person,size: 40,color: Colors.white,)
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=>
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Column(
                        children: [
                          InkWell(
                            onTap: (){
                              change();
                              Navigator.pushNamed(context, StoriesScreen.routName);
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.pink,
                                          Colors.purple,
                                          Colors.orange,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent, // Set as transparent to show the gradient border
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 3,
                                    right: 3,
                                    top: 3,
                                    bottom: 3,
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: ClipOval(child: Image.network("https://picsum.photos/id/23/300/300",fit: BoxFit.cover,)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                      Text('${userData.followsList[index]['follows']}')  ],
                      ),

                    ],
                  ),
              itemCount: userData.followsList.length,
            ),
          ),
        ],
      ),
    );
  }
}
//https://picsum.photos/300/300