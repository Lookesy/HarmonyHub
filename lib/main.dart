import 'package:flutter/material.dart';
import 'map/domain/map_screen.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() {
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
      home: const HomePage(),
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
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: const Text("HarmonyHub", textAlign: TextAlign.center),
          ),
          bottomNavigationBar: menu(),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Icon(Icons.directions_car),
              Map(),
              Icon(Icons.directions_bike),
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

