import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:hankkitoktok/models/order/order.dart';

import '../const/style2.dart';
import '../screen/1_my_page/2_order_history_detail_screen.dart';
import '../functions/formatter.dart';
class Payment extends StatelessWidget {
  final Order order;

  const Payment({
    required this.order,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: SECONDARY_1, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('결제완료', style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_1)),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.simpleOrderDateString, style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_3),),
              InkWell(
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
            '${order.orderType == OrderType.IMMEDIATE ? '일 결제' : '주간결제'} - ${order.totalMealDeliveryCount}회: ${f.format(order.mealPrice)}원',
            style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR),
          ),
          const SizedBox(height: 2),
          if(order.deliveryPrice > 0)
          Text(
            '배달비: ${f.format(order.deliveryPrice)}원',
            style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR),
          ),
          const SizedBox(height: 2),
          if(order.fullServicePrice > 0)
          Text(
            '한끼풀대접: ${f.format(order.fullServicePrice)}원',
            style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR),
          ),
          const SizedBox(height: 4),
        ],
      )
    );
  }
}
