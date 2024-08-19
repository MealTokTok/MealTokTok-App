import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controller/meal_controller.dart';
import 'meal.dart';

class MealDetail {
  String title;
  String subTitle;
  int priority;

  MealDetail.init({
    this.title = '',
    this.subTitle = '',
    this.priority = 0,
  });
}

class OrderedMeal extends BaseModel {
  int mealId;
  late Meal meal;
  DateTime reservedDate;
  Time reservedTime;
  late DayOfWeek dayOfWeek;
  bool includeRice = false;
  bool hasFullDiningOption = false;

  bool isVisible = false;
  bool isChecked = false;

  OrderedMeal.init({
    this.mealId = 0,
    required this.reservedDate,
    this.reservedTime = Time.LUNCH,
    this.includeRice = false,
    this.hasFullDiningOption = false,
    this.isVisible = false,
  }) {
    meal = Meal.init();
    dayOfWeek = DayOfWeek.values[reservedDate.weekday % 7];
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
    return {
      'mealId': meal.mealId,
      'reservedSchedule': {
        'reservedDate': formatter.format(reservedDate),
        // DateTime을 String YYYY-MM-DD 로 변환
        'reservedTime': reservedTime.toString().split('.').last,
        // enum 을 String 으로 변환
      },
      'includeRice': includeRice,
      'hasFullDiningOption': hasFullDiningOption,
    };
  }

  Meal _mealIDtoMeal(int mealId) {
    final mealController = Get.find<MealController>();
    return mealController.getMealByID(mealId);

    return Meal.init();
  }

  String getDeliveryTime() {
    return "${reservedDate.year}-${reservedDate.month}-${reservedDate.day}";
  }

  String getMealString() {
    // 월요일-점심 도시락 이름
    return "$dayOfWeek-${reservedTime == Time.LUNCH ? '점심' : '저녁'} ${meal.name}";
  }

  String getMenuString() {
    // 메뉴이름, 메뉴이름, 메뉴이름/햇반o
    return "${meal.getDishString()} /햇반 ${includeRice ? 'o' : 'x'}";
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
      title: getMealString(),
      subTitle: getMenuString(),
      priority: priority,
    );
  }

  String getDayOfWeek() {
    return dayOfWeek.toString().split('.').last;
  }
}
