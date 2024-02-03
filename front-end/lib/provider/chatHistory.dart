import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ChatHistory with ChangeNotifier{
  List<Object> _chatHistory =[];


  List<dynamic> get chatHistory{

    return [..._chatHistory];
  }

  Future<void> getMessage(String sender , String receiver) async{
    var url = Uri.parse('http://localhost:3000/user/getmessage/$sender/$receiver');
    http.Response ps = await http.get(url);
    print(jsonDecode(ps.body).length);
    clearChat();
    for(int i=0;i<jsonDecode(ps.body).length;i++){
         _chatHistory.add(jsonDecode(ps.body)[i]);
         // print(chatHistory);
    }
    notifyListeners();


  }
 Future<void> sendMessage(String sender,String receiver,String message) async{

   var url = Uri.parse('http://localhost:3000/user/sendmessage');
   http.Response ps = await http.post(url,body: {'sender':sender,'receiver':receiver,'message':message});
   print(ps.statusCode);
 }

  void clearChat(){
    _chatHistory.clear();
    notifyListeners();
  }
  void insertChat (String message){
   // _chatHistory.addAll(message);
    notifyListeners();
  }
}