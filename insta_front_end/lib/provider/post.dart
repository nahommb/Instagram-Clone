import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:insta_front_end/screens/newPostScreen.dart';


class Post with ChangeNotifier{

  File? image;
  final _picker = ImagePicker();

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
}