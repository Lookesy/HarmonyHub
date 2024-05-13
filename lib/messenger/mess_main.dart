import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harmonyhubhest/firestore_services.dart';
import 'package:harmonyhubhest/style.dart';
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
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
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
      return Column(
        children: [
          GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                )
                ));
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.deepPurple.shade800.withOpacity(0.6)
                ),
                child: Row(
                  children: [
                    FutureBuilder(
                        future: downloadOtherUserURL('Avatar.jpg', data['email']),
                        builder: (context,AsyncSnapshot<String> snapshot){
                          if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                            return CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(snapshot.data!),
                            );
                          }
                          if (snapshot.connectionState==ConnectionState.waiting){
                            return CircleAvatar(
                              radius: 30,
                              child: CircularProgressIndicator(),
                            );
                          }
                          return CircleAvatar(
                            radius: 30,
                          );
                        }
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width*0.45,
                      child: Text(
                        data['email'],
                        style: interFS17,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.sizeOf(context).width*0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50),
                                bottomRight: Radius.circular(50)
                            ),
                          ),
                          child: ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                  ],
                                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Container(
                                foregroundDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50)
                                    ),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.black.withOpacity(0.7)
                                        ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft
                                    )
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50)
                                  ),
                                  child: FutureBuilder(
                                      future: downloadOtherUserURL('TrackImage.jpg', data['email']),
                                      builder: (context,AsyncSnapshot<String> snapshot){
                                        if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                                          return Image(image: NetworkImage(snapshot.data!));
                                        }
                                        if (snapshot.connectionState==ConnectionState.waiting){
                                          return Container();
                                        }
                                        return Container();
                                      }
                                  ),
                                ),
                              )
                          ),
                        ),
                        Container(
                          height: 90,
                          width: MediaQuery.sizeOf(context).width*0.3,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  data['trackAuthor'],
                                  overflow: TextOverflow.ellipsis,
                                  style: interFS15,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  data['trackTitle'],
                                  overflow: TextOverflow.ellipsis,
                                  style: interFS15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
          ),
          SizedBox(
            height: 8,
          )
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/images/image 5.png'),
              fit: BoxFit.cover,
            opacity: 0.8
          )
        ),
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: EdgeInsets.only(top: 25,bottom: 25),
          child: _buildUserList(),
        ),
      ),
    );
  }

}