import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/models/meal/ordered_meal.dart';
import 'package:hankkitoktok/models/enums.dart';

class Order extends BaseModel{
  int orderID; //주문번호
  OrderType orderType; // 주문타입 (일 결제, 주간 결제)
  OrderState? orderState; // 주문상태 (주문완료, 배송중, 배송완료)
  String specialInstruction; //요청사항

  int userId;
  int addressId; // 배송주소

  int mealPrice;
  int deliveryPrice;
  int fullServicePrice;
  int totalPrice;

  int totalMealDeliveryCount;
  int remainingMealDeliveryCount;

  DateTime? orderTime; // 주문닐짜


  late List<MealDelivery> mealDeliveries; // 주문한 도시락 리스트(주간 결제일 경우 2개이상, 일 결제일 경우 1개이상)

  Order.init({
    this.orderID = 0,
    this.orderType = OrderType.IMMEDIATE,
    this.orderState = OrderState.ORDERED,
    this.specialInstruction = '',
    this.userId = 0,
    this.addressId = 0,
    this.mealPrice = 0,
    this.deliveryPrice = 0,
    this.fullServicePrice = 0,
    this.totalPrice = 0,
    this.orderTime,
    this.totalMealDeliveryCount = 0,
    this.remainingMealDeliveryCount = 0,
  }){
    mealDeliveries = [];
  }


  @override
  Order fromMap(Map<String, dynamic> map) {
    return Order.init(
      orderID: _extractOrderId(map['orderId']),  // OrderId 객체 처리
      orderType: _getOrderType(map['orderType']),
      orderState: _getOrderState(map['orderState']),
      specialInstruction: map['specialInstruction'] ?? '',  // null 처리
      userId: map['orderer']?['userId'] ?? 0,  // null 처리
      mealPrice: map['orderPrice']?['mealPrice']?['amount'] ?? 0,
      deliveryPrice: map['orderPrice']?['deliveryPrice']?['amount'] ?? 0,
      fullServicePrice: map['orderPrice']?['fullServicePrice']?['amount'] ?? 0,
      totalPrice: map['orderPrice']?['totalPrice']?['amount'] ?? 0,
      orderTime: map['orderTime'] != null ? DateTime.parse(map['orderTime']) : null,
    );
  }

  int _extractOrderId(dynamic orderIdObj) {
    // OrderId 객체에서 값을 추출하는 로직
    if (orderIdObj is String) {
      // 혹시 orderId가 단순 문자열이라면 파싱
      return int.tryParse(orderIdObj) ?? 0;
    }
    // 다른 형태로 받는다면 적절한 변환 로직 추가
    // 기본값으로 0 반환
    return 0;
  }

  OrderType _getOrderType(String? orderTypeStr) {
    // Enum 변환에서 안전하게 처리
    return OrderType.values.firstWhere(
          (e) => e.toString().split('.').last == orderTypeStr,
      orElse: () => OrderType.IMMEDIATE,  // 기본값 설정
    );
  }

  OrderState? _getOrderState(String? orderStateStr) {
    // Enum 변환에서 안전하게 처리, null 허용
    if (orderStateStr == null) return null;
    return OrderState.values.firstWhere(
          (e) => e.toString().split('.').last == orderStateStr,
      orElse: () => OrderState.ORDERED,  // 기본값 설정
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
        'orderType': orderType.toString().split('.').last,
        //'orderedMeals' : mealDeliveries.map((e) => e.toJson()).toList(),

        'specialInstruction': specialInstruction,
        'orderPrice': {
          'mealPrice': {'amount': mealPrice},
          'deliveryPrice': {'amount': deliveryPrice},
          'fullServicePrice': {'amount': fullServicePrice},
          'totalPrice': {'amount': totalPrice},
        },


      'orderTime': orderTime.toString(),
      //'mealDeliveries': mealDeliveries.map((e) => e.toJson()).toList(),
    };
  }




  List<MealDetail> get combinedMenuList {
    List<MealDetail> mealDetails = [];
    for (var item in mealDeliveries) {
      mealDetails.add(item.orderedMeal.getMealDetail());
    }

    mealDetails.sort((a, b) => a.priority.compareTo(b.priority));

    return mealDetails;
  }

  //수, 금, 토
  String get dayOfWeekInitial {
    List<String> dayOfWeekList = ['일', '월', '화', '수', '목', '금', '토'];

    Set<String> initialsSet = Set<String>();

    for (var item in combinedMenuList) {
      initialsSet.add(dayOfWeekList[(item.priority)~/2]);
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
      '월요일',
      '화요일',
      '수요일',
      '목요일',
      '금요일',
      '토요일',
      '일요일'
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
