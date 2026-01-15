import 'package:flutter/material.dart';
import 'package:harmonyhubhest/music_player/music_player_mainpage.dart';
import 'package:harmonyhubhest/user_profile.dart';
import 'features/users/view/users_list.dart';
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
              MessMain(),
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
        indicatorPadding: EdgeInsets.all(3.0),
        padding: EdgeInsets.all(5),
        indicatorColor: Colors.white,
        labelStyle: interFS15,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(
            icon: Icon(Icons.headphones),
          ),
          Tab(
            icon: Icon(Icons.message),
          ),
          Tab(
            icon: Icon(Icons.man),
          ),
        ],
      ),
    );
  }
}