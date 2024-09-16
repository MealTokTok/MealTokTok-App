import 'package:flutter/material.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';

import '../const/color.dart';
import '../const/style2.dart';
import '../models/meal/meal.dart';
import 'four_image.dart';

class MealInfo extends StatelessWidget {

  MealDelivery mealDelivery;
  Color orderNumberColor;
  late Meal meal;

  MealInfo({
    required this.mealDelivery,
    required this.orderNumberColor,
    super.key
  }){
    meal = mealDelivery.orderedMeal.meal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("배송된 반찬도시락", style: TextStyles.getTextStyle(TextType.TITLE_3, BLACK_COLOR),),
        Text("주문번호 ${mealDelivery.orderId}", style: TextStyles.getTextStyle(TextType.BUTTON, orderNumberColor),),
      ]),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildFourImage(meal.getDishUrls(), 74, 74),
          const SizedBox(width: 16), //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal.name,
                style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${meal.price}원",
                style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2),
              ),
              //객체 안에있는 리스트 수 만큼 메뉴 텍스트 추가
              for (int i = 0; i < meal.getDishNames().length; i++)
                Text(
                  meal.getDishNames()[i],
                  style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2),
                ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 32),
    ]);
  }
}


