import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/controller/meal_controller.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';
import 'package:hankkitoktok/models/meal/dish.dart';
import 'package:hankkitoktok/models/meal/dish_category.dart';
import 'package:hankkitoktok/screen/3_menu_choice/0_meal_menu_screen.dart';
import 'package:get/get.dart';

List<Dish> listSideDish = [];

List<Dish> sampleSideDishes = [];

class ChoiceMenuScreen extends StatefulWidget {
  @override
  State<ChoiceMenuScreen> createState() => _ChoiceMenuScreenState();
}

class _ChoiceMenuScreenState extends State<ChoiceMenuScreen> {
  // String obentoName = ''; // 도시락 이름
  // String sideDishType = '';
  // List<Dish> selectedSideDish = []; // 선택된 사이드디쉬 리스트
  // List<Dish> listSideDish = sampleSideDishes; // 화면에 표시할 사이드디쉬 리스트
  // List<Dish> allListSideDish = sampleSideDishes; // 모든 사이드디쉬

  // void searchSideDish() {
  //   setState(() {
  //     if (sideDishType != '') {
  //       listSideDish = allListSideDish
  //           .where((sideDish) => sideDish.type == sideDishType)
  //           .toList();
  //     } else {
  //       listSideDish = allListSideDish; // 필터 해제 시 모든 사이드디쉬를 표시
  //     }
  //   });
  // }
  //모든 반찬 들여오기
  List<Dish> selectedSideDish = [];
  List<Dish> listSideDish = [];

  int sideDishType = 0;
  List<DishCategory> listDishCategory = [];

  TextEditingController dishSearch = TextEditingController();
  TextEditingController dishName = TextEditingController();
  MealController _mealController = Get.find();
  int mealPrice = 0;
  List<int> dishIds = [];
  String textValue = "";
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      listDishCategory = await networkGetListRequest111(
          DishCategory.init(), 'api/v1/dish-categories', null);
      setState(() {}); // 카테고리 업데이트 후 화면 갱신

      // 선택된 카테고리의 반찬 리스트를 가져옴 (예: 첫 번째 카테고리로 테스트)
      if (listDishCategory.isNotEmpty) {
        listSideDish = await networkGetListRequest111(
            Dish.init(),
            'api/v1/stores/1/categories/${listDishCategory[0].categoryId}/dishes',
            null);
        setState(() {}); // 반찬 리스트 업데이트 후 화면 갱신
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "메뉴 구성",
            style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black),
          ),
          centerTitle: true,
          surfaceTintColor: Colors.transparent, // 스크롤이동시 색 바뀌는거 방지
          leading: const BackButton(),
          automaticallyImplyLeading: false,
      ),
          leading: Container(
            height: 24,
            width: 24,
            padding: EdgeInsets.all(8),
            child: IconButton(
              iconSize: 24,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Image.asset(
                'assets/images/1_my_page/left_arrow.png',
              ),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '반찬 도시락 이름',
              style: TextStyles.getTextStyle(TextType.TITLE_3, Colors.black),
            ),
            SizedBox(height: 4),
            // Expanded(
            //   child: Container(
            //     //width: 375,
            //     //너비 자유롭게 되도록 설정해둬야 함
            //     height: 48,
            //    child:
            TextFormField(
              maxLength: 10,
              controller: dishName,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.start,
              style: TextStyles.getTextStyle(TextType.BUTTON, Colors.black),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                labelText: "이름을 입력해주세요.",
                labelStyle: TextStyles.getTextStyle(TextType.BUTTON, GRAY3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: GRAY1,

                    //color: isAvailable != null && isAvailable!.isAvailable ? GRAY1 : SECONDARY,
                    width: 1.6,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: GRAY1,

                    // color: isAvailable != null && isAvailable!.isAvailable ? GRAY1 : SECONDARY,
                    width: 1.6,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: GRAY1,
                    //color: isAvailable != null && isAvailable!.isAvailable ? GRAY1 : SECONDARY,
                    width: 1.6,
                  ),
                ),
                counterText: "",
                suffix: Text(
                  "(${textValue.length}/10)",
                  style: TextStyles.getTextStyle(TextType.BODY_2, GRAY2),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              onChanged: (value) {
                setState(() {
                  textValue = value;
                });
              },
              validator: (value) {
                //띄워쓰기 입력시 거절 추가
                if (value == null || value.isEmpty) {
                  return '이름을 입력해주세요.';
                }
                // if (int.tryParse(value) == null) {
                //   return '';
                // }
                return null;
              },
            ),
            //   ),
            //
            // ),
            SizedBox(height: 40),
            Text(
              '원하는 반찬 4개를 선택해주세요.(중복선택 가능)',
              style: TextStyles.getTextStyle(TextType.TITLE_3, Colors.black),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedSideDish.isEmpty
                  ? [Container(width: 50, height: 97)]
                  : selectedSideDish.map((sideDish) {
                      return Column(children: [
                        Row(children: [
                          //SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Stack(clipBehavior: Clip.none, children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  sideDish.imgUrl,
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                ),
                                // child: Image.asset(
                                //   'assets/images/3_menu_choice/rice.png',
                                //   width: 72,
                                //   height: 72,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Positioned(
                                top: -9,
                                right: -9,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSideDish.remove(sideDish);
                                    }); // X 버튼을 눌렀을 때 실행할 동작
                                  },
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    child: Image.asset(
                                      'assets/images/3_menu_choice/cancel.png',
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(width: 4),
                        ]),
                        SizedBox(width: 4),
                        Container(
                          width: 72,
                          child: Text(
                            sideDish.dishName,
                            style: TextStyles.getTextStyle(
                                TextType.BODY_2, Colors.black),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ]);
                    }).toList(),
            ),
            SizedBox(height: 20),
            //Expanded(
            //child: Container(
            //width: 375,
            //너비 자유롭게 되도록 설정해둬야 함
            //height: 48,
            //child:
            TextFormField(
              maxLength: 10,
              controller: dishSearch,
              textAlignVertical: TextAlignVertical.top,
              textAlign: TextAlign.start,
              style: TextStyles.getTextStyle(TextType.BUTTON, Colors.black),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () async {
                    try {
                      listSideDish = await networkGetListRequest111(
                        Dish.init(),
                        'api/v1/stores/1/dishes/search',
                        {
                          'keyword': dishSearch.text,
                        },
                      );
                      setState(() {}); // 새로운 반찬 리스트가 업데이트된 후 화면 갱신
                    } catch (e) {
                      print('Error loading side dishes: $e');
                    }
                  },
                  icon: Image.asset(
                    width: 24,
                    'assets/images/1_my_page/search.png',
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                labelText: "반찬명을 검색해주세요.",
                labelStyle: TextStyles.getTextStyle(TextType.BUTTON, GRAY3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: GRAY1,

                    //color: isAvailable != null && isAvailable!.isAvailable ? GRAY1 : SECONDARY,
                    width: 1.6,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: GRAY1,

                    // color: isAvailable != null && isAvailable!.isAvailable ? GRAY1 : SECONDARY,
                    width: 1.6,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: GRAY1,
                    //color: isAvailable != null && isAvailable!.isAvailable ? GRAY1 : SECONDARY,
                    width: 1.6,
                  ),
                ),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              validator: (value) {
                //띄워쓰기 입력시 거절 추가
                if (value == null || value.isEmpty) {
                  return '반찬명을 입력해주세요.';
                }
                // if (int.tryParse(value) == null) {
                //   return '';
                // }
                return null;
              },
            ),
            //),

            //),
            SizedBox(height: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      ...listDishCategory.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Expanded(
                            child: TextButton(
                              onPressed: () async {
                                try {
                                  listSideDish = await networkGetListRequest111(
                                    Dish.init(),
                                    'api/v1/stores/1/categories/${category.categoryId}/dishes',
                                    null,
                                  );
                                  setState(() {
                                    selectedCategory = category.categoryName;
                                  }); // 새로운 반찬 리스트가 업데이트된 후 화면 갱신
                                } catch (e) {
                                  print('Error loading side dishes: $e');
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    selectedCategory == category.categoryName
                                        ? PRIMARY_COLOR
                                        : GRAY1,
                                foregroundColor:
                                    selectedCategory == category.categoryName
                                        ? GRAY0
                                        : GRAY4,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.0), // 둥근 모서리 적용
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 12),
                              ),
                              child: Text(
                                '${category.categoryName}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Pretendard Variable',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: listSideDish.length,
                      itemBuilder: (context, index) {
                        final sideDish = listSideDish[index];
                        return Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (selectedSideDish.length < 4) {
                                    setState(() {
                                      selectedSideDish.add(sideDish);
                                    });
                                    print(
                                        'Selected Side Dish: ${sideDish.dishName}');
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    width: 104,
                                    height: 104,
                                    sideDish.imgUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: double.infinity,
                              child: Text(
                                sideDish.dishName,
                                style: TextStyles.getTextStyle(
                                    TextType.BODY_2, Colors.black),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              if (selectedSideDish.length == 4) {
                for (int i = 0; i < selectedSideDish.length; i++) {
                  mealPrice += selectedSideDish[i].dishPrice;
                  dishIds.add(selectedSideDish[i].dishId);
                }
                await _mealController.addMeal(dishName.text, mealPrice, dishIds);
                // await networkRequest('api/v1/meals', RequestType.POST, {
                //   "mealName": dishName.text,
                //   "mealPrice": mealPrice,
                //   "dishIds": dishIds
                // });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MealMenuScreen()));
              } else {}
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
              "반찬 도시락 추가",
              style: TextStyles.getTextStyle(TextType.BUTTON, Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
