import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class ChatHistory with ChangeNotifier{

  final serverIpAddress = '127.0.0.1'; //''; //192.168.56.1
  List<Object> _chatHistory =[];


  List<dynamic> get chatHistory{

    return [..._chatHistory];
  }

  Future<void> getMessage(String sender , String receiver) async{
    try{
      var url = Uri.parse('http://$serverIpAddress:3000/user/getmessage/$sender/$receiver');
      http.Response ps = await http.get(url);
      //print(jsonDecode(ps.body).length);
      clearChat();
      for(int i=0;i<jsonDecode(ps.body).length;i++){
        _chatHistory.add(jsonDecode(ps.body)[i]);
        // print(chatHistory);
      }
    }
    catch(err){
      print(err);
    }

    notifyListeners();

  }
 Future<void> sendMessage(String sender,String receiver,String message) async{
   try{
     var url = Uri.parse('http://$serverIpAddress:3000/user/sendmessage');
     http.Response ps = await http.post(url,body: {'sender':sender,'receiver':receiver,'message':message});
     print(ps.statusCode);
   }
   catch(err){
     print(err);
   }

 }
  //
  // Stream<List<dynamic>> getNewMessage(String sender, String receiver) async* {
  //   //ScrollController _scrollController = ScrollController();
  //
  //   try{
  //     final serverIpAddress = '192.168.56.1'; //localhost
  //
  //     var url = Uri.parse('http://$serverIpAddress:3000/user/getmessage/$sender/$receiver');
  //     http.Response ps = await http.get(url);
  //     // print("lee ${ps.statusCode}");
  //     List<dynamic> messages= jsonDecode(ps.body);
  //     //print(messages);
  //     yield messages;
  //
  //     while (true) {
  //       await Future.delayed(Duration(seconds: 1));
  //       http.Response newPs = await http.get(url);
  //       List<dynamic> newMessages = jsonDecode(newPs.body);
  //       if (newMessages.length > messages.length) {
  //         List<dynamic> diff = newMessages.sublist(messages.length);
  //         messages.addAll(diff);
  //         yield diff;
  //       }
  //     }
  //   }
  //   catch(err){
  //     print('newaojsoijdoijasodjsjd $err');
  //   }
  //
  // }

  void clearChat(){
    _chatHistory.clear();
    notifyListeners();
  }
  void insertChat (String message){
   // _chatHistory.addAll(message);
    notifyListeners();
  }
}