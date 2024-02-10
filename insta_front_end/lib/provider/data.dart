import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insta_front_end/models/userData.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class data with ChangeNotifier{

  Map<String,dynamic> _currentUser = {};
  Map<String,dynamic> get currentUser {
    return {..._currentUser};
  }


  List<dynamic> _allUsers =[];
  List<dynamic> get allUSers{

    return [..._allUsers];
  }

  List<dynamic>_findedUser =[];
  List<dynamic> get findedUser{
    return [..._findedUser];
  }

  Future<bool> login(String username , String password) async{
    var url = Uri.parse('http://localhost:3000/user/login');
    // http.Response rs = await http.get(url);
    // print('leee${rs.statusCode}');

    http.Response ps = await http.post(url,body: {'username':username,'password':password});
    print(ps.body);

    if (ps.body.length > 0) {
      Map<String, dynamic> responseBody = jsonDecode(ps.body).cast<String, dynamic>();
      _currentUser = responseBody;
      print(currentUser['username']);
      notifyListeners();
      return true;
    }
    else{
      notifyListeners();
      return false;
    }
  }
  Future<bool> signup(String username , String password) async{
    var url = Uri.parse('http://localhost:3000/user/signup');
    http.Response ps = await http.post(url,body: {'username':username,'password':password});
    print(ps.body.length);
    print(ps.body);
    if(ps.body == 'Registerd'){
      notifyListeners();
      return true;
    }
    else{
      notifyListeners();
      return false;
    }

  }

  Future<void> getUser() async{

    var url = Uri.parse('http://localhost:3000/user');
    http.Response gt = await http.get(url);
    // print(gt.body.length);
    // print(gt.body);
    for(int i=0;i<jsonDecode(gt.body).length;i++){
      _allUsers.add(jsonDecode(gt.body)[i]);
    }
   // print(allUSers[0]['username']);
    _allUsers.removeWhere((element) => element['username']==currentUser['username']);

    notifyListeners();
  }

  Future<void> searchUser(String username) async{

    var url = Uri.parse('http://localhost:3000/user/search/$username');
    http.Response gt = await http.get(url);
    // print(gt.body.length);
     print(gt.body);
    // for(int i=0;i<jsonDecode(gt.body).length;i++){
    //   _findedUser.add(jsonDecode(gt.body)[i]);
    // }
    // // print(allUSers[0]['username']);
    // _findedUser.removeWhere((element) => element['username']==currentUser['username']);

    notifyListeners();
  }



  void clearUsers(){
    _allUsers.clear();
    notifyListeners();
  }
 List<UserData> users  = [
     UserData(
         id: 123,
         name: 'Nahom',
         storyImageUrl: "https://picsum.photos/id/23"
     ),
   UserData(
       id: 234,
       name: 'Biruk',
       storyImageUrl: "https://picsum.photos/id/23"
   ),
   UserData(
       id: 098,
       name: 'Hunde',
       storyImageUrl: "https://picsum.photos/id/23"
   ),
 ];

 void change (){
   print('pressed');
   notifyListeners();
  // apitest();
 }

}