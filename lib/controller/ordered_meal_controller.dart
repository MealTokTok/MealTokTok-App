import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/meal_controller.dart';
import 'package:hankkitoktok/models/meal/ordered_meal.dart';
import 'package:hankkitoktok/models/enums.dart';

import '../models/meal/meal.dart';
class OrderedMealController extends GetxController {


  Map<DateTime, List<OrderedMeal>> orderedDayMeals = <DateTime, List<OrderedMeal>>{};
  Map<DateTime, List<OrderedMeal>> orderedWeekMeals = <DateTime, List<OrderedMeal>>{};

  int menuPriceDay() {
    int sum = 0;
    for (var orderedMeals in orderedDayMeals.values) {
      for (var orderedMeal in orderedMeals) {
        if(orderedMeal.isChecked == false) continue;

        sum += orderedMeal.meal.price;
        if(orderedMeal.includeRice) sum += 1000;
      }
    }
    return sum;
  }
  int menuPriceWeek(){
    int sum = 0;
    for (var orderedMeals in orderedWeekMeals.values) {
      for (var orderedMeal in orderedMeals) {
        if(orderedMeal.isChecked == false) continue;
        sum += orderedMeal.meal.price;
        if(orderedMeal.includeRice) sum += 1000;
      }
    }
    return sum;
  }

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

  void setMeals(){
    MealController mealController = Get.find();
    int defaultMealId = mealController.getMeals[0].mealId;
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
          reservedTime: Time.LUNCH,
          mealId: defaultMealId
      ));
      orderedWeekMeals[nextSunday]!.add(OrderedMeal.init(
          reservedDate: DateTime(
              nextSunday.year,nextSunday.month,nextSunday.day, 0, 0),
          reservedTime: Time.DINNER,
          mealId: defaultMealId
      ));
      nextSunday = nextSunday.add(const Duration(days: 1));
    }


    DateTime currentDay = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      0,
      0
    );

    orderedDayMeals[currentDay] = [];
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
        reservedDate: DateTime(
            currentDay.year, currentDay.month, currentDay.day, 0, 0),
        reservedTime: Time.LUNCH,
        isVisible: (DateTime.now().hour < 10) ? true : false,
        mealId: defaultMealId
    ));
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
        reservedDate: DateTime(
            currentDay.year, currentDay.month, currentDay.day, 0, 0),
        reservedTime: Time.DINNER,
        isVisible: (DateTime.now().hour < 16) ? true : false,
        mealId: defaultMealId
    ));

    currentDay = currentDay.add(const Duration(days: 1));
    orderedDayMeals[currentDay] = [];
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
      reservedDate: DateTime(currentDay.year, currentDay.month,
          currentDay.day + 1, 0, 0),
      reservedTime: Time.LUNCH,
      isVisible: true,
      mealId: defaultMealId
    ));
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
      reservedDate: DateTime(currentDay.year, currentDay.month,
          currentDay.day, 0, 0),
      reservedTime: Time.DINNER,
      isVisible: true,
      mealId: defaultMealId
    ));
    currentDay = currentDay.add(const Duration(days: 1));
    orderedDayMeals[currentDay] = [];
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
        reservedDate: DateTime(currentDay.year, currentDay.month,
            currentDay.day, 0, 0),
        reservedTime: Time.LUNCH,
        isVisible: (DateTime.now().hour < 16) ? false : true,
        mealId: defaultMealId
    ));
    orderedDayMeals[currentDay]!.add(OrderedMeal.init(
        reservedDate: DateTime(currentDay.year, currentDay.month,
            currentDay.day, 0, 0),
        reservedTime: Time.DINNER,
        isVisible: (DateTime.now().hour < 16) ? false : true,
        mealId: defaultMealId
    ));
    update();

  }

  void updateVisible(DateTime dateTime){
    for (var element in orderedWeekMeals[dateTime]!) {
      element.isVisible = !element.isVisible;
      if(element.isVisible == false){
        element.isChecked = false;
      }
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

  void updateMealById(OrderType orderType, DateTime dateTime, Time time, int mealId){
    MealController mealController = Get.find();
    if(orderType == OrderType.DAY_ORDER){
      for (var element in orderedDayMeals[dateTime]!) {
        if(element.reservedTime == time){
          element.meal = mealController.getMealByID(mealId);
          element.mealId = mealId;
        }
      }
    }
    else{
      for (var element in orderedWeekMeals[dateTime]!) {
        if(element.reservedTime == time){
          element.meal = mealController.getMealByID(mealId);
          element.mealId = mealId;
        }
      }
    }
    update();
  }

  List<OrderedMeal> getOrderedMealsSelected(OrderType orderType){
    List<OrderedMeal> result = [];
    if(orderType == OrderType.DAY_ORDER){
      for (var orderedMeals in orderedDayMeals.values) {
        for (var orderedMeal in orderedMeals) {
          if(orderedMeal.isChecked == true && orderedMeal.isVisible == true){
            result.add(orderedMeal);
          }
        }
      }
    }
    else{
      for (var orderedMeals in orderedWeekMeals.values) {
        for (var orderedMeal in orderedMeals) {
          if(orderedMeal.isChecked == true && orderedMeal.isVisible == true){
            result.add(orderedMeal);
          }
        }
      }
    }
    return result;
  }
}