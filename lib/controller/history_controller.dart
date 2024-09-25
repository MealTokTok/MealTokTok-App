import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';

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

    List<Order> tmp = await orderGetList(query);
    orderHistories.addAll(tmp);
    orderPage++;
  }

  void addDelivery() async {
    // mealDeliveryHistories.addAll(mealDeliveries);
    // mealDeliveryHistories.addAll(mealDeliveries);
    // mealDeliveryHistories.addAll(mealDeliveries);
    // mealDeliveryHistories.addAll(mealDeliveries);
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
    List<MealDelivery> tmp = await networkGetDeliveryList(query, DeliveryListRequestMode.ALL);
    mealDeliveryHistories.addAll(tmp);
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