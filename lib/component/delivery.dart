import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/screen/1_my_page/3_delivery_history_detali_screen.dart';

import '../const/style2.dart';
import '../models/order/order.dart';
import '../screen/1_my_page/2_order_history_detail_screen.dart';
import '../functions/formatter.dart';
class Delivery extends StatelessWidget {
  final MealDelivery mealDelivery;
  const Delivery({
    required this.mealDelivery,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryState(mealDelivery.deliveryState),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(mealDelivery.getDeliveryDateTimeStringByDot, style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_3),),
                InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryHistoryDetailScreen(deliveryId: mealDelivery.mealDeliveryId),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('상세보기', style: TextStyles.getTextStyle(TextType.CAPTION, GREY_COLOR_3)),
                          Image.asset('assets/images/3_menu_choice/arrow_right.png', width: 24, height: 24, color: GREY_COLOR_3),
                        ],
                      ),
                    )
                )
              ],
            ),
            Text(
              mealDelivery.orderedReservedDateTimeString(),
              style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR),
            ),
            const SizedBox(height: 2),
              Text(
                '${mealDelivery.getOrderTypeString} - 메뉴명', //Todo: 반영하기
                style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR),
              ),
            const SizedBox(height: 4),
          ],
        )
    );
  }

  Widget _buildDeliveryState( DeliveryState deliveryState){
    Color color = deliveryState == DeliveryState.PENDING ? SECONDARY_2 : deliveryState == DeliveryState.INDELIVERING ? PRIMARY_COLOR : SECONDARY_1;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(deliveryState == DeliveryState.PENDING ? '배송예정' : deliveryState == DeliveryState.INDELIVERING ? '배송중' : '배송완료' , style: TextStyles.getTextStyle(TextType.BUTTON, color)),
    );
  }
}
