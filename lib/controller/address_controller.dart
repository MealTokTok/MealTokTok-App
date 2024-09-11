import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../models/address/address.dart';
import '../models/address/address_data.dart';
import '../models/user/user.dart';
import '../models/user/user_data.dart';

//주소정보: 앱 전역에 관리(메인 화면, 주문 화면에 필요)
//주소정보는 사용자가 여러개를 가질 수 있으므로 리스트로 관리
//실행되는 시점: 앱 시작 시
class AddressController extends GetxController{
  List<Address> addresses = [];
  int selectedAddressIndex = 0;

  //컨트롤러가 Put 되는 시점에 주소 정보 가져오기(앱 시작시 해당 생성자 실행)
  @override
  void onInit() async {
    // TODO: implement onInit
    await initAddresses();
    super.onInit();
  }

  Future<void> initAddresses()async {
    debugPrint('initAddresses');
    addresses = await addressGetList();
    update();
  }

  void setAddresses(List<Address> addresses){
    this.addresses = addresses;
    update();
  }

  void setSelectedAddressIndex(int index){
    selectedAddressIndex = index;
    update();
  }

  Address get getSelectedAddress{
    return addresses.isNotEmpty ? addresses[selectedAddressIndex] : Address.init();
  }

  List<String> get getAddressList{
    List<String> addressList = [];
    for(var address in addresses){
      addressList.add(address.address);
    }
    return addressList;
  }

}
