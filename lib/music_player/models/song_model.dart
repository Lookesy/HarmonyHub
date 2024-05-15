class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs = [
    Song(
      title: 'After Dark',
      description: 'Mr.Kitty',
      url: 'assets/music/afterdark.mp3',
      coverUrl: 'assets/musicImages/afterdark.jpg',
    ),
    Song(
      title: 'Eyes blue like the atlantic',
      description: 'Sista Prod',
      url: 'assets/music/eyesblue.mp3',
      coverUrl: 'assets/musicImages/eyesblue.jpg',
    ),
    Song(
      title: 'Little dark age',
      description: 'MGMT',
      url: 'assets/music/littledarkage.mp3',
      coverUrl: 'assets/musicImages/littledarkage.jpg',
    ),
    Song(
      title: 'Home',
      description: 'Vacations',
      url: 'assets/music/home.mp3',
      coverUrl: 'assets/musicImages/vacations.jpg',
    ),
    Song(
      title: 'Your love is my drug',
      description: 'just valery',
      url: 'assets/music/yourloveismydrug.mp3',
      coverUrl: 'assets/musicImages/yourloveismydrug.jpg',
    ),
    Song(
      title: 'Dark side of the moon',
      description: 'Suisside',
      url: 'assets/music/darksideofthemoon.mp3',
      coverUrl: 'assets/musicImages/darksideofthemoon.jpg',
    ),
  ];
}

