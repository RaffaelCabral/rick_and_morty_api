import 'package:rick_and_morty_api/src/modules/home/data/models/api_reference_modal.dart';

class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final ApiReference origin;
  final ApiReference location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterModel.fromMap(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String? ?? '',
      gender: json['gender'] as String,
      origin: ApiReference.fromMap(json['origin'] as Map<String, dynamic>),
      location: ApiReference.fromMap(json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
      episode: (json['episode'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      url: json['url'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'origin': origin.toMap(),
    'location': location.toMap(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created.toIso8601String(),
  };
}
