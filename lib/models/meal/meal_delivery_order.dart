import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controller/meal_controller.dart';
import '../../controller/tmpdata.dart';
import 'meal.dart';
import 'meal_delivery.dart';



class MealDeliveryOrder extends MealDelivery {

  bool isVisible = false;
  bool isChecked = false;

  MealDeliveryOrder.init({
    mealDeliveryId = 0,
    orderId = "",
    orderType = OrderType.IMMEDIATE,
    mealId = 0,
    reservedDate,
    reservedTime = Time.AFTERNOON,
    includeRice = false,
    hasFullDiningOption = false,
    deliveryState = DeliveryState.PENDING,

    deliveryRequestTime,
    deliveryStartTime,
    deliveryCompleteTime,
    this.isChecked = false,
    this.isVisible = false,
  }) : super.init(
    mealDeliveryId: mealDeliveryId,
    orderId: orderId,
    orderType: orderType,
    mealId: mealId,
    reservedDate: reservedDate,
    reservedTime: reservedTime,
    deliveryState: deliveryState,
    includeRice: includeRice,
    hasFullDiningOption: hasFullDiningOption,
    deliveryRequestTime: deliveryRequestTime,
    deliveryStartTime: deliveryStartTime,
    deliveryCompleteTime: deliveryCompleteTime,
  );

  @override
  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if(reservedDate == null){
      throw Exception('Ordered Meal 클래스: reservedDate가 null입니다.');
    }
    return {
      'mealId': meal.mealId,
      'reservedSchedule': {
        'reservedDate': formatter.format(reservedDate!),// DateTime을 String YYYY-MM-DD 로 변환
        'reservedTime': reservedTime.toString().split('.').last,
        // enum 을 String 으로 변환
      },
      'includeRice': includeRice,
      'hasFullDiningOption': hasFullDiningOption,
    };
  }
}
