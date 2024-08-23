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

  int mealPrice;
  int deliveryPrice;
  int fullServicePrice;
  int totalPrice;

  DateTime orderTime; // 주문닐짜
  String address; // 배송주소

  List<MealDelivery> mealDeliveries; // 주문한 도시락 리스트(주간 결제일 경우 2개이상, 일 결제일 경우 1개이상)

  Order.init({
    this.orderID = 0,
    this.orderType = OrderType.DAY_ORDER,
    this.orderState = OrderState.ORDERED,
    this.specialInstruction = '',
    this.userId = 0,
    this.mealPrice = 0,
    this.deliveryPrice = 0,
    this.fullServicePrice = 0,
    this.totalPrice = 0,
    required this.orderTime,
    this.address = '',
    this.mealDeliveries = const [],
  });


  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    List<MealDelivery> mealDeliveries = [];
    OrderedMeal orderedMeal = OrderedMeal.init(reservedDate: DateTime(0));
    for(var item in map['mealDeliveries']){
      mealDeliveries.add(MealDelivery.init(orderedMeal: orderedMeal).fromMap(item));
    }
    return Order.init(
      orderID: map['order']['orderID'],
      orderType: OrderType.values.firstWhere(
          (e) => e.toString().split('.').last == map['order']['orderType']),
      orderState: OrderState.values.firstWhere(
          (e) => e.toString().split('.').last == map['order']['orderState']),
      specialInstruction: map['order']['specialInstruction'],
      userId: map['order']['orderer']['userId'],
      mealPrice: map['order']['orderPrice']['mealPrice']['amount'],
      deliveryPrice: map['order']['orderPrice']['deliveryPrice']['amount'],
      fullServicePrice: map['order']['orderPrice']['fullServicePrice']['amount'],
      totalPrice: map['order']['orderPrice']['totalPrice']['amount'],
      orderTime: DateTime.parse(map['order']['orderTime']),
      mealDeliveries: mealDeliveries,
    );

  }

  @override
  Map<String, dynamic> toJson() {
    return {
        'orderType': orderType.toString().split('.').last,
        'orderedMeals' : mealDeliveries.map((e) => e.toJson()).toList(),

        'specialInstruction': specialInstruction,
        'orderPrice': {
          'mealPrice': {'amount': mealPrice},
          'deliveryPrice': {'amount': deliveryPrice},
          'fullServicePrice': {'amount': fullServicePrice},
          'totalPrice': {'amount': totalPrice},
        },
      'orderTime': orderTime.toString(),
      'mealDeliveries': mealDeliveries.map((e) => e.toJson()).toList(),
    };
  }


  List<MealDetail> get orderedMealList {
    List<MealDetail> mealDetails = [];
    for (var item in mealDeliveries) {
      mealDetails.add(MealDetail.init(
          title: item.orderedMeal.getMealString(), subTitle: item.orderedMeal.getMenuString()));
    }

    mealDetails.sort((a, b) => a.title.compareTo(b.title));

    return mealDetails;
  }
  //수, 금, 토
  String get dayOfWeekInitial {
    List<String> dayOfWeekList = ['일', '월', '화', '수', '목', '금', '토'];

    Set<String> initialsSet = Set<String>();

    for (var item in orderedMealList) {
      initialsSet.add(dayOfWeekList[(item.priority)~/2]);
    }
    List<String> sortedInitials = initialsSet.toList()..sort();
    return sortedInitials.join(', ');
  }

  List<MealDetail> getCombinedMenuList() {
    List<MealDetail> mealDetails = [];
    for (var item in mealDeliveries) {
      mealDetails.add(MealDetail.init(
          title: item.orderedMeal.getMealString(), subTitle: item.orderedMeal.getMenuString()));
    }

    mealDetails.sort((a, b) => a.priority.compareTo(b.priority));

    return mealDetails;
  }

  //2024년 06월 29일 오후 14:20
  String get orderDateString {
    return '${orderTime.year}년 ${orderTime.month}월 ${orderTime.day}일 ${orderTime.hour}:${orderTime.minute}';
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
    for (var item in orderedMealList) {
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
