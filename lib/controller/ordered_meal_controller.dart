import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/meal_controller.dart';
import 'package:hankkitoktok/models/meal/meal_delivery_order.dart';
import 'package:hankkitoktok/models/enums.dart';

import '../models/meal/meal.dart';
import '../models/meal/meal_delivery.dart';
import '../models/order/order.dart';
import '../models/order/order_post.dart';
class OrderedMealController extends GetxController {


  Map<DateTime, List<MealDeliveryOrder>> orderedDayMeals = <DateTime, List<MealDeliveryOrder>>{};
  Map<DateTime, List<MealDeliveryOrder>> orderedWeekMeals = <DateTime, List<MealDeliveryOrder>>{};


  bool getSelectedDate(DateTime day) {
    return orderedWeekMeals[
        day.subtract(const Duration(hours: 9)).toLocal()] !=
        null &&
        orderedWeekMeals[
        day.subtract(const Duration(hours: 9)).toLocal()]![0]
            .isVisible &&
            orderedWeekMeals[
        day.subtract(const Duration(hours: 9)).toLocal()]![1]
            .isVisible;
  }

  int menuPriceDay() {
    int sum = 0;
    for (var orderedMeals in orderedDayMeals.values) {
      for (var orderedMeal in orderedMeals) {
        if(orderedMeal.isChecked == false) continue;

        sum += orderedMeal.meal.mealPrice;
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
        sum += orderedMeal.meal.mealPrice;
        if(orderedMeal.includeRice) sum += 1000;
        if(orderedMeal.hasFullDiningOption) sum += 2000;
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
      orderedWeekMeals[nextSunday]!.add(MealDeliveryOrder.init(
          reservedDate: DateTime(
              nextSunday.year,nextSunday.month,nextSunday.day, 0, 0),
          reservedTime: Time.AFTERNOON,
          mealId: defaultMealId
      ));
      orderedWeekMeals[nextSunday]!.add(MealDeliveryOrder.init(
          reservedDate: DateTime(
              nextSunday.year,nextSunday.month,nextSunday.day, 0, 0),
          reservedTime: Time.EVENING,
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
    orderedDayMeals[currentDay]!.add(MealDeliveryOrder.init(
        reservedDate: DateTime(
            currentDay.year, currentDay.month, currentDay.day, 0, 0),
        reservedTime: Time.AFTERNOON,
        isVisible: (DateTime.now().hour < 10) ? true : false,
        mealId: defaultMealId
    ));
    orderedDayMeals[currentDay]!.add(MealDeliveryOrder.init(
        reservedDate: DateTime(
            currentDay.year, currentDay.month, currentDay.day, 0, 0),
        reservedTime: Time.EVENING,
        isVisible: (DateTime.now().hour < 16) ? true : false,
        mealId: defaultMealId
    ));

    currentDay = currentDay.add(const Duration(days: 1));
    orderedDayMeals[currentDay] = [];
    orderedDayMeals[currentDay]!.add(MealDeliveryOrder.init(
      reservedDate: DateTime(currentDay.year, currentDay.month,
          currentDay.day + 1, 0, 0),
      reservedTime: Time.AFTERNOON,
      isVisible: true,
      mealId: defaultMealId
    ));
    orderedDayMeals[currentDay]!.add(MealDeliveryOrder.init(
      reservedDate: DateTime(currentDay.year, currentDay.month,
          currentDay.day, 0, 0),
      reservedTime: Time.EVENING,
      isVisible: true,
      mealId: defaultMealId
    ));
    currentDay = currentDay.add(const Duration(days: 1));
    orderedDayMeals[currentDay] = [];
    orderedDayMeals[currentDay]!.add(MealDeliveryOrder.init(
        reservedDate: DateTime(currentDay.year, currentDay.month,
            currentDay.day, 0, 0),
        reservedTime: Time.AFTERNOON,
        isVisible: (DateTime.now().hour < 16) ? false : true,
        mealId: defaultMealId
    ));
    orderedDayMeals[currentDay]!.add(MealDeliveryOrder.init(
        reservedDate: DateTime(currentDay.year, currentDay.month,
            currentDay.day, 0, 0),
        reservedTime: Time.EVENING,
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

  //메뉴션택 업데이트
  void updateChecked(OrderType orderType, DateTime dateTime, Time time){
    if(orderType == OrderType.IMMEDIATE){
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

  //풀서비스 업데이트
  void updateFullServiceSelected(OrderType orderType)
  {
      for (var element in orderedWeekMeals.values) {
        for (var orderedMeal in element) {
          if(orderedMeal.isChecked == true){
            orderedMeal.hasFullDiningOption = !orderedMeal.hasFullDiningOption;
          }
        }
      }
    update();
  }

  // 풀서비스 선택 여부
  bool getFullServiceSelected(){
    if(orderedWeekMeals.isEmpty) return false;
    //선택한 메뉴 모두가 풀대접 서비스를 받는 경우 true, 아니면 false 반환
    for (var element in orderedWeekMeals.values) {
      for (var orderedMeal in element) {
        if(orderedMeal.isChecked == true && orderedMeal.hasFullDiningOption == false){
          return false;
        }
      }
    }
    return true;
  }

  void updateRice(OrderType orderType, DateTime dateTime, Time time){
    if(orderType == OrderType.IMMEDIATE){
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
    if(orderType == OrderType.IMMEDIATE){
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


  //주문내역 요일 반환 (월요일, 수요일, 목요일) 형식
  String getFullDiningDaysOfWeek(){

    //요일을 문자열로 저장
    List<String> dayOfWeekList = [
      '월요일',
      '화요일',
      '수요일',
      '목요일',
      '금요일',
      '토요일',
      '일요일'
    ];

    //최종 문자열
    String result = '';

    //선택한 요일을 저장할 Set
    //Set을 선택한 이유: 중복제거
    Set<String> initialsSet = Set<String>();

    for (var orderedMeals in orderedWeekMeals.values) {
      for (var orderedMeal in orderedMeals) {
        if(orderedMeal.isChecked == true && orderedMeal.isVisible == true){
          initialsSet.add(dayOfWeekList[orderedMeal.reservedDate!.weekday - 1]);
        }
      }
    }
    // Set을 List로 변환
    List<String> sortedInitials = initialsSet.toList();
    //Set은 순서가 없기 때문에 따로 정렬 필요
    sortedInitials.sort((a, b) => dayOfWeekList.indexOf(a).compareTo(dayOfWeekList.indexOf(b)));


    //List<String>["월요일", "수요일", "목요일"] -> String 월요일, 수요일, 목요일
    return sortedInitials.join(', ');

  }

  int getCntFullDiningDaysOfWeek(){
    List<String> dayOfWeekList = [
      '월요일',
      '화요일',
      '수요일',
      '목요일',
      '금요일',
      '토요일',
      '일요일'
    ];
    Set<String> initialsSet = Set<String>();

    for (var orderedMeals in orderedWeekMeals.values) {
      for (var orderedMeal in orderedMeals) {
        if(orderedMeal.isChecked == true && orderedMeal.isVisible == true){
          initialsSet.add(dayOfWeekList[orderedMeal.reservedDate!.weekday - 1]);
        }
      }
    }
    return initialsSet.length;
  }

  OrderPost getOrderedMealsSelected(OrderType orderType){
    List<MealDeliveryOrder> result = [];
    if(orderType == OrderType.IMMEDIATE){
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
    return OrderPost.init(
      orderType: orderType,
      mealDeliveryOrders: result,
    );
  }
}