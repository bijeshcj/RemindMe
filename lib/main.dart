import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remind_me/screens/add_reminder_screen.dart';
import 'package:remind_me/widgets/home_reminder_list.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

Future<void> main() async{
  // initAlarmManager();
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();
  runApp(const MyApp());
}

// initAlarmManager() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Initialize timezone
//   tz.initializeTimeZones();
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   // Initialize the plugin
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   const IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings(
//     requestAlertPermission: true,
//     requestBadgePermission: true,
//     requestSoundPermission: true,
//   );
//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onSelectNotification: (String? payload) async {
//       // Handle notification tapped event here
//     },
//   );
// }

// Future<void> scheduleAlarm(
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'alarm_notification_channel',
//     'Alarm Notification Channel',
//     'Channel for alarms',
//     icon: '@mipmap/ic_launcher',
//     sound: RawResourceAndroidNotificationSound('alarm_sound'),
//     largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
//   );
//
//   const IOSNotificationDetails iOSPlatformChannelSpecifics =
//       IOSNotificationDetails(
//     sound: 'alarm_sound.aiff',
//   );
//
//   const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);
//
//   // Replace the scheduled time with your desired alarm time
//   final DateTime scheduledTime = DateTime.now().add(const Duration(seconds: 5));
//
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0, // ID for the notification
//     'Alarm',
//     'Wake up!',
//     tz.TZDateTime.from(scheduledTime, tz.local), // scheduled time
//     platformChannelSpecifics,
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Remind me'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // scheduleAlarm(flutterLocalNotificationsPlugin);
  }

  void _openReminderScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddReminder()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const HomeReminderList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddReminder()));
        },
        tooltip: 'Add Reminder',
        child: const Icon(Icons.add),
      ),
    );
  }
}
