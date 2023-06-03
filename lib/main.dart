// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nabt_oman/BottomPart.dart';
import 'package:nabt_oman/Data/nabt_model.dart';


import 'Data/DatabaseHelper.dart';
import 'Data/app_info_list.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // if (nabtList.isNotEmpty){
  //   DatabaseHelper.createDataFirebaseRealtimeWithUniqueID("Nabt", nabtList);
  // }else{
  //   print("Data connot therefore be saved into Firebase");
  // }
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
  final InitializationSettings initializationSettings= InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NABT Oman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomPart(
            onUpdatePlant: (Plant, bool){},
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
