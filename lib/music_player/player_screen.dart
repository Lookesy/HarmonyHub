import 'package:flutter/material.dart';
import 'player_source.dart';


class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Player(),
    );
  }
}