import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Post with ChangeNotifier{




  File? image;
  final _picker = ImagePicker();

  Future<void> getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
    if(pickedFile!=null){
      image = File(pickedFile.path);

      print('leeeeeeee $image');
    }
    else{
      print('no image picked');
    }
  }
}