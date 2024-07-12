import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/screen/2_home/0_home_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/0_set_meal_name_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_choice_menu_screen.dart';

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'const/strings.dart';
import 'convention.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: YOUR_NATIVE_APP_KEY,
    javaScriptAppKey: YOUR_JAVASCRIPT_APP_KEY,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
      ),
      getPages: [
        // 스크린 지정
        // GetPage(
        //   name: '/',
        //   page: () => Home1Screen(),
        // ),
        // GetPage(
        //   name: '/community',
        //   page: () => CommunityScreen(),
        // ),
      ],
      home: SetMealNameScreen(),
    );
  }
}

//test
