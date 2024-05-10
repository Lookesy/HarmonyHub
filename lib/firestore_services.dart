import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

var userEmail;
var userUId;

getUserInfo() async {

  final firebaseUser = await FirebaseAuth.instance.currentUser;
  if (firebaseUser!=null){
    userEmail = firebaseUser.email;
    userUId = firebaseUser.uid;
  }
}



pickImage() async {
  final ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  File file = File(image!.path);
  return file;
}

Future<void> uploadImage() async {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  var userEmail = firebaseUser?.email;
  final storageRef = FirebaseStorage.instance.ref('users/$userEmail/Avatar.jpg');

  final imageToUpload = await pickImage();

  try {
    await storageRef.putFile(imageToUpload);
  } on FirebaseException catch (e){
    print('ошибка в загрузке');
    print(e);
  }
}

Future<String> downloadURL(String imageName) async {
  final firebaseUser = await FirebaseAuth.instance.currentUser;
  String downloadURL = await FirebaseStorage.instance.ref('users/${firebaseUser?.email}/$imageName').getDownloadURL();

  return downloadURL;
}

Future<String> downloadOtherUserURL(String imageName, String userEmail) async {
  String downloadURL = await FirebaseStorage.instance.ref('users/$userEmail/$imageName').getDownloadURL();

  return downloadURL;
}