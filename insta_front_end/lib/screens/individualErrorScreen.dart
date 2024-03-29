import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/chatHistory.dart';
import '../provider/data.dart';
class individualErrorScreen extends StatefulWidget {
  const individualErrorScreen({Key? key}) : super(key: key);

  @override
  State<individualErrorScreen> createState() => _individualErrorScreenState();
}

class _individualErrorScreenState extends State<individualErrorScreen> {
  var message = '';
  // final _auth = FirebaseAuth.instance;
  //  Map<dynamic,dynamic> messageContainer = {};
  final textController = TextEditingController();
  FocusNode fc = FocusNode();
  ScrollController _scrollController = ScrollController();
  bool isInit = true;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isInit) {
      final getMessage = await Provider.of<ChatHistory>(context).chatHistory;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent+40,
        duration: Duration(milliseconds: 20),
        curve: Curves.fastOutSlowIn,
      );
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final getMessage = Provider.of<ChatHistory>(context).chatHistory;
    final sendMessage = Provider.of<ChatHistory>(context).sendMessage;
    final currentUser = Provider.of<data>(context).currentUser;
    final messageHandler =Provider.of<ChatHistory>(context).getMessage("${currentUser['username']}", '${args['name']}');

    return Column(
      children: [
        Expanded(
          child: Container(
            // color: Colors.lightBlue,
            width: double.infinity,
            padding: EdgeInsets.only(left: 30,right: 30),
            child: (getMessage.isNotEmpty)?SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                // crossAxisAlignment:  (currentUser['username']==insertMessage[3]['sender'])? CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: getMessage.map((messages) => Container(
                  color: Colors.blue,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment:  (currentUser['username']==messages['sender'])? CrossAxisAlignment.end:CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Container(
                          height: 35,
                          //width: 80,
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color:  (currentUser['username']==messages['sender'])?Colors.green:Colors.lightBlue,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  messages['message'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ):Container(),
          ),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 16 ,vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            //color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              TextField(
                focusNode:fc,
                onChanged: (val){
                  message = val;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(25))// Change the border color here
                  ),
                  filled: true,
                  fillColor: Colors.black,
                  contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 6),
                ),
                controller: textController,
                style: TextStyle(color: Colors.white),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.send,color: Colors.white,),
                  onPressed: () async{
                    if(message!='' && message!=null){
                      sendMessage('${currentUser['username']}','${args['name']}','$message');
                      textController.clear();
                      setState(() {
                        fc.unfocus();
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent+40,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        );
                      });
                      message ='';
                    }

                    // await _auth.createUserWithEmailAndPassword(email: message, password: message);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
