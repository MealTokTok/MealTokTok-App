import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/four_image.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:hankkitoktok/models/full_service/full_service.dart';
import 'package:hankkitoktok/models/meal/meal.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/models/meal/meal_delivery_order.dart';
import 'package:intl/intl.dart'; // Date formatting을 위한 패키지

class ReturnFullDining extends StatefulWidget {
  const ReturnFullDining({super.key});

  @override
  _ReturnFullDiningState createState() => _ReturnFullDiningState();
}

class _ReturnFullDiningState extends State<ReturnFullDining> {
  List<DiningData> diningList = [];
  List<MealDelivery> mealDeliveryList = [];
  List<Meal1> mealList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // diningList 불러오기
      diningList = await networkGetListRequest111(
          DiningData.init(), 'api/v1/full-dinings/full-dinings', null);

      // mealDeliveryList에 데이터를 추가
      for (int i = 0; i < diningList.length; i++) {
        MealDelivery mealDelivery = await networkGetRequest111(
            MealDeliveryOrder.init(),
            'api/v1/meal-deliveries/${diningList[i].mealDeliveryId}',
            null);
        mealDeliveryList.add(mealDelivery);
      }

//Todo 인덱스 i 0부터 시작하도록 하기
      // mealList에 데이터를 추가
      for (int i = 1; i < mealDeliveryList.length; i++) {
        Meal1 meal = await networkGetRequest111(
            Meal1.init(),
            'api/v1/meals/${mealDeliveryList[i].mealId}', // 경로 오타 수정
            null);
        mealList.add(meal);
      }

      // 데이터가 정상적으로 불러와졌음을 UI에 반영
      setState(() {});
    } catch (e) {
      // 에러 처리
      debugPrint("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "다회용기 수거",
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '배송된 상품',
                style:
                TextStyles.getTextStyle(TextType.SUBTITLE_1, Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  // itemCount: diningList.length,
                  //Todo 위에 꺼로 바꾸기
                    itemCount: mealList.length,
                    itemBuilder: (context, index) {
                      return buildDeliveryItem(
                          mealDelivery: mealDeliveryList[index],
                          meal: mealList[index],
                          status: diningList[index].collectState,
                          id: diningList[index].fullDiningId
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDeliveryItem({
    required MealDelivery mealDelivery,
    required Meal1 meal,
    required String status,
    required int id,
  }) {
    // DateTime을 'YYYY.MM.DD' 형식으로 변환
    String formattedDate =
    DateFormat('yyyy.MM.dd').format(mealDelivery.reservedDate!);

    // reservedTime을 '점심' 또는 '저녁'으로 변환
    String formattedTime =
    mealDelivery.reservedTime == Time.AFTERNOON ? '점심' : '저녁';

    CollectingState collectingState =
    stringToCollecting(status); // CollectingState로 변환
    Color statusColor;

    switch (collectingState) {
      case CollectingState.NOT_COLLECTED:
        statusColor = SECONDARY_2;
        break;
      case CollectingState.COLLECT_REQUESTED:
        statusColor = PRIMARY_COLOR;
        break;
      case CollectingState.COLLECTED:
        statusColor = SECONDARY_1;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: GRAY1, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 음식 이미지

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상태 (미반납, 수거중, 반납완료)

                Container(
                  //width: 72,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    //color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor, width: 1),
                  ),
                  child: Text(
                    collectingState == CollectingState.NOT_COLLECTED
                        ? '미반납'
                        : collectingState == CollectingState.COLLECT_REQUESTED
                        ? '수거중'
                        : '반납완료',
                    style:
                    TextStyles.getTextStyle(TextType.BUTTON, statusColor),
                  ),
                ),

                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        buildFourImage(meal.getDishUrls(), 40, 40),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$formattedDate - $formattedTime',
                              style: TextStyles.getTextStyle(
                                  TextType.SMALL, GRAY4),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${meal.mealName}',
                              style: TextStyles.getTextStyle(
                                  TextType.BODY_2, Colors.black),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              '${meal.mealPrice}원',
                              style: TextStyles.getTextStyle(
                                  TextType.CAPTION, Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        if (collectingState == CollectingState.NOT_COLLECTED)
                          TextButton(
                            //Todo 버튼 동작하도록 만들기
                            onPressed: () async {
                              await networkRequest('api/v1/full-dinings/full-dinings/${id}/COLLECT_REQUESTED', RequestType.PATCH, {

                                "fullDiningId": id,
                                "collectingState ": "COLLECT_REQUESTED",

                              });
                              setState(() {});

                            },
                            child: Text(
                              '반납하기',
                              style: TextStyles.getTextStyle(
                                  TextType.BUTTON, Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              backgroundColor: PRIMARY_COLOR, // 배경색
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8.0), // 둥근 모서리
                              ),

                              //minimumSize: Size.fromHeight(36),
                            ),
                          ),
                        if (collectingState ==
                            CollectingState.COLLECT_REQUESTED)
                          TextButton(
                            onPressed: () async {
                              await networkRequest('api/v1/full-dinings/full-dinings/${id}/NOT_COLLECTED', RequestType.PATCH, {

                                "fullDiningId": id,
                                "collectingState ": "NOT_COLLECTED",

                              });
                              setState(() {});

                            },
                            child: Text(
                              '반납취소',
                              style: TextStyles.getTextStyle(
                                  TextType.BUTTON, GRAY4),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              backgroundColor: GRAY1, // 배경색
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8.0), // 둥근 모서리
                              ),

                              //minimumSize: Size.fromHeight(36),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          // 버튼 (반납하기, 반납취소)
        ],
      ),
    );
  }
}
