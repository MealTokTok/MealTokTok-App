import 'package:intl/intl.dart';

import 'ordered_meal.dart';
import '../base_model.dart';
import '../enums.dart';

class MealDelivery extends BaseModel{
  int mealDeliveryId;
  String orderId;
  OrderedMeal orderedMeal;

  OrderState orderState;
  DeliveryState deliveryState;
  OrderType orderType;
  DateTime? orderTime;
  DateTime? deliveryRequestTime;
  DateTime? deliveryStartTime;
  DateTime? deliveryCompleteTime;

  MealDelivery.init({
    this.mealDeliveryId = 0,
    this.orderId = "",
    required this.orderedMeal,
    this.orderState = OrderState.ORDERED,
    this.deliveryState = DeliveryState.PENDING,
    this.orderType = OrderType.IMMEDIATE,
    this.orderTime,
    this.deliveryRequestTime,
    this.deliveryStartTime,
    this.deliveryCompleteTime,
  });

  @override
  MealDelivery fromMap(Map<String, dynamic> map) {
    return MealDelivery.init(
      mealDeliveryId: map['mealDeliveryId'],
      orderId: map['orderId'],
      orderedMeal: OrderedMeal.init(reservedDate: DateTime(0)).fromMap(map['orderedMeal']),
      orderState: OrderState.values.firstWhere(
          (e) => e.toString().split('.').last == map['orderState']),
      deliveryState: DeliveryState.values.firstWhere(
          (e) => e.toString().split('.').last == map['deliveryState']),
      orderType: OrderType.values.firstWhere(
          (e) => e.toString().split('.').last == map['orderType']),
      deliveryRequestTime: map['deliveryDateTime']['deliveryRequestTime'] == null ? null : DateTime.parse(map['deliveryDateTime']['deliveryRequestTime']),
      deliveryStartTime: map['deliveryDateTime']['deliveryStartTime'] == null ? null : DateTime.parse(map['deliveryDateTime']['deliveryStartTime']),
      deliveryCompleteTime: map['deliveryDateTime']['deliveryCompleteTime'] == null ? null : DateTime.parse(map['deliveryDateTime']['deliveryCompleteTime']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'mealDeliveryId': mealDeliveryId,
      'orderId': orderId,
      'orderedMeal': orderedMeal.toJson(),
      'orderState': orderState.toString().split('.').last,
      'deliveryState': deliveryState.toString().split('.').last,
      'deliveryDateTime': {
        'deliveryRequestTime': deliveryRequestTime.toString(),
        'deliveryStartTime': deliveryStartTime.toString(),
        'deliveryCompleteTime': deliveryCompleteTime.toString(),
      },
    };
  }

  String get simpleOrderDateString {
    if(orderTime == null) throw Exception('MealDelivery 클래스: orderTime이 null입니다.');
    return '${orderTime!.year}.${orderTime!.month}.${orderTime!.day}';
  }

  //7월 3일 수요일 - 점심
  String orderedReservedDateTimeString() {
    return "${orderedMeal.getDateString} ${orderedMeal.getDayOfWeekString}-${orderedMeal.getTimeString}";
  }

  String get getNextDeliveryString {
    return "다음 배송은 ${orderedMeal.getDateString} ${orderedMeal.getTimeString}";
  }

  String get getNextDeliveryMenuString {
    return "${orderedMeal.meal.name}입니다!";
  }

  String get getOrderTypeString {
    return orderType == OrderType.IMMEDIATE ? '일 결제' : '주간 결제';
  }


}