import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/models/meal/ordered_meal.dart';
import 'package:hankkitoktok/models/enums.dart';
class OrderedMealController extends GetxController {


  Map<DateTime, List<OrderedMeal>> orderedDayMeals = <DateTime, List<OrderedMeal>>{};
  Map<DateTime, List<OrderedMeal>> orderedWeekMeals = <DateTime, List<OrderedMeal>>{};

  List<DateTime> get orderedDayKeys{
    List<DateTime> keys = orderedDayMeals.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    return keys;
  }

  List<DateTime> get orderedWeekKeys{
    List<DateTime> keys = orderedWeekMeals.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    return keys;
  }

  @override
  void onInit() {
    setMeals();
    super.onInit();
  }

  void setMeals(){

    DateTime nextSunday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: 7 - DateTime.now().weekday));


    for(int i=0;i<7;i++){
      orderedWeekMeals[nextSunday] = [];
      orderedWeekMeals[nextSunday]!.add(OrderedMeal.init(
          reservedDate: DateTime(
              nextSunday.year,nextSunday.month,nextSunday.day, 0, 0),
          reservedTime: Time.LUNCH
      ));
      orderedWeekMeals[nextSunday]!.add(OrderedMeal.init(
          reservedDate: DateTime(
              nextSunday.year,nextSunday.month,nextSunday.day, 0, 0),
          reservedTime: Time.DINNER
      ));
      nextSunday = nextSunday.add(const Duration(days: 1));
    }


    DateTime currentDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    orderedDayMeals[currentDay] = [];
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
        reservedDate: DateTime(
            currentDay.year, currentDay.month, currentDay.day, 0, 0),
        reservedTime: Time.LUNCH,
        isVisible: true
    ));
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
        reservedDate: DateTime(
            currentDay.year, currentDay.month, currentDay.day, 0, 0),
        reservedTime: Time.DINNER,
        isVisible: true
    ));

    currentDay = currentDay.add(const Duration(days: 1));
    orderedDayMeals[currentDay] = [];
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
      reservedDate: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 0, 0),
      reservedTime: Time.LUNCH,
      isVisible: true
    ));
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
      reservedDate: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day + 1, 0, 0),
      reservedTime: Time.DINNER,
      isVisible: true
    ));
    update();

  }

  void updateVisible(DateTime dateTime){
    for (var element in orderedWeekMeals[dateTime]!) {
      element.isVisible = !element.isVisible;
    }
    update();
  }

  void updateChecked(OrderType orderType, DateTime dateTime, Time time){
    if(orderType == OrderType.DAY_ORDER){
      for (var element in orderedDayMeals[dateTime]!) {
        if(element.reservedTime == time){
          element.isChecked = !element.isChecked;
        }
      }
    }
    else{
      for (var element in orderedWeekMeals[dateTime]!) {
        if(element.reservedTime == time){
          element.isChecked = !element.isChecked;
        }
      }
    }
    update();
  }

  void updateRice(OrderType orderType, DateTime dateTime, Time time){
    if(orderType == OrderType.DAY_ORDER){
      for (var element in orderedDayMeals[dateTime]!) {
        if(element.reservedTime == time){
          element.includeRice = !element.includeRice;
        }
      }
    }
    else{
      for (var element in orderedWeekMeals[dateTime]!) {
        if(element.reservedTime == time){
          element.includeRice = !element.includeRice;
        }
      }
    }
    update();
  }

}