import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/user/user.dart';
import '../models/user/user_data.dart';

//주소정보: 앱 전역에 관리(주문 화면, 마이 페이지에 필요)
//실행되는 시점: 앱 시작 시
class UserController extends GetxController{
  late User user;

  //컨트롤러가 Put 되는 시점에 사용자 정보 가져오기(앱 시작시 해당 생성자 실행)
  @override
  void onInit() async {
    // TODO: implement onInit
    await initUser();

    super.onInit();
  }

  //네트워크 요정으로 사용자 정보 가져오기
  Future<void> initUser()async {
    user = await networkGetUser() ?? User.init();
    if(user != null){
      debugPrint('initUser: ${user!.username}');
    }
    update();
  }

  void setUser(User user){
    this.user = user;
    update();
  }

}
