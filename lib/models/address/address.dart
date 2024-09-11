import 'package:hankkitoktok/models/base_model.dart';

enum AddressStatus{
  CONFIGURED
}

class Address extends BaseModel{

  int deliveryAddressId;
  String address;
  String detailAddress;
  AddressStatus addressStatus;
  double? latitude;
  double? longitude;
  bool visible = true;

  Address.init({
    this.deliveryAddressId = 0,
    this.address = '',
    this.detailAddress = '',
    this.addressStatus = AddressStatus.CONFIGURED,
    this.latitude,
    this.longitude,
  });

  @override
  Address fromMap(Map<String, dynamic> map) {
    deliveryAddressId = map['deliveryAddressId'] ?? 0;
    address = map['address']['address'] ?? '';
    detailAddress = map['address']['detailAddress'] ?? '';
    addressStatus = AddressStatus.values.firstWhere(
          (e) => e.toString().split('.').last == map['addressStatus'],
      orElse: () => AddressStatus.CONFIGURED,
    );
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': {
        'address': address,
        'detailAddress': detailAddress,
      },
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  String get getAddressString {
    return '$address $detailAddress';
  }

  void setVisible(bool value){
    visible = value;
  }
}