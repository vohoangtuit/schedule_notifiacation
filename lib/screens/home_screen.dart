import 'package:demo_local_notification/notification/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Guidebook notification:')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ElevatedButton(
              child:Text('Schedule Notifications'),
              onPressed: (){
                _setup();
              },
            )

          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }
  void _init()async{
     await NotificationService.checkPending();
  }
  void _setup()async{
    await NotificationService.cancelNotificationAll();
   // await NotificationService.scheduleRepeatEvery5Minutes();
    //await NotificationService.scheduleEveryHour();
   // await NotificationService.showNow();
     await NotificationService.scheduleDailyMorning();
     await NotificationService.scheduleDailyEvening();
   // showToast("Đã lên lịch thông báo 1");
     //  NotificationService.checkPending();
  }
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      fontSize: 15.0,
    );
  }
}
