import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/ordered_meal_controller.dart';
import 'package:intl/intl.dart';
import '../const/style2.dart';
import '../const/color.dart';
import '../controller/meal_controller.dart';
import '../models/enums.dart';
import '../models/meal/meal_delivery_order.dart';

enum Mode { MEAL, RICE, WASHING }

class TimeCheckbox extends StatelessWidget {
  final Mode mode;
  final TimeType timeType;
  final OrderType orderType;

  TimeCheckbox({
    required this.orderType,
    required this.mode,
    required this.timeType,
    Key? key,
  }) : super(key: key);

  bool _visibleMeal(OrderedMealController controller, dateTime, int index) {
    if (mode == Mode.MEAL) {
      if (timeType == TimeType.BEFORE_LUNCH && (index == 0 || index == 1)) {
        if (orderType == OrderType.IMMEDIATE) {
          return controller.orderedDayMeals[dateTime]![index].isVisible;
        }
        return controller.orderedWeekMeals[dateTime]![index].isVisible;
      } else if (timeType == TimeType.AFTER_LUNCH && index == 1) {
        if (orderType == OrderType.IMMEDIATE) {
          return controller.orderedDayMeals[dateTime]![index].isVisible;
        }
        return controller.orderedWeekMeals[dateTime]![index].isVisible;
      }
    } else if (mode == Mode.RICE) {
      if (orderType == OrderType.IMMEDIATE) {
        return controller.orderedDayMeals[dateTime]![index].isChecked;
      }
      return controller.orderedWeekMeals[dateTime]![index].isChecked;
    } else if (mode == Mode.WASHING) {
      //Todo: 풀대접
    }
    return false;
  }

  bool _getValue(OrderedMealController controller, DateTime key, int index) {
    if (mode == Mode.MEAL) {
      if (orderType == OrderType.IMMEDIATE) {
        return controller.orderedDayMeals[key]![index].isChecked;
      }
      return controller.orderedWeekMeals[key]![index].isChecked;
    } else if (mode == Mode.RICE) {
      if (orderType == OrderType.IMMEDIATE) {
        return controller.orderedDayMeals[key]![index].includeRice;
      }
      return controller.orderedWeekMeals[key]![index].includeRice;
    } else if (mode == Mode.WASHING) {}
    return false;
  }

  void _getOnChanged(
      OrderedMealController controller, DateTime key, int index) {
    if (mode == Mode.MEAL) {
      MealController mealController = Get.find();
      int defaultMealId = mealController.getMeals[0].mealId;
      controller.updateChecked(
          orderType, key, index == 0 ? Time.AFTERNOON : Time.EVENING);
      controller.updateMealById(
          orderType, key, index == 0 ? Time.AFTERNOON : Time.EVENING, defaultMealId);
    } else if (mode == Mode.RICE) {
      controller.updateRice(
          orderType, key, index == 0 ? Time.AFTERNOON : Time.EVENING);
    } else if (mode == Mode.WASHING) {}
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderedMealController>(
      builder: (_orderedMealController) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (DateTime key in orderType == OrderType.IMMEDIATE
                ? _orderedMealController.orderedDayMeals.keys
                : _orderedMealController.orderedWeekMeals.keys)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_visibleMeal(_orderedMealController, key, 0) ||
                      _visibleMeal(_orderedMealController, key, 1))
                    Text(
                      DateFormat('EEEE', 'ko_KR').format(key),
                      style: TextStyles.getTextStyle(
                          TextType.SUBTITLE_1, BLACK_COLOR_2),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_visibleMeal(_orderedMealController, key, 0))
                        _buildCheckboxDetail(
                          value: _getValue(_orderedMealController, key, 0),
                          label: " 점심 (12시 ~ 1시)",
                          onPressed: () {
                            _getOnChanged(_orderedMealController, key, 0);
                          },
                        ),
                      if (_visibleMeal(_orderedMealController, key, 1))
                        _buildCheckboxDetail(
                          value: _getValue(_orderedMealController, key, 1),
                          label: "저녁 (6시 ~ 7시)",
                          onPressed: () {
                            _getOnChanged(_orderedMealController, key, 1);
                          },
                        ),
                    ],
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildCheckboxDetail({
    required bool value,
    required String label,
    required void Function() onPressed,
  }) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: 140,
        child: Row(
          children: [
            //Checkbox(value: value, onChanged: onChanged),
            IconButton(
                onPressed: onPressed,
                icon: Image.asset(
                    value
                        ? 'assets/images/3_menu_choice/checkbox_selected.png'
                        : 'assets/images/3_menu_choice/checkbox_unselected.png',
                    width: 24,
                    height: 24)),
            Text(
              label,
              style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR),
            ),
          ],
        ),
      ),
    );
  }
}
