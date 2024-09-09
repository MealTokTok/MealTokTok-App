import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controller/meal_controller.dart';
import '../../controller/tmpdata.dart';
import 'meal.dart';

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

class OrderedMeal extends BaseModel {
  int mealId;
  late Meal meal;
  DateTime? reservedDate;
  Time reservedTime;
  late DayOfWeek dayOfWeek;
  bool includeRice = false;
  bool hasFullDiningOption = false;

  bool isVisible = false;
  bool isChecked = false;

  OrderedMeal.init({
    this.mealId = 0,
    this.reservedDate,
    this.reservedTime = Time.LUNCH,
    this.includeRice = false,
    this.hasFullDiningOption = false,
    this.isVisible = false,
  }) {

    meal = getMealById(mealId);
    if(reservedDate == null){
      throw Exception('Ordered Meal 클래스: reservedDate가 null입니다.');
    }
    dayOfWeek = DayOfWeek.values[reservedDate!.weekday % 7];

  }

  @override
  OrderedMeal fromMap(Map<String, dynamic> map) {
    return OrderedMeal.init(
      mealId: map['mealId'],
      reservedDate: DateTime.parse(map['reservedSchedule']['reservedDate']),
      reservedTime: stringToTime(map['reservedSchedule']['reservedTime']),
      includeRice: map['includeRice'],
      hasFullDiningOption: map['hasFullDiningOption'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if(reservedDate == null){
      throw Exception('Ordered Meal 클래스: reservedDate가 null입니다.');
    }
    return {
      'mealId': meal.mealId,
      'reservedSchedule': {
        'reservedDate': formatter.format(reservedDate!),
        // DateTime을 String YYYY-MM-DD 로 변환
        'reservedTime': reservedTime.toString().split('.').last,
        // enum 을 String 으로 변환
      },
      'includeRice': includeRice,
      'hasFullDiningOption': hasFullDiningOption,
    };
  }

  String getDeliveryDateTimeString() {
    if(reservedDate == null){
      throw Exception('Ordered Meal 클래스: reservedDate가 null입니다.');
    }
    return "${reservedDate!.year}-${reservedDate!.month}-${reservedDate!.day}";
  }

  String get getMealString {
    // 월요일-점심 도시락 이름
    List<String> days = ['월', '화', '수', '목', '금', '토', '일'];
    String dayOfWeekString = days[reservedDate!.weekday % 7];


    return "$dayOfWeekString-${reservedTime == Time.LUNCH ? '점심' : '저녁'}(${meal.name})";
  }

  String get getDeliveryDateTimeString2{
    if(reservedDate == null){
      throw Exception('Ordered Meal 클래스: reservedDate가 null입니다.');
    }
    return "${reservedDate!.year}.${reservedDate!.month}.${reservedDate!.day} - ${reservedTime == Time.LUNCH ? '점심' : '저녁'}";
  }

  String get getDateString {
    return "${reservedDate!.year}월 ${reservedDate!.month}일";
  }

  String get getDayOfWeekString {
    return DateFormat('EEEE','ko-KR').format(reservedDate!);
  }

  String get getTimeString{
    return reservedTime == Time.LUNCH ? '점심' : '저녁';
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
    if (reservedTime == Time.LUNCH) {
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
}
