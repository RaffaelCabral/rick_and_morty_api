import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

abstract class HomeRepository {
  Future<EpisodeModel> getEpisode(int id);
  Future<CharacterModel> getCharacter(int id);
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids);
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDatasource);

  final HomeRemoteDatasource _remoteDatasource;

  @override
  Future<EpisodeModel> getEpisode(int id) {
    return _remoteDatasource.getEpisode(id);
  }

  @override
  Future<CharacterModel> getCharacter(int id) {
    return _remoteDatasource.getCharacter(id);
  }

  @override
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids) {
    return _remoteDatasource.getCharactersByIds(ids);
  }
}
