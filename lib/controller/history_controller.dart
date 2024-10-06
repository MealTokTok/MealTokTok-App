import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';

import '../models/meal/meal_data.dart';
import '../models/meal/meal_delivery.dart';
import '../models/order/order.dart';
import '../models/order/order_data.dart';
import '../models/meal/meal_delivery_data.dart';

class HistoryController extends GetxController {

  RxList<Order> orderHistories = <Order>[].obs;
  RxList<MealDelivery> mealDeliveryHistories = <MealDelivery>[].obs;
  RxList<String> dropdownValues = <String>['전체보기','결제완료'].obs;
  RxString dropdownValue = '전체보기'.obs;

  var orderScrollController = ScrollController().obs;
  var deliveryScrollController = ScrollController().obs;
  int orderPage = 1;
  int deliveryPage = 1;



  void addOrder() async{
    // orderHistories.addAll(orders);
    // orderHistories.addAll(orders);
    // orderHistories.addAll(orders);
    // orderHistories.addAll(orders);

    Map<String, dynamic> query = {
      "page":orderPage.toString(),
      "size": "12",
      "sortOrders": [
        {
          "key": "createdAt",
          "direction": "ASC"
        }
      ]
    };

    List<Order> newOrders = await orderGetList(query);



    orderHistories.addAll(newOrders);
    orderPage++;
  }

  //스크롤을 내렸을 때 배송정보 추가 요청
  void addDelivery() async {

    //최대 12개까지 추가하는 쿼리
    Map<String, dynamic> query = {
      "page":deliveryPage.toString(),
      "size": "12",
      "sortOrders": [
        {
          "key": "createdAt",
          "direction": "ASC"
        }
      ]
    };
    List<MealDelivery> newMealDeliveries = await networkGetDeliveryList(query, DeliveryListRequestMode.ALL);
    for(MealDelivery mealDelivery in newMealDeliveries){
      mealDelivery.meal = await networkGetMeal(mealDelivery.mealId);
    }
    mealDeliveryHistories.addAll(newMealDeliveries);
    deliveryPage++;
  }

  @override
  void onInit() {

    addOrder();
    addDelivery();

    orderScrollController.value.addListener(() {
      if (orderScrollController.value.position.pixels ==
          orderScrollController.value.position.maxScrollExtent) {
        addOrder();
      }
    });

    deliveryScrollController.value.addListener(() {
      if (deliveryScrollController.value.position.pixels ==
          deliveryScrollController.value.position.maxScrollExtent) {
         addDelivery();
      }
    });
    super.onInit();
  }


}