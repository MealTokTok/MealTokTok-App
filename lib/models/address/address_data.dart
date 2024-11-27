import 'dart:convert';
import 'package:hankkitoktok/models/address/address.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';

import '../../mode.dart';

enum RequestType { POST, PATCH, DELETE }


Future<List<Address>> addressGetList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/v1/user/my/addresses');


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
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if(response.statusCode == 200){
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<Address> result = [];
      print(responseBody['result']);
      for(var data in responseBody['result']){
        Address address = Address.init();
        result.add(address.fromMap(data));
      }
      // await prefs.setString("access_token", responseBody['access']); //Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseBody['refresh']); //Todo: 데이터 보고 교체
      return result;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }catch (e) {
    debugPrint(e.toString());
    throw Exception("네트워크 요청에 실패했습니다: $e");
  }
}

Future<Address> networkGetAddress(int addressId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/v1/user/my/addresses/$addressId');


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
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if(response.statusCode == 200){
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print("responseBody: $responseBody['result']");
      // await prefs.setString("access_token", responseBody['access']); //Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseBody['refresh']); //Todo: 데이터 보고 교체
      return Address.init().fromMap(responseBody['result']);
    } else {
      throw Exception(response.statusCode.toString());
    }
  }catch (e) {
    debugPrint(e.toString());
    throw Exception("네트워크 요청에 실패했습니다: $e");
  }
}

Future<bool> networkDeleteAddress(int addressId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/v1/user/my/addresses/$addressId');


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
    response = await http.delete(uri, headers: header);
    if (response == null) {
      throw Exception('리스폰스가 null입니다.');
    }

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if(response.statusCode == 200){
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      bool result = responseBody['result']['value'] == 1 ? true : false;
      // await prefs.setString("access_token", responseBody['access']); //Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseBody['refresh']); //Todo: 데이터 보고 교체
      return result;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }catch (e) {
    debugPrint("네트워크 요청에 실패했습니다: $e");
    return false;
  }
}


// 기본배송지 설정
Future<bool> networkPatchAddress(int addressId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/v1/user/my/addresses/$addressId');


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
    response = await http.patch(uri, headers: header);
    if (response == null) {
      throw Exception('리스폰스가 null입니다.');
    }

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if(response.statusCode == 200){
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      bool result = responseBody['result']['value'] == 1 ? true : false;
      // await prefs.setString("access_token", responseBody['access']); //Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseBody['refresh']); //Todo: 데이터 보고 교체
      return result;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }catch (e) {
    debugPrint("네트워크 요청에 실패했습니다: $e");
    return false;
  }
}