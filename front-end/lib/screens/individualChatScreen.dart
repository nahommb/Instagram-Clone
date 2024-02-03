import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leegram/screens/individualErrorScreen.dart';
import 'package:provider/provider.dart';

import '../provider/chatHistory.dart';
import '../provider/data.dart';


Stream<List<dynamic>> getNewMessage(String sender, String receiver) async* {
  //ScrollController _scrollController = ScrollController();

  var url = Uri.parse('http://127.0.0.1:3000/user/getmessage/$sender/$receiver');
  http.Response ps = await http.get(url);
  print(ps);
  List<dynamic> messages;
  try{
    messages = jsonDecode(ps.body);
  }
  catch(e){
    messages=[];
  }

 print(messages);
  yield messages;

  while (true) {
    await Future.delayed(Duration(seconds: 1));
    http.Response newPs = await http.post(url, body: {
      'sender': sender,
      'receiver': receiver,
    });
    List<dynamic> newMessages = jsonDecode(newPs.body);
    if (newMessages.length > messages.length) {
      List<dynamic> diff = newMessages.sublist(messages.length);
      messages.addAll(diff);
      yield diff;
     // _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}

class IndividualChatScreen extends StatefulWidget {
  static String routName ='individual_chat';


  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  var message = '';

  final textController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
   // final insertMessage = Provider.of<ChatHistory>(context).chatHistory;
    final sendMessage = Provider.of<ChatHistory>(context).sendMessage;
    final currentUser = Provider.of<data>(context).currentUser;
    final messageHandler =Provider.of<ChatHistory>(context).getMessage("${currentUser['username']}", '${args['name']}');

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("${args['name']}"),backgroundColor: Colors.black,),
      body:StreamBuilder<List<dynamic>>(
        stream: getNewMessage(currentUser['username'],args['name']), // Replace with appropriate sender and receiver values
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List<dynamic> messages = snapshot.data!;
            // Do something with the list of messages
            return Container(
              //color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: ListView.builder(
                        itemCount: messages.length,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: (currentUser['username']==messages[index]['sender'])? CrossAxisAlignment.end:CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Container(
                                   //color:Colors.lightGreenAccent,
                                    padding:EdgeInsets.all(7),
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color:(currentUser['username']==messages[index]['sender'])? Colors.green:Colors.lightBlue,
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Text(messages[index]['message'].toString(),style: TextStyle(fontSize: 13),)
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                   // width: 400,
                    margin: EdgeInsets.symmetric(horizontal: 16 ,vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                     // color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        TextField(
                          onChanged: (val){
                            message = val;
                          },
                          controller: textController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Change the border color here
                          ),
                          filled: true,
                          fillColor: Colors.black,
                          contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 6),
                        )
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.send,color: Colors.white,),
                            onPressed: () async{
                              setState(() {
                                sendMessage('${currentUser['username']}','${args['name']}','$message');
                                textController.clear();
                               _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.fastOutSlowIn,
                                );
                              });
                              // await _auth.createUserWithEmailAndPassword(email: message, password: message);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return individualErrorScreen();
          } else {
            // Show a loading indicator while waiting for data
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}