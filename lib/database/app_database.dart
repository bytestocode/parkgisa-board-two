import 'dart:io';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:parkgisa_board_two/models/photo_info.dart';
import 'package:parkgisa_board_two/models/work_type.dart';
import 'package:parkgisa_board_two/models/location_history.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [PhotoInfos, WorkTypes, LocationHistories])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<PhotoInfo>> getAllPhotos() => select(photoInfos).get();
  
  Future<List<PhotoInfo>> getPhotosByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    return (select(photoInfos)
      ..where((tbl) => tbl.capturedAt.isBetweenValues(startOfDay, endOfDay)))
      .get();
  }
  
  Future<List<PhotoInfo>> getPhotosByLocation(String location) {
    return (select(photoInfos)
      ..where((tbl) => tbl.location.equals(location)))
      .get();
  }
  
  Future<List<PhotoInfo>> getPhotosByWorkType(String workType) {
    return (select(photoInfos)
      ..where((tbl) => tbl.workType.equals(workType)))
      .get();
  }
  
  Future<int> insertPhoto(PhotoInfosCompanion photo) => into(photoInfos).insert(photo);
  
  Future<bool> updatePhoto(PhotoInfo photo) => update(photoInfos).replace(photo);
  
  Future<int> deletePhoto(int id) => (delete(photoInfos)..where((tbl) => tbl.id.equals(id))).go();
  
  Future<List<WorkType>> getAllWorkTypes() {
    return (select(workTypes)..orderBy([(t) => OrderingTerm.desc(t.usageCount)]))
      .get();
  }
  
  Future<int> insertWorkType(String name) async {
    final existing = await (select(workTypes)..where((tbl) => tbl.name.equals(name))).getSingleOrNull();
    
    if (existing != null) {
      await (update(workTypes)..where((tbl) => tbl.id.equals(existing.id)))
        .write(WorkTypesCompanion(
          usageCount: Value(existing.usageCount + 1),
          lastUsed: Value(DateTime.now()),
        ));
      return existing.id;
    } else {
      return into(workTypes).insert(
        WorkTypesCompanion(
          name: Value(name),
          usageCount: Value(1),
          lastUsed: Value(DateTime.now()),
        ),
      );
    }
  }
  
  Future<List<LocationHistory>> getAllLocations() {
    return (select(locationHistories)..orderBy([(t) => OrderingTerm.desc(t.usageCount)]))
      .get();
  }
  
  Future<int> insertLocation(String locationName) async {
    final existing = await (select(locationHistories)..where((tbl) => tbl.locationName.equals(locationName))).getSingleOrNull();
    
    if (existing != null) {
      await (update(locationHistories)..where((tbl) => tbl.id.equals(existing.id)))
        .write(LocationHistoriesCompanion(
          usageCount: Value(existing.usageCount + 1),
          lastUsed: Value(DateTime.now()),
        ));
      return existing.id;
    } else {
      return into(locationHistories).insert(
        LocationHistoriesCompanion(
          locationName: Value(locationName),
          usageCount: Value(1),
          lastUsed: Value(DateTime.now()),
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'parkgisa_board.db'));
    return NativeDatabase.createInBackground(file);
  });
}