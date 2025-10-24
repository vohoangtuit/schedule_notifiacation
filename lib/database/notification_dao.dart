import 'package:demo_local_notification/database/app_database.dart';
import 'package:demo_local_notification/database/notification_info.dart';
import 'package:drift/drift.dart';
part 'notification_dao.g.dart';

@DriftAccessor(tables: [NotificationInfo])
class NotificationDao extends  DatabaseAccessor<AppDatabase> with _$NotificationDaoMixin{
  NotificationDao(super.db);
}