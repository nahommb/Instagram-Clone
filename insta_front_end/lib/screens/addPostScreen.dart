import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatelessWidget {


  File? image;
  final _picker = ImagePicker();
Future getImage()async{
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
  if(pickedFile!=null){
    image = File(pickedFile.path);

  }
  else{
    print('no image picked');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: (){
          getImage();
        }, child: Text('add')) ,
      ),
    );
  }
}
