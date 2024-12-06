import 'dart:convert';
import 'package:hankkitoktok/const/strings.dart';
import 'package:hankkitoktok/models/user/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//회원가입
Future<bool> signUp(String address, double latitude, double longitude,
    String accessToken, String idToken, String deviceToken) async {
  try {
    Uri uri = Uri.parse('$BASE_URL/api/v1/auth/oauth/sign-up');
    Map<String, dynamic> requestData = {
      "oAuthTokens": {
        "accessToken": accessToken,
        "idToken": idToken,
      },
      "deviceToken": deviceToken,
    };

    http.Response response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Access-token': 'Bearer $accessToken',
      }, //여기는 엑세스 토큰 안 넣어줘도 되나?
      body: requestData,
    );
    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));

      //응답 예외처리
      if (responseBody['responseCode'] != "SUCCESS") {
        throw Exception('회원가입 실패: ${responseBody['responseCode']}');
      }
      debugPrint(response.headers.toString());
      debugPrint(responseBody.toString());
      await prefs.setString(
          "access_token", response.headers['access-token'] ?? "");
      await prefs.setString(
          "refresh_token", response.headers['refresh-token'] ?? "");

      return true;

      //회원가입 성공하면 로그인 진행
      //await login(accessToken, idToken, deviceToken);
    } else {
      // 에러 처리
      throw Exception('회원가입 실패: ${response.statusCode}');
    }
  } catch (e) {
    // 네트워크 요청 실패 시 처리
    debugPrint('네트워크 요청 실패: $e');
    return false;
  }
}

//등록된 유저인지 확인
Future<bool> getIsUser(String idToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소

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
      debugPrint(responseBody.toString());
      debugPrint('200');
      return true;
    } else {
      throw ('Error: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Request failed: $e');
    return false;
  }
}

//로그인
Future<bool> login(
    String accessToken, String idToken, String deviceToken) async {
  Uri authUri = Uri.parse('$BASE_URL/api/v1/auth/oauth/login'); // HTTPS 사용 권장
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Map<String, dynamic> queryParams = {
  //   'oAuthTokens': {
  //     "accessToken": accessToken,
  //     "idToken": idToken,
  //   },
  //   'device-token': deviceToken,
  // };

  try {
    http.Response authResponse = await http.get(
      authUri.replace(queryParameters: {
        'accessToken': accessToken,
        'idToken': idToken,
        'device-token': deviceToken,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Access-token': 'Bearer $accessToken',
      },
    );

    if (authResponse.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseHeader = authResponse.headers;
      var responseBody = jsonDecode(utf8.decode(authResponse.bodyBytes));
      debugPrint('성공');
      debugPrint(responseBody.toString());

      if (responseHeader['access-token'] == null ||
          responseHeader['refresh-token'] == null) {
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

//Map을 String으로 변환
//테스트에만 사용
String mapToString(Map<String, String> map) {
  StringBuffer buffer = StringBuffer();
  map.forEach((key, value) {
    buffer.write('$key: $value\n');
  });
  return buffer.toString();
}
