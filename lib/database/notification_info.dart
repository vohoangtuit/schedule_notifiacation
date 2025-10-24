import 'package:drift/drift.dart';

class NotificationInfo extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get dateTimeNoty => text().nullable()();
  TextColumn get beforeTimeActive => text().nullable()();
  BoolColumn get active => boolean().nullable()();
}