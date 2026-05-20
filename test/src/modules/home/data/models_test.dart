import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/api_reference_modal.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

import '../../../../helpers/home_fixtures.dart';

void main() {
  group('EpisodeModel', () {
    test('converte map da API corretamente', () {
      final model = EpisodeModel.fromMap(episodeMap());

      expect(model.id, 28);
      expect(model.name, 'The Ricklantis Mixup');
      expect(model.airDate, '10 de setembro de 2017');
      expect(model.episode, 'S03E07');
      expect(model.characters, hasLength(2));
      expect(model.created, createdDate);
    });

    test('toJson preserva campos necessários', () {
      final model = episodeModel();
      final json = model.toJson();

      expect(json['id'], model.id);
      expect(json['air_date'], model.airDate);
      expect(json['characters'], model.characters);
      expect(json['created'], createdText);
    });
  });

  group('CharacterModel', () {
    test('converte map da API corretamente', () {
      final model = CharacterModel.fromMap(characterMap(type: null));

      expect(model.id, 1);
      expect(model.name, 'Rick Sanchez');
      expect(model.type, '');
      expect(model.origin.name, 'Earth (C-137)');
      expect(model.location.name, 'Citadel of Ricks');
      expect(model.episode, ['https://rickandmortyapi.com/api/episode/1']);
      expect(model.created, createdDate);
    });

    test('toMap preserva campos necessários', () {
      final model = characterModel();
      final map = model.toMap();

      expect(map['id'], model.id);
      expect(map['origin'], model.origin.toMap());
      expect(map['location'], model.location.toMap());
      expect(map['episode'], model.episode);
      expect(map['created'], createdText);
    });
  });

  group('ApiReference', () {
    test('converte map e volta para map', () {
      final model = ApiReference.fromMap({
        'name': 'Earth',
        'url': 'https://rickandmortyapi.com/api/location/1',
      });

      expect(model.name, 'Earth');
      expect(model.toMap(), {
        'name': 'Earth',
        'url': 'https://rickandmortyapi.com/api/location/1',
      });
    });
  });
}
