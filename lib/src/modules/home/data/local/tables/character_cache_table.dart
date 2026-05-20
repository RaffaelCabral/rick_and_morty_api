part of '../home_cache_database.dart';

@DataClassName('CharacterCacheRow')
class CharacterCache extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();
  TextColumn get originJson => text()();
  TextColumn get locationJson => text()();
  TextColumn get image => text()();
  TextColumn get episodeUrlsJson => text()();
  TextColumn get url => text()();
  DateTimeColumn get created => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
