import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
class NotificationService {
  static String dailyMorningId='daily_morning_id';
  static String dailyMorningName='Thông báo buổi sáng';
  static String titleMorning='Have a nice day';
  static String bodyMorning='Tới giờ đi làm';


  static String dailyEveningId='daily_evening_id';
  static String dailyEveningName='Thông báo buổi tối';
  static String titleEvening='Good evening';
  static String bodyEvening='Bạn đã về đến nhà chưa!';


  // Android Alarm IDs là duy nhất trong app

  static int androidMorningId=1001;
  static int androidEveningId=1002;
  static int androidTestId=1003;
  // Khởi tạo plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Hàm khởi tạo tổng
  static Future<void> init() async {
    // Khởi tạo cơ sở dữ liệu múi giờ
    tz.initializeTimeZones();
    //tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    // Khởi tạo service thông báo
    // Cài đặt cho Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Dùng icon app mặc định

    // Cài đặt cho iOS
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Khởi tạo plugin
    await _notificationsPlugin.initialize(initializationSettings);

    // Xin quyền trên Android +
  await  _requestExactAlarmPermission();
  }
  static  Future<void> _requestExactAlarmPermission() async {
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final bool? canScheduleExact = await androidPlugin?.canScheduleExactNotifications();
    debugPrint("🔔 Có thể lên lịch exact notification: $canScheduleExact");

    if (canScheduleExact == false) {
      // mở cài đặt cho người dùng bật quyền exact alarm
      await androidPlugin?.requestExactAlarmsPermission();
      debugPrint("📅 Đã yêu cầu quyền SCHEDULE_EXACT_ALARM");
    }
    //checkPending();
  }
  static Future<void> setupSchedule()async{
    if(Platform.isAndroid){

     //await testAndroid();
      await androidSetupMorning();
      await androidSetupEvening();
    }else if(Platform.isIOS){
      await NotificationService.cancelNotificationAll();
      await scheduleIOSDailyMorning();
      await scheduleIOSDailyEvening();
    }
  }
  //  todo --for android----------------------------
  static Future<void> testAndroid()async{
    await AndroidAlarmManager.cancel(androidTestId);
   // await AndroidAlarmManager.initialize();
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 14,40);
    //int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      1003,
      showAndroidTestAlarm,
      startAt: scheduledDate,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }
  static Future<void> androidSetupMorning() async {
    await AndroidAlarmManager.cancel(androidMorningId);
    tz.TZDateTime scheduledDate = await getTimeSchedule(true);
    //int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      androidMorningId,
      showMorningAlarm,// androidShowNotificationMorning,/
      startAt: scheduledDate,
      wakeup: true,
      rescheduleOnReboot: true,
    );

  }
 static void androidShowNotificationMorning() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      dailyMorningId,
      dailyMorningName,
      channelDescription: 'Thông báo hằng ngày',
      importance: Importance.max,
      priority: Priority.high,
    );
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    await flutterLocalNotificationsPlugin.show(
      id,
      titleMorning,
      bodyMorning,
       NotificationDetails(android: androidDetails),
    );
  }
  static Future<void> androidSetupEvening() async {
    tz.TZDateTime scheduledDate = await getTimeSchedule(false);
    await AndroidAlarmManager.cancel(androidEveningId);
    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      androidEveningId,
      showEveningAlarm, // androidShowNotificationEvening,
      startAt: scheduledDate,
      wakeup: true,
      rescheduleOnReboot: true,
    );

  }
  static void androidShowNotificationEvening() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      dailyEveningId,
      dailyEveningName,
      channelDescription: 'Thông báo hằng ngày',
      importance: Importance.max,
      priority: Priority.high,
    );
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    await flutterLocalNotificationsPlugin.show(
      id,
      titleEvening,
      bodyEvening,
      NotificationDetails(android: androidDetails),
    );
  }
  //  todo --done android----------------------------
  //------------------------------------
  // todo --for ios----------------------------
  static Future<void> scheduleIOSDailyMorning() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 07,20);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    NotificationDetails  notificationDetails = NotificationDetails(
      // android: AndroidNotificationDetails(
      //   dailyMorningId, // ID của Channel
      //   dailyMorningName, // Tên Channel
      //   importance: Importance.max,
      //   priority: Priority.high,
      // ),
      iOS: DarwinNotificationDetails(
        presentBadge: true,
        presentAlert: true, // ✅ BẮT BUỘC để hiện alert
        presentSound: true, // ✅ BẮT BUỘC để phát âm báo
      ),
    );
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    debugPrint("id =$id");
    // 3. Lên lịch thông báo
    await _notificationsPlugin.zonedSchedule(
      id, // ID của thông báo
      titleMorning,
      bodyMorning,
      scheduledDate, // Thời gian (TZDateTime)
      notificationDetails,

      // Quan trọng: Báo cho Android chạy nền
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,// 🔁 Lặp lại mỗi ngày cùng giờ
    );
  }

  static Future<void> scheduleIOSDailyEvening() async {
    // 1. Tính toán thời gian 18:00 tiếp theo
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 18,10); // 18 giờ

    // 2. Định nghĩa nội dung thông báo
    const NotificationDetails notificationDetails = NotificationDetails(
        // android: AndroidNotificationDetails(
        //   'daily_18pm_channel_id', // ID của Channel
        //   'daily_18pm_channel_id', // Tên Channel
        //   importance: Importance.max,
        //   priority: Priority.high,
        //   playSound: true,
        //   showWhen: true,
        //   enableLights: true,
        //   color: Colors.blue,
        //   ledColor: Colors.blue,
        //   ledOnMs: 1000,
        //   ledOffMs: 500,
        //   autoCancel: true,
        // ),
        iOS: DarwinNotificationDetails( presentBadge: true,
          presentAlert: true, // ✅ BẮT BUỘC để hiện alert
          presentSound: true, // ✅ BẮT BUỘC để phát âm báo),
        ));
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    debugPrint("id: =$id");
    // 3. Lên lịch thông báo
    await _notificationsPlugin.zonedSchedule(
      id, // ID của thông báo
      titleEvening,
      bodyEvening,
      scheduledDate, // Thời gian (TZDateTime)
      notificationDetails,

      // Quan trọng: Báo cho Android chạy nền
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,// 🔁 Lặp lại mỗi ngày cùng giờ
    );
  }

  //todo --done ios----------------------------
  static Future<tz.TZDateTime> getTimeSchedule(bool morning)async{
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime? scheduledDate ;
    if(morning){
      scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 7,20);
    }else{
      scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 18,10);
    }
    return scheduledDate;
  }
  //--------------------
  static Future<void> checkPending()async{
    final pending = await _notificationsPlugin.pendingNotificationRequests();
    debugPrint("⏱ Đang có ${pending.length} notification đang chờ");
    for (var n in pending) {
      debugPrint("• id=${n.id}, title=${n.title}, body=${n.body} ,payload=${n.payload}");
    }
    // final active = await _notificationsPlugin.getActiveNotifications();
    // debugPrint("⏱ Đang có ${active.length} notification active");
    // if(active.isNotEmpty){
    //   for (var n in active) {
    //    // debugPrint("• id=${n.id}, title=${n.title}, body=${n.body} ,payload=${n.payload}");
    //     debugPrint("active: ${n.toString()}");
    //   }
    // }
  }
  static Future<void> showNow() async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'immediate_channel_id',
        'Thông báo tức thì',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    await _notificationsPlugin.show(
      id+1, // ID ngẫu nhiên
      'Thử thông báo 🚀',
      'Nếu bạn thấy dòng này, plugin đã hoạt động!',
      notificationDetails,
    );
    print('Đã gọi xong showNow().');
  }
  static Future<void> scheduleRepeatEvery5Minutes() async {
    final scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5));

    const androidDetails = AndroidNotificationDetails(
      'repeat_channel_id',
      'Repeat Notification',
      channelDescription: 'Thông báo lặp lại mỗi 5 phút',
      importance: Importance.max,
      priority: Priority.high,
    );
    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    await _notificationsPlugin.zonedSchedule(
      id+1, // id bất kỳ
      'Thông báo định kỳ',
      '⏰ Nhắc lại mỗi 5 phút',
      scheduledDate,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // Không set matchDateTimeComponents vì bạn muốn custom 5 phút
    );

    debugPrint("✅ Đã lên lịch lúc $scheduledDate");
  }
  static Future<void> scheduleEveryHour() async {
    final scheduledDate = tz.TZDateTime.now(tz.local).add(const Duration(hours: 1));

    int id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    // 2. Định nghĩa nội dung thông báo
     NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'every_hour', // ID của Channel
        'every_hour', // Tên Channel
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: true,
        enableLights: true,
        color: Colors.blue,
        ledColor: Colors.blue,
        ledOnMs: 1000,
        ledOffMs: 500,
        autoCancel: true,
      ),
      iOS: DarwinNotificationDetails(presentBadge: true,
        presentAlert: true, // ✅ BẮT BUỘC để hiện alert
        presentSound: true, // ✅ BẮT BUỘC để phát âm báo),
      ));

    // 3. Lên lịch thông báo
    await _notificationsPlugin.zonedSchedule(
      id, // ID của thông báo
      'Thông báo mỗi Giờ 🔔',
      'Bạn có kế hoạch nào mới không',
      scheduledDate, // Thời gian (TZDateTime)
      notificationDetails,

      // Quan trọng: Báo cho Android chạy nền
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      //matchDateTimeComponents: DateTimeComponents.time,// 🔁 Lặp lại mỗi ngày cùng giờ
    );
  }


  // (Tùy chọn) Hủy thông báo
  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
    await _notificationsPlugin.cancelAll();
  }
  static Future<void> cancelNotificationAll() async {
    await _notificationsPlugin.cancelAll();
  }
}
// todo phải đặc ngoài class mới chạy được trên android background
@pragma('vm:entry-point')
void showAndroidTestAlarm() async {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(android: androidInit);
  await plugin.initialize(initSettings);

  const androidDetails = AndroidNotificationDetails(
    'test_id',
    'Thông báo Test',
    channelDescription: 'Thông báo Test',
    importance: Importance.max,
    priority: Priority.high,
  );
  final id = DateTime.now().millisecondsSinceEpoch.remainder(100000); // tạo id ngẫu nhiên
  await plugin.show(
    id,
    'Test Alarm',
    'Đã hiện thị thông báo test alarm',
    const NotificationDetails(android: androidDetails),
  );

  print("🔥 Test alarm triggered at ${DateTime.now()}");
}

@pragma('vm:entry-point')
void showMorningAlarm() async {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(android: androidInit);
  await plugin.initialize(initSettings);

  const androidDetails = AndroidNotificationDetails(
    'daily_morning_id',
    'Thông báo buổi sáng',
    channelDescription: 'Thông báo buổi sáng',
    importance: Importance.max,
    priority: Priority.high,
  );
  final id = DateTime.now().millisecondsSinceEpoch.remainder(100000); // tạo id ngẫu nhiên
  await plugin.show(
    id,
    'Have a nice day',
    'Tới giờ đi làm',
    const NotificationDetails(android: androidDetails),
  );

  print("🔥 Morning alarm triggered at ${DateTime.now()}");
}

@pragma('vm:entry-point')
void showEveningAlarm() async {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(android: androidInit);
  await plugin.initialize(initSettings);

  const androidDetails = AndroidNotificationDetails(
    'daily_evening_id',
    'Thông báo buổi tối',
    channelDescription: 'Thông báo buổi tối',
    importance: Importance.max,
    priority: Priority.high,
  );
  final id = DateTime.now().millisecondsSinceEpoch.remainder(100000); // tạo id ngẫu nhiên
  await plugin.show(
    id,
    'Good evening',
    'Bạn đã về đến nhà chưa!',
    const NotificationDetails(android: androidDetails),
  );

  print("🔥 Evening alarm triggered at ${DateTime.now()}");
}
