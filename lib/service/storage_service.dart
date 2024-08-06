import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'auth_service.dart';


class StorageService {
  static final _storage = FirebaseStorage.instance.ref();
  static final folder = "post_image";
  static final flode_post = "user_post";

  static Future<String> uploadUserImage(File _image) async {
    String uid = AuthService.currentUserId();
    String image = uid;
    var firebaseStorage = _storage.child(folder).child(image);
    var uploadTask = firebaseStorage.putFile(_image);
    final String downloadUrl = await firebaseStorage.getDownloadURL();
    return downloadUrl;
  }

  static Future<String>uploadUserPost(File _image)async{
    String uid = AuthService.currentUserId();
    String image_name = uid +"_"+DateTime.now().toString();
    var firebaseStorage = _storage.child(folder).child(image_name);
    var uploadTask = firebaseStorage.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete((){});
    final String downloadUrl = await firebaseStorage.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}