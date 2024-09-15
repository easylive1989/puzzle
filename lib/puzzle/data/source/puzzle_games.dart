import 'package:drift/drift.dart';

class PuzzleGames extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tiles => text()();
  TextColumn get type => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}