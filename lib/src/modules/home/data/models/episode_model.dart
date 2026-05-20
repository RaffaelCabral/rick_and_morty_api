class EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode; // ex: "S03E07"
  final List<String> characters;
  final String url;
  final DateTime created;

  const EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory EpisodeModel.fromMap(Map<String, dynamic> json) {
    return EpisodeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      airDate: json['air_date'] as String,
      episode: json['episode'] as String,
      characters: (json['characters'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'air_date': airDate,
    'episode': episode,
    'characters': characters,
    'url': url,
    'created': created.toIso8601String(),
  };
}
