import 'package:intl/intl.dart';
import 'meal.dart';
import 'meal_data.dart';
import 'meal_delivery_order.dart';
import '../base_model.dart';
import '../enums.dart';

enum SeparatorType {
  HYPHEN,
  DOT,
  KOREAN,
}

// 날짜, 시간을 정렬해서 표시하기위한 클래스
class MealDetail {
  String title;
  String subTitle;
  int mealPrice;
  int priority;
  int date;

  MealDetail.init({
    this.title = '',
    this.subTitle = '',
    this.mealPrice = 0,
    this.priority = 0,
    this.date = 0,
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

  // separatorType : 구분자 타입
  // year : 년도 표시 여부
  // time : 시간 표시 여부
  // dayOfWeek : 요일 표시 여부
  String getReservedDate(SeparatorType separatorType, bool year, bool time, bool dayOfWeek){
    String res = '';
    if(reservedDate == null){
      return "";
    }
    if(year){
      res += "${reservedDate!.year}";
    }
    switch(separatorType){
      case SeparatorType.HYPHEN:
        res += "-";
        break;
      case SeparatorType.DOT:
        res += ".";
        break;
      case SeparatorType.KOREAN:
        res += "년 ";
        break;
    }
    res += "${reservedDate!.month}";
    switch(separatorType){
      case SeparatorType.HYPHEN:
        res += "-";
        break;
      case SeparatorType.DOT:
        res += ".";
        break;
      case SeparatorType.KOREAN:
        res += "월 ";
        break;
    }
    res += "${reservedDate!.day}";
    if(separatorType == SeparatorType.KOREAN){
      res += "일 ";
    }
    if(time){
      res += " - ${reservedTime == Time.AFTERNOON ? '점심' : '저녁'}";
    }
    if(dayOfWeek){
      res += DateFormat('EEEE','ko-KR').format(reservedDate!);
    }
    return res;
  }



  // 월요일-점심(도시락 이름)
  String get getMealString {
    if(reservedDate == null){
      return "";
    }
    // 월-점심 도시락 이름
    List<String> days = ['일', '월', '화', '수', '목', '금', '토'];
    String dayOfWeekString = days[reservedDate!.weekday % 7];


    return "$dayOfWeekString-${reservedTime == Time.AFTERNOON ? '점심' : '저녁'}(${meal.mealName})";
  }

  String get getMenuString {
    // 메뉴이름, 메뉴이름, 메뉴이름/햇반o
    return "${meal.getDishString()} /햇반 ${includeRice ? 'o' : 'x'}";
  }

  int get orderedMealPrice {
    int price = meal.mealPrice;
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
    int date = 0;
    if(reservedDate!=null){
      date = reservedDate!.day;
    }
    priority += dayOfWeek.index * 2;


    return MealDetail.init(
      title: getMealString,
      subTitle: getMenuString,
      mealPrice: orderedMealPrice,
      priority: priority,
      date: date,
    );
  }

  String getDayOfWeek() {
    return dayOfWeek.toString().split('.').last;
  }


  //메뉴명 입니다!
  String get getNextDeliveryMenuString {
    return "${meal.mealName}입니다!";
  }

  String get getOrderTypeString {
    return orderType == OrderType.IMMEDIATE ? '일 결제' : '주간 결제';
  }

}