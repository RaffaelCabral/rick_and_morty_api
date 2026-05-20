import 'package:rick_and_morty_api/src/modules/home/data/models/api_reference_modal.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

const createdText = '2017-11-10T12:56:33.798Z';
final createdDate = DateTime.parse(createdText);

Map<String, dynamic> episodeMap({
  int id = 28,
  String name = 'The Ricklantis Mixup',
  List<String>? characters,
}) {
  return {
    'id': id,
    'name': name,
    'air_date': 'September 10, 2017',
    'episode': 'S03E07',
    'characters':
        characters ??
        [
          'https://rickandmortyapi.com/api/character/1',
          'https://rickandmortyapi.com/api/character/2',
        ],
    'url': 'https://rickandmortyapi.com/api/episode/$id',
    'created': createdText,
  };
}

Map<String, dynamic> characterMap({
  int id = 1,
  String name = 'Rick Sanchez',
  String? type = '',
}) {
  return {
    'id': id,
    'name': name,
    'status': 'Alive',
    'species': 'Human',
    'type': type,
    'gender': 'Male',
    'origin': {
      'name': 'Earth (C-137)',
      'url': 'https://rickandmortyapi.com/api/location/1',
    },
    'location': {
      'name': 'Citadel of Ricks',
      'url': 'https://rickandmortyapi.com/api/location/3',
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/$id.jpeg',
    'episode': ['https://rickandmortyapi.com/api/episode/1'],
    'url': 'https://rickandmortyapi.com/api/character/$id',
    'created': createdText,
  };
}

EpisodeModel episodeModel({
  int id = 28,
  String name = 'The Ricklantis Mixup',
  List<String>? characters,
}) {
  return EpisodeModel.fromMap(
    episodeMap(id: id, name: name, characters: characters),
  );
}

CharacterModel characterModel({int id = 1, String name = 'Rick Sanchez'}) {
  return CharacterModel.fromMap(characterMap(id: id, name: name));
}

ApiReference apiReference({
  String name = 'Earth (C-137)',
  String url = 'https://rickandmortyapi.com/api/location/1',
}) {
  return ApiReference(name: name, url: url);
}
