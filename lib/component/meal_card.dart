import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/ordered_meal_controller.dart';

import '../const/color.dart';
import '../const/style2.dart';
import '../controller/meal_controller.dart';
import '../models/meal/dish.dart';
import '../models/enums.dart';

import 'package:hankkitoktok/controller/tmpdata.dart';

import '../models/meal/meal.dart';

enum DropDownType { ON, OFF }

class MenuCards extends StatefulWidget {
  //int _selectedValue = 0;
  OrderType orderType;
  DateTime reservedDate;
  Time time;
  OrderedMealController orderedMealController;

  MenuCards(
      {required this.orderType,
      required this.reservedDate,
      required this.time,
      required this.orderedMealController,
      super.key});

  @override
  State<MenuCards> createState() => _MenuCardsState();
}

class _MenuCardsState extends State<MenuCards> {
  late MealController _mealController;
  final List<DropDownType> _dropDowns = [];

  @override
  void initState() {
    _mealController = Get.find();
    for (int i = 0; i < _mealController.getMeals.length; i++) {
      _dropDowns.add(DropDownType.OFF);
    }
    super.initState();
  }

  void setValue(int mealId) {
    OrderedMealController orderedMealController = Get.find();
    orderedMealController.updateMealById(
        widget.orderType, widget.reservedDate, widget.time, mealId);
  }

  void setDropDown(int index) {
    setState(() {
      if (_dropDowns[index] == DropDownType.OFF) {
        _dropDowns[index] = DropDownType.ON;
      } else {
        _dropDowns[index] = DropDownType.OFF;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MealController>(builder: (_mealController) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (int index = 0; index < _mealController.getMeals.length; index++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: GREY_COLOR_4,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: InkWell(
                    onTap: () {
                      debugPrint("inkwell button clicked");
                      int mealId = _mealController.getMeals[index].mealId;
                      setValue(mealId);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.orderType == OrderType.IMMEDIATE
                            ? SizedBox(
                                width: 32,
                                height: 32,
                                child: Center(
                                  child: Image.asset(
                                      widget.orderedMealController.orderedDayMeals[widget.reservedDate] != null &&
                                      (widget.orderedMealController.orderedDayMeals[widget.reservedDate]![widget.time == Time.AFTERNOON ? 0 : 1].mealId
                                          == _mealController.getMeals[index].mealId)
                                          ? "assets/images/3_menu_choice/radio_button_on.png"
                                          : "assets/images/3_menu_choice/radio_button_off.png",
                                      width: 24,
                                      height: 24),
                                ))
                            : SizedBox(
                                width: 32,
                                height: 32,
                                child: Center(
                                  child: Image.asset(
                                      widget.orderedMealController.orderedWeekMeals[widget.reservedDate] != null &&
                                          (widget.orderedMealController.orderedWeekMeals[widget.reservedDate]![widget.time == Time.AFTERNOON ? 0 : 1].mealId
                                              == _mealController.getMeals[index].mealId)
                                          ? "assets/images/3_menu_choice/radio_button_on.png"
                                          : "assets/images/3_menu_choice/radio_button_off.png",
                                      width: 24,
                                      height: 24),
                                )),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _mealController.getMeals[index].name,
                                      style: TextStyles.getTextStyle(
                                          TextType.SUBTITLE_1, BLACK_COLOR_2),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setDropDown(index);
                                      },
                                      child: Image.asset(
                                          _dropDowns[index] == DropDownType.OFF
                                              ? "assets/images/3_menu_choice/arrow_down.png"
                                              : "assets/images/3_menu_choice/arrow_up.png",
                                          width: 24,
                                          height: 24),
                                    ),
                                  ]),
                              Text(
                                '${_mealController.getMeals[index].price}원',
                                style: TextStyles.getTextStyle(
                                    TextType.BODY_2, BLACK_COLOR_2),
                              ),
                              SizedBox(
                                  height: _dropDowns[index] == DropDownType.OFF
                                      ? 0
                                      : 4),
                              _dropDowns[index] == DropDownType.OFF
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          for (Dish dish in _mealController
                                              .getMeals[index].dishList)
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image(
                                                    image: NetworkImage(
                                                        dish.imgUrl),
                                                  ),
                                                  Text(
                                                    dish.dishName,
                                                    style:
                                                        TextStyles.getTextStyle(
                                                            TextType.SMALL,
                                                            BLACK_COLOR),
                                                  ),
                                                ]),
                                        ])
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 8),
            ],
          )
      ]);
    });
  }
}
