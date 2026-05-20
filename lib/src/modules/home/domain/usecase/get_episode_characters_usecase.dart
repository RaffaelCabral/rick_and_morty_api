import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';

class GetEpisodeCharactersUseCase {
  GetEpisodeCharactersUseCase(this._repository);

  final HomeRepository _repository;

  Future<({EpisodeModel episode, List<CharacterModel> characters})> call(
    String rawInput,
  ) async {
    final episodeId = _parseEpisodeId(rawInput);

    final episode = await _repository.getEpisode(episodeId);
    final characterIds = episode.characters
        .map(extractCharacterIdFromUrl)
        .toList();
    final characters = await _repository.getCharactersByIds(characterIds);
    final sortedByName = List<CharacterModel>.from(characters)
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return (episode: episode, characters: sortedByName);
  }

  int _parseEpisodeId(String rawInput) {
    final text = rawInput.trim();

    if (text.isEmpty) {
      throw ArgumentError('Informe o número do episódio.');
    }

    final episodeId = int.tryParse(text);
    if (episodeId == null) {
      throw ArgumentError('Número de episódio inválido.');
    }

    if (episodeId <= 0) {
      throw ArgumentError('Informe um número de episódio válido.');
    }

    return episodeId;
  }
}
