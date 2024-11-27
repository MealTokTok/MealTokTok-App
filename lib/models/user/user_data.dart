import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hankkitoktok/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../const/strings.dart';
import '../../mode.dart';

Future<User?> networkGetUser(int userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/v1/user/$userId');

  http.Response? response;
    Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken',
  };

  if(APP_MODE == AppMode.DEBUG){
    header = {
      'Content-Type': 'application/json',
      'Access-token': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzNDYyOTM5LCJleHAiOjE3NDkzODI5Mzl9.rmDSuxTSfjJplWLm-v1AxKrz_-9jt8u5RJeC4q2JW38'
    };
  }

  try {
    response = await http.get(uri, headers: header);
    if (response == null) {
      throw Exception('리스폰스가 null입니다.');
    }

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('refresh_token')}';
      response = await http.get(uri, headers: header);

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if(response.statusCode == 200){
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      User result = User.init();
      debugPrint(responseBody.toString());
      result = result.fromMap(responseBody['result']);
      // await prefs.setString("access_token", responseBody['access']); //Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseBody['refresh']); //Todo: 데이터 보고 교체
      return result;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }catch (e) {
    debugPrint(e.toString());
    return null;
  }
}


//로그인
Future<bool> login(String accessToken, String idToken, String deviceToken) async {
  Uri authUri = Uri.parse('$BASE_URL/api/v1/auth/oauth/login'); // HTTPS 사용 권장
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Map<String, String> queryParams = {
    'accessToken': accessToken,
    'idToken': idToken,
    'device-token': deviceToken,
  };

  try {
    http.Response authResponse = await http.get(
      authUri.replace(queryParameters: queryParams),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },

    );

    if (authResponse.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseHeader = authResponse.headers;
      var responseBody = jsonDecode(utf8.decode(authResponse.bodyBytes));
      debugPrint('성공');
      debugPrint(responseBody.toString());

      if(responseHeader['access-token']==null || responseHeader['refresh-token']==null){
        throw Exception('토큰이 없습니다.');
      }

      prefs.setString("access_token", responseHeader['access-token']!);
      prefs.setString("refresh_token", responseHeader['refresh-token']!);

      return true;


    } else {
      // 에러 처리
      var errorResponse = jsonDecode(utf8.decode(authResponse.bodyBytes));
      throw Exception('로그인 실패: ${errorResponse['responseCode']}');


    }
  } catch (e) {
    // 네트워크 요청 실패 시 처리
    debugPrint('Error making authentication request: $e');
    return false;
  }
}

//로그아웃
Future<bool> logout() async {
  try {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('access_token');
      prefs.remove('refresh_token');
    });
    return true;
  } catch (e) {
    debugPrint('로그아웃 실패: $e');
    return false;
  }
}

//Map을 String으로 변환
//테스트에만 사용
String mapToString(Map<String, String> map) {
  StringBuffer buffer = StringBuffer();
  map.forEach((key, value) {
    buffer.write('$key: $value\n');
  });
  return buffer.toString();
}

