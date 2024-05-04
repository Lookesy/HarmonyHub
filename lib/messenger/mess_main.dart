import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_page.dart';

class UsersPage extends StatefulWidget{

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>{

  @override
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Text('error');
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if(FirebaseAuth.instance.currentUser!.email != data['email']){
      return ListTile(
        title: Text(data['email']),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
            receiverUserEmail: data['email'],
            receiverUserID: data['uid'],
          )));
        },
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

}