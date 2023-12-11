import 'package:flutter/material.dart';



class PopupProfileWidget extends StatefulWidget{
  const PopupProfileWidget({Key? key}) : super(key: key);


  @override
  State<PopupProfileWidget> createState() => _PopupProfileWidgetState();
}

class _PopupProfileWidgetState extends State<PopupProfileWidget>{

  @override
  void initState() {
    super.initState();
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
                CircleAvatar(backgroundColor: Colors.grey,
                  radius: 100,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ClipOval(
                      child: Image.asset('assets/images/avatarka.jpg'),
                    ),
                  ),
                ),
                const SizedBox(width: 50,),
                const Text('UserNickname', textScaleFactor: 2, style: TextStyle(color: Colors.white),)
              ],
          ),

          const SizedBox(height: 25,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.white,
              ),
              GestureDetector(
                child: const Text('Элемент', textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              ),

              const Divider(
                color: Colors.white,
              ),
              const SizedBox(height: 5,),

              GestureDetector(
                child: const Text('Элемент', textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              ),

              const Divider(
                color: Colors.white,
              ),
              const SizedBox(height: 5,),

              GestureDetector(
                child: const Text('Элемент', textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              ),

              const Divider(
                color: Colors.white,
              ),
              const SizedBox(height: 5,),

              GestureDetector(
                child: const Text('Элемент', textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              ),

              const Divider(
                color: Colors.white,
              ),
              const SizedBox(height: 5,),

              GestureDetector(
                child: const Text('Элемент', textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              ),

              const Divider(
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }

}
