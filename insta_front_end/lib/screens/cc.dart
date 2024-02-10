import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/chatHistory.dart';


Stream<List<dynamic>> getMessage(String sender, String receiver) async* {
  var url = Uri.parse('http://localhost:3000/user/getmessage');
  http.Response ps = await http.post(url, body: {
    'sender': sender,
    'receiver': receiver,
  });

  List<dynamic> messages = jsonDecode(ps.body);
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
    }
  }
}

class YourWidget extends StatelessWidget {
  static String routName ='cc';


  @override
  Widget build(BuildContext context) {
    final messageHandler =Provider.of<ChatHistory>(context).getMessage('nahom', 'biruk');

    return Scaffold(
      appBar: AppBar(title: Text("ll"),),
      body:StreamBuilder<List<dynamic>>(
        stream: getMessage('nahom', 'biruk'), // Replace with appropriate sender and receiver values
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List<dynamic> messages = snapshot.data!;
            // Do something with the list of messages
            return Container(
              color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                    //  height: 700,
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Text(messages[index]['message'].toString()),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.orange,
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Show a loading indicator while waiting for data
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:leegram/provider/chatHistory.dart';
// import 'package:provider/provider.dart';
//
// import '../provider/data.dart';
//
//
// class IndividualChatScreen extends StatefulWidget {
//   static String routName = 'individualchatscreen';
//
//   @override
//   State<IndividualChatScreen> createState() => _IndividualChatScreenState();
// }
//
// class _IndividualChatScreenState extends State<IndividualChatScreen> {
//
//   var message = '';
//   // final _auth = FirebaseAuth.instance;
//   //  Map<dynamic,dynamic> messageContainer = {};
//   final textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
//     // final userData = Provider.of<data>(context).currentUser;
//     final insertMessage = Provider.of<ChatHistory>(context).chatHistory;
//     final sendMessage = Provider.of<ChatHistory>(context).sendMessage;
//     final currentUser = Provider.of<data>(context).currentUser;
//
//     print(currentUser['username']);
//     // final insertMessage =[];
//     return Scaffold(
//       backgroundColor: Colors.black38,
//       appBar: AppBar(
//         title: Text("${args['name']}"),
//         backgroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               //color: Colors.lightBlue,
//               width: double.infinity,
//               padding: EdgeInsets.all(30),
//               child: (insertMessage.isNotEmpty)?SingleChildScrollView(
//                 child: Column(
//                   //crossAxisAlignment:  (currentUser['username']==insertMessage[3]['sender'])? CrossAxisAlignment.end:CrossAxisAlignment.start,
//                   children: insertMessage.map((messages) => Container(
//                     // color: Colors.blue,
//                     width: double.infinity,
//                     child: Column(
//                       crossAxisAlignment:  (currentUser['username']==messages['sender'])? CrossAxisAlignment.end:CrossAxisAlignment.start,
//                       children: [
//                         FittedBox(
//                           child: Container(
//                             height: 35,
//                             //width: 80,
//                             margin: EdgeInsets.only(bottom: 10),
//                             padding: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               borderRadius: BorderRadius.all(Radius.circular(15)),
//                             ),
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     messages['message'],
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(fontSize: 13),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )).toList(),
//                 ),
//               ):Container(),
//             ),
//           ),
//           Container(
//             height: 50,
//             margin: EdgeInsets.symmetric(horizontal: 16),
//             padding: EdgeInsets.symmetric(horizontal: 8),
//             decoration: BoxDecoration(
//               color: Colors.blueGrey,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Stack(
//               children: [
//                 TextField(
//                   onChanged: (val){
//                     message = val;
//                   },
//                   controller: textController,
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: IconButton(
//                     icon: Icon(Icons.send,color: Colors.white,),
//                     onPressed: () async{
//                       sendMessage('${currentUser['username']}','${args['name']}','$message');
//                       textController.clear();
//                       // await _auth.createUserWithEmailAndPassword(email: message, password: message);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
