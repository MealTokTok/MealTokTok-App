import 'package:flutter/material.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';

import '../../component/four_image.dart';
import '../../const/color.dart';
import '../../const/style2.dart';
import '../../controller/tmpdata.dart';
import '../../models/enums.dart';
import '../../models/meal/ordered_meal.dart';
import '../../models/order/order.dart';
import '../../models/user/user.dart';
import '2_order_history_detail_screen.dart';

class DeliveryHistoryDetailScreen extends StatefulWidget {
  int deliveryId;

  DeliveryHistoryDetailScreen({required this.deliveryId, super.key});

  @override
  State<DeliveryHistoryDetailScreen> createState() =>
      _DeliveryHistoryDetailScreenState();
}

class _DeliveryHistoryDetailScreenState
    extends State<DeliveryHistoryDetailScreen> {
  late MealDelivery mealDelivery;
  MealDelivery? nextMealDelivery;
  late Order order;
  late User user;
  late OrderedMeal orderedMeal;
  late String address;

  void getOrderData() {
    setState(() {
      // order = await networkGetRequest(
      //     model, "/api/v1/orders/${widget.orderId}", null);
      mealDelivery = getMealDeliveryById(widget.deliveryId);
      order = getOrderById(mealDelivery.orderId);
      user = getUserById(order.userId);
      orderedMeal = mealDelivery.orderedMeal;
      address = getAddressById(order.addressId);
      if(order.orderState == OrderState.DELIVERING && mealDelivery.deliveryState == DeliveryState.DELIVERED){
        nextMealDelivery = getNextMealDelivery(order.orderID);
      }
      print(order.orderState);
      print(mealDelivery.deliveryState);
    });
  }

  @override
  void initState() {
    getOrderData();
    super.initState();
  }

  //Todo: 수정
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,16,0,0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(mealDelivery.deliveryState == DeliveryState.INDELIVERING)
                const SizedBox(height: 8.0),
              if(mealDelivery.deliveryState == DeliveryState.INDELIVERING)
                _buildTodayDelivery(),
              _buildMealInfo(),
              if(order.orderState == OrderState.DELIVERING && mealDelivery.deliveryState == DeliveryState.DELIVERED)
                _buildNextDeliveryBanner(),
              if(order.orderState == OrderState.DELIVERING && mealDelivery.deliveryState == DeliveryState.DELIVERED)
                const SizedBox(height: 8.0),
              _buildOrderHistoryButton(),
              const Divider(thickness: 4, color: GREY_COLOR_0),
              _buildDeliveryInfo(),
            ],
          ),
        ),
      )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('상세내역',
          style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR_3)),
      centerTitle: true,
    );
  }

  Widget _buildTodayDelivery(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: SECONDARY_1_CONTAINER,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('${mealDelivery.orderedMeal.reservedTime == Time.AFTERNOON ? '12-1' : '6-7'}시 사이에 배송됩니다.' , style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_1)),
      )
    );
  }

  Widget _buildMealInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text("배송 상품",
              style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
          const SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: GREY_COLOR_4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(orderedMeal.getDeliveryDateTimeString2,
                            style: TextStyles.getTextStyle(
                                TextType.SMALL, GREY_COLOR_2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildFourImage(
                                orderedMeal.meal.getDishUrls(), 74, 74),
                            const SizedBox(width: 4.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(orderedMeal.meal.name,
                                    style: TextStyles.getTextStyle(
                                        TextType.SUBTITLE_1, BLACK_COLOR)),
                                Text(orderedMeal.meal.price.toString(),
                                    style: TextStyles.getTextStyle(
                                        TextType.BUTTON, GREY_COLOR_2)),
                                for (String dishName
                                    in orderedMeal.meal.getDishNames())
                                  Text(dishName,
                                      style: TextStyles.getTextStyle(
                                          TextType.BODY_2, GREY_COLOR_2)),
                              ],
                            ),
                          ],
                        ),
                      ])),
              const SizedBox(height: 8.0)
            ],
          )
        ],
      ),
    );
  }
  Widget _buildNextDeliveryBanner(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: PRIMARY_LIGHT,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nextMealDelivery!.getNextDeliveryString, style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
                  Text(nextMealDelivery!.getNextDeliveryMenuString, style: TextStyles.getTextStyle(TextType.SUBTITLE_2, BLACK_COLOR_2)),
                ],
              ),
              buildFourImage(nextMealDelivery!.orderedMeal.meal.getDishUrls(), 40, 40)
            ],
          )
      )
    );
  }
  Widget _buildOrderHistoryButton(){
    return Center(
      child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistoryDetailScreen(orderId: order.orderID),
                )
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(10,4,2,4),
            height: 28,

            decoration: BoxDecoration(
              color: GREY_COLOR_0,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('상세보기', style: TextStyles.getTextStyle(TextType.CAPTION, GREY_COLOR_3)),
                Image.asset('assets/images/3_menu_choice/arrow_right.png', width: 24, height: 24, color: GREY_COLOR_3),
              ],
            ),
          )
      )
    );
}

  Widget _buildDeliveryInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('배송 정보', style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '주문번호: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: order.orderID.toString(),
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '배송주소: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: address,
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '받는사람: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: user.username,
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '연락처: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: user.phoneNumber,
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
