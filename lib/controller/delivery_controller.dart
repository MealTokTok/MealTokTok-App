import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';
import 'package:hankkitoktok/models/order/order.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';

import '../models/full_service/full_service_data.dart';
import '../models/meal/meal_delivery_data.dart';
import '../models/meal/meal_delivery_order.dart';
import '../models/order/order_data.dart';

//주문 정보와 다음 배송 정보를 가져오는 컨트롤러 (해당 정보들은 사용자 시나리오에 따라 null일 수 있음)
//실행되는 시점: 앱 시작 시
class DeliveryController extends GetxController {
  Order? recentOrder;
  MealDelivery? nextMealDelivery;
  MealDelivery? deliveringMealDelivery;
  MealDelivery? recentDeliveredMealDelivery;

  int fullDiningCount = 0;

  @override
  void onInit() async {
    // 주문정보 가져오기
    await initOrder();
    //다음 배송정보 가져오기
    await initNextMealDelivery();
    //배송중인 배송 정보 가져오기
    await initDeliveringMealDelivery();
    //최근 배송된 배송정보 가져오기
    await initDeliveredMealDelivery();
    //요청 수거된 다회용기 횟수 가져오기
    initFullDiningCount();
    super.onInit();
  }

  Future<void> initOrder() async {
    Map<String, dynamic> query = {
      "page": "1",
      "size": "1",
      "sortOrders": [
        {
          "key": "createdAt",
          "direction": "ASC"
        }
      ]
    };
    debugPrint("initOrder");
    List<Order> tmp = await orderGetList(query);
    if(tmp.isNotEmpty) {
      recentOrder = tmp.first;
    }
    update();
  }

  //다음 배송 정보 가져오기
  Future<void> initNextMealDelivery() async {
    String? orderId;
    if(recentOrder != null) orderId = recentOrder!.orderID;
    if(orderId == null) return;

    Map<String, dynamic> query = {
      "orderId": orderId,
    };


    nextMealDelivery = await networkGetDelivery(query, DeliveryRequestMode.NEXT_DELIVERY);

    update();
  }

  //현재 배송 중인 정보 가져오기
  Future<void> initDeliveringMealDelivery() async {
    debugPrint("delivering");

    deliveringMealDelivery = await networkGetDelivery(null, DeliveryRequestMode.DELVERING_DELIVERY);
    update();
  }

  //최근 배송 완료된 배송 정보 가져오기
  Future<void> initDeliveredMealDelivery() async {
    debugPrint("delivered");
    recentDeliveredMealDelivery = await networkGetDelivery(null, DeliveryRequestMode.RECENT_DELIVERED_DELIVERY);
    update();
  }



  Future<void> initFullDiningCount() async {
    fullDiningCount = await networkGetFullDiningsCount() ?? 0;
    update();
  }
}