class Music {
  final String singer;
  final String name;
  final String backGroundImage;
  final String singerImage;

  Music({
    required this.singer,
    required this.name,
    required this.backGroundImage,
    required this.singerImage,
  });
}

final _assetPath = 'assets/expandable_nav_bar/';

final musics = List.generate(
  5,
  (index) => Music(
    singer: 'Singer ${index + 1}',
    name: 'Song name ${index + 1}',
    backGroundImage: '${_assetPath}img${index + 1}.png',
    singerImage: '${_assetPath}person${index + 1}.png',
  ),
);
