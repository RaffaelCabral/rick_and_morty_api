// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cache_database.dart';

// ignore_for_file: type=lint
class $EpisodeCacheTable extends EpisodeCache
    with TableInfo<$EpisodeCacheTable, EpisodeCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EpisodeCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _airDateMeta = const VerificationMeta(
    'airDate',
  );
  @override
  late final GeneratedColumn<String> airDate = GeneratedColumn<String>(
    'air_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeCodeMeta = const VerificationMeta(
    'episodeCode',
  );
  @override
  late final GeneratedColumn<String> episodeCode = GeneratedColumn<String>(
    'episode_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _charactersUrlsJsonMeta =
      const VerificationMeta('charactersUrlsJson');
  @override
  late final GeneratedColumn<String> charactersUrlsJson =
      GeneratedColumn<String>(
        'characters_urls_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    airDate,
    episodeCode,
    charactersUrlsJson,
    url,
    created,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'episode_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<EpisodeCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('air_date')) {
      context.handle(
        _airDateMeta,
        airDate.isAcceptableOrUnknown(data['air_date']!, _airDateMeta),
      );
    } else if (isInserting) {
      context.missing(_airDateMeta);
    }
    if (data.containsKey('episode_code')) {
      context.handle(
        _episodeCodeMeta,
        episodeCode.isAcceptableOrUnknown(
          data['episode_code']!,
          _episodeCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_episodeCodeMeta);
    }
    if (data.containsKey('characters_urls_json')) {
      context.handle(
        _charactersUrlsJsonMeta,
        charactersUrlsJson.isAcceptableOrUnknown(
          data['characters_urls_json']!,
          _charactersUrlsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_charactersUrlsJsonMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EpisodeCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EpisodeCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      airDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}air_date'],
      )!,
      episodeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_code'],
      )!,
      charactersUrlsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}characters_urls_json'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
    );
  }

  @override
  $EpisodeCacheTable createAlias(String alias) {
    return $EpisodeCacheTable(attachedDatabase, alias);
  }
}

class EpisodeCacheRow extends DataClass implements Insertable<EpisodeCacheRow> {
  final int id;
  final String name;
  final String airDate;
  final String episodeCode;
  final String charactersUrlsJson;
  final String url;
  final DateTime created;
  const EpisodeCacheRow({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episodeCode,
    required this.charactersUrlsJson,
    required this.url,
    required this.created,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['air_date'] = Variable<String>(airDate);
    map['episode_code'] = Variable<String>(episodeCode);
    map['characters_urls_json'] = Variable<String>(charactersUrlsJson);
    map['url'] = Variable<String>(url);
    map['created'] = Variable<DateTime>(created);
    return map;
  }

  EpisodeCacheCompanion toCompanion(bool nullToAbsent) {
    return EpisodeCacheCompanion(
      id: Value(id),
      name: Value(name),
      airDate: Value(airDate),
      episodeCode: Value(episodeCode),
      charactersUrlsJson: Value(charactersUrlsJson),
      url: Value(url),
      created: Value(created),
    );
  }

  factory EpisodeCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EpisodeCacheRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      airDate: serializer.fromJson<String>(json['airDate']),
      episodeCode: serializer.fromJson<String>(json['episodeCode']),
      charactersUrlsJson: serializer.fromJson<String>(
        json['charactersUrlsJson'],
      ),
      url: serializer.fromJson<String>(json['url']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'airDate': serializer.toJson<String>(airDate),
      'episodeCode': serializer.toJson<String>(episodeCode),
      'charactersUrlsJson': serializer.toJson<String>(charactersUrlsJson),
      'url': serializer.toJson<String>(url),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  EpisodeCacheRow copyWith({
    int? id,
    String? name,
    String? airDate,
    String? episodeCode,
    String? charactersUrlsJson,
    String? url,
    DateTime? created,
  }) => EpisodeCacheRow(
    id: id ?? this.id,
    name: name ?? this.name,
    airDate: airDate ?? this.airDate,
    episodeCode: episodeCode ?? this.episodeCode,
    charactersUrlsJson: charactersUrlsJson ?? this.charactersUrlsJson,
    url: url ?? this.url,
    created: created ?? this.created,
  );
  EpisodeCacheRow copyWithCompanion(EpisodeCacheCompanion data) {
    return EpisodeCacheRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      airDate: data.airDate.present ? data.airDate.value : this.airDate,
      episodeCode: data.episodeCode.present
          ? data.episodeCode.value
          : this.episodeCode,
      charactersUrlsJson: data.charactersUrlsJson.present
          ? data.charactersUrlsJson.value
          : this.charactersUrlsJson,
      url: data.url.present ? data.url.value : this.url,
      created: data.created.present ? data.created.value : this.created,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EpisodeCacheRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('airDate: $airDate, ')
          ..write('episodeCode: $episodeCode, ')
          ..write('charactersUrlsJson: $charactersUrlsJson, ')
          ..write('url: $url, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    airDate,
    episodeCode,
    charactersUrlsJson,
    url,
    created,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EpisodeCacheRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.airDate == this.airDate &&
          other.episodeCode == this.episodeCode &&
          other.charactersUrlsJson == this.charactersUrlsJson &&
          other.url == this.url &&
          other.created == this.created);
}

class EpisodeCacheCompanion extends UpdateCompanion<EpisodeCacheRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> airDate;
  final Value<String> episodeCode;
  final Value<String> charactersUrlsJson;
  final Value<String> url;
  final Value<DateTime> created;
  const EpisodeCacheCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.airDate = const Value.absent(),
    this.episodeCode = const Value.absent(),
    this.charactersUrlsJson = const Value.absent(),
    this.url = const Value.absent(),
    this.created = const Value.absent(),
  });
  EpisodeCacheCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String airDate,
    required String episodeCode,
    required String charactersUrlsJson,
    required String url,
    required DateTime created,
  }) : name = Value(name),
       airDate = Value(airDate),
       episodeCode = Value(episodeCode),
       charactersUrlsJson = Value(charactersUrlsJson),
       url = Value(url),
       created = Value(created);
  static Insertable<EpisodeCacheRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? airDate,
    Expression<String>? episodeCode,
    Expression<String>? charactersUrlsJson,
    Expression<String>? url,
    Expression<DateTime>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (airDate != null) 'air_date': airDate,
      if (episodeCode != null) 'episode_code': episodeCode,
      if (charactersUrlsJson != null)
        'characters_urls_json': charactersUrlsJson,
      if (url != null) 'url': url,
      if (created != null) 'created': created,
    });
  }

  EpisodeCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? airDate,
    Value<String>? episodeCode,
    Value<String>? charactersUrlsJson,
    Value<String>? url,
    Value<DateTime>? created,
  }) {
    return EpisodeCacheCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      airDate: airDate ?? this.airDate,
      episodeCode: episodeCode ?? this.episodeCode,
      charactersUrlsJson: charactersUrlsJson ?? this.charactersUrlsJson,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (airDate.present) {
      map['air_date'] = Variable<String>(airDate.value);
    }
    if (episodeCode.present) {
      map['episode_code'] = Variable<String>(episodeCode.value);
    }
    if (charactersUrlsJson.present) {
      map['characters_urls_json'] = Variable<String>(charactersUrlsJson.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EpisodeCacheCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('airDate: $airDate, ')
          ..write('episodeCode: $episodeCode, ')
          ..write('charactersUrlsJson: $charactersUrlsJson, ')
          ..write('url: $url, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

class $CharacterCacheTable extends CharacterCache
    with TableInfo<$CharacterCacheTable, CharacterCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originJsonMeta = const VerificationMeta(
    'originJson',
  );
  @override
  late final GeneratedColumn<String> originJson = GeneratedColumn<String>(
    'origin_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationJsonMeta = const VerificationMeta(
    'locationJson',
  );
  @override
  late final GeneratedColumn<String> locationJson = GeneratedColumn<String>(
    'location_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _episodeUrlsJsonMeta = const VerificationMeta(
    'episodeUrlsJson',
  );
  @override
  late final GeneratedColumn<String> episodeUrlsJson = GeneratedColumn<String>(
    'episode_urls_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    status,
    species,
    type,
    gender,
    originJson,
    locationJson,
    image,
    episodeUrlsJson,
    url,
    created,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('origin_json')) {
      context.handle(
        _originJsonMeta,
        originJson.isAcceptableOrUnknown(data['origin_json']!, _originJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_originJsonMeta);
    }
    if (data.containsKey('location_json')) {
      context.handle(
        _locationJsonMeta,
        locationJson.isAcceptableOrUnknown(
          data['location_json']!,
          _locationJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_locationJsonMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('episode_urls_json')) {
      context.handle(
        _episodeUrlsJsonMeta,
        episodeUrlsJson.isAcceptableOrUnknown(
          data['episode_urls_json']!,
          _episodeUrlsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_episodeUrlsJsonMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharacterCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      originJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_json'],
      )!,
      locationJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_json'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      episodeUrlsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}episode_urls_json'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      created: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created'],
      )!,
    );
  }

  @override
  $CharacterCacheTable createAlias(String alias) {
    return $CharacterCacheTable(attachedDatabase, alias);
  }
}

class CharacterCacheRow extends DataClass
    implements Insertable<CharacterCacheRow> {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originJson;
  final String locationJson;
  final String image;
  final String episodeUrlsJson;
  final String url;
  final DateTime created;
  const CharacterCacheRow({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originJson,
    required this.locationJson,
    required this.image,
    required this.episodeUrlsJson,
    required this.url,
    required this.created,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    map['species'] = Variable<String>(species);
    map['type'] = Variable<String>(type);
    map['gender'] = Variable<String>(gender);
    map['origin_json'] = Variable<String>(originJson);
    map['location_json'] = Variable<String>(locationJson);
    map['image'] = Variable<String>(image);
    map['episode_urls_json'] = Variable<String>(episodeUrlsJson);
    map['url'] = Variable<String>(url);
    map['created'] = Variable<DateTime>(created);
    return map;
  }

  CharacterCacheCompanion toCompanion(bool nullToAbsent) {
    return CharacterCacheCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      species: Value(species),
      type: Value(type),
      gender: Value(gender),
      originJson: Value(originJson),
      locationJson: Value(locationJson),
      image: Value(image),
      episodeUrlsJson: Value(episodeUrlsJson),
      url: Value(url),
      created: Value(created),
    );
  }

  factory CharacterCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterCacheRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      species: serializer.fromJson<String>(json['species']),
      type: serializer.fromJson<String>(json['type']),
      gender: serializer.fromJson<String>(json['gender']),
      originJson: serializer.fromJson<String>(json['originJson']),
      locationJson: serializer.fromJson<String>(json['locationJson']),
      image: serializer.fromJson<String>(json['image']),
      episodeUrlsJson: serializer.fromJson<String>(json['episodeUrlsJson']),
      url: serializer.fromJson<String>(json['url']),
      created: serializer.fromJson<DateTime>(json['created']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'species': serializer.toJson<String>(species),
      'type': serializer.toJson<String>(type),
      'gender': serializer.toJson<String>(gender),
      'originJson': serializer.toJson<String>(originJson),
      'locationJson': serializer.toJson<String>(locationJson),
      'image': serializer.toJson<String>(image),
      'episodeUrlsJson': serializer.toJson<String>(episodeUrlsJson),
      'url': serializer.toJson<String>(url),
      'created': serializer.toJson<DateTime>(created),
    };
  }

  CharacterCacheRow copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? originJson,
    String? locationJson,
    String? image,
    String? episodeUrlsJson,
    String? url,
    DateTime? created,
  }) => CharacterCacheRow(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    species: species ?? this.species,
    type: type ?? this.type,
    gender: gender ?? this.gender,
    originJson: originJson ?? this.originJson,
    locationJson: locationJson ?? this.locationJson,
    image: image ?? this.image,
    episodeUrlsJson: episodeUrlsJson ?? this.episodeUrlsJson,
    url: url ?? this.url,
    created: created ?? this.created,
  );
  CharacterCacheRow copyWithCompanion(CharacterCacheCompanion data) {
    return CharacterCacheRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      species: data.species.present ? data.species.value : this.species,
      type: data.type.present ? data.type.value : this.type,
      gender: data.gender.present ? data.gender.value : this.gender,
      originJson: data.originJson.present
          ? data.originJson.value
          : this.originJson,
      locationJson: data.locationJson.present
          ? data.locationJson.value
          : this.locationJson,
      image: data.image.present ? data.image.value : this.image,
      episodeUrlsJson: data.episodeUrlsJson.present
          ? data.episodeUrlsJson.value
          : this.episodeUrlsJson,
      url: data.url.present ? data.url.value : this.url,
      created: data.created.present ? data.created.value : this.created,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterCacheRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('type: $type, ')
          ..write('gender: $gender, ')
          ..write('originJson: $originJson, ')
          ..write('locationJson: $locationJson, ')
          ..write('image: $image, ')
          ..write('episodeUrlsJson: $episodeUrlsJson, ')
          ..write('url: $url, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    status,
    species,
    type,
    gender,
    originJson,
    locationJson,
    image,
    episodeUrlsJson,
    url,
    created,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterCacheRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.species == this.species &&
          other.type == this.type &&
          other.gender == this.gender &&
          other.originJson == this.originJson &&
          other.locationJson == this.locationJson &&
          other.image == this.image &&
          other.episodeUrlsJson == this.episodeUrlsJson &&
          other.url == this.url &&
          other.created == this.created);
}

class CharacterCacheCompanion extends UpdateCompanion<CharacterCacheRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> status;
  final Value<String> species;
  final Value<String> type;
  final Value<String> gender;
  final Value<String> originJson;
  final Value<String> locationJson;
  final Value<String> image;
  final Value<String> episodeUrlsJson;
  final Value<String> url;
  final Value<DateTime> created;
  const CharacterCacheCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.species = const Value.absent(),
    this.type = const Value.absent(),
    this.gender = const Value.absent(),
    this.originJson = const Value.absent(),
    this.locationJson = const Value.absent(),
    this.image = const Value.absent(),
    this.episodeUrlsJson = const Value.absent(),
    this.url = const Value.absent(),
    this.created = const Value.absent(),
  });
  CharacterCacheCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required String originJson,
    required String locationJson,
    required String image,
    required String episodeUrlsJson,
    required String url,
    required DateTime created,
  }) : name = Value(name),
       status = Value(status),
       species = Value(species),
       type = Value(type),
       gender = Value(gender),
       originJson = Value(originJson),
       locationJson = Value(locationJson),
       image = Value(image),
       episodeUrlsJson = Value(episodeUrlsJson),
       url = Value(url),
       created = Value(created);
  static Insertable<CharacterCacheRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<String>? species,
    Expression<String>? type,
    Expression<String>? gender,
    Expression<String>? originJson,
    Expression<String>? locationJson,
    Expression<String>? image,
    Expression<String>? episodeUrlsJson,
    Expression<String>? url,
    Expression<DateTime>? created,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (species != null) 'species': species,
      if (type != null) 'type': type,
      if (gender != null) 'gender': gender,
      if (originJson != null) 'origin_json': originJson,
      if (locationJson != null) 'location_json': locationJson,
      if (image != null) 'image': image,
      if (episodeUrlsJson != null) 'episode_urls_json': episodeUrlsJson,
      if (url != null) 'url': url,
      if (created != null) 'created': created,
    });
  }

  CharacterCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? status,
    Value<String>? species,
    Value<String>? type,
    Value<String>? gender,
    Value<String>? originJson,
    Value<String>? locationJson,
    Value<String>? image,
    Value<String>? episodeUrlsJson,
    Value<String>? url,
    Value<DateTime>? created,
  }) {
    return CharacterCacheCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      originJson: originJson ?? this.originJson,
      locationJson: locationJson ?? this.locationJson,
      image: image ?? this.image,
      episodeUrlsJson: episodeUrlsJson ?? this.episodeUrlsJson,
      url: url ?? this.url,
      created: created ?? this.created,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (originJson.present) {
      map['origin_json'] = Variable<String>(originJson.value);
    }
    if (locationJson.present) {
      map['location_json'] = Variable<String>(locationJson.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (episodeUrlsJson.present) {
      map['episode_urls_json'] = Variable<String>(episodeUrlsJson.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterCacheCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('type: $type, ')
          ..write('gender: $gender, ')
          ..write('originJson: $originJson, ')
          ..write('locationJson: $locationJson, ')
          ..write('image: $image, ')
          ..write('episodeUrlsJson: $episodeUrlsJson, ')
          ..write('url: $url, ')
          ..write('created: $created')
          ..write(')'))
        .toString();
  }
}

abstract class _$HomeCacheDatabase extends GeneratedDatabase {
  _$HomeCacheDatabase(QueryExecutor e) : super(e);
  late final $EpisodeCacheTable episodeCache = $EpisodeCacheTable(this);
  late final $CharacterCacheTable characterCache = $CharacterCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    episodeCache,
    characterCache,
  ];
}
