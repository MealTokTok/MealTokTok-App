import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../models/address/address.dart';
import '../models/address/address_data.dart';
import '../models/user/user.dart';

class UserController extends GetxController{
  User user = User.init();
  List<Address> addresses = [];
  int selectedAddressIndex = 0;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  void initAddresses()async {
    addresses = await addressGetList();
    update();
  }

  void setAddresses(List<Address> addresses){
    this.addresses = addresses;
    update();
  }

  void setUser(User user){
    this.user = user;
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
