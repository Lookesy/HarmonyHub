import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'player_buttons.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://rur.hitmotop.com/get/music/20181113/Miyagi_Kadi_-_Rodnaya_pojj_60277327.mp3")),
      AudioSource.uri(Uri.parse(
          "https://rur.hitmotop.com/get/music/20190710/Miyagi_-_Captain_65373340.mp3")),
      AudioSource.uri(Uri.parse(
          "https://rur.hitmotop.com/get/music/20190710/Miyagi_-_Sorry_65373347.mp3")),
      AudioSource.uri(Uri.parse(
          "https://rur.hitmotop.com/get/music/20170830/Miyagi_-_Bejjba_sudba_47829400.mp3")),
      AudioSource.uri(Uri.parse(
          "https://rur.hitmotop.com/get/music/20190710/Miyagi_Andy_Panda_-_Govori_mne_65373355.mp3")),
    ]))
        .catchError((error) {
      // catch load errors: 404, invalid url ...
      print("An error occured $error");
    });
  }

  @override
  void dispose(){
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PlayerButtons(_audioPlayer),
      ),
    );
  }
}