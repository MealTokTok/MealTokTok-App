import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/strings.dart';
import '../models/user/user.dart';
import 'package:hankkitoktok/mode.dart';

enum PaymentStatus {
  SUCCESS,
  FAIL,
}

Future<bool> paymentRequest(Map<String,dynamic> body, PaymentStatus paymentStatus) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  String uriString = '$BASE_URL/api/v1/payments/${paymentStatus == PaymentStatus.SUCCESS ? 'success' : 'fail'}';
  Uri uri = Uri.parse(uriString);

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
    response = await http.post(uri, headers: header, body: jsonEncode(body));
    if (response == null) {
      throw Exception('리스폰스가 null입니다.');
    }

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.post(uri, headers: header, body: jsonEncode(body));

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if(response.statusCode == 200){
      return true;
      // await prefs.setString("access_token", responseBody['access']); //Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseBody['refresh']); //Todo: 데이터 보고 교체
    } else {
      throw Exception(response.statusCode.toString());
    }
  }catch (e) {
    debugPrint(e.toString());
    return false;
  }
}