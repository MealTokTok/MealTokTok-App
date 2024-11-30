import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/four_image.dart';
import 'package:hankkitoktok/component/mealinfo2.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/models/meal/meal.dart';

class OrderStateOrderFail extends StatefulWidget {
  List<Meal> unavailableList;

  OrderStateOrderFail({
    required this.unavailableList,
    super.key,
  });

  @override
  State<OrderStateOrderFail> createState() => _OrderStateOrderFailState();
}

class _OrderStateOrderFailState extends State<OrderStateOrderFail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "주문실패",
          style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with image and delivery text
              //Expanded(
              //flex: 2,
              //child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "주문을 완료하지 못했어요.",
                    style:
                        TextStyles.getTextStyle(TextType.TITLE_2, Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "주문이 불가한 항목이 있어요.",
                    style:
                        TextStyles.getTextStyle(TextType.BODY_2, SECONDARY_2),

                    //textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Placeholder for the delivery vector image
                ],
              ),
              // ),
      //         ...widget.unavailableList.map((meal){
      // return MealInfo(meal: meal);
      //
      // })
              ...widget.unavailableList.map((meal) {
                return MealInfo2(meal: meal); // return 추가
              }).toList(),
              // Meal details card
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '홈으로',
                    style: TextStyles.getTextStyle(TextType.BUTTON, GRAY4),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(12, 17, 12, 17),
                    backgroundColor: GRAY1, // 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
                    ),
                    //minimumSize: Size(124, 48),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '다시 주문하기',
                    style:
                        TextStyles.getTextStyle(TextType.BUTTON, Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(12, 17, 12, 17),
                    backgroundColor: PRIMARY_COLOR, // 주황색 배경
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
                    ),
                    //minimumSize: Size(124, 48),
                  ),
                ),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


}
