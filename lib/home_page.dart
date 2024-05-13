import 'package:flutter/material.dart';
import 'package:harmonyhubhest/music_player/music_player_mainpage.dart';
import 'package:harmonyhubhest/user_profile.dart';
import 'messenger/mess_main.dart';
import 'style.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              MusicPlayer(),
              UsersPage(),
              PopupProfileWidget(),
            ],
          ),
        )
    );
  }

  Widget menu() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.cyan
            ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.white,
        labelStyle: interFS15,
        tabs: const [
          Tab(
            text: "Музыка",
            icon: Icon(Icons.headphones),
          ),
          Tab(
            text: "Чат",
            icon: Icon(Icons.message),
          ),
          Tab(
            text: "Профиль",
            icon: Icon(Icons.man),
          ),
        ],
      ),
    );
  }
}