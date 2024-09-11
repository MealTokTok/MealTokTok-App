import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/base_model.dart';

String BASE_URL = 'http://mealtoktok.p-e.kr';
enum RequestType { POST, PATCH, DELETE }

//POST, PATCH, DELETE 형식으로 요청을 받을 때
Future<bool> networkRequest(String detailUri,RequestType requestType, Map<String,dynamic> data) async { //Todo: body 추가, return값 추가
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/$detailUri');
  http.Response? response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    //'Authorization': 'Bearer $accessToken',
    'Access-token': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzNDYyOTM5LCJleHAiOjE3NDkzODI5Mzl9.rmDSuxTSfjJplWLm-v1AxKrz_-9jt8u5RJeC4q2JW38'

  };
  try{
    response = await httpResponse(uri, header, requestType, data);

    if(response == null){
      throw Exception('리스폰스가 null입니다.');
    }

    if (response.statusCode == 401) {
      // access token이 만료되었을 경우,
      await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await httpResponse(uri, header, requestType, data);
    }
    //응답이 없을 경우
    if(response==null){
      throw Exception('리스폰스가 null입니다.');
    }
    //요청에 성공했을 경우
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));

      //슬라이딩 토큰

      if(response.headers['access-token'] == null || response.headers['refresh-token'] == null){
        throw Exception('토큰이 없습니다.');
      }

      await prefs.setString("access_token", responseBody['access']);
      await prefs.setString("refresh_token", responseBody['refresh']);


      return true;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }catch(e){
    debugPrint("네트워크 요청에 실패했습니다: $e");
    return false;
  }
}

Future<http.Response>? httpResponse(Uri uri, Map<String,String> header, RequestType requestType, Map<String,dynamic> data){
  if(requestType == RequestType.POST){
    return http.post(uri, headers: header, body:jsonEncode(data));
  } else if(requestType == RequestType.PATCH){
    return http.patch(uri, headers: header, body:jsonEncode(data));
  } else if(requestType == RequestType.DELETE){
    return http.delete(uri, headers: header, body:jsonEncode(data));
  } else {
    return null;
  }
}

//GET 요청(상세조회)
Future<T> networkGetRequest<T extends BaseModel>(T model, String detailUri, Map<String, dynamic>? query) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';

  Uri uri = Uri.parse('$BASE_URL/$detailUri');

  if (query != null) {
    uri = uri.replace(queryParameters: query);
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
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      var responseHeader = response.headers;
      if (responseHeader['access-token'] == null || responseHeader['refresh-token'] == null) {
        throw Exception('토큰이 없습니다.');
      }
      // await prefs.setString("access_token", responseHeader['access-token']!); // Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseHeader['refresh-token']!); // Todo: 데이터 보고 교체
      return model.fromMap(responseBody) as T;
    } else {
      throw Exception(response.statusCode.toString());
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception("네트워크 요청에 실패했습니다: $e");
  }
}


//GET 요청(전체조회)
Future<List<T>> networkGetListRequest<T extends BaseModel>(T model,String detailUri, Map<String,dynamic>? query) async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  String accessToken = prefs.getString('access_token') ?? '';
  Uri uri = Uri.parse('$BASE_URL/$detailUri');

  if (query != null) {
    uri = uri.replace(queryParameters: query);
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
      header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
      response = await http.get(uri, headers: header);

      if (response == null) {
        throw Exception('리스폰스가 null입니다.');
      }
    }
    if(response.statusCode == 200){
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<T> result = [];
      for (var data in responseBody['result']) {
        // 매번 새로운 인스턴스를 생성하여 사용
        T newInstance = model.fromMap(data) as T;
        result.add(newInstance);
      }
      for(T data in result){
        print(data.toJson());
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

// 토큰 갱신
Future<void> tokenRefresh(SharedPreferences prefs) async {
  Uri uri = Uri.parse('$BASE_URL/'); //Todo: 토큰 리프레시 주소
  String refreshToken = prefs.getString('refresh_token') ?? '';
  var data = jsonEncode({
    'refresh': refreshToken,
  });
  http.Response response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data
  );


  if(response.statusCode==200){
    var responseBody = jsonDecode(response.body);
    //debugPrint(responseBody.toString());
    await prefs.setString("access_token", responseBody['access']);
    await prefs.setString("refresh_token", responseBody['refresh']);

  } else if(response.statusCode==401){
     //Todo: 로그인 페이지로 이동
  } else {
    //Todo: 에러코드 알림
  }

}


/////////////////////////////////////////////////////

//마스터 토큰용
Future<T> networkGetRequest111<T extends BaseModel>(T model, String detailUri, Map<String, dynamic>? query, ) async {
  //SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  //String accessToken = prefs.getString('access_token') ?? '';
  String accessToken ='Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzNDYyOTM5LCJleHAiOjE3NDkzODI5Mzl9.rmDSuxTSfjJplWLm-v1AxKrz_-9jt8u5RJeC4q2JW38';

  Uri uri = Uri.parse('$BASE_URL/$detailUri');
  // Todo:  아래 형식과 같이 만든 후에 쿼리 파라미터 자리로 넣어줘야 함
  //  Map<String, dynamic> queryParams = {
  //       'nickname': _nickname.text,
  //     };
  if (query != null) {
    uri = uri.replace(queryParameters: query);
  }

  http.Response? response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Access-Token': 'Bearer $accessToken',
  };

  try {
    response = await http.get(uri, headers: header);
    if (response == null) {
      throw Exception('리스폰스가 null입니다.');
    }

    // if (response.statusCode == 401) {
    //   // access token이 만료되었을 경우,
    //   await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    //   header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
    //   response = await http.get(uri, headers: header);
    //
    //   if (response == null) {
    //     throw Exception('리스폰스가 null입니다.');
    //   }
    // }
    if (response.statusCode == 200) {
      final jsonBody  = utf8.decode(response.bodyBytes);
      final  responseBody = json.decode(jsonBody);
      var responseHeader = response.headers;
      // if (responseHeader['access-token'] == null || responseHeader['refresh-token'] == null) {
      //   throw Exception('토큰이 없습니다.');
      // }
      // await prefs.setString("access_token", responseHeader['access-token']!); // Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseHeader['refresh-token']!); // Todo: 데이터 보고 교체
      debugPrint('Raw Response Body: $jsonBody');

      // 파싱된 JSON 데이터를 디버그 프린트로 출력
      debugPrint('Parsed JSON Body: $responseBody');
      return model.fromMap(responseBody['result']) as T;
    } else {
      throw Exception(response.statusCode.toString());
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception("네트워크 요청에 실패했습니다: $e");
  }
}


//마스터 토큰용(배송상태)
Future<int> networkGetRequest222(String detailUri, Map<String, dynamic>? query, ) async {
  //SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  //String accessToken = prefs.getString('access_token') ?? '';
  String accessToken ='Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzNDYyOTM5LCJleHAiOjE3NDkzODI5Mzl9.rmDSuxTSfjJplWLm-v1AxKrz_-9jt8u5RJeC4q2JW38';

  Uri uri = Uri.parse('$BASE_URL/$detailUri');
  // Todo:  아래 형식과 같이 만든 후에 쿼리 파라미터 자리로 넣어줘야 함
  //  Map<String, dynamic> queryParams = {
  //       'nickname': _nickname.text,
  //     };
  if (query != null) {
    uri = uri.replace(queryParameters: query);
  }

  http.Response? response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Access-Token': 'Bearer $accessToken',
  };

  try {
    response = await http.get(uri, headers: header);
    if (response == null) {
      throw Exception('리스폰스가 null입니다.');
    }

    // if (response.statusCode == 401) {
    //   // access token이 만료되었을 경우,
    //   await tokenRefresh(prefs); // refresh token으로 token을 refresh한 후 다시 요청
    //   header['Authorization'] = 'Bearer ${prefs.getString('access_token')}';
    //   response = await http.get(uri, headers: header);
    //
    //   if (response == null) {
    //     throw Exception('리스폰스가 null입니다.');
    //   }
    // }
    if (response.statusCode == 200) {
      final jsonBody  = utf8.decode(response.bodyBytes);
      final  responseBody = json.decode(jsonBody);
      var responseHeader = response.headers;
      // if (responseHeader['access-token'] == null || responseHeader['refresh-token'] == null) {
      //   throw Exception('토큰이 없습니다.');
      // }
      // await prefs.setString("access_token", responseHeader['access-token']!); // Todo: 데이터 보고 교체
      // await prefs.setString("refresh_token", responseHeader['refresh-token']!); // Todo: 데이터 보고 교체
      debugPrint('Raw Response Body: $jsonBody');

      // 파싱된 JSON 데이터를 디버그 프린트로 출력
      debugPrint('Parsed JSON Body: $responseBody');
      return responseBody['result'];
    } else {
      throw Exception(response.statusCode.toString());
    }
  } catch (e) {
    debugPrint(e.toString());
    throw Exception("네트워크 요청에 실패했습니다: $e");
  }
}
