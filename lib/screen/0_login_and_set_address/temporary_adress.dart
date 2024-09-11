import 'dart:convert';
import 'package:hankkitoktok/const/strings.dart';
import 'package:hankkitoktok/screen/2_home/1_home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/models/user/auth_data.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../2_home/0_home.dart';

class TemporaryAddress extends StatefulWidget {
  // OAuthToken token;
  // TemporaryAdress({required this.token, super.key});
  //이부분 받아서 받은 데이터 넣어주기
  String socialAccessToken;
  String socialIdToken;
  TemporaryAddress({
    required this.socialAccessToken,
    required this.socialIdToken,

    super.key});

  @override
  State<TemporaryAddress> createState() => _TemporaryAdressState();
}

class _TemporaryAdressState extends State<TemporaryAddress> {
  String address= '충청북도 청주시 흥덕구 충대로 1';
  double latitude = 36.6298968;
  double longitude = 127.4534557;
  late String accessToken;
  late String idToken;
  late String deviceToken;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    getUDID();
    accessToken = widget.socialAccessToken;
    idToken = widget.socialIdToken;
    print('accessToken: $accessToken');
    print('idToken: $idToken');

  }
  void getUDID() async {
    deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint(deviceToken ?? 'null');
  }

  bool isUser=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("주소 페이지 입니다."),
            ElevatedButton(onPressed: () async{
              isUser=await getIsUser(idToken);
              if(isUser==true){
                debugPrint('유저ㅇㅇ');
                await login(accessToken, idToken, deviceToken);
              }
              else{
                debugPrint('유저ㄴㄴ');
                //회원가입 성공(200)하면 로그인 api요청되도록 구현함
                await signUp(address, latitude, longitude, accessToken, idToken, deviceToken);
              }
            }, child: Text('유저인지 확인하기+로그인+회원가입')),
            ElevatedButton(onPressed: () async{
              isUser=await getIsUser(idToken);
              if(isUser==true){
                debugPrint('유저ㅇㅇ');
                debugPrint('{$accessToken}');
                debugPrint('{$idToken}');
              }
              else{
                debugPrint('유저ㄴㄴ');
              }
            }, child: Text('유저인지 확인하기')),
            ElevatedButton(onPressed: () async{
              bool signUpStatus = await signUp(address, latitude, longitude, accessToken, idToken, deviceToken);
              if(signUpStatus){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return  Home();
                    },
                  ),
                      (route) => false,
                );
              }
              else{
                debugPrint('회원가입 실패');
              }
            }, child: Text('회원가입')),

            ElevatedButton(onPressed: () async{
              bool loginStatus = await login(accessToken, idToken, deviceToken);
              if(loginStatus){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Home();
                    },
                  ),
                      (route) => false,
                );
              }
              else{
                debugPrint('실패');
              }
            }, child: Text('로그인')),
          ],
        ),
      ),
    );
  }
}
