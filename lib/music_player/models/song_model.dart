class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;
  late final int id;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
    required this.id
  });

  static List<Song> songs = [
    Song(
      title: 'Glass',
      description: 'Glass',
      url: 'assets/music/glass.mp3',
      coverUrl: 'assets/musicImages/glass.jpg',
      id: 1
    ),
    Song(
      title: 'Illusions',
      description: 'Illusions',
      url: 'assets/music/illusions.mp3',
      coverUrl: 'assets/musicImages/illusions.jpg',
        id: 2
    ),
    Song(
      title: 'Pray',
      description: 'Pray',
      url: 'assets/music/pray.mp3',
      coverUrl: 'assets/musicImages/pray.jpg',
        id: 3
    )
  ];
}

