import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: AssetImage(
                        song.coverUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
             Padding(
                 padding: EdgeInsets.only(left: 5,top: 10,bottom: 10),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(song.title, style: GoogleFonts.inter(
                       textStyle: TextStyle(
                           color: Colors.black,
                           fontSize: 15,
                           fontWeight: FontWeight.w600
                       )
                   ),),
                   Spacer(),
                   Text(song.description, style: GoogleFonts.inter(
                       textStyle: TextStyle(
                           color: Color(0xff242424),
                           fontSize: 13,
                           fontWeight: FontWeight.w500
                       )
                   ),),
                 ],
               ),
             ),
              Spacer(),
              IconButton(
                  onPressed: (){
                    
                  },
                  icon: Icon(Icons.more_vert, color: Color(0xff242424), size: 30,)
              )
            ],
          )
      ),
    );
  }
}