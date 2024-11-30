import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/mealinfo2.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';
import 'package:hankkitoktok/models/meal/meal.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';

class OrderStateDelivered extends StatefulWidget {
  const OrderStateDelivered({super.key});

  @override
  State<OrderStateDelivered> createState() => _OrderStateDeliveredState();
}

class _OrderStateDeliveredState extends State<OrderStateDelivered> {
  MealDelivery? mealDelivery;
  Meal? meal;
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    mealDelivery = await networkGetRequest111(MealDelivery.init(), 'api/v1/meal-deliveries/delivered',null );
    meal= await networkGetRequest111(Meal.init(), 'api/v1/meals/${mealDelivery?.mealId}',null );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "배송완료",
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
                    "주문하신 반찬도시락\n배달이 완료되었습니다!",
                    style: TextStyles.getTextStyle(TextType.TITLE_2, Colors.black),

                  ),
                  const SizedBox(height: 8),
                  Text(
                    "맛있는 점심식사 되세요!",
                    style: TextStyles.getTextStyle(TextType.BODY_2, Colors.black),

                    //textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Placeholder for the delivery vector image
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/2_home/main_after_delivery.png',
                      // Add your image asset here
                      height: 124,
                      fit: BoxFit.cover,
                      //alignment:
                    ),
                  ),
                ],
              ),
              // ),
              const SizedBox(height: 48),
              // Order info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "배송내역",
                    style: TextStyles.getTextStyle(
                        TextType.SUBTITLE_1, Colors.black),
                  ),
                  Text(
                    "주문번호 203",
                    style: TextStyles.getTextStyle(
                        TextType.SUBTITLE_2, PRIMARY_COLOR),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Meal details card
              MealInfo2(meal: meal ?? Meal.init()),

              //////////////////////////////////////////////
              const SizedBox(height: 8),
              // Order history button
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: PRIMARY_LIGHT, // Light background color
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // Text section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '다음 배송은 7월 3일 점심',
                            style: TextStyles.getTextStyle(
                                TextType.BODY_2, Colors.black),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '제수때 도시락 반찬들 입니다!',
                            style: TextStyles.getTextStyle(
                                TextType.SUBTITLE_2, Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Image section
                  ],
                ),
              ),
              ////////////////////////////////////////////
              SizedBox(
                height: 12,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to order history screen
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '주문내역',
                        style: TextStyles.getTextStyle(TextType.BUTTON, GRAY3),
                      ),
                      //Icon(Icons.arrow_forward_ios, size: 24,),
                      Image.asset(
                        'assets/images/1_my_page/white_right_arrow.png',
                        // Add your image asset here
                        height: 24,
                        width: 24,
                        //fit: BoxFit.cover,
                        //alignment:
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GRAY0,
                      foregroundColor: GRAY3,
                      fixedSize: Size(92, 28),
                      //fixedSize: Size.fromHeight(28),

                      //minimumSize: Size(50, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(
                        top: 4.0,
                        bottom: 4.0,
                        left: 10.0,
                        right: 2.0,
                      ),
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      iconColor: GRAY3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
