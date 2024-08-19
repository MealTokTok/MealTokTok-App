import 'package:hankkitoktok/models/base_model.dart';

class OrderUser extends BaseModel {
  int userId;
  String username;
  String phoneNumber;

  OrderUser.init({
    this.userId = 0,
    this.username = "",
    this.phoneNumber = "",
  });

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return OrderUser.init(
      userId: map['userId'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }
}