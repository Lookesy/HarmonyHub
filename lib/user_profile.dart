import 'package:flutter/material.dart';
import 'firestore_services.dart';



class PopupProfileWidget extends StatefulWidget{
  const PopupProfileWidget({Key? key}) : super(key: key);


  @override
  State<PopupProfileWidget> createState() => _PopupProfileWidgetState();
}

class _PopupProfileWidgetState extends State<PopupProfileWidget>{

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x303030),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          const SizedBox(height: 25,),
          Row(
              children: [
                const SizedBox(width: 25,),
                GestureDetector(
                  child: FutureBuilder(
                      future: downloadURL('Avatar.jpg'),
                      builder: (context,AsyncSnapshot<String> snapshot){
                        if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(snapshot.data!),
                          );
                        }
                        if (snapshot.connectionState==ConnectionState.waiting){
                          return CircleAvatar(
                            radius: 50,
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CircleAvatar(
                          radius: 50,
                        );
                      }
                  ),
                  onTap: (){
                      setState(() {
                        uploadImage().then((value) =>
                            setState(() {

                            })
                        );
                      });
                  },
                ),
              ],
          ),
          const SizedBox(height: 25,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.white,
              ),
              FutureBuilder(
                future: getUserInfo(),
                builder: (context, snapshot){
                  if(snapshot.connectionState!=ConnectionState.done){
                    return Text('Loading...', style: TextStyle(color: Colors.white), textScaler: TextScaler.linear(1.5),);
                  }
                  return Text('$userEmail', style: TextStyle(color: Colors.black), textScaler: TextScaler.linear(1.5),);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

}
