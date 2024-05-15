import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonyhubhest/style.dart';
import '../models/song_model.dart';

class SongCard extends StatelessWidget {
  const SongCard({Key? key, required this.song,}) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/song', arguments: song);
      },
      child: Container(
          height: 60,
          width: MediaQuery.sizeOf(context).width*0.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.deepPurple.withOpacity(0.8),
              Colors.cyan.withOpacity(0.8)
            ])
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: AssetImage(
                        song.coverUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(song.title, style: interFS15,)
            ],
          )
      ),
    );
  }
}