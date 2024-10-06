import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'meal_delivery_order.dart';

enum DeliveryRequestMode {
  NEXT_DELIVERY,
  RECENT_DELIVERED_DELIVERY,
  DELVERING_DELIVERY,
  COMMON
}

enum DeliveryListRequestMode {
  BY_ORDER_ID,
  ALL
}

Future<List<MealDelivery>> networkGetDeliveryList(Map<String,dynamic> query, DeliveryListRequestMode deliveryListRequestMode)async{
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/api/v1/meal-deliveries${deliveryListRequestMode== DeliveryListRequestMode.BY_ORDER_ID ? '/order' : ''}');
  uri = uri.replace(queryParameters: query.map((key, value) => MapEntry(key, value.toString())));

  http.Response? response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    //'Authorization': 'Bearer $accessToken',
    'Access-token': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzNDYyOTM5LCJleHAiOjE3NDkzODI5Mzl9.rmDSuxTSfjJplWLm-v1AxKrz_-9jt8u5RJeC4q2JW38'
  };

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
      var responseBody;
      switch(deliveryListRequestMode)
      {
        case DeliveryListRequestMode.BY_ORDER_ID:
          responseBody = jsonDecode(utf8.decode(response.bodyBytes))['result'];
          break;
        case DeliveryListRequestMode.ALL:
          responseBody = jsonDecode(utf8.decode(response.bodyBytes))['result']['content'];
          break;

        default: throw Exception("잘못된 요청입니다.");
      }

      List<MealDelivery> result = [];



       for (var data in responseBody) {
         MealDelivery mealDelivery = MealDelivery.init();
          //Todo: mealDelivery 비정규화 필요?
         result.add(mealDelivery.fromMap(data));
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

Future<MealDelivery?> networkGetDelivery(Map<String,dynamic>? query, DeliveryRequestMode mode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';

  String uriString = "";

  switch(mode) {
    case DeliveryRequestMode.NEXT_DELIVERY:
      uriString = '$BASE_URL/api/v1/meal-deliveries/next-delivery';
      break;
    case DeliveryRequestMode.RECENT_DELIVERED_DELIVERY:
      uriString = '$BASE_URL/api/v1/meal-deliveries/delivered';
      uriString = '$BASE_URL/api/v1/meal-deliveries/delivering';
      break;
    case DeliveryRequestMode.DELVERING_DELIVERY:
      uriString = '$BASE_URL/api/v1/meal-deliveries/delivering';
      break;
    case DeliveryRequestMode.COMMON:
      uriString = '$BASE_URL/api/v1/meal-deliveries/${query!['mealDeliveryId']}';
      break;
  }

  Uri uri = Uri.parse(uriString);


  if (mode != DeliveryRequestMode.COMMON && query != null) {
    uri = uri.replace(queryParameters: query.map((key, value) => MapEntry(key, value.toString())));
  }

  http.Response? response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    //'Authorization': 'Bearer $accessToken',
    'Access-token': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzNDYyOTM5LCJleHAiOjE3NDkzODI5Mzl9.rmDSuxTSfjJplWLm-v1AxKrz_-9jt8u5RJeC4q2JW38'
  };

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
      print("mode: ${mode}, $responseBody}");
      MealDelivery result = MealDelivery.init();
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
