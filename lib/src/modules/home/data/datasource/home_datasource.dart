import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

abstract class HomeDataSource {
  Future<EpisodeModel> getEpisode(int id);

  Future<CharacterModel> getCharacter(int id);

  Future<List<CharacterModel>> getCharactersByIds(List<int> ids);
}

abstract class HomeLocalDataSource extends HomeDataSource {
  Future<void> saveEpisode(EpisodeModel episode);

  Future<void> saveCharacters(List<CharacterModel> characters);

  Future<EpisodeModel?> getEpisodeById(int id);

  Future<CharacterModel?> getCharacterById(int id);

  Future<List<CharacterModel>> getCharactersByIdsOrdered(List<int> ids);
}

int extractCharacterIdFromUrl(String url) {
  final match = RegExp(r'/character/(\d+)$').firstMatch(url);
  if (match == null) {
    throw FormatException('URL de personagem inválida: $url');
  }
  return int.parse(match.group(1)!);
}
