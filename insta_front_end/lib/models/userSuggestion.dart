import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class userSuggestion extends StatefulWidget {
  const userSuggestion({Key? key}) : super(key: key);

  @override
  State<userSuggestion> createState() => _userSuggestionState();
}

class _userSuggestionState extends State<userSuggestion> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(isInit){
     final username = Provider.of<data>(context).currentUser['username'];
      Provider.of<data>(context).followSuggestion(username);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<data>(context);
    // userData.followSuggestion(userData.currentUser['username']);
    final notFollowingUsers = Provider.of<data>(context,listen: true).nonFollowers;

    return GestureDetector(
      onTap: (){
        userData.clearSearch();
      },
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Center(child: Text("User not found"),),
            Center(
                child: TextButton(
                  onPressed: () async{
                     // userData.clearSuggestion();
                    // await userData.followSuggestion(userData.currentUser['username']);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // userData.followSuggestion(userData.currentUser['username']);
                        return AlertDialog(
                          title: Text('User Suggestions'),
                          content: SizedBox(
                            height: 300,
                            width: 300,
                            child: ListView.builder(
                              itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                ),
                                title: Text('${notFollowingUsers[index]['username']}'),
                                subtitle: Text('leeeiopia'),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // Add your follow logic here
                                  },
                                  child: Text('Follow'),
                                ),
                              ),
                              itemCount: notFollowingUsers.length,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                 // userData.clearSuggestion();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Open Suggestions'),
                ),
            ),
          ],
        ),
      ),
    );
  }
}