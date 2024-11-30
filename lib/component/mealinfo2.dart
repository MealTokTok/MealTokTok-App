import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/four_image.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/models/meal/meal.dart';

Widget MealInfo2({
  required Meal meal,
}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: GRAY1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(32))),
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildFourImage(meal.getDishUrls(), 74, 74),
        const SizedBox(width: 16), //
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meal.mealName,
              style:
              TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${meal.mealPrice}원",
              style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2),
            ),
            const SizedBox(width: 8), //

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
  );
}