import 'package:flutter/material.dart';
import 'package:harmonyhubhest/style.dart';
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
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/image 5.png'),
              fit: BoxFit.cover,
              opacity: 0.8
          )
        ),
        child: Center(
          child: Container(
            width: MediaQuery.sizeOf(context).width*0.8,
            height: MediaQuery.sizeOf(context).height*0.5,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(25)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: FutureBuilder(
                      future: downloadURL('Avatar.jpg'),
                      builder: (context,AsyncSnapshot<String> snapshot){
                        if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                          return CircleAvatar(
                            radius: 75,
                            backgroundImage: NetworkImage(snapshot.data!),
                          );
                        }
                        if (snapshot.connectionState==ConnectionState.waiting){
                          return CircleAvatar(
                            radius: 75,
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CircleAvatar(
                          radius: 75,
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
                SizedBox(
                  height: 25,
                ),
                FutureBuilder(
                  future: getUserInfo(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState!=ConnectionState.done){
                      return Text('Loading...', style: TextStyle(color: Colors.white), textScaler: TextScaler.linear(1.5),);
                    }
                    return Text('$userEmail',
                      style: interFS20
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

}