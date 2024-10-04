import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/ordered_meal_controller.dart';

import '../../component/calendar.dart';
import '../../const/color.dart';
import '../../const/style2.dart';
import '../../models/enums.dart';
import '../4_pay_choice/0_pay_aggrement_screen.dart';

class TmpFullServiceScreen extends StatelessWidget {

  OrderType orderType;
  TmpFullServiceScreen({
    required this.orderType,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderedMealController>(
        builder: (_orderedMealController) {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  children: [
                    //캘린더, 선택시 변화 x
                    Calendar(
                      selectDate: _orderedMealController.getSelectedDate,
                    ),

                    // 임시: 풀대접 체크박스
                    IconButton(
                        onPressed: () {
                          //주간 배송에서 선택한 모든 주문 도시락에 풀대접 서비스 적용/해제
                          _orderedMealController.updateFullServiceSelected(orderType);
                        },
                        icon: Image.asset(
                          //풀대접 서비스 선택 여부에 따라 이미지 변경
                            _orderedMealController.getFullServiceSelected() ? 'assets/images/3_menu_choice/checkbox_selected.png' : 'assets/images/3_menu_choice/checkbox_unselected.png',
                            width: 24,
                            height: 24
                        )
                    ),

                    ElevatedButton(
                        onPressed: () {
                          //TODO: 풀대접 서비스 페이지 보기
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PayAggrementScreen(orderPost: _orderedMealController.getOrderedMealsSelected(orderType))
                              )
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
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
                                child: Text('테스트',
                                    style:
                                    TextStyles.getTextStyle(
                                        TextType.BUTTON,
                                        WHITE_COLOR)))))
                  ]
              )
          );
        },
      )
    );
  }
}
