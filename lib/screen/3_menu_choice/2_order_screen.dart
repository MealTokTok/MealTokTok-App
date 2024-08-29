import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/ordered_meal_controller.dart';
import 'package:intl/intl.dart';
import '../../const/style2.dart';
import '../../component/calendar.dart';
import '../../component/meal_card.dart';
import '../../component/tile.dart';
import '../../const/color.dart';
import '../../const/style2.dart';
import '../../component/time_checkbox.dart';

import '../../controller/meal_controller.dart';
import '../../functions/formatter.dart';
import '../../models/enums.dart';
import '../../models/meal/meal.dart';
import '../../models/meal/ordered_meal.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderType _orderType;
  late TimeType _timeType;
  late MealController _mealController;
  late OrderedMealController _orderedMealController;
  late List<Meal> _menus;

  @override
  void initState() {
    _orderType = OrderType.DAY_ORDER;
    _timeType = TimeType.BEFORE_LUNCH;
    _mealController = Get.find<MealController>();
    _orderedMealController = Get.find<OrderedMealController>();
    _orderedMealController.setMeals();
    _menus = _mealController.getMeals;
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay) {
    _orderedMealController.updateVisible(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderButtons(),
          const Divider(thickness: 4, color: GREY_COLOR_0),
          if (_orderType == OrderType.WEEK_ORDER) _buildSelectOrderDay(),
          if (_orderType == OrderType.WEEK_ORDER)
            const Divider(thickness: 4, color: GREY_COLOR_0),
          _buildSelectOrderTime(),
          const Divider(thickness: 4, color: GREY_COLOR_0),
          _buildSelectMenu(),
          const Divider(thickness: 4, color: GREY_COLOR_0),
          _buildSelectRice(),
          const SizedBox(height: 6),
          _buildNextButton()
        ],
      ))),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Text('반찬 도시락 주문',
          style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_3)),
    );
  }

  Widget _buildOrderButtons() {
    Widget orderButton2(OrderType buttonOrderType) {
      return OutlinedButton(
        style: _orderType == buttonOrderType
            ? OutlinedButton.styleFrom(
            maximumSize: const Size(double.infinity, 48),
            backgroundColor: PRIMARY_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(color: PRIMARY_COLOR, width: 1))
            : OutlinedButton.styleFrom(
            maximumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(color: GREY_COLOR_5, width: 1)),
        onPressed: () {
          setState(() {
            _orderType = buttonOrderType;
          });
        },
        child: Text(buttonOrderType == OrderType.DAY_ORDER ? '일 결제' : '주간 결제',
            style: _orderType == buttonOrderType
                ? TextStyles.getTextStyle(TextType.BUTTON, WHITE_COLOR)
                : TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_3)),
      );
    }

    Widget orderButton(OrderType buttonOrderType) {
      return InkWell(
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: _orderType == buttonOrderType ? PRIMARY_COLOR : WHITE_COLOR,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: _orderType == buttonOrderType
                    ? PRIMARY_COLOR
                    : GREY_COLOR_5,
                width: 1),
          ),
          child: Center(
            child: Text(buttonOrderType == OrderType.DAY_ORDER ? '일 결제' : '주간 결제',
                style: _orderType == buttonOrderType
                    ? TextStyles.getTextStyle(TextType.BUTTON, WHITE_COLOR)
                    : TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_3)),
          )
        ),

        onTap: () {
          setState(() {
            _orderType = buttonOrderType;
          });
        },

      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('주문방식 선택',
                style: TextStyles.getTextStyle(TextType.TITLE_3, BLACK_COLOR)),
            IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('주문 방식을 잘 읽고 선택해주세요!',
                                style: TextStyles.getTextStyle(
                                    TextType.SUBTITLE_1, BLACK_COLOR)),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Image.asset(
                                  'assets/images/3_menu_choice/close.png',
                                  width: 24,
                                  height: 24),
                            ),
                          ],
                        ),


                      ]
                    )
                  )
                )
              ),
              icon: Image.asset("assets/images/3_menu_choice/info.png",
                  width: 24, height: 24),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(flex: 1,child: orderButton(OrderType.DAY_ORDER)),
            const SizedBox(width: 12),
            Flexible(flex: 1,child: orderButton(OrderType.WEEK_ORDER)),
          ],
        ),
      ]),
    );
  }

  Widget _buildSelectOrderDay() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tile(title: '주문 요일 선택', subtitle: '배송 받고 싶은 요일을 선택해주세요.'),
            const SizedBox(height: 8),
            Calendar(
              onDaySelected: _onDaySelected,
            )
          ],
        ));
  }

  Widget _buildSelectOrderTime() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tile(title: '시간 선택', subtitle: '도시락을 받고 싶은 시간대를 선택해주세요.'),
            const SizedBox(height: 8),
            TimeCheckbox(
              orderType: _orderType,
              mode: Mode.MEAL,
              timeType: _timeType,
            )
          ],
        ));
  }

  Widget _buildSelectMenu() {
    Widget buildSelectMenuDetails(OrderedMeal orderedMeal, String time,
        OrderedMealController orderedMealController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: DateFormat('EEEE', 'ko_KR')
                      .format(orderedMeal.reservedDate!),
                  style: TextStyles.getTextStyle(
                      TextType.SUBTITLE_1, BLACK_COLOR_2),
                ),
                TextSpan(
                  text: time,
                  style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          MenuCards(
            orderType: _orderType,
            reservedDate: orderedMeal.reservedDate!,
            time: orderedMeal.reservedTime,
            orderedMealController: orderedMealController,
          ),
          const SizedBox(height: 12),
        ],
      );
    }

    Widget buildOrderList(OrderType orderType) {
      return GetBuilder<OrderedMealController>(
        builder: (_orderedMealController) {
          return (orderType == OrderType.DAY_ORDER)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (DateTime key in _orderedMealController.orderedDayKeys)
                      if (_orderedMealController.orderedDayMeals[key] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_orderedMealController
                                .orderedDayMeals[key]![0].isChecked)
                              buildSelectMenuDetails(
                                  _orderedMealController
                                      .orderedDayMeals[key]![0],
                                  ' 점심 (12시 ~ 1시)',
                                  _orderedMealController),
                            if (_orderedMealController
                                .orderedDayMeals[key]![1].isChecked)
                              buildSelectMenuDetails(
                                  _orderedMealController
                                      .orderedDayMeals[key]![1],
                                  ' 저녁 (6시 ~ 7시)',
                                  _orderedMealController),
                          ],
                        )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (DateTime key in _orderedMealController.orderedWeekKeys)
                      if (_orderedMealController.orderedWeekMeals[key] != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_orderedMealController
                                .orderedWeekMeals[key]![0].isChecked)
                              buildSelectMenuDetails(
                                  _orderedMealController
                                      .orderedWeekMeals[key]![0],
                                  ' 점심 (12시 ~ 1시)',
                                  _orderedMealController),
                            if (_orderedMealController
                                .orderedWeekMeals[key]![1].isChecked)
                              buildSelectMenuDetails(
                                  _orderedMealController
                                      .orderedWeekMeals[key]![1],
                                  ' 저녁 (6시 ~ 7시)',
                                  _orderedMealController),
                          ],
                        )
                  ],
                );
        },
      );
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tile(title: '메뉴 선택', subtitle: '선택하신 날짜에 받고싶은 도시락을 정해주세요.'),
            const SizedBox(height: 12),
            _orderType == OrderType.DAY_ORDER
                ? buildOrderList(OrderType.DAY_ORDER)
                : buildOrderList(OrderType.WEEK_ORDER),

            // _menuList
          ],
        ));
  }

  Widget _buildSelectRice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tile(title: '햇반도 함께 먹을건가요?'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: GREY_COLOR_0,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/3_menu_choice/rice.png',
                    width: 60, height: 60),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('햇반 백미 210g 1개',
                        style: TextStyles.getTextStyle(
                            TextType.BODY_2, BLACK_COLOR_2)),
                    const SizedBox(height: 4),
                    Text('1,000원',
                        style: TextStyles.getTextStyle(
                            TextType.SUBTITLE_2, BLACK_COLOR_2)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (_orderType == OrderType.DAY_ORDER)
            TimeCheckbox(
                orderType: _orderType, mode: Mode.RICE, timeType: _timeType)
          else
            TimeCheckbox(
                orderType: _orderType, mode: Mode.RICE, timeType: _timeType)
        ],
      ),
    );
  }

  Widget _buildNextButton() {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {
            if((_orderType == OrderType.DAY_ORDER ? _orderedMealController.menuPriceDay() : _orderedMealController.menuPriceWeek()) > 0){
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                      height: 360,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                          padding: const EdgeInsets.symmetric(
                             horizontal: 20, vertical: 8),
                              child: SizedBox(
                                  height: 60,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('장바구니에 상품을 담았습니다.',
                                          style: TextStyles.getTextStyle(
                                              TextType.BODY_1, BLACK_COLOR))),
                              )),
                          const SizedBox(height: 8),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: '밥먹고 설거지에 음식물 쓰레기까지..\n',
                                              style: TextStyles.getTextStyle(
                                                  TextType.TITLE_3, BLACK_COLOR_2)),
                                          TextSpan(
                                              text: '귀찮지 않으신가요?',
                                              style: TextStyles.getTextStyle(
                                                  TextType.TITLE_2, BLACK_COLOR)),
                                        ])),
                                    Text(
                                      '저희 한끼톡톡이\n모든 것을 청결하게 정리해드려요!',
                                      style: TextStyles.getTextStyle(
                                          TextType.BODY_2, GREY_COLOR_2),
                                    ),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: 170,
                                      child: OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: WHITE_COLOR,
                                            //parent color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            side: const BorderSide(
                                                color: SECONDARY_1, width: 1),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  2, 4, 10, 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text('풀대접 서비스란',
                                                      style:
                                                      TextStyles.getTextStyle(
                                                          TextType.CAPTION,
                                                          SECONDARY_1)),
                                                  Image.asset(
                                                      'assets/images/3_menu_choice/chevron_forward.png',
                                                      width: 24,
                                                      height: 24)
                                                ],
                                              )))
                                    )
                                  ])),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        //TODO: 장바구니 보기
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(0, 48),
                                        backgroundColor: GREY_COLOR_4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Center(
                                              child: Text('장바구니 보기',
                                                  style: TextStyles.getTextStyle(
                                                      TextType.BUTTON,
                                                      WHITE_COLOR))))),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                    flex: 1,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          //TODO: 풀대접 서비스 페이지 보기
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(0, 48),
                                          backgroundColor: PRIMARY_COLOR,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Center(
                                                child: Text('함께 구매하기',
                                                    style:
                                                    TextStyles.getTextStyle(
                                                        TextType.BUTTON,
                                                        WHITE_COLOR)))))),
                              ],
                            ),
                          )
                        ],
                      ));
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: PRIMARY_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: GetBuilder<OrderedMealController>(
            builder: (_orderedMealController) {
              return Text(
                  '${f.format(_orderType == OrderType.DAY_ORDER ? _orderedMealController.menuPriceDay() : _orderedMealController.menuPriceWeek())}원 담기',
                  style: TextStyles.getTextStyle(TextType.BUTTON, WHITE_COLOR));
            },
          ),
        ),
      ),
    );
  }
}
