import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';

import '../models/meal/meal_delivery.dart';
import '../models/order/order.dart';

class ListViewScrollController extends GetxController {

  RxList<Order> orderHistories = <Order>[].obs;
  RxList<MealDelivery> mealDeliveryHistories = <MealDelivery>[].obs;
  RxList<String> dropdownValues = <String>['전체보기','결제완료'].obs;
  RxString dropdownValue = '전체보기'.obs;

  var orderScrollController = ScrollController().obs;
  var deliveryScrollController = ScrollController().obs;
  int orderPage = 1;
  int deliveryPage = 1;



  void addOrder() {
    orderHistories.addAll(orders);
    orderHistories.addAll(orders);
    orderHistories.addAll(orders);
    orderHistories.addAll(orders);
    orderPage++;
  }

  void addDelivery() {
    mealDeliveryHistories.addAll(mealDeliveries);
    mealDeliveryHistories.addAll(mealDeliveries);
    mealDeliveryHistories.addAll(mealDeliveries);
    mealDeliveryHistories.addAll(mealDeliveries);
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