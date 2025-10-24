
import 'dart:io';
import 'package:demo_local_notification/database/notification_dao.dart';
import 'package:demo_local_notification/database/notification_info.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';
@DriftDatabase(tables: [NotificationInfo], daos: [NotificationDao])//todo add table và dao vào đây
class AppDatabase extends _$AppDatabase {


  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1; //todo 2,3 Tăng version nếu thay đổi DB

  // Khai báo DAO
  late final NotificationDao accountDao = NotificationDao(this);

  // Thêm các DAO khác nếu cần
  //todo: dart run build_runner build: run trước khi thay đổi schema, nếu không sẽ báo lỗi
  // @override
  // MigrationStrategy get migration {
  //   return MigrationStrategy(
  //     onCreate: (Migrator m) async {
  //       await m.createAll();
  //     },
  //     onUpgrade: (Migrator m, int from, int to) async {
  //       // if (from == 2) {// todo add table mới version 3
  //       //   await m.createTable(newsInfo); // 👈 thêm table mới
  //       // }
  //       //
  //       // if (from == 1) {// todo add column mới version 2
  //       //   await m.addColumn(accountInfo, accountInfo.profileType); // 👈 Thêm column mới
  //       // }
  //       //
  //     },
  //
  //   );
  // }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tu_notification.db'));
    ///print('Database file path: ${file.path}'); // Thêm dòng này
    //showLog('Database file path: ${file.path}'); // Thêm dòng này
    return NativeDatabase(file);
  });
}

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); // Riverpod sẽ tự đảm bảo chỉ tạo một instance
});