import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/0_login_screen.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/temporary_adress.dart';
import 'package:hankkitoktok/screen/2_home/0_home.dart';
import 'package:hankkitoktok/screen/2_home/1_home_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/0_meal_menu_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/0_set_meal_name_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_choice_menu_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/2_order_screen.dart';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'const/strings.dart';
import 'convention.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ...
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _initializeNotification()async{
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  var initialzationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  var initialzationSettingsIOS = DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid, iOS: initialzationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

}

void _notificationSetting(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    var androidNotiDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
    );
    var iOSNotiDetails = const DarwinNotificationDetails();
    var details =
    NotificationDetails(android: androidNotiDetails, iOS: iOSNotiDetails);
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        details,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print(message);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _initializeNotification();
  _notificationSetting();
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey:'c1eda5ec75bb843acef283b8b4a297f1',
    javaScriptAppKey: 'e0247dc88e43a60751fd39f8fc18459a',
 );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //logout카카오 로그아웃
  Future<void> logout() async {
    bool logoutSuccessful = false;

    try {
      await UserApi.instance.logout();
      logoutSuccessful = true;
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }

    // if(logoutSuccessful){
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (context)=>const LoginPage(),));
    // }

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PRIMARY_COLOR),
        useMaterial3: true,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
      ),
      getPages: [
        // 스크린 지정
        GetPage(
          name: '/',
          page: () => Home(),
        ),
        // GetPage(
        //   name: '/community',
        //   page: () => CommunityScreen(),
        // ),
      ],
      home: MealMenuScreen(),
    );
  }
}

