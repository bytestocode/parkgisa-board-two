// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PhotoInfosTable extends PhotoInfos
    with TableInfo<$PhotoInfosTable, PhotoInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workTypeMeta = const VerificationMeta(
    'workType',
  );
  @override
  late final GeneratedColumn<String> workType = GeneratedColumn<String>(
    'work_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customFieldsMeta = const VerificationMeta(
    'customFields',
  );
  @override
  late final GeneratedColumn<String> customFields = GeneratedColumn<String>(
    'custom_fields',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imagePath,
    capturedAt,
    location,
    latitude,
    longitude,
    workType,
    description,
    customFields,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_infos';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhotoInfo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_capturedAtMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('work_type')) {
      context.handle(
        _workTypeMeta,
        workType.isAcceptableOrUnknown(data['work_type']!, _workTypeMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('custom_fields')) {
      context.handle(
        _customFieldsMeta,
        customFields.isAcceptableOrUnknown(
          data['custom_fields']!,
          _customFieldsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoInfo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      workType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_type'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      customFields: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_fields'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PhotoInfosTable createAlias(String alias) {
    return $PhotoInfosTable(attachedDatabase, alias);
  }
}

class PhotoInfo extends DataClass implements Insertable<PhotoInfo> {
  final int id;
  final String imagePath;
  final DateTime capturedAt;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? workType;
  final String? description;
  final String? customFields;
  final DateTime createdAt;
  const PhotoInfo({
    required this.id,
    required this.imagePath,
    required this.capturedAt,
    this.location,
    this.latitude,
    this.longitude,
    this.workType,
    this.description,
    this.customFields,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_path'] = Variable<String>(imagePath);
    map['captured_at'] = Variable<DateTime>(capturedAt);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || workType != null) {
      map['work_type'] = Variable<String>(workType);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || customFields != null) {
      map['custom_fields'] = Variable<String>(customFields);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PhotoInfosCompanion toCompanion(bool nullToAbsent) {
    return PhotoInfosCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      capturedAt: Value(capturedAt),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      workType: workType == null && nullToAbsent
          ? const Value.absent()
          : Value(workType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      customFields: customFields == null && nullToAbsent
          ? const Value.absent()
          : Value(customFields),
      createdAt: Value(createdAt),
    );
  }

  factory PhotoInfo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoInfo(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
      location: serializer.fromJson<String?>(json['location']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      workType: serializer.fromJson<String?>(json['workType']),
      description: serializer.fromJson<String?>(json['description']),
      customFields: serializer.fromJson<String?>(json['customFields']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
      'location': serializer.toJson<String?>(location),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'workType': serializer.toJson<String?>(workType),
      'description': serializer.toJson<String?>(description),
      'customFields': serializer.toJson<String?>(customFields),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PhotoInfo copyWith({
    int? id,
    String? imagePath,
    DateTime? capturedAt,
    Value<String?> location = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> workType = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> customFields = const Value.absent(),
    DateTime? createdAt,
  }) => PhotoInfo(
    id: id ?? this.id,
    imagePath: imagePath ?? this.imagePath,
    capturedAt: capturedAt ?? this.capturedAt,
    location: location.present ? location.value : this.location,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    workType: workType.present ? workType.value : this.workType,
    description: description.present ? description.value : this.description,
    customFields: customFields.present ? customFields.value : this.customFields,
    createdAt: createdAt ?? this.createdAt,
  );
  PhotoInfo copyWithCompanion(PhotoInfosCompanion data) {
    return PhotoInfo(
      id: data.id.present ? data.id.value : this.id,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      location: data.location.present ? data.location.value : this.location,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      workType: data.workType.present ? data.workType.value : this.workType,
      description: data.description.present
          ? data.description.value
          : this.description,
      customFields: data.customFields.present
          ? data.customFields.value
          : this.customFields,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoInfo(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('location: $location, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('workType: $workType, ')
          ..write('description: $description, ')
          ..write('customFields: $customFields, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    imagePath,
    capturedAt,
    location,
    latitude,
    longitude,
    workType,
    description,
    customFields,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoInfo &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.capturedAt == this.capturedAt &&
          other.location == this.location &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.workType == this.workType &&
          other.description == this.description &&
          other.customFields == this.customFields &&
          other.createdAt == this.createdAt);
}

class PhotoInfosCompanion extends UpdateCompanion<PhotoInfo> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<DateTime> capturedAt;
  final Value<String?> location;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> workType;
  final Value<String?> description;
  final Value<String?> customFields;
  final Value<DateTime> createdAt;
  const PhotoInfosCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.location = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.workType = const Value.absent(),
    this.description = const Value.absent(),
    this.customFields = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PhotoInfosCompanion.insert({
    this.id = const Value.absent(),
    required String imagePath,
    required DateTime capturedAt,
    this.location = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.workType = const Value.absent(),
    this.description = const Value.absent(),
    this.customFields = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : imagePath = Value(imagePath),
       capturedAt = Value(capturedAt);
  static Insertable<PhotoInfo> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<DateTime>? capturedAt,
    Expression<String>? location,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? workType,
    Expression<String>? description,
    Expression<String>? customFields,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (location != null) 'location': location,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (workType != null) 'work_type': workType,
      if (description != null) 'description': description,
      if (customFields != null) 'custom_fields': customFields,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PhotoInfosCompanion copyWith({
    Value<int>? id,
    Value<String>? imagePath,
    Value<DateTime>? capturedAt,
    Value<String?>? location,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? workType,
    Value<String?>? description,
    Value<String?>? customFields,
    Value<DateTime>? createdAt,
  }) {
    return PhotoInfosCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      capturedAt: capturedAt ?? this.capturedAt,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      workType: workType ?? this.workType,
      description: description ?? this.description,
      customFields: customFields ?? this.customFields,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (workType.present) {
      map['work_type'] = Variable<String>(workType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (customFields.present) {
      map['custom_fields'] = Variable<String>(customFields.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoInfosCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('location: $location, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('workType: $workType, ')
          ..write('description: $description, ')
          ..write('customFields: $customFields, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WorkTypesTable extends WorkTypes
    with TableInfo<$WorkTypesTable, WorkType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
    'last_used',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    usageCount,
    lastUsed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkType> instance, {
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
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WorkTypesTable createAlias(String alias) {
    return $WorkTypesTable(attachedDatabase, alias);
  }
}

class WorkType extends DataClass implements Insertable<WorkType> {
  final int id;
  final String name;
  final int usageCount;
  final DateTime? lastUsed;
  final DateTime createdAt;
  const WorkType({
    required this.id,
    required this.name,
    required this.usageCount,
    this.lastUsed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['usage_count'] = Variable<int>(usageCount);
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WorkTypesCompanion toCompanion(bool nullToAbsent) {
    return WorkTypesCompanion(
      id: Value(id),
      name: Value(name),
      usageCount: Value(usageCount),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
      createdAt: Value(createdAt),
    );
  }

  factory WorkType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'usageCount': serializer.toJson<int>(usageCount),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WorkType copyWith({
    int? id,
    String? name,
    int? usageCount,
    Value<DateTime?> lastUsed = const Value.absent(),
    DateTime? createdAt,
  }) => WorkType(
    id: id ?? this.id,
    name: name ?? this.name,
    usageCount: usageCount ?? this.usageCount,
    lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
    createdAt: createdAt ?? this.createdAt,
  );
  WorkType copyWithCompanion(WorkTypesCompanion data) {
    return WorkType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, usageCount, lastUsed, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkType &&
          other.id == this.id &&
          other.name == this.name &&
          other.usageCount == this.usageCount &&
          other.lastUsed == this.lastUsed &&
          other.createdAt == this.createdAt);
}

class WorkTypesCompanion extends UpdateCompanion<WorkType> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> usageCount;
  final Value<DateTime?> lastUsed;
  final Value<DateTime> createdAt;
  const WorkTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  WorkTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.usageCount = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WorkType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? usageCount,
    Expression<DateTime>? lastUsed,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (usageCount != null) 'usage_count': usageCount,
      if (lastUsed != null) 'last_used': lastUsed,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  WorkTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? usageCount,
    Value<DateTime?>? lastUsed,
    Value<DateTime>? createdAt,
  }) {
    return WorkTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      usageCount: usageCount ?? this.usageCount,
      lastUsed: lastUsed ?? this.lastUsed,
      createdAt: createdAt ?? this.createdAt,
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
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LocationHistoriesTable extends LocationHistories
    with TableInfo<$LocationHistoriesTable, LocationHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUsedMeta = const VerificationMeta(
    'lastUsed',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsed = GeneratedColumn<DateTime>(
    'last_used',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    locationName,
    usageCount,
    lastUsed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_locationNameMeta);
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('last_used')) {
      context.handle(
        _lastUsedMeta,
        lastUsed.isAcceptableOrUnknown(data['last_used']!, _lastUsedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      )!,
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      lastUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocationHistoriesTable createAlias(String alias) {
    return $LocationHistoriesTable(attachedDatabase, alias);
  }
}

class LocationHistory extends DataClass implements Insertable<LocationHistory> {
  final int id;
  final String locationName;
  final int usageCount;
  final DateTime? lastUsed;
  final DateTime createdAt;
  const LocationHistory({
    required this.id,
    required this.locationName,
    required this.usageCount,
    this.lastUsed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['location_name'] = Variable<String>(locationName);
    map['usage_count'] = Variable<int>(usageCount);
    if (!nullToAbsent || lastUsed != null) {
      map['last_used'] = Variable<DateTime>(lastUsed);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocationHistoriesCompanion toCompanion(bool nullToAbsent) {
    return LocationHistoriesCompanion(
      id: Value(id),
      locationName: Value(locationName),
      usageCount: Value(usageCount),
      lastUsed: lastUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsed),
      createdAt: Value(createdAt),
    );
  }

  factory LocationHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationHistory(
      id: serializer.fromJson<int>(json['id']),
      locationName: serializer.fromJson<String>(json['locationName']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      lastUsed: serializer.fromJson<DateTime?>(json['lastUsed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'locationName': serializer.toJson<String>(locationName),
      'usageCount': serializer.toJson<int>(usageCount),
      'lastUsed': serializer.toJson<DateTime?>(lastUsed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocationHistory copyWith({
    int? id,
    String? locationName,
    int? usageCount,
    Value<DateTime?> lastUsed = const Value.absent(),
    DateTime? createdAt,
  }) => LocationHistory(
    id: id ?? this.id,
    locationName: locationName ?? this.locationName,
    usageCount: usageCount ?? this.usageCount,
    lastUsed: lastUsed.present ? lastUsed.value : this.lastUsed,
    createdAt: createdAt ?? this.createdAt,
  );
  LocationHistory copyWithCompanion(LocationHistoriesCompanion data) {
    return LocationHistory(
      id: data.id.present ? data.id.value : this.id,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      lastUsed: data.lastUsed.present ? data.lastUsed.value : this.lastUsed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationHistory(')
          ..write('id: $id, ')
          ..write('locationName: $locationName, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, locationName, usageCount, lastUsed, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationHistory &&
          other.id == this.id &&
          other.locationName == this.locationName &&
          other.usageCount == this.usageCount &&
          other.lastUsed == this.lastUsed &&
          other.createdAt == this.createdAt);
}

class LocationHistoriesCompanion extends UpdateCompanion<LocationHistory> {
  final Value<int> id;
  final Value<String> locationName;
  final Value<int> usageCount;
  final Value<DateTime?> lastUsed;
  final Value<DateTime> createdAt;
  const LocationHistoriesCompanion({
    this.id = const Value.absent(),
    this.locationName = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LocationHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required String locationName,
    this.usageCount = const Value.absent(),
    this.lastUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : locationName = Value(locationName);
  static Insertable<LocationHistory> custom({
    Expression<int>? id,
    Expression<String>? locationName,
    Expression<int>? usageCount,
    Expression<DateTime>? lastUsed,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (locationName != null) 'location_name': locationName,
      if (usageCount != null) 'usage_count': usageCount,
      if (lastUsed != null) 'last_used': lastUsed,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LocationHistoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? locationName,
    Value<int>? usageCount,
    Value<DateTime?>? lastUsed,
    Value<DateTime>? createdAt,
  }) {
    return LocationHistoriesCompanion(
      id: id ?? this.id,
      locationName: locationName ?? this.locationName,
      usageCount: usageCount ?? this.usageCount,
      lastUsed: lastUsed ?? this.lastUsed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (lastUsed.present) {
      map['last_used'] = Variable<DateTime>(lastUsed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('locationName: $locationName, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsed: $lastUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PhotoInfosTable photoInfos = $PhotoInfosTable(this);
  late final $WorkTypesTable workTypes = $WorkTypesTable(this);
  late final $LocationHistoriesTable locationHistories =
      $LocationHistoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    photoInfos,
    workTypes,
    locationHistories,
  ];
}

typedef $$PhotoInfosTableCreateCompanionBuilder =
    PhotoInfosCompanion Function({
      Value<int> id,
      required String imagePath,
      required DateTime capturedAt,
      Value<String?> location,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> workType,
      Value<String?> description,
      Value<String?> customFields,
      Value<DateTime> createdAt,
    });
typedef $$PhotoInfosTableUpdateCompanionBuilder =
    PhotoInfosCompanion Function({
      Value<int> id,
      Value<String> imagePath,
      Value<DateTime> capturedAt,
      Value<String?> location,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> workType,
      Value<String?> description,
      Value<String?> customFields,
      Value<DateTime> createdAt,
    });

class $$PhotoInfosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotoInfosTable> {
  $$PhotoInfosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workType => $composableBuilder(
    column: $table.workType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PhotoInfosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotoInfosTable> {
  $$PhotoInfosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workType => $composableBuilder(
    column: $table.workType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PhotoInfosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotoInfosTable> {
  $$PhotoInfosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get workType =>
      $composableBuilder(column: $table.workType, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customFields => $composableBuilder(
    column: $table.customFields,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PhotoInfosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotoInfosTable,
          PhotoInfo,
          $$PhotoInfosTableFilterComposer,
          $$PhotoInfosTableOrderingComposer,
          $$PhotoInfosTableAnnotationComposer,
          $$PhotoInfosTableCreateCompanionBuilder,
          $$PhotoInfosTableUpdateCompanionBuilder,
          (
            PhotoInfo,
            BaseReferences<_$AppDatabase, $PhotoInfosTable, PhotoInfo>,
          ),
          PhotoInfo,
          PrefetchHooks Function()
        > {
  $$PhotoInfosTableTableManager(_$AppDatabase db, $PhotoInfosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotoInfosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotoInfosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotoInfosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
                Value<DateTime> capturedAt = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> workType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PhotoInfosCompanion(
                id: id,
                imagePath: imagePath,
                capturedAt: capturedAt,
                location: location,
                latitude: latitude,
                longitude: longitude,
                workType: workType,
                description: description,
                customFields: customFields,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String imagePath,
                required DateTime capturedAt,
                Value<String?> location = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> workType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> customFields = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PhotoInfosCompanion.insert(
                id: id,
                imagePath: imagePath,
                capturedAt: capturedAt,
                location: location,
                latitude: latitude,
                longitude: longitude,
                workType: workType,
                description: description,
                customFields: customFields,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PhotoInfosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotoInfosTable,
      PhotoInfo,
      $$PhotoInfosTableFilterComposer,
      $$PhotoInfosTableOrderingComposer,
      $$PhotoInfosTableAnnotationComposer,
      $$PhotoInfosTableCreateCompanionBuilder,
      $$PhotoInfosTableUpdateCompanionBuilder,
      (PhotoInfo, BaseReferences<_$AppDatabase, $PhotoInfosTable, PhotoInfo>),
      PhotoInfo,
      PrefetchHooks Function()
    >;
typedef $$WorkTypesTableCreateCompanionBuilder =
    WorkTypesCompanion Function({
      Value<int> id,
      required String name,
      Value<int> usageCount,
      Value<DateTime?> lastUsed,
      Value<DateTime> createdAt,
    });
typedef $$WorkTypesTableUpdateCompanionBuilder =
    WorkTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> usageCount,
      Value<DateTime?> lastUsed,
      Value<DateTime> createdAt,
    });

class $$WorkTypesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkTypesTable> {
  $$WorkTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkTypesTable> {
  $$WorkTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkTypesTable> {
  $$WorkTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WorkTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkTypesTable,
          WorkType,
          $$WorkTypesTableFilterComposer,
          $$WorkTypesTableOrderingComposer,
          $$WorkTypesTableAnnotationComposer,
          $$WorkTypesTableCreateCompanionBuilder,
          $$WorkTypesTableUpdateCompanionBuilder,
          (WorkType, BaseReferences<_$AppDatabase, $WorkTypesTable, WorkType>),
          WorkType,
          PrefetchHooks Function()
        > {
  $$WorkTypesTableTableManager(_$AppDatabase db, $WorkTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WorkTypesCompanion(
                id: id,
                name: name,
                usageCount: usageCount,
                lastUsed: lastUsed,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => WorkTypesCompanion.insert(
                id: id,
                name: name,
                usageCount: usageCount,
                lastUsed: lastUsed,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkTypesTable,
      WorkType,
      $$WorkTypesTableFilterComposer,
      $$WorkTypesTableOrderingComposer,
      $$WorkTypesTableAnnotationComposer,
      $$WorkTypesTableCreateCompanionBuilder,
      $$WorkTypesTableUpdateCompanionBuilder,
      (WorkType, BaseReferences<_$AppDatabase, $WorkTypesTable, WorkType>),
      WorkType,
      PrefetchHooks Function()
    >;
typedef $$LocationHistoriesTableCreateCompanionBuilder =
    LocationHistoriesCompanion Function({
      Value<int> id,
      required String locationName,
      Value<int> usageCount,
      Value<DateTime?> lastUsed,
      Value<DateTime> createdAt,
    });
typedef $$LocationHistoriesTableUpdateCompanionBuilder =
    LocationHistoriesCompanion Function({
      Value<int> id,
      Value<String> locationName,
      Value<int> usageCount,
      Value<DateTime?> lastUsed,
      Value<DateTime> createdAt,
    });

class $$LocationHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $LocationHistoriesTable> {
  $$LocationHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationHistoriesTable> {
  $$LocationHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsed => $composableBuilder(
    column: $table.lastUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationHistoriesTable> {
  $$LocationHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUsed =>
      $composableBuilder(column: $table.lastUsed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LocationHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationHistoriesTable,
          LocationHistory,
          $$LocationHistoriesTableFilterComposer,
          $$LocationHistoriesTableOrderingComposer,
          $$LocationHistoriesTableAnnotationComposer,
          $$LocationHistoriesTableCreateCompanionBuilder,
          $$LocationHistoriesTableUpdateCompanionBuilder,
          (
            LocationHistory,
            BaseReferences<
              _$AppDatabase,
              $LocationHistoriesTable,
              LocationHistory
            >,
          ),
          LocationHistory,
          PrefetchHooks Function()
        > {
  $$LocationHistoriesTableTableManager(
    _$AppDatabase db,
    $LocationHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> locationName = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LocationHistoriesCompanion(
                id: id,
                locationName: locationName,
                usageCount: usageCount,
                lastUsed: lastUsed,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String locationName,
                Value<int> usageCount = const Value.absent(),
                Value<DateTime?> lastUsed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LocationHistoriesCompanion.insert(
                id: id,
                locationName: locationName,
                usageCount: usageCount,
                lastUsed: lastUsed,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationHistoriesTable,
      LocationHistory,
      $$LocationHistoriesTableFilterComposer,
      $$LocationHistoriesTableOrderingComposer,
      $$LocationHistoriesTableAnnotationComposer,
      $$LocationHistoriesTableCreateCompanionBuilder,
      $$LocationHistoriesTableUpdateCompanionBuilder,
      (
        LocationHistory,
        BaseReferences<_$AppDatabase, $LocationHistoriesTable, LocationHistory>,
      ),
      LocationHistory,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PhotoInfosTableTableManager get photoInfos =>
      $$PhotoInfosTableTableManager(_db, _db.photoInfos);
  $$WorkTypesTableTableManager get workTypes =>
      $$WorkTypesTableTableManager(_db, _db.workTypes);
  $$LocationHistoriesTableTableManager get locationHistories =>
      $$LocationHistoriesTableTableManager(_db, _db.locationHistories);
}
