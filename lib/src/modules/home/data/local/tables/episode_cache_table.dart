part of '../home_cache_database.dart';

@DataClassName('EpisodeCacheRow')
class EpisodeCache extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get airDate => text()();
  TextColumn get episodeCode => text()();
  TextColumn get charactersUrlsJson => text()();
  TextColumn get url => text()();
  DateTimeColumn get created => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
