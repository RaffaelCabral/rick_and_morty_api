import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/data/local/home_cache_database.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl(this._db);

  final HomeCacheDatabase _db;

  @override
  Future<EpisodeModel> getEpisode(int id) async {
    final cached = await getEpisodeById(id);
    if (cached != null) return cached;
    throw HomeOfflineCacheException(
      'Ainda não temos dados salvos para esse episódio.',
    );
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    final cached = await getCharacterById(id);
    if (cached != null) return cached;
    throw HomeOfflineCacheException(
      'Ainda não temos dados salvos para esse personagem.',
    );
  }

  @override
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids) {
    return getCharactersByIdsOrdered(ids);
  }

  @override
  Future<void> saveEpisode(EpisodeModel episode) async {
    await _db
        .into(_db.episodeCache)
        .insertOnConflictUpdate(
          EpisodeCacheCompanion.insert(
            id: Value(episode.id),
            name: episode.name,
            airDate: episode.airDate,
            episodeCode: episode.episode,
            charactersUrlsJson: jsonEncode(episode.characters),
            url: episode.url,
            created: episode.created,
          ),
        );
  }

  @override
  Future<void> saveCharacters(List<CharacterModel> characters) async {
    if (characters.isEmpty) return;

    await _db.transaction(() async {
      for (final c in characters) {
        await _db
            .into(_db.characterCache)
            .insertOnConflictUpdate(
              CharacterCacheCompanion.insert(
                id: Value(c.id),
                name: c.name,
                status: c.status,
                species: c.species,
                type: c.type,
                gender: c.gender,
                originJson: jsonEncode(c.origin.toMap()),
                locationJson: jsonEncode(c.location.toMap()),
                image: c.image,
                episodeUrlsJson: jsonEncode(c.episode),
                url: c.url,
                created: c.created,
              ),
            );
      }
    });
  }

  @override
  Future<EpisodeModel?> getEpisodeById(int id) async {
    final row = await (_db.select(
      _db.episodeCache,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return _episodeFromRow(row);
  }

  @override
  Future<CharacterModel?> getCharacterById(int id) async {
    final row = await (_db.select(
      _db.characterCache,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return _characterFromRow(row);
  }

  @override
  Future<List<CharacterModel>> getCharactersByIdsOrdered(List<int> ids) async {
    if (ids.isEmpty) return [];

    final rows = await (_db.select(
      _db.characterCache,
    )..where((t) => t.id.isIn(ids))).get();

    final byId = {for (final r in rows) r.id: r};

    final out = <CharacterModel>[];
    for (final id in ids) {
      final row = byId[id];
      if (row == null) {
        throw HomeOfflineCacheException(
          'Sem dados offline para todos os personagens deste episódio. '
          'Abra este episódio com internet pelo menos uma vez.',
        );
      }
      out.add(_characterFromRow(row));
    }
    return out;
  }

  EpisodeModel _episodeFromRow(EpisodeCacheRow row) {
    final urls = (jsonDecode(row.charactersUrlsJson) as List<dynamic>)
        .cast<String>();
    return EpisodeModel(
      id: row.id,
      name: row.name,
      airDate: row.airDate,
      episode: row.episodeCode,
      characters: urls,
      url: row.url,
      created: row.created,
    );
  }

  CharacterModel _characterFromRow(CharacterCacheRow row) {
    final map = <String, dynamic>{
      'id': row.id,
      'name': row.name,
      'status': row.status,
      'species': row.species,
      'type': row.type,
      'gender': row.gender,
      'origin': jsonDecode(row.originJson) as Map<String, dynamic>,
      'location': jsonDecode(row.locationJson) as Map<String, dynamic>,
      'image': row.image,
      'episode': jsonDecode(row.episodeUrlsJson) as List<dynamic>,
      'url': row.url,
      'created': row.created.toIso8601String(),
    };
    return CharacterModel.fromMap(map);
  }
}
