import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/models/order/order.dart';
import 'package:hankkitoktok/functions/formatter.dart';

import '../models/order/order_post.dart';

Widget buildPriceInfoByOrder(Order order) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("결제 금액", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("주문 금액", style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
              Text("${f.format(order.mealPrice)}원",
                  style:  TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("배달 금액", style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
              Text("${f.format(order.deliveryPrice)}원",
                  style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
            ],
          ),
          const SizedBox(height: 4.0),
          (order.fullServicePrice > 0)
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("풀결제 서비스 금액", style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
              Text("${f.format(order.fullServicePrice)}원",
                  style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
            ],
          )
              : const SizedBox(),
          (order.fullServicePrice > 0)
              ? const SizedBox(height: 4.0)
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("최종 결제 금액", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
              Text("${f.format(order.totalPrice)}원",
                  style: TextStyles.getTextStyle(TextType.SUBTITLE_1, PRIMARY_COLOR)),
            ],
          ),
        ],
      ));
}

Widget buildPriceInfoByOrderPost(OrderPost orderPost) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("결제 금액", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("주문 금액", style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
              Text("${f.format(orderPost.mealPrice)}원",
                  style:  TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("배달 금액", style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
              Text("${f.format(orderPost.deliveryPrice)}원",
                  style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
            ],
          ),
          const SizedBox(height: 4.0),
          (orderPost.fullServicePrice > 0)
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("풀결제 서비스 금액", style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
              Text("${f.format(orderPost.fullServicePrice)}원",
                  style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
            ],
          )
              : const SizedBox(),
          (orderPost.fullServicePrice > 0)
              ? const SizedBox(height: 4.0)
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("최종 결제 금액", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
              Text("${f.format(orderPost.totalPrice)}원",
                  style: TextStyles.getTextStyle(TextType.SUBTITLE_1, PRIMARY_COLOR)),
            ],
          ),
        ],
      ));
}