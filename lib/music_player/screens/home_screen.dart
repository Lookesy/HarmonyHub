import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../firestore_services.dart';
import '../../style.dart';
import '../models/song_model.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: (){

                          },
                          icon: Icon(
                            Icons.menu,
                            size: 35,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Сохранённые",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){

                          },
                          icon: Icon(
                            Icons.search,
                            size: 35,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )
              )
          ),
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _TrendingMusic(songs: songs),
              ],
            ),
          ),
        )
      ),
    );
  }

}



class _TrendingMusic extends StatelessWidget {
  const _TrendingMusic({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width*0.98,
      height: MediaQuery.sizeOf(context).height,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index){
          return SizedBox(
            height: 3,
          );
        },
        scrollDirection: Axis.vertical,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return SongCard(song: songs[index]);
        },
      ),
    );
  }
}
