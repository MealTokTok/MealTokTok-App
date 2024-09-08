import 'package:flutter/material.dart';

import '../const/color.dart';
import '../const/style2.dart';
import '../functions/formatter.dart';
import '../models/enums.dart';
import '../models/meal/ordered_meal.dart';
import '../models/order/order.dart';
import '../models/order/order_post.dart';

Widget buildOrderDetailByOrder(Order order) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문내역', style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '주문방식: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: order.orderType==OrderType.DAY_ORDER ? '일 결제' : '주간 결제',
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '요일: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: order.dayOfWeekInitial,
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Text('시간', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
          for (String orderTime in order.getOrderTimeList)
            Text(orderTime, style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
          const SizedBox(height: 8.0),
          Text('메뉴', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
          for (MealDetail menu in order.combinedMenuList)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(menu.title, style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
                    Text("${f.format(menu.mealPrice)}원",
                        style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(menu.subTitle, style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                const SizedBox(height: 8.0),
              ],
            ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("총 횟수", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, PRIMARY_COLOR)),
              Text(
                  "${order.combinedMenuList.length}회",
                  style: TextStyles.getTextStyle(TextType.SUBTITLE_1, PRIMARY_COLOR)),
            ],
          )
        ],
      ));
} //Todo: 오류수정

Widget buildOrderDetailByOrderPost(OrderPost orderPost) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '주문방식: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: orderPost.orderType==OrderType.DAY_ORDER ? '일 결제' : '주간 결제',
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '요일: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: orderPost.dayOfWeekInitial,
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Text('시간', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
          for (String orderTime in orderPost.getOrderTimeList)
            Text(orderTime, style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
          const SizedBox(height: 8.0),
          Text('메뉴', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
          for (MealDetail menu in orderPost.combinedMenuList)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(menu.title, style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
                    Text("${f.format(menu.mealPrice)}원",
                        style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(menu.subTitle, style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                const SizedBox(height: 8.0),
              ],
            ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("총 횟수", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, PRIMARY_COLOR)),
              Text(
                  "${orderPost.combinedMenuList.length}회",
                  style: TextStyles.getTextStyle(TextType.SUBTITLE_1, PRIMARY_COLOR)),
            ],
          )
        ],
      ));
} //Todo: 오류수정