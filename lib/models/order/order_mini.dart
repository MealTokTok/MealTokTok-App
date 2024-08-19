import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/enums.dart';

class OrderMini extends BaseModel{
  int orderId;
  OrderType orderType;
  OrderState orderState;
  DateTime orderTime;
  int mealPrice;
  int deliveryPrice;
  int fullServicePrice;
  int totalPrice;

  OrderMini.init({
    this.orderId = 0,
    this.orderType = OrderType.DAY_ORDER,
    this.orderState = OrderState.ORDERED,
    required this.orderTime,
    this.mealPrice = 0,
    this.deliveryPrice = 0,
    this.fullServicePrice = 0,
    this.totalPrice = 0,
  });

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return OrderMini.init(
      orderId: map['orderId'],
      orderType: OrderType.values.firstWhere(
          (e) => e.toString().split('.').last == map['orderType']),
      orderState: OrderState.values.firstWhere(
          (e) => e.toString().split('.').last == map['orderState']),
      orderTime: DateTime.parse(map['orderTime']),
      mealPrice: map['mealPrice'],
      deliveryPrice: map['deliveryPrice'],
      fullServicePrice: map['fullServicePrice'],
      totalPrice: map['totalPrice'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderType': orderType.toString().split('.').last,
      'orderState': orderState.toString().split('.').last,
      'orderTime': orderTime.toString(),
      'mealPrice': mealPrice,
      'deliveryPrice': deliveryPrice,
      'fullServicePrice': fullServicePrice,
      'totalPrice': totalPrice,
    };
  }



}
