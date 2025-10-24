import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationController {
  late final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final GlobalKey<NavigatorState> navigatorKey;

  NotificationController({required this.navigatorKey}) {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  Future<void> initialize() async {
    // ✅ 1. Khởi tạo timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));

    // ✅ 2. Yêu cầu quyền thông báo
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // ✅ 3. Cấu hình khởi tạo
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    final darwinInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: (id, title, body, payload) async {
      //   // Bắt sự kiện khi thông báo được hiển thị foreground trên iOS
      //   debugPrint('📩 iOS Foreground Notification: $title');
      // },
    );

    var settings = InitializationSettings(
      android: androidInit,
      iOS: darwinInit,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );

    // ✅ 4. Log quyền
    final granted = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();
    debugPrint("🔔 Quyền thông báo (areNotificationsEnabled): $granted");
  }

  Future<void> _onDidReceiveNotificationResponse(
      NotificationResponse response) async {
    debugPrint('🔔 Notification clicked: ${response.payload}');
    // Nếu muốn điều hướng:
    // navigatorKey.currentState?.pushNamed('/target');
  }

  // ✅ Hiện thông báo ngay (cho test nhanh)
  Future<void> showNow({String? title, String? body}) async {
    const androidDetails = AndroidNotificationDetails(
      'instant_channel',
      'Instant Notifications',
      channelDescription: 'Thông báo hiển thị ngay',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const details =
    NotificationDetails(android: androidDetails, iOS: DarwinNotificationDetails());

    await _flutterLocalNotificationsPlugin.show(
      999,
      title ?? 'Thông báo test',
      body ?? 'Đây là thông báo hiện ngay',
      details,
    );
  }

  // ✅ Schedule sau X giây
  Future<void> scheduleInSeconds(int seconds) async {
    final scheduledDate =
    tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));

    const androidDetails = AndroidNotificationDetails(
      'test_channel_id',
      'Test Channel',
      channelDescription: 'Kênh test nhanh',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const details =
    NotificationDetails(android: androidDetails, iOS: DarwinNotificationDetails());

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      100,
      'Test notification',
      'Hiển thị sau $seconds giây',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      // androidAllowWhileIdle: true,
    );

    debugPrint('✅ scheduled test for: $scheduledDate');
  }

  // ✅ Lên lịch hàng ngày
  Future<void> scheduleDailyAt({
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'daily_channel_id',
      'Daily Notifications',
      channelDescription: 'Thông báo hằng ngày',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(presentAlert: true),
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Nhắc nhở hằng ngày',
      'Làm gì vào lúc này?',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      // uiLocalNotificationDateInterpretation:
      // UILocalNotificationDateInterpretation.absoluteTime,
      // androidAllowWhileIdle: true,
    );

    debugPrint("✅ Đã lên lịch thông báo hàng ngày lúc: $scheduledDate");
  }

  // ✅ Hủy toàn bộ
  Future<void> cancelAll() => _flutterLocalNotificationsPlugin.cancelAll();
}