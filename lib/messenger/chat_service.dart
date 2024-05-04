import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harmonyhubhest/messenger/message.dart';

class ChatService extends ChangeNotifier{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async{
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();


    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId){
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

}