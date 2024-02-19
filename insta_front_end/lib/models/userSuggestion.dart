import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class userSuggestion extends StatelessWidget {
  const userSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<data>(context);
    // userData.followSuggestion(userData.currentUser['username']);
    final allUsers = Provider.of<data>(context).nonFollowers;

    return GestureDetector(
      onTap: (){
        userData.clearSearch();
      },
      child: Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Center(child: Text("User not found"),),
            Center(
                child: TextButton(
                  onPressed: () {
                    userData.followSuggestion(userData.currentUser['username']);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
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
                                title: Text('${allUsers[index]['username']}'),
                                subtitle: Text('leeeiopia'),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // Add your follow logic here
                                  },
                                  child: Text('Follow'),
                                ),
                              ),
                              itemCount: allUsers.length,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                userData.clearSuggestion();
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