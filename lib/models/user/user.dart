// import 'package:hankkitoktok/models/base_model.dart';
//
// class User extends BaseModel{
//   String? uid;
//   String? email;
//   String? name;
//   String? photoUrl;
//   String? provider;
//   String? token;
//
//   User({
//     this.uid,
//     this.email,
//     this.name,
//     this.photoUrl,
//     this.provider,
//     this.token,
//   });
//
//   User.fromMap(Map<String, dynamic> map) {
//     uid = map['uid'];
//     email = map['email'];
//     name = map['name'];
//     photoUrl = map['photoUrl'];
//     provider = map['provider'];
//     token = map['token'];
//   }
//
//   @override
//   BaseModel fromMap(Map<String, dynamic> map) {
//     return User.fromMap(map);
//   }
//
//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'email': email,
//       'name': name,
//       'photoUrl': photoUrl,
//       'provider': provider,
//       'token': token,
//     };
//   }
// }
//////////////////////////////////////////////////////////////////////////////
// class User {
//    int? userId;
//    String? username;
//    String? nickname;
//    String? email;
//    String? phoneNumber;
//    String? profileImageUrl;
//    String? birth;
//
//   User({
//      this.userId,
//      this.username,
//      this.nickname,
//      this.email,
//      this.phoneNumber,
//      this.profileImageUrl,
//      this.birth,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userId: json['userId'],
//       username: json['username'],
//       nickname: json['nickname'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       profileImageUrl: json['profileImageUrl'],
//       birth: json['birth'],
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/strings.dart';
import 'package:hankkitoktok/models/base_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Define a User class to map the JSON response
class User extends BaseModel{
  int userId;
  String username;
  String nickname;
  String email;
  String phoneNumber;
  String profileImageUrl;
  DateTime? birth;
  String token;

  User.init({
    this.userId = 0,
    this.username = '',
    this.nickname = '',
    this.email = '',
    this.phoneNumber = '',
    this.profileImageUrl = '',
    this.birth,
    this.token = '',
  });

  @override
  User fromMap(Map<String, dynamic> map) {
    return User.init(
      userId: map['uid'],
      username: map['username'],
      nickname: map['nickname'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profileImageUrl: map['profileImageUrl'],
      birth: map['birth'],
      token: map['token'],
    );
  }



  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': userId,
      'username': username,
      'nickname': nickname,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'birth': birth,
      'token': token,

    };
  }
}

class IsAvailable extends BaseModel{
  final bool isAvailable;

  IsAvailable({
    required this.isAvailable,
  });

  factory IsAvailable.fromJson(Map<String, dynamic> json) {
    return IsAvailable(
      isAvailable: json['isAvailable'] ?? false,

    );
  }

  @override
  IsAvailable fromMap(Map<String, dynamic> map) {
    return IsAvailable.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'isAvailable': isAvailable,
    };
  }
}



//사용자 정보 get

Future<User> getUser() async {
  //SharedPreferences prefs = await SharedPreferences.getInstance(); // 저장소
  //String accessToken = prefs.getString('access_token') ?? '';

  Uri uri = Uri.parse('$BASE_URL/api/v1/user/my');

  // if (query != null) {
  //   uri = uri.replace(queryParameters: query);
  // }

  http.Response? response;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Access-token':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwiaWF0IjoxNzIzNDYyOTM5LCJleHAiOjE3NDkzODI5Mzl9.rmDSuxTSfjJplWLm-v1AxKrz_-9jt8u5RJeC4q2JW38',
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
      // if (responseHeader['access-token'] == null ||
      //     responseHeader['refresh-token'] == null) {
      //   throw Exception('토큰이 없습니다.');
      // }
      //return User.fromJson(responseBody['result']);
      debugPrint('Raw Response Body: $jsonBody');

      // 파싱된 JSON 데이터를 디버그 프린트로 출력
      debugPrint('Parsed JSON Body: $responseBody');
      User user = User.init();
      return user.fromMap(responseBody['result']);

      //return User.fromJson(responseBody);
    } else {
      throw Exception(response.statusCode.toString());
    }
  } catch (e) {
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
  http.Response response = await http.post(uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data);

  if (response.statusCode == 200) {
    var responseBody = jsonDecode(response.body);
    //debugPrint(responseBody.toString());
    await prefs.setString("access_token", responseBody['access']);
    await prefs.setString("refresh_token", responseBody['refresh']);
  } else if (response.statusCode == 401) {
    //Todo: 로그인 페이지로 이동
  } else {
    //Todo: 에러코드 알림
  }
}
