import 'ordered_meal.dart';
import '../base_model.dart';
import '../enums.dart';

class MealDelivery extends BaseModel{
  int mealDeliveryId;
  int orderId;
  OrderedMeal orderedMeal;

  OrderState orderState;
  DateTime? deliveryStartTime;
  DateTime? deliveryCompleteTime;
  MealDelivery.init({
    this.mealDeliveryId = 0,
    this.orderId = 0,
    required this.orderedMeal,
    this.orderState = OrderState.ORDERED,
    this.deliveryStartTime,
    this.deliveryCompleteTime,
  });

  @override
  MealDelivery fromMap(Map<String, dynamic> map) {
    return MealDelivery.init(
      mealDeliveryId: map['mealDeliveryId'],
      orderId: map['orderId'],
      orderedMeal: OrderedMeal.init(mealId: 0, reservedDate: DateTime(0), reservedTime: Time.LUNCH).fromMap(map['orderedMeal']),
      orderState: OrderState.values.firstWhere(
          (e) => e.toString().split('.').last == map['orderState']),
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
      'deliveryDateTime': {
        'deliveryStartTime': deliveryStartTime.toString(),
        'deliveryCompleteTime': deliveryCompleteTime.toString(),
      },
    };
  }

}