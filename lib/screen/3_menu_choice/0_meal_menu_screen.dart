import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';
import 'package:hankkitoktok/models/meal/meal.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_choice_menu_screen_ver2.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_side_dish_menu_update.dart';

class MealMenuScreen extends StatefulWidget {
  const MealMenuScreen({super.key});

  @override
  State<MealMenuScreen> createState() => _MealMenuScreenState();
}

class _MealMenuScreenState extends State<MealMenuScreen> {
  //List mealList = [0, 1, 2, 3, 4, 5, 6, 7];
  List<Meal1> mealList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    mealList =
        await networkGetListRequest111(Meal1.init(), 'api/v1/meals', null);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GRAY0,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          automaticallyImplyLeading: false,
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
                      MaterialPageRoute(builder: (context) => SelectMenuScreen()),
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
                  itemCount: mealList.length,
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
                                    ...mealList[index].dishes.map((dish) {
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
                                          child: Image.network(
                                            dish.imgUrl,
                                            fit: BoxFit.cover, // 이미지가 컨테이너에 맞게 채워지도록 설정
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
                                          '${mealList[index].mealName}',
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
                                          '${mealList[index].mealPrice}원',
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectMenuScreen1(meal: mealList[index],)));

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
              //주문하기 페이지로 이동함
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
