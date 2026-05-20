import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'tables/episode_cache_table.dart';
part 'tables/character_cache_table.dart';
part 'home_cache_database.g.dart';

@DriftDatabase(tables: [EpisodeCache, CharacterCache])
class HomeCacheDatabase extends _$HomeCacheDatabase {
  HomeCacheDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'home_cache.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
