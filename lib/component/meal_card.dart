import 'package:flutter/material.dart';

import '../const/color.dart';
import '../const/style2.dart';
import '../models/meal/dish.dart';
import '../models/meal/meal.dart';

import 'package:hankkitoktok/controller/tmpdata.dart';

enum DropDownType { ON, OFF }

class MenuCardTest extends StatefulWidget {
  const MenuCardTest({super.key});

  @override
  State<MenuCardTest> createState() => _MenuCardTestState();
}

class _MenuCardTestState extends State<MenuCardTest> {
  List<Meal> menus = mealMenuList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MenuCards(menus: menus));
  }
}

class MenuCards extends StatefulWidget {
  List<Meal> menus;
  final List<DropDownType> _dropDowns = [];
  int _selectedValue = 0;

  MenuCards({required this.menus, super.key}) {
    for (int i = 0; i < menus.length; i++) {
      _dropDowns.add(DropDownType.OFF);
    }
  }

  @override
  State<MenuCards> createState() => _MenuCardsState();
}

class _MenuCardsState extends State<MenuCards> {
  void setValue(int value) {
    setState(() {
      widget._selectedValue = value;
    });
  }

  void setDropDown(int index) {
    setState(() {
      if (widget._dropDowns[index] == DropDownType.OFF) {
        widget._dropDowns[index] = DropDownType.ON;
      } else {
        widget._dropDowns[index] = DropDownType.OFF;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (int index = 0; index < widget.menus.length; index++)
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
                    setValue(index);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 32,
                          height: 32,
                          child: Center(
                            child: Image.asset(
                                widget._selectedValue == index
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
                                    widget.menus[index].name,
                                    style: TextStyles.getTextStyle(
                                        TextType.SUBTITLE_1, BLACK_COLOR_2),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setDropDown(index);
                                    },
                                    child: Image.asset(
                                        widget._dropDowns[index] ==
                                            DropDownType.OFF
                                            ? "assets/images/3_menu_choice/arrow_down.png"
                                            : "assets/images/3_menu_choice/arrow_up.png",
                                        width: 24,
                                        height: 24),
                                  ),
                                ]),
                            Text(
                              '${widget.menus[index].price}원',
                              style: TextStyles.getTextStyle(
                                  TextType.BODY_2, BLACK_COLOR_2),
                            ),
                            SizedBox(
                                height: widget._dropDowns[index] ==
                                    DropDownType.OFF
                                    ? 0
                                    : 4),
                            widget._dropDowns[index] == DropDownType.OFF
                                ? Container()
                                : Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  for (Dish dish in widget.menus[index].dishList)
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Image(
                                            image: NetworkImage(dish.imgUrl),
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
  }
}
