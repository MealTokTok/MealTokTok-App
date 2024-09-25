import 'package:intl/intl.dart';
import 'meal.dart';
import 'meal_data.dart';
import 'meal_delivery_order.dart';
import '../base_model.dart';
import '../enums.dart';

class MealDetail {
  String title;
  String subTitle;
  int mealPrice;
  int priority;

  MealDetail.init({
    this.title = '',
    this.subTitle = '',
    this.mealPrice = 0,
    this.priority = 0,
  });
}

class MealDelivery extends BaseModel{
  int mealDeliveryId;
  String orderId;
  OrderType orderType;
  int mealId;
  Meal meal = Meal.init();
  DateTime? reservedDate;
  Time reservedTime;
  DeliveryState deliveryState;
  bool includeRice;
  bool hasFullDiningOption;
  DateTime? deliveryRequestTime;
  DateTime? deliveryStartTime;
  DateTime? deliveryCompleteTime;
  DayOfWeek dayOfWeek = DayOfWeek.MONDAY;

  MealDelivery.init({
    this.mealDeliveryId = 0,
    this.orderId = "",
    this.orderType = OrderType.IMMEDIATE,
    this.mealId = 0,
    this.reservedDate,
    this.reservedTime = Time.AFTERNOON,
    this.deliveryState = DeliveryState.PENDING,
    this.includeRice = false,
    this.hasFullDiningOption = false,

    this.deliveryRequestTime,
    this.deliveryStartTime,
    this.deliveryCompleteTime,
  }){
    if(reservedDate != null){
      dayOfWeek = DayOfWeek.values[reservedDate!.weekday % 7];
    }
  }

  MealDelivery fromMap(Map<String, dynamic> map) {
    return MealDelivery.init(
      mealDeliveryId: map['mealDeliveryId'] ?? 0,
      orderId: map['orderId'] ?? "",
      orderType: OrderType.values.firstWhere(
              (e) => e.toString().split('.').last == map['orderType'],
          orElse: () => OrderType.IMMEDIATE), // orderType이 JSON에 없음
      mealId: map['orderedMeal']['mealId'] ?? 0,
      reservedDate: map['orderedMeal']['reservedSchedule']['reservedDate'] != null
          ? DateTime.parse(map['orderedMeal']['reservedSchedule']['reservedDate'])
          : null,
      reservedTime: map['orderedMeal']['reservedSchedule']['reservedTime'] != null
          ? Time.values.firstWhere((e) => e.toString().split('.').last == map['orderedMeal']['reservedSchedule']['reservedTime'])
          : Time.AFTERNOON,
      includeRice: map['orderedMeal']['includeRice'] ?? false,
      hasFullDiningOption: map['orderedMeal']['hasFullDiningOption'] ?? false,
      deliveryState: DeliveryState.values.firstWhere(
              (e) => e.toString().split('.').last == map['deliveryState'],
          orElse: () => DeliveryState.PENDING),
      deliveryRequestTime: map['deliveryDateTime']['deliveryRequestTime'] != null
          ? DateTime.parse(map['deliveryDateTime']['deliveryRequestTime'])
          : null,
      deliveryStartTime: map['deliveryDateTime']['deliveryStartTime'] != null
          ? DateTime.parse(map['deliveryDateTime']['deliveryStartTime'])
          : null,
      deliveryCompleteTime: map['deliveryDateTime']['deliveryCompleteTime'] != null
          ? DateTime.parse(map['deliveryDateTime']['deliveryCompleteTime'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'mealDeliveryId': mealDeliveryId,
      'orderId': orderId,
      'orderType': orderType.toString().split('.').last,
      'orderedMeal': {
        'mealId': mealId,
        'reservedDate': reservedDate.toString(),
        'reservedTime': reservedTime.toString().split('.').last,
      },
      'includeRice': includeRice,
      'hasFullDiningOption': hasFullDiningOption,
      'deliveryState': deliveryState.toString().split('.').last,
      'deliveryDateTime': {
        'deliveryRequestTime': deliveryRequestTime.toString(),
        'deliveryStartTime': deliveryStartTime.toString(),
        'deliveryCompleteTime': deliveryCompleteTime.toString(),
      },
    };
  }

  Future<void> setMeal() async {
    meal = await networkGetMeal(mealId);
  }

  // String get simpleOrderDateString {
  //   if(orderTime == null) throw Exception('MealDelivery 클래스: orderTime이 null입니다.');
  //   return '${orderTime!.year}.${orderTime!.month}.${orderTime!.day}';
  // }

  //2024-07-03
  String getDeliveryDateTimeString() {
    if(reservedDate == null){
      return "";
    }
    return "${reservedDate!.year}-${reservedDate!.month}-${reservedDate!.day}";
  }

  // 월요일-점심(도시락 이름)
  String get getMealString {
    if(reservedDate == null){
      return "";
    }
    // 월요일-점심 도시락 이름
    List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
    String dayOfWeekString = days[reservedDate!.weekday % 7];


    return "$dayOfWeekString-${reservedTime == Time.AFTERNOON ? '점심' : '저녁'}(${meal.name})";
  }
  //2024. 07. 03
  String get getDeliveryDateTimeStringByDot{
    if(reservedDate == null){
      return "";
    }
    return "${reservedDate!.year}. ${reservedDate!.month}. ${reservedDate!.day}";
  }

  //2024.07.03 - 점심
  String get getDeliveryDateTimeString2{
    if(reservedDate == null){
      return "";
    }
    return "${reservedDate!.year}.${reservedDate!.month}.${reservedDate!.day} - ${reservedTime == Time.AFTERNOON ? '점심' : '저녁'}";
  }

  //7월 3일
  String get getDateString {
    if(reservedDate == null){
      return "";
    }
    return "${reservedDate!.month}월 ${reservedDate!.day}일";
  }


  //수요일
  String get getDayOfWeekString {
    if(reservedDate == null){
      return "";
    }
    return DateFormat('EEEE','ko-KR').format(reservedDate!);
  }

  //잠심
  String get getTimeString{
    return reservedTime == Time.AFTERNOON ? '점심' : '저녁';
  }

  String get getMenuString {
    // 메뉴이름, 메뉴이름, 메뉴이름/햇반o
    return "${meal.getDishString()} /햇반 ${includeRice ? 'o' : 'x'}";
  }

  int get orderedMealPrice {
    int price = meal.price;
    if (includeRice) {
      price += 1000;
    }
    return price;
  }

  MealDetail getMealDetail() {
    int priority;
    if (reservedTime == Time.AFTERNOON) {
      priority = 0;
    } else {
      priority = 1;
    }

    priority += dayOfWeek.index * 2;



    return MealDetail.init(
      title: getMealString,
      subTitle: getMenuString,
      mealPrice: orderedMealPrice,
      priority: priority,
    );
  }

  String getDayOfWeek() {
    return dayOfWeek.toString().split('.').last;
  }

  //7월 3일 수요일 - 점심
  String orderedReservedDateTimeString() {
    return "${reservedDate!.month}월 ${reservedDate!.day}일 $getDayOfWeekString - $getTimeString";
  }

  // 다음 배송은 7월 3일 점심
  String get getNextDeliveryString {
    return "다음 배송은 ${DateFormat('M월 d일').format(reservedDate!)} $getTimeString";
  }

  //메뉴명 입니다!
  String get getNextDeliveryMenuString {
    return "${meal.name}입니다!";
  }

  String get getOrderTypeString {
    return orderType == OrderType.IMMEDIATE ? '일 결제' : '주간 결제';
  }

}