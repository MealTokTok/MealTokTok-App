import 'package:flutter/material.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/models/meal/meal_delivery_data.dart';
import 'package:hankkitoktok/models/order/order_data.dart';

import '../../component/four_image.dart';
import '../../const/color.dart';
import '../../const/style2.dart';
import '../../controller/tmpdata.dart';
import '../../models/address/address.dart';
import '../../models/address/address_data.dart';
import '../../models/enums.dart';
import '../../models/meal/meal_delivery_order.dart';
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
  MealDelivery mealDelivery = MealDelivery.init();
  MealDelivery? nextMealDelivery;
  Order order = Order.init();
  User user = User.init();
  Address address = Address.init();

  void getOrderData() async {
    // order = await networkGetRequest(
    //     model, "/api/v1/orders/${widget.orderId}", null);

    print("de: ${widget.deliveryId}");

    Map<String, dynamic> deliveryQuery = {
      "mealDeliveryId": widget.deliveryId,
    };

    mealDelivery =
        (await networkGetDelivery(deliveryQuery, DeliveryRequestMode.COMMON))!;

    print("mealDelivery: ${mealDelivery.mealId}");
    await mealDelivery.setMeal();

    print("mealDelivery.orderId: ${mealDelivery.orderId}");

    Map<String, dynamic> orderQuery = {
      "orderId": mealDelivery.orderId,
    };

    order = await networkGetOrder(mealDelivery.orderId);
    //user = getUserById(order.userId);
    //address = getAddressById(order.addressId);
    print("address: ${order.addressId}");

    //Todo: 주소 정상화 이후 바꾸기
    address = await networkGetAddress(1);

    nextMealDelivery = await networkGetDelivery(
        orderQuery, DeliveryRequestMode.NEXT_DELIVERY);
    if(nextMealDelivery!= null){
      await nextMealDelivery!.setMeal();
    }

    setState(() {});
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (mealDelivery.deliveryState ==
                        DeliveryState.INDELIVERING)
                      const SizedBox(height: 8.0),
                    if (mealDelivery.deliveryState ==
                        DeliveryState.INDELIVERING)
                      _buildTodayDelivery(),
                    _buildMealInfo(),
                    if (nextMealDelivery != null)
                      _buildNextDeliveryBanner(),
                    if (nextMealDelivery != null)
                      const SizedBox(height: 8.0),
                    _buildOrderHistoryButton(),
                  ]),
            ),
            const Divider(thickness: 4, color: GREY_COLOR_0),
            _buildDeliveryInfo(),
          ],
        ),
      ),
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

  Widget _buildTodayDelivery() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: SECONDARY_1_CONTAINER,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
              '${mealDelivery.reservedTime == Time.AFTERNOON ? '12-1' : '6-7'}시 사이에 배송됩니다.',
              style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_1)),
        ));
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
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: GREY_COLOR_4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mealDelivery.getDeliveryDateTimeString2,
                            style: TextStyles.getTextStyle(
                                TextType.SMALL, GREY_COLOR_2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            buildFourImage(
                                mealDelivery.meal.getDishUrls(), 74, 74),
                            const SizedBox(width: 4.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(mealDelivery.meal.name,
                                    style: TextStyles.getTextStyle(
                                        TextType.SUBTITLE_1, BLACK_COLOR)),
                                Text("${mealDelivery.meal.price.toString()}원",
                                    style: TextStyles.getTextStyle(
                                        TextType.BUTTON, GREY_COLOR_2)),
                                for (String dishName
                                    in mealDelivery.meal.getDishNames())
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

  Widget _buildNextDeliveryBanner() {
    return Container(
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
                Text(nextMealDelivery!.getNextDeliveryString,
                    style: TextStyles.getTextStyle(
                        TextType.BODY_2, BLACK_COLOR_2)),
                Text(nextMealDelivery!.getNextDeliveryMenuString,
                    style: TextStyles.getTextStyle(
                        TextType.SUBTITLE_2, BLACK_COLOR_2)),
              ],
            ),
            buildFourImage(nextMealDelivery!.meal.getDishUrls(), 40, 40)
          ],
        ));
  }

  Widget _buildOrderHistoryButton() {
    return Center(
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderHistoryDetailScreen(orderId: order.orderID),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 4, 2, 4),
              height: 28,
              decoration: BoxDecoration(
                color: GREY_COLOR_0,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('주문내역',
                      style: TextStyles.getTextStyle(
                          TextType.CAPTION, GREY_COLOR_3)),
                  Image.asset('assets/images/3_menu_choice/arrow_right.png',
                      width: 24, height: 24, color: GREY_COLOR_3),
                ],
              ),
            )));
  }

  Widget _buildDeliveryInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('배송 정보',
              style:
                  TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: '주문번호: ',
                    style:
                        TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: order.orderID.toString(),
                    style:
                        TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: '배송주소: ',
                    style:
                        TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: address.address,
                    style:
                        TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: '받는사람: ',
                    style:
                        TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: user.username,
                    style:
                        TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: '연락처: ',
                    style:
                        TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: user.phoneNumber,
                    style:
                        TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
