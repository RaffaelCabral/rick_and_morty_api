class EpisodeModel {
  final int id;
  final String name;
  final String airDate;
  final String episode;
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
      airDate: _formatAirDatePtBr(json['air_date'] as String),
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

String _formatAirDatePtBr(String value) {
  final parts = value.replaceAll(',', '').split(' ');
  if (parts.length != 3) return value;

  final month = _monthsPtBr[parts[0]];
  if (month == null) return value;

  return '${parts[1]} de $month de ${parts[2]}';
}

const _monthsPtBr = {
  'January': 'janeiro',
  'February': 'fevereiro',
  'March': 'março',
  'April': 'abril',
  'May': 'maio',
  'June': 'junho',
  'July': 'julho',
  'August': 'agosto',
  'September': 'setembro',
  'October': 'outubro',
  'November': 'novembro',
  'December': 'dezembro',
};
