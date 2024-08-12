import 'package:hankkitoktok/models/base_model.dart';

class User extends BaseModel{
  String? uid;
  String? email;
  String? name;
  String? photoUrl;
  String? provider;
  String? token;

  User({
    this.uid,
    this.email,
    this.name,
    this.photoUrl,
    this.provider,
    this.token,
  });

  User.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    name = map['name'];
    photoUrl = map['photoUrl'];
    provider = map['provider'];
    token = map['token'];
  }

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return User.fromMap(map);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'provider': provider,
      'token': token,
    };
  }
}