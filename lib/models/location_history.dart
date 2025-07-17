import 'package:drift/drift.dart';

class LocationHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get locationName => text()();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUsed => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}