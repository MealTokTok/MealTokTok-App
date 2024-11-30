import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/calendar.dart';
import 'package:hankkitoktok/component/full_dining_calendar.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:hankkitoktok/screen/4_pay_choice/0_pay_aggrement_screen.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/ordered_meal_controller.dart';
import 'package:get/get.dart';


class FullDiningSelcet extends StatefulWidget {
  OrderType orderType;

  FullDiningSelcet({required this.orderType, super.key});

  @override
  State<FullDiningSelcet> createState() => _FullDiningSelcetState();
}

class _FullDiningSelcetState extends State<FullDiningSelcet> {
  List<String> day = [];
  final formatter = NumberFormat('#,###');
  OrderedMealController _orderedMealController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "풀대접 서비스",
            style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black),
          ),
          centerTitle: true,
          leading: Container(
            height: 24,
            width: 24,
            padding: EdgeInsets.all(8),
            child: IconButton(
              iconSize: 24,
              onPressed: () {},
              icon: Image.asset(
                'assets/images/1_my_page/left_arrow.png',
              ),
            ),
          )),
      body: GetBuilder<OrderedMealController>(
        builder: (_orderedMealController) {
          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('풀대점 서비스 구매',
                      style: TextStyles.getTextStyle(
                          TextType.TITLE_3, Colors.black)),
                  SizedBox(height: 12),
                  Container(
                    height: 37,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: SECONDARY_1.withAlpha(20), // 배경색 설정
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '반찬 도시락을 선택한 끼니에 다회용기로 배송됩니다.',
                      style:
                          TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_1),
                    ),
                  ),
                  SizedBox(height: 8),
//캘린더
                  Calendar(
                    selectDate: _orderedMealController.getSelectedDate,
                  ),
                  // FullDiningCalendar(
                  //   selectDate: (day) {
                  //     // 선택된 날짜가 월, 수, 금인지 확인하는 로직
                  //     return day.weekday == DateTime.monday ||
                  //         day.weekday == DateTime.wednesday ||
                  //         day.weekday == DateTime.friday;
                  //   },
                  // ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_orderedMealController.getFullDiningDaysOfWeek(),
                        style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black),),
                      Text(
                        '총 ${_orderedMealController.getCntFullDiningDaysOfWeek()}회',
                        style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black),
                      ),

                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('수요일, 금요일, 토요일',
                  //         style: TextStyles.getTextStyle(
                  //             TextType.BODY_1, Colors.black)),
                  //     Text('총 3회',
                  //         style: TextStyles.getTextStyle(
                  //             TextType.BODY_1, Colors.black)),
                  //   ],
                  // ),
                  SizedBox(
                    width: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('최종 금액',
                          style: TextStyles.getTextStyle(
                              TextType.TITLE_3, Colors.black)),
                      Row(
                        children: [
                          Text('${formatter.format(_getFullDiningPrice(_orderedMealController.getCntFullDiningDaysOfWeek()))} 원',
                              style: TextStyles.getTextStyle(
                                  TextType.TITLE_3, Colors.black)),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${formatter.format(_orderedMealController.getCntFullDiningDaysOfWeek()*700)} 원',
                            style: TextStyle(
                              color: GRAY3,
                              fontSize: 12,
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                              height: 0.12,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PayAggrementScreen(orderPost: _orderedMealController.getOrderedMealsSelected(widget.orderType))
                  )
              );

            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
              foregroundColor: Colors.white,
              fixedSize: Size.fromHeight(48),
              //minimumSize: Size(50, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(12),
              elevation: 0.0,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              "장바구니에 담기",
              style: TextStyles.getTextStyle(TextType.BUTTON, Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  double _getFullDiningPrice(int number) {
    switch (number) {
      case 1:
        return number*700;
      case 2:
        return number*700;
      case 3:
        return number*700*0.95;
      case 4:
        return number*700*0.95;
      case 5:
        return number*700*0.9;
      case 6:
        return number*700*0.9;
      case 7:
        return number*700*0.85;
      default:
        return 0;
    }
  }
}
