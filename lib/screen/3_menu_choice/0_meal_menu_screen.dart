import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/controller/meal_controller.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';
import 'package:hankkitoktok/models/meal/meal.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_choice_menu_screen_ver2.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_side_dish_menu_update.dart';
import 'package:hankkitoktok/screen/5_order/3_order_state_order_fail.dart';

class MealMenuScreen extends StatefulWidget {
  const MealMenuScreen({super.key});

  @override
  State<MealMenuScreen> createState() => _MealMenuScreenState();
}

class _MealMenuScreenState extends State<MealMenuScreen> {
  //List mealList = [0, 1, 2, 3, 4, 5, 6, 7];
  MealController _mealController = Get.find();
  List<Meal> unavailableList = []; // 품절된 도시락을 담는 리스트

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    for (var meal in _mealController.getMeals) {
      bool hasUnavailableDish = false;

      // meal의 dishes 중 ON_SALE 상태가 아닌 dish가 있는지 확인
      for (var dish in meal.dishes) {
        if (dish.dishState != 'ON_SALE') {
          hasUnavailableDish = true;
          break; // ON_SALE이 아닌 dish를 찾으면 바로 중단
        }
      }

      // ON_SALE이 아닌 dish가 있는 meal만 unavailableList에 추가
      if (hasUnavailableDish) {
        unavailableList.add(meal);
      }
    }

    //Todo 테스트 후에 삭제하기
    // unavailableList.add(mealList[1]);
    // unavailableList.add(mealList[2]);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GRAY0,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(

          backgroundColor: GRAY0,
          title: const Text('반찬 구성',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w700,
                height: 0.07,
                // letterSpacing: -0.40,
              )),

          actions: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: SizedBox(
                height: 32.0,
                width: 68.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChoiceMenuScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: PRIMARY_COLOR, // 버튼 배경 색상
                    foregroundColor: Colors.white, // 글자 및 아이콘 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // 둥근 모서리 반경
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        child: Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                      Text(
                        "추가",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w500,
                          height: 0.11,
                          letterSpacing: -0.28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 68),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내가 담은 반찬도시락',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w600,
                //height: 0.08,
                //letterSpacing: -0.36,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _mealController.getMeals.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x0C000000),
                                blurRadius: 10,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ..._mealController.getMeals[index].dishes.map((dish) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            // color: PRIMARY_COLOR,
                                          ),
                                          width: 72,
                                          height: 72,
                                          child: dish.dishState == 'ON_SALE'
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  // BorderRadius 추가

                                                  // child: Image.asset(
                                                  //   'assets/images/2_home/main_on_delivery.png',
                                                  //   // Add your image asset here
                                                  //   width: 72,
                                                  //   height: 72,
                                                  //   fit: BoxFit.cover,
                                                  //   //alignment:
                                                  // ),
                                                  child: Image.network(
                                                    dish.imgUrl,
                                                    fit: BoxFit.cover,
                                                    // 이미지가 컨테이너에 맞게 채워지도록 설정
                                                    width: 72,
                                                    height: 72,
                                                  ),
                                                )
                                              : Stack(
                                                  children: [
                                                    // 흑백 필터를 적용한 이미지
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      // BorderRadius 추가
                                                      child: ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          Colors.grey,
                                                          BlendMode.saturation,
                                                        ),
                                                        // child: Image.asset(
                                                        //   'assets/images/2_home/main_on_delivery.png',
                                                        //   // Add your image asset here
                                                        //   width: 72,
                                                        //   height: 72,
                                                        //   fit: BoxFit.cover,
                                                        //   //alignment:
                                                        // ),
                                                        child: Image.network(
                                                          dish.imgUrl,
                                                          fit: BoxFit.cover,
                                                          // 이미지가 컨테이너에 맞게 채워지도록 설정
                                                          width: 72,
                                                          height: 72,
                                                        ),
                                                      ),
                                                    ),
                                                    // "품절" 텍스트를 이미지 위에 배치
                                                    Positioned.fill(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          '품절',
                                                          style: TextStyles
                                                              .getTextStyle(
                                                                  TextType
                                                                      .BUTTON,
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      );
                                    }).toList(),
                                    // Container(
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(24),
                                    //       //color: PRIMARY_COLOR,
                                    //     ),
                                    //     width: 72,
                                    //     height: 72,
                                    //     child: Image.network(
                                    //       '${mealList[index].dishes[i].imgUrl}',
                                    //       fit: BoxFit.cover, // 이미지가 컨테이너에 맞게 채워지도록 설정
                                    //     ),
                                    //   ),
                                    //   const SizedBox(width: 4),
                                    //
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(24),
                                    //     color: PRIMARY_COLOR,
                                    //   ),
                                    //   width: 72,
                                    //   height: 72,
                                    // ),
                                    // const SizedBox(width: 4),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(24),
                                    //     color: PRIMARY_COLOR,
                                    //   ),
                                    //   width: 72,
                                    //   height: 72,
                                    // ),
                                    // const SizedBox(width: 4),
                                    // Container(
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(24),
                                    //     color: PRIMARY_COLOR,
                                    //   ),
                                    //   width: 72,
                                    //   height: 72,
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          '${_mealController.getMeals[index].mealName}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Pretendard Variable',
                                            fontWeight: FontWeight.w400,
                                            //height: 0.09,
                                            //letterSpacing: -0.32,
                                          ),
                                        ),
                                        Text(
                                          '${_mealController.getMeals[index].mealPrice}원',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'Pretendard Variable',
                                            fontWeight: FontWeight.w600,
                                            //height: 0.11,
                                            //letterSpacing: -0.28,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 48,
                                      //height: 29,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectMenuScreen1(
                                                        meal: _mealController.getMeals[index],
                                                      )));
                                        },
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          side: BorderSide(
                                              width: 1, color: GRAY2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          '수정',
                                          style: TextStyle(
                                            color: GRAY4,
                                            fontSize: 14,
                                            fontFamily: 'Pretendard Variable',
                                            fontWeight: FontWeight.w500,
                                            height: 0.11,
                                            //letterSpacing: -0.28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    );
                  }),
            ),
            // Container(
            //   height: 45,
            // )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(20, 9, 20, 12),
        child: Container(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if(unavailableList.length>0){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderStateOrderFail(unavailableList: unavailableList,
                    ),
                  ),
                );
              }
              else{
                //주문하기 페이지로 이동함
              }
            },
            child: Text(
              '반찬 도시락 구매',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
                height: 0.11,
                // letterSpacing: -0.28,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
