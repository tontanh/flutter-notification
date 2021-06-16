import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_alert/screen.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification({n,v, flp}) async {
  var android = AndroidNotificationDetails(
      'owlMall_id_001', 'owlMall name', 'owl alert detail',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(0, '$n', '$v', platform, payload: '\n $v');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher,
      isInDebugMode:
          false); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager().registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(seconds: 1), //when should it check the link
      initialDelay:
          Duration(seconds: 2), //duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
        // requiresBatteryNotLow: true,
        // requiresCharging: true,
        // requiresDeviceIdle: true,
        // requiresStorageNotLow: true
      ));
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettlings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initSettlings);

    var url = Uri.parse("https://api.tonserver.cf/public/api/read/lastid.php");
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
    var id = responseJson['id'];
    String email= responseJson['email'];
     String name= responseJson['name'];
    var urlSet = Uri.parse("https://api.tonserver.cf/public/api/read/update.php?id=$id&see=1");
    final response = await http.get(urlSet);
    showNotification(n: '$name',v: '$email', flp: flp);


      print("no messgae");
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter notification',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: ScreenPage()));
  }
}
