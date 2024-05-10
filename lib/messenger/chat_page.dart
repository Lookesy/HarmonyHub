import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harmonyhubhest/messenger/chat_bubble.dart';
import 'package:harmonyhubhest/messenger/chat_service.dart';
import 'package:harmonyhubhest/style.dart';

import '../firestore_services.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _messageListController = ScrollController();

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail, overflow: TextOverflow.ellipsis,),
        actions: [
          Padding(
              padding: EdgeInsets.all(3),
            child: FutureBuilder(
                future: downloadOtherUserURL('Avatar.jpg', widget.receiverUserEmail),
                builder: (context,AsyncSnapshot<String> snapshot){
                  if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                    return CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(snapshot.data!),
                    );
                  }
                  if (snapshot.connectionState==ConnectionState.waiting){
                    return CircleAvatar(
                      radius: 24,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CircleAvatar(
                    radius: 24,
                  );
                }
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.deepPurple,
              Colors.cyanAccent
            ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.3),
                Colors.transparent
              ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/images/image 5.png'),
              fit: BoxFit.cover,
            opacity: 0.8
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height-140,
              width: MediaQuery.sizeOf(context).width,
              child: _buildMessageList(),
            ),

            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: _buildMessageInput(),
                ),
              )
            )
          ],
        )
      )
    );
  }

  Widget _buildMessageList(){
    return StreamBuilder(
        stream: _chatService.getMessage(widget.receiverUserID, firebaseAuth.currentUser!.uid),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Error${snapshot.error}');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Text('Loading...');
          }
          return ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
            controller: _messageListController,
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        }
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderID'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;



    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (data['senderID'] == firebaseAuth.currentUser!.uid)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderID'] == firebaseAuth.currentUser!.uid)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail'],
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                  )
              ),
            ),
            SizedBox(height: 5,),
            ChatBubble(message: data['message'])
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(){
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
              ),
              child: Flex(
                  direction: Axis.horizontal,
                children: [
                  SizedBox(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue
                          )
                        )
                      ),
                      controller: _messageController,
                      obscureText: false,
                    ),
                    width: MediaQuery.sizeOf(context).width*0.75,
                  )
                ],
              )
          ),

          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.arrow_upward,
              size: 40,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
