import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/enums.dart';
import '../meal/meal_delivery.dart';
import '../meal/meal_delivery_order.dart';

class OrderPost{
  int orderId;
  OrderType orderType;
  OrderState orderState;
  DateTime? orderTime;

  List<MealDeliveryOrder> mealDeliveryOrders = [];
  String specialInstruction = '';
  int mealPrice;
  int deliveryPrice;
  int fullServicePrice;
  int totalPrice;

  OrderPost.init({
    this.orderId = 0,
    this.orderType = OrderType.IMMEDIATE,
    this.orderState = OrderState.ORDERED,
    this.orderTime,
    required this.mealDeliveryOrders,
    this.specialInstruction = '',
    this.mealPrice = 0,
    this.deliveryPrice = 0,
    this.fullServicePrice = 0,
    this.totalPrice = 0,
  }){
    for(var mealDeliveryOrder in mealDeliveryOrders){
      mealPrice += mealDeliveryOrder.orderedMealPrice;
      if(mealDeliveryOrder.hasFullDiningOption){
        fullServicePrice += 2000;
      }
      deliveryPrice += 2000;
      //Todo: fullServicePrice 계산
    }
    totalPrice = mealPrice + deliveryPrice + fullServicePrice;
  }


  Map<String, dynamic> toJson() {
    return {
      'orderType': orderType.toString().split('.').last,
      'orderState': orderState.toString().split('.').last,
      'orderTime': orderTime.toString(),
      'orderedMeals': mealDeliveryOrders.map((e) => e.toJson()).toList(),
      'mealPrice': mealPrice,
      'deliveryPrice': deliveryPrice,
      'fullServicePrice': fullServicePrice,
      'totalPrice': totalPrice,
    };
  }

  List<MealDetail> get combinedMenuList {
    List<MealDetail> mealDetails = [];
    for (var item in mealDeliveryOrders) {
      mealDetails.add(item.getMealDetail());
    }

    mealDetails.sort((a, b) => a.priority.compareTo(b.priority));

    return mealDetails;
  }

  //수, 금, 토
  String get dayOfWeekInitial {
    List<String> dayOfWeekList = ['일', '월', '화', '수', '목', '금', '토'];

    Set<String> initialsSet = Set<String>();

    for (var item in combinedMenuList) {
      initialsSet.add("${item.date}일(${dayOfWeekList[(item.priority)~/2]})");
    }
    List<String> sortedInitials = initialsSet.toList();
    sortedInitials.sort((a, b) => dayOfWeekList.indexOf(a).compareTo(dayOfWeekList.indexOf(b)));
    return sortedInitials.join(', ');
  }

  //2024년 06월 29일 오후 14:20
  String get orderDateString {
    return '${orderTime!.year}년 ${orderTime!.month}월 ${orderTime!.day}일 ${orderTime!.hour}:${orderTime!.minute}';
  }
  //2024.06.29
  String get simpleOrderDateString {
    return '${orderTime!.year}.${orderTime!.month}.${orderTime!.day}';
  }

  // 월요일 - 저녁
  //수요일 - 점심, 저녁
  List<String> get getOrderTimeList {

    List<String> dayOfWeekList = [
      '일요일',
      '월요일',
      '화요일',
      '수요일',
      '목요일',
      '금요일',
      '토요일'
    ];

    List<int> dayOfWeekIndexList = [0,0,0,0,0,0,0];
    for (var item in combinedMenuList) {
      dayOfWeekIndexList[(item.priority)~/2] += 1;
      if(item.priority % 2 == 0){
        dayOfWeekIndexList[(item.priority)~/2] += 1;
      }
      else{
        dayOfWeekIndexList[(item.priority)~/2] += 2;
      }
    }

    List<String> dayOfWeekStringList = [];
    for(int i = 0; i < dayOfWeekIndexList.length; i++){
      if(dayOfWeekIndexList[i] == 0){
        continue;
      }
      String dayOfWeekString = dayOfWeekList[i];
      if(dayOfWeekIndexList[i] == 2){
        dayOfWeekString += ' 점심';
      }
      else if(dayOfWeekIndexList[i] == 3){
        dayOfWeekString += ' 저녁';
      }
      else{
        dayOfWeekString += ' 점심, 저녁';
      }
      dayOfWeekStringList.add(dayOfWeekString);
    }
    return dayOfWeekStringList;
  }

}
