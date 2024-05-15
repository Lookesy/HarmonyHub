import 'package:flutter/material.dart';
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
        image: DecorationImage(
          image: AssetImage('assets/images/image 5.png'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const Icon(Icons.grid_view_rounded),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: FutureBuilder(
                  future: downloadURL('Avatar.jpg'),
                  builder: (context,AsyncSnapshot<String> snapshot){
                    if(snapshot.connectionState==ConnectionState.done&&snapshot.hasData){
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(snapshot.data!),
                      );
                    }
                    if (snapshot.connectionState==ConnectionState.waiting){
                      return CircleAvatar(
                        radius: 25,
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CircleAvatar(
                      radius: 25,
                    );
                  }
              ),
            ),
          ],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Сохранённые',
          overflow: TextOverflow.ellipsis,
          style: interFS20,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.7,
          width: MediaQuery.sizeOf(context).width*0.98,
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
        )
      ],
    );
  }
}
