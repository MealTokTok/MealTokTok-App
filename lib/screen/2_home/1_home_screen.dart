import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/component/mealinfo.dart';
import 'package:hankkitoktok/component/four_image.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/controller/address_controller.dart';
import 'package:hankkitoktok/controller/delivery_controller.dart';
import 'package:hankkitoktok/controller/meal_controller.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';

import 'package:hankkitoktok/controller/user_controller.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/models/meal/meal.dart';

import 'package:hankkitoktok/screen/2_home/2_notification_screen.dart';
import '../../models/enums.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum ScreenStatus {
  AFTER_DELIVERY,
  MENU_EMPTY,
  MENU_SELECTED,
  ON_DELIVERY,
  ADDRESS_EMPTY
}

class HomeScreen extends StatefulWidget {
  int testStatus = 1;

  HomeScreen({required this.testStatus, super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //--------sampleData----------

  String _dropdownValue = '';
  String _buttonString = '반찬도시락 메뉴담기';
  String _mainTitle = '반찬도시락\n메뉴를 선택해볼까요?';
  String _subTitle = '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!';

  OrderState orderState = OrderState.DELIVERING;
  ScreenStatus screenStatus = ScreenStatus.MENU_EMPTY;
  Time timeStatus = Time.AFTERNOON;
  int cartCount = 1;
  int alarmCount = 0;

  //--------sampleData----------

  late final UserController _userController;
  late final DeliveryController _deliveryController;
  late final MealController _mealController;

  // void _checkMenu() {
  //   if (widget.testStatus == 1) {
  //     //Todo 조건: menu empty
  //     setState(() {
  //       screenStatus = ScreenStatus.MENU_EMPTY;
  //       _mainTitle = '반찬도시락\n메뉴를 선택해볼까요?';
  //       _subTitle = '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!';
  //       _buttonString = '반찬도시락 메뉴담기';
  //     });
  //   }
  //   if (widget.testStatus == 2) {
  //     //Todo 조건: mealmenu is not empty
  //     setState(() {
  //       screenStatus = ScreenStatus.MENU_SELECTED;
  //       _buttonString = '주문하기';
  //       });
  //     }
  //         if (widget.testStatus == 3) {
  //       // Todo 조건: 배송 중, 점심
  //
  //       setState(() {
  //         screenStatus = ScreenStatus.ON_DELIVERY;
  //         timeStatus = Time.AFTERNOON;
  //         _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
  //         _subTitle = '12시~1시 사이에 배송됩니다!';
  //         _buttonString = '배송 조회';
  //       });
  //     }
  //     if (widget.testStatus == 4) {
  //       // Todo: 조건: 배송 중, 저녁
  //       setState(() {
  //         screenStatus = ScreenStatus.ON_DELIVERY;
  //         timeStatus = Time.EVENING;
  //         _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
  //         _subTitle = '6시~7시 사이에 배송됩니다!';
  //         _buttonString = '배송 조회';
  //       });
  //     }
  //     // if (widget.testStatus == 5) {
  //     //   // Todo: 조건: 배송 후, 점심
  //     //   setState(() {
  //     //     screenStatus = ScreenStatus.AFTER_DELIVERY;
  //     //     timeStatus = Time.AFTERNOON;
  //     //     _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
  //     //     _subTitle = '맛있는 점심식사 되세요!';
  //     //     _buttonString = '배송 내역';
  //     //   });
  //     // }
  //     // if (widget.testStatus == 6) {
  //     //   // Todo: 조건: 배송 후, 저녁
  //     //   setState(() {
  //     //     screenStatus = ScreenStatus.AFTER_DELIVERY;
  //     //     timeStatus = Time.EVENING;
  //     //     _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
  //     //     _subTitle = '맛있는 저녁식사 되세요!';
  //     //     _buttonString = '배송 내역';
  //     //   });
  //     // }
  //   }

  void _checkMenu() {
    if (_mealController.getMeals.isEmpty) {
      //Todo 조건: menu empty
      setState(() {
        screenStatus = ScreenStatus.MENU_EMPTY;
        _mainTitle = '반찬도시락\n메뉴를 선택해볼까요?';
        _subTitle = '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!';
        _buttonString = '반찬도시락 메뉴담기';
      });
      return;
    }
    if (_deliveryController.deliveringMealDelivery != null) {
      if (_deliveryController
              .deliveringMealDelivery!.reservedTime ==
          Time.AFTERNOON) {
        // Todo 조건: 배송 중, 점심
        setState(() {
          screenStatus = ScreenStatus.ON_DELIVERY;
          timeStatus = Time.AFTERNOON;
          _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
          _subTitle = '12시~1시 사이에 배송됩니다!';
          _buttonString = '배송 조회';
        });
      } else {
        // Todo 조건: 배송 중, 저녁
        setState(() {
          screenStatus = ScreenStatus.ON_DELIVERY;
          timeStatus = Time.EVENING;
          _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
          _subTitle = '6시~7시 사이에 배송됩니다!';
          _buttonString = '배송 조회';
        });
      }
    }
    if (_deliveryController.recentDeliveredMealDelivery != null) {
      if (_deliveryController
              .recentDeliveredMealDelivery!.reservedTime ==
          Time.AFTERNOON) {
        // Todo 조건: 배송 후, 점심
        setState(() {
          screenStatus = ScreenStatus.AFTER_DELIVERY;
          timeStatus = Time.AFTERNOON;
          _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
          _subTitle = '맛있는 점심식사 되세요!';
          _buttonString = '배송 내역';
        });
      } else {
        // Todo 조건: 배송 중, 저녁
        setState(() {
          screenStatus = ScreenStatus.AFTER_DELIVERY;
          timeStatus = Time.EVENING;
          _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
          _subTitle = '맛있는 저녁식사 되세요!';
          _buttonString = '배송 내역';
        });
      }
    }
    if (_deliveryController.deliveringMealDelivery == null &&
        _deliveryController.recentDeliveredMealDelivery == null) {
      //Todo 조건: mealmenu is not empty
      setState(() {
        screenStatus = ScreenStatus.MENU_SELECTED;
        _mainTitle = '반찬도시락을\n주문해볼까요?';
        _subTitle = '원하는 반찬을 원하는 끼니에 \n문앞 배송으로 든든한 한끼가 되어줄게요!';
        _buttonString = '주문하기';
      });
    }
  }

  @override
  void initState() {
    // TODO: 처음 들어갔을 때, 사용자 정보 가져오기
    //TODO: MealDelivery로 화면 Status 결정
    _userController = Get.find();
    _deliveryController = Get.find();
    _mealController = Get.find();
    _checkMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(_deliveryController.fullDiningCount),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    screenStatus == ScreenStatus.AFTER_DELIVERY
                        ? _buildAfterDeliveryTitle()
                        : _buildMainTitle(),
                    const SizedBox(height: 32),
                    screenStatus == ScreenStatus.ON_DELIVERY
                        ? _buildOnDelivery()
                        : screenStatus == ScreenStatus.AFTER_DELIVERY
                            ? MealInfo(
                                mealDelivery: _deliveryController
                                    .recentDeliveredMealDelivery!,
                                orderNumberColor: GREY_COLOR_4)
                            : screenStatus == ScreenStatus.MENU_EMPTY
                                ? _buildMenuEmpty()
                                : _buildMenuList(mealMenuList),
                    const SizedBox(height: 10),
                    _buildSelectedMenuButton(screenStatus),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    //Todo: 사용자가 저장한 주소로 변경

    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: GetBuilder<AddressController>(
        builder: (controller) {
          return DropdownButton(
              underline: Container(),
              value: controller.getAddressList.isNotEmpty
                  ? controller.getAddressList[controller.selectedAddressIndex]
                  : '배달 주소를 설정해주세요',
              items: controller.getAddressList.map((String value) {
                return DropdownMenuItem(
                    value: value,
                    child: Row(
                      children: [
                        Image.asset('assets/images/2_home/app_bar_place.png',
                            width: 24, height: 24),
                        const SizedBox(width: 8),
                        controller.getAddressList.isNotEmpty
                            ? Text(
                                value,
                                style: TextStyles.getTextStyle(
                                    TextType.SUBTITLE_1, BLACK_COLOR),
                              )
                            : const Text(''),
                      ],
                    ));
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  for (int i = 0; i < controller.getAddressList.length; i++) {
                    if (controller.getAddressList[i] == value) {
                      controller.selectedAddressIndex = i;
                    }
                  }
                });
              });
        },
      ),
      actions: [
        IconButton(
          icon: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/images/2_home/app_bar_cart.png'),
              ),
              (cartCount > 0)
                  ? Positioned(
                      right: 3,
                      top: 3,
                      child: Container(
                        padding: (cartCount > 9)
                            ? const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1)
                            : const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: (cartCount > 9)
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          borderRadius: (cartCount > 9)
                              ? BorderRadius.circular(50)
                              : null,
                        ),
                        child: Text(
                          cartCount.toString(),
                          style: badgeStyle,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          onPressed: () {
            // Todo: 첫번째 버튼 눌렀을 때 로직
          },
        ),
        IconButton(
          icon: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/images/2_home/app_bar_alarm.png'),
              ),
              (alarmCount > 9)
                  ? Positioned(
                      right: 3,
                      top: 3,
                      child: Container(
                        padding: (alarmCount > 9)
                            ? const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1)
                            : const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: (alarmCount > 9)
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          borderRadius: (alarmCount > 9)
                              ? BorderRadius.circular(50)
                              : null,
                        ),
                        child: Text(
                          alarmCount.toString(),
                          style: badgeStyle,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          onPressed: () {
            // Todo: 두번째 버튼 눌렀을 때 로직
            Get.to(() => NotificationScreen());
          },
        ),
      ],
    );
  }

  void _showAddressDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        surfaceTintColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('배달 주소를\n설정하지 않았어요!',
                style: TextStyles.getTextStyle(TextType.TITLE_2, BLACK_COLOR)),
            Text('배달 주소를 설정하고\n반찬도시락을 주문해보세요!',
                style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
            const SizedBox(height: 4),
            const Center(
              child: Image(
                image: AssetImage(
                    'assets/images/2_home/alert_dialog_delivery.png'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                debugPrint("배달 주소 설정 버튼 클릭");
                //Todo: 배달주소 설정 페이지 이동
              },
              child: Center(
                child: Text(
                  '주소 설정하기',
                  style: TextStyles.getTextStyle(TextType.BUTTON, WHITE_COLOR),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildBanner(int containerCount) {
    return InkWell(
        onTap: () {
          debugPrint("Panel Clicked");
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: BANNER_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (containerCount > 0)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('다회용기를 보냉백에 넣어\n문앞에 놔주세요',
                              style: TextStyles.getTextStyle(
                                  TextType.BUTTON, BLACK_COLOR)),
                          const SizedBox(height: 10),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: '반납할 ',
                                style: TextStyles.getTextStyle(
                                    TextType.TITLE_2, BLACK_COLOR)),
                            TextSpan(
                                text: '다회용기 $containerCount개',
                                style: TextStyles.getTextStyle(
                                    TextType.TITLE_2, PRIMARY_COLOR)),
                          ]))
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '식사 후 귀찮은 설거지까지\n한끼톡톡에서 다!',
                            style: TextStyles.getTextStyle(
                                TextType.BUTTON, BLACK_COLOR),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(text: '한끼 풀대접', style: noName),
                            TextSpan(
                                text: ' 오픈!',
                                style: TextStyles.getTextStyle(
                                    TextType.TITLE_2, BLACK_COLOR)),
                          ]))
                        ],
                      ),
                (containerCount > 0)
                    ? const Image(
                        image: AssetImage(
                            'assets/images/2_home/banner_full_service.png'),
                        width: 87,
                        height: 80,
                      )
                    : const Image(
                        image:
                            AssetImage('assets/images/2_home/banner_image.png'),
                        width: 100,
                        height: 80,
                      ),
              ],
            )

            //const Image(
            //  image: AssetImage('assets/images/2_home/banner.png')),
            ));
  }

  Widget _buildSelectedMenuButton(ScreenStatus screenStatus) {
    void selectMenu() {
      debugPrint("메뉴 담기 버튼 클릭");
      //Todo: 메뉴 선택 페이지로 이동
    }

    void order() {
      debugPrint("주문하기 버튼 클릭");
      //Todo: 주문하기 페이지로 이동
    }

    void delivery() {
      debugPrint("배송조회 버튼 클릭");
      //Todo: 배송조회 페이지로 이동
    }

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          if (screenStatus == ScreenStatus.ON_DELIVERY) {
            delivery();
          } else if (screenStatus == ScreenStatus.AFTER_DELIVERY) {
          } else if (screenStatus == ScreenStatus.MENU_EMPTY) {
            selectMenu();
          } else {
            order();
          }
        },
        child: Center(
            child: Text(_buttonString,
                style: TextStyles.getTextStyle(TextType.BUTTON, WHITE_COLOR))));
  }

  Widget _buildAfterDeliveryTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_mainTitle,
              style: TextStyles.getTextStyle(TextType.TITLE_2, BLACK_COLOR_2)),
          const SizedBox(height: 16),
          Text(_subTitle,
              style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR)),
        ],
      ),
      const Padding(
          padding: EdgeInsets.only(top: 32),
          child: Image(
              image: AssetImage('assets/images/2_home/main_after_delivery.png'),
              width: 112,
              height: 116)),
    ]);
  }

  Widget _buildMainTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _mainTitle,
          style: TextStyles.getTextStyle(TextType.TITLE_2, BLACK_COLOR_2),
        ),
        const SizedBox(height: 16),
        Text(
          _subTitle,
          style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR),
        ),
        //_buildMenuList(mealMenuList),
      ],
    );
  }

  Widget _buildOnDelivery() {
    return const SizedBox(
      height: 304,
      child: Center(
        child: Image(
            image: AssetImage('assets/images/2_home/main_on_delivery.png')),
      ),
    );
  }

  Widget _buildMenuEmpty() {
    return const SizedBox(
      height: 304,
      child: Center(
        child: Image(
            image: AssetImage('assets/images/2_home/main_menu_empty.png')),
      ),
    );
  }

  Widget _buildMenuCard(Meal meal) {
    List<String> imageList = meal.getDishUrls();
    return Column(
      children: [
        buildFourImage(imageList, 60, 60),
        const SizedBox(height: 8),
        SizedBox(
          width: 120,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              meal.name,
              style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${meal.price}원",
              style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildMenuList(List<Meal> mealList) {
    return SizedBox(
        height: 304,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("내가 담은 반찬 도시락",
                  style:
                      TextStyles.getTextStyle(TextType.TITLE_3, BLACK_COLOR)),
              InkWell(
                  onTap: () {
                    //Todo: 메뉴 수정 페이지로 이동
                  },
                  child: Row(
                    children: [
                      Text("수정",
                          style: TextStyles.getTextStyle(
                              TextType.BUTTON, GREY_COLOR_3)),
                      const Image(
                        image:
                            AssetImage('assets/images/2_home/arrow_right.png'),
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mealList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildMenuCard(mealList[index]));
              },
            ),
          ),
        ]));
  }
}
// sampledata
