import 'package:hankkitoktok/models/base_model.dart';

class OrderMini extends BaseModel{

  int orderID; //주문번호
  DateTime orderDate; // 주문닐짜
  String orderStatus; // 주문상태 (주문완료, 배송중, 배송완료)
  String orderType; // 주문타입 (일 결제, 주간 결제)
  int orderNumberDay; //주문횟수
  int orderNumberWeek; //주문횟수

  int washingService; // 세척서비스 횟수 (orderNumber 이하의 횟수)
  int washingServicePrice; // 세척서비스 가격
  int menuPrice; // 주문가격
  int deliveryPrice; // 배송비

  OrderMini(
      this.orderID,
      this.orderDate,
      this.orderStatus,
      this.orderType,
      this.orderNumberDay,
      this.orderNumberWeek,

      this.washingService,
      this.washingServicePrice,
      this.menuPrice,
      this.deliveryPrice,
      );
  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return OrderMini(
        map['orderID'],
        DateTime.parse(map['orderDate']),
        map['orderStatus'],
        map['orderType'],
        map['orderNumberDay'],
        map['orderNumberWeek'],

        map['washingService'],
        map['washingServicePrice'],
        map['menuPrice'],
        map['deliveryPrice'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'orderID': orderID,
      'orderDate': orderDate.toIso8601String(),
      'orderStatus': orderStatus,
      'orderType': orderType,
      'orderNumberDay': orderNumberDay,
      'orderNumberWeek': orderNumberWeek,

      'washingService': washingService,
      'washingServicePrice': washingServicePrice,
      'menuPrice': menuPrice,
      'deliveryPrice': deliveryPrice,
    };
  }

}

