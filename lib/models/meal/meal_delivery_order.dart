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
    int mealDeliveryId = 0,
    String orderId = "",
    OrderType orderType = OrderType.IMMEDIATE,
    int mealId = 0,
    DateTime? reservedDate,
    Time reservedTime = Time.AFTERNOON,
    bool includeRice = false,
    bool hasFullDiningOption = false,
    DeliveryState deliveryState = DeliveryState.PENDING,
    DateTime? deliveryRequestTime,
    DateTime? deliveryStartTime,
    DateTime? deliveryCompleteTime,
    this.isChecked = false,
    this.isVisible = false,
  }) : super.init(
    mealDeliveryId: mealDeliveryId,
    orderId: orderId,
    orderType: orderType,
    mealId: mealId,
    reservedDate: reservedDate ?? DateTime.now(),
    // 기본값 처리
    reservedTime: reservedTime,
    includeRice: includeRice,
    hasFullDiningOption: hasFullDiningOption,
    deliveryState: deliveryState,
    deliveryRequestTime: deliveryRequestTime,
    deliveryStartTime: deliveryStartTime,
    deliveryCompleteTime: deliveryCompleteTime,
  );

  @override
  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if (reservedDate == null) {
      throw Exception('Ordered Meal 클래스: reservedDate가 null입니다.');
    }
    return {
      'mealId': meal.mealId,
      'reservedSchedule': {
        'reservedDate': formatter.format(reservedDate!),
        // DateTime을 String YYYY-MM-DD 로 변환
        'reservedTime': reservedTime
            .toString()
            .split('.')
            .last,
        // enum 을 String 으로 변환
      },
      'includeRice': includeRice,
      'hasFullDiningOption': hasFullDiningOption,
    };
  }
}
