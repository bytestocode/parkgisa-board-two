import 'package:drift/drift.dart';

class PhotoInfos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get imagePath => text()();
  DateTimeColumn get capturedAt => dateTime()();
  TextColumn get location => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get workType => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get customFields => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class PhotoInfo {
  final int id;
  final String imagePath;
  final DateTime capturedAt;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? workType;
  final String? description;
  final Map<String, String>? customFields;
  final DateTime createdAt;

  PhotoInfo({
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
}