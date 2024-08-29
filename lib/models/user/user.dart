import 'package:hankkitoktok/models/base_model.dart';

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