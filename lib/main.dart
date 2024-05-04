import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'map/domain/map_screen.dart';
import 'user_profile.dart';
import 'music_player/player_screen.dart';
import 'auth/login_page.dart';
import 'firebase_options.dart';
import 'messenger/mess_main.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());

}

//Главный виджет с вкладками, содержащими остальные виджеты.
class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TabView Tutorial GFG',
      theme: ThemeData(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: LoginPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MusicPlayer(),
              Map(),
              UsersPage(),
              Profile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: const Color(0xFF673AB7),
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.deepPurple,
        tabs: [
          Tab(
            text: "Music",
            icon: Icon(Icons.headphones),
          ),
          Tab(
            text: "Map",
            icon: Icon(Icons.map),
          ),
          Tab(
            text: "Messenger",
            icon: Icon(Icons.message),
          ),
          Tab(
            text: "Profile",
            icon: Icon(Icons.man),
          ),
        ],
      ),
    );
  }
}


//Виджет карты. Всегда в рабочем состоянии
class Map extends StatelessWidget{
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yandex Map',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MapScreen(),
    );
  }
}




class Profile extends StatelessWidget{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      home: PopupProfileWidget(),
    );
  }
}


