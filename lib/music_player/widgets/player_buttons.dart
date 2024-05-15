import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:harmonyhubhest/firestore_services.dart';
import 'package:just_audio/just_audio.dart';

import '../models/song_model.dart';
import '../screens/song_screen.dart';

class PlayerButtons extends StatefulWidget {
  const PlayerButtons({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
          stream: widget.audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: (){
                setState(() {
                  widget.audioPlayer.seekToPrevious();
                  if(i-1>=0){
                    i--;
                    Song soong = Song.songs[i];
                    Get.close(1);
                    Get.toNamed('/song', arguments: soong)?.then((value) => setState(() {

                    }));
                  }
                });
              },
              iconSize: 45,
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
              ),
            );
          },
        ),
        StreamBuilder<PlayerState>(
          stream: widget.audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = playerState!.processingState;

              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  width: 64.0,
                  height: 64.0,
                  margin: const EdgeInsets.all(10.0),
                  child: const CircularProgressIndicator(),
                );
              } else if (!widget.audioPlayer.playing) {
                return IconButton(
                  onPressed: (){
                    widget.audioPlayer.play();
                  },
                  iconSize: 75,
                  icon: const Icon(
                    Icons.play_circle,
                    color: Colors.white,
                  ),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(
                    Icons.pause_circle,
                    color: Colors.white,
                  ),
                  iconSize: 75.0,
                  onPressed: widget.audioPlayer.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.replay_circle_filled_outlined,
                    color: Colors.white,
                  ),
                  iconSize: 75.0,
                  onPressed: () => widget.audioPlayer.seek(
                    Duration.zero,
                    index: widget.audioPlayer.effectiveIndices!.first,
                  ),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: widget.audioPlayer.sequenceStateStream,
          builder: (context, index) {
            return IconButton(
              onPressed: (){
                setState(() {
                  widget.audioPlayer.seekToNext();
                  if(i+1<=Song.songs.length){
                    i++;
                    Song soong = Song.songs[i];
                    Get.close(1);
                    Get.toNamed('/song', arguments: soong)?.then((value) => setState(() {

                    }));
                  }
                });
              },
              iconSize: 45,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}