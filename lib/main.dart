import 'package:demo_local_notification/notification/notification_service.dart';
import 'package:demo_local_notification/screens/home_screen.dart';
import 'package:flutter/material.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
 // final NotificationController notificationController;
  const MyApp({super.key,});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      locale: Locale("vi", "VN"),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


