import 'dart:convert';
import 'package:hankkitoktok/const/strings.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/models/user/user_data.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class TemporaryAddress extends StatefulWidget {
  // OAuthToken token;
  // TemporaryAdress({required this.token, super.key});
  //이부분 받아서 받은 데이터 넣어주기
  const TemporaryAddress({super.key});

  @override
  State<TemporaryAddress> createState() => _TemporaryAdressState();
}

class _TemporaryAdressState extends State<TemporaryAddress> {
  String address= '충청북도 청주시 흥덕구 충대로 1';
  double latitude = 36.6298968;
  double longitude = 127.4534557;
  String accessToken='d4iuHfe73n8ecfLxsnnpiF22nr59j20sAAAAAQorDKgAAAGQ-GPYvKbXH4eeWQ3B';
  String idToken= 'eyJraWQiOiI5ZjI1MmRhZGQ1ZjIzM2Y5M2QyZmE1MjhkMTJmZWEiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJjMWVkYTVlYzc1YmI4NDNhY2VmMjgzYjhiNGEyOTdmMSIsInN1YiI6IjM2NDExMDU2MDEiLCJhdXRoX3RpbWUiOjE3MjIxNTQyMTEsImlzcyI6Imh0dHBzOi8va2F1dGgua2FrYW8uY29tIiwibmlja25hbWUiOiLrsJXsiJzsmIEiLCJleHAiOjE3MjIxOTc0MTEsImlhdCI6MTcyMjE1NDIxMSwicGljdHVyZSI6Imh0dHBzOi8vdDEua2FrYW9jZG4ubmV0L2FjY291bnRfaW1hZ2VzL2RlZmF1bHRfcHJvZmlsZS5qcGVnLnR3Zy50aHVtYi5SMTEweDExMCJ9.HsITUDBbNT6fLrjCJaxdZHdQ3aVJHLb02XO6A4Qn3Vi7gZcBa5RYkDm3uzhufOBaZo99RAQOMWCRJ2t6zdoPRRJ_lWs1sVolRxU_wE6eetLLp18t9lcLkfI-URLwW7FI33aJvNra6C7KcEWLEA0BfkDEq4Uwka0n4GzXMmbX_OR-_2WvHKZw1cwVjVPDRFfsGH205K3f_hSSQnZmULDGPzfi2MJPqlKzm7r8w5yZAdOfwd-DMhg6nZonBzFeVJD0BwUyL4lJdU16NMj6PSqrqhDpi53N31owhh11woFc-1X20TibHSr_hFtOaZ3b_RTfo25PoU28lXaHo_7UYh4fKQ';

  String deviceToken ='sfdfdfdfsff';
  void getUDID() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint(fcmToken ?? 'null');
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
              }
              else{
                debugPrint('유저ㄴㄴ');
              }
            }, child: Text('유저인지 확인하기')),
            ElevatedButton(onPressed: () async{
              await signUp(address, latitude, longitude, accessToken, idToken, deviceToken);
            }, child: Text('회원가입')),

            ElevatedButton(onPressed: () async{
              await login(accessToken, idToken, deviceToken);
            }, child: Text('로그인')),
          ],
        ),
      ),
    );
  }
}
