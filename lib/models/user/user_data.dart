import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//회원가입
Future<void> signUp(String address, double latitude, double longitude,
    String accessToken, String idToken, String deviceToken) async {
  try {
    Uri uri = Uri.parse('$BASE_URL/api/v1/auth/oauth/sign-up');
    var data = jsonEncode({
      "oAuthTokens": {
        'accessToken': accessToken,
        'idToken': idToken,
      },
      'deviceToken': deviceToken,
      'addressInfo': {
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      },
    });

    http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: data,
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));

      //prefs.setString("access_token", responseBody['token']['access']);
      //prefs.setString("refresh_token", responseBody['token']['refresh']);

      debugPrint(responseBody.toString());

      //회원가입 성공하면 로그인 진행
      await login(accessToken, idToken, deviceToken);

    } else {
      // 에러 처리
      debugPrint('인증 실패: ${response.body}');
      debugPrint('Error: ${response.statusCode}');
    }
  } catch (e) {
    // 네트워크 요청 실패 시 처리
    debugPrint('네트워크 요청 실패: $e');
  }
}

// Future<bool> getIsUser(String idToken) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
//
//   String accessToken = prefs.getString('access_token') ?? '';
//   Uri uri = Uri.parse('$BASE_URL/api/v1/auth/oauth/can-sign-up');
//   http.Response response;
//   Map<String, String> header = {
//     'Content-Type': 'application/json',
//     'idToken': '$idToken',
//   };
//   response = await http.get(uri, headers: header);
//
//   if (response.statusCode == 401) {
//     // access token이 만료되었을 경우,
//     await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
//     bool serviceUser = await getIsUser(idToken);
//     debugPrint('401111111111111');
//
//     return serviceUser;
//   } else if (response.statusCode == 400) {
//     // access token이 invalid할 경우
//     debugPrint(response.body);
//     debugPrint('400000000000');
//   }
//   //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
//   if (response.statusCode == 200) {
//     var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
//     return responseBody.result;
//   } else {
//     debugPrint(response.statusCode.toString());
//     debugPrint('2222222222200');
//     return false;
//   }
// }

//등록된 유저인지 확인
Future<bool> getIsUser(String idToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';

  Uri uri =
      Uri.parse('$BASE_URL/api/v1/auth/oauth/can-sign-up?idToken=$idToken');

  try {
    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      // await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      // bool serviceUser = await getIsUser(idToken);
      debugPrint('Error: 401');

      return false;
    } else if (response.statusCode == 400) {
      // access token이 invalid할 경우
      debugPrint(response.body);
      debugPrint('Error: 400');
      return false;

    }
    //401: 토큰 만료, 400: 인증 에러, 200: 성공, else: 나머지 에러
    else if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint('200');
      return true;
    } else {
      debugPrint('Error: ${response.statusCode}');
      return false;
    }
  } catch (e) {
      debugPrint('Request failed: $e');
      return false;
  }
}


// Future<void> tokenRefresh(SharedPreferences prefs) async {
//   Uri uri = Uri.parse('$BASE_URL/api/token/refresh/');
//   String refreshToken = prefs.getString('refresh_token') ?? '';
//   // {
//   //   "refresh": "enskagharktjaslkyhrselkygjdslkures;atawekjrhlsrj;egahejorv"
//   // }
//   var data = jsonEncode({
//     'refresh': refreshToken,
//   });
//
//   http.Response refreshResponse = await http.post(uri, headers: {
//     'Content-Type': 'application/json',
//   });
//   var responseBody = jsonDecode(refreshResponse.body);
//   await prefs.setString("access_token", responseBody['token']['access']);
//   await prefs.setString("refresh_token", responseBody['token']['refresh']);
// }


//로그인
Future<void> login(String accessToken, String idToken, String deviceToken) async {
  Uri authUri = Uri.parse('$BASE_URL/api/v1/auth/oauth/login'); // HTTPS 사용 권장
  var queryParams = {
    'oAuthTokens': jsonEncode({
      'accessToken': accessToken,
      'idToken': idToken,
    }),
    'device-token': deviceToken,
  };

  try {
    http.Response authResponse = await http.post(
      authUri.replace(queryParameters: queryParams),
      headers: {'Content-Type': 'application/json'},
    );

    if (authResponse.statusCode == 200) {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseBody = jsonDecode(authResponse.body);
      debugPrint('성공');
      // json web token를 활용하여 access_token, refresh_token을 로컬 스토리지에 저장
      //prefs.setString("access_token", responseBody['token']['access']);
      //prefs.setString("refresh_token", responseBody['token']['refresh']);

      //String? accessToken = prefs.getString("access_token");
      // 유저 데이터 맵을 클래스로 변환
      // ServiceUser serviceUser = await getServiceUser();
      // MyInfo myInfo = Get.find();
      // myInfo.setMyInfo(serviceUser);

      // if(serviceUser.user_name==''){ // 유저네임이 없을 경우 랜덤 생성
      //   Uri uri = Uri.parse('https://nickname.hwanmoo.kr/?format=json&count=15');
      //   http.Response response = await http.get(uri); //TODO: 랜덤 이름 생성기. 추후 자체서버 구현 필요
      //   String username = 'invalid user';
      //   for (String word in jsonDecode(response.body)['words']) {
      //     if (word.length < 10) username = word;
      //   }
      //   DateTime now = await NTP.now();
      //   String nowString = now.toIso8601String();
      //   http.Response patchUser = await http.patch(uri,body:{"user_name":username, "updated_at": nowString});
      //   if(patchUser.statusCode == 400);
      // }
    } else {
      // 에러 처리
      debugPrint('Authentication failed: ${authResponse.body}');
      debugPrint('${authResponse.statusCode}');
    }
  } catch (e) {
    // 네트워크 요청 실패 시 처리
    debugPrint('Error making authentication request: $e');
  }
}
