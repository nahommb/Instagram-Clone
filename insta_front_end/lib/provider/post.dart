import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:insta_front_end/screens/newPostScreen.dart';


class Post with ChangeNotifier{
  final serverIpAddress = '192.168.56.1'; //''; //localhost
  File? image;
  final _picker = ImagePicker();

  List<dynamic> _posts =[];
  List<dynamic> get posts{

    return [..._posts];
  }
  List<dynamic> _allposts =[];
  List<dynamic> get allposts{

    return [..._allposts];
  }
  Future<void> getImage(context)async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
    if(pickedFile!=null){
      image = File(pickedFile.path);

      print('leeeeeeee $image');
    }
    else{
      print('no image picked');
    }

  if(image!=null){
    print('not null');

    Navigator.pushNamed(context, NewPostScreen.routName,arguments: {'imageUrl':image});

  }

  }

  Future<void> postImage(username,caption) async{

    try{
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.56.1:3000/user/post'),
      );
      request.files.add(await http.MultipartFile.fromPath('image', image!.path,));
      request.fields['username'] = username;
      request.fields['caption'] = caption;
      var response = await request.send();
      print('responseee$response');

    }

    catch(err){
      print(err);
    }

  }

  Future<void> getPost(username) async{
    var url = Uri.parse('http://$serverIpAddress:3000/home/post/$username');
    http.Response response = await http.get(url);
    List<dynamic> bd = jsonDecode(response.body);
    print(bd.length);
   // final bdl = bd.length;
    _posts.clear();
    _posts = bd;
    // for(int i=0;i<bdl;i++){
    //
    //
    //   // _posts.add(bd[i]);
    // }
    //print(posts.length);
    notifyListeners();

  }
  Future<void> getAllPost() async{
    var url = Uri.parse('http://$serverIpAddress:3000/user/post/');
    http.Response response = await http.get(url);
    List<dynamic> bd = jsonDecode(response.body);
    _allposts.clear();
    _allposts = bd;

    notifyListeners();

  }
}