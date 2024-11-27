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
import 'package:hankkitoktok/screen/0_login_and_set_address/3_view_address_screen.dart';
import 'package:hankkitoktok/screen/1_my_page/3_delivery_history_detali_screen.dart';

import 'package:hankkitoktok/screen/2_home/2_notification_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_choice_menu_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/2_order_screen.dart';
import '../../mode.dart';
import '../../models/address/address.dart';
import '../../models/enums.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../3_menu_choice/0_meal_menu_screen.dart';

enum ScreenStatus {
  AFTER_DELIVERY,
  MENU_EMPTY,
  MENU_SELECTED,
  ON_DELIVERY,
  ADDRESS_EMPTY
}

class HomeScreen extends StatefulWidget {


  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //--------sampleData----------

  String _buttonString = '반찬도시락 메뉴담기';
  String _mainTitle = '반찬도시락\n메뉴를 선택해볼까요?';
  String _subTitle = '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!';

  ScreenStatus screenStatus = ScreenStatus.MENU_SELECTED;
  Time timeStatus = Time.AFTERNOON;
  int cartCount = 0;
  int alarmCount = 0;

  //--------sampleData----------

  late final UserController _userController;
  late final DeliveryController _deliveryController;
  late final MealController _mealController;
  late final AddressController _addressController;

  void _checkMenu1(AppMode appMode){
    if(appMode == AppMode.DEBUG){
      int type = 6;
      //0: 주소 없음 1: 메뉴 선택, 2: 배송 완료(점심), 3: 배송완료(저녁), 4: 배송중(점심), 5. 배송중(저녁) 6: 메뉴 없음
      switch(type)
      {
        case 0:
          screenStatus = ScreenStatus.ADDRESS_EMPTY;
          break;
        case 1:
          screenStatus = ScreenStatus.MENU_SELECTED;
          break;
        case 2:
          screenStatus = ScreenStatus.AFTER_DELIVERY;
          timeStatus = Time.AFTERNOON;
          break;
        case 3:
          screenStatus = ScreenStatus.AFTER_DELIVERY;
          timeStatus = Time.EVENING;
          break;
        case 4:
          screenStatus = ScreenStatus.ON_DELIVERY;
          timeStatus = Time.AFTERNOON;
          break;
        case 5:
          screenStatus = ScreenStatus.ON_DELIVERY;
          timeStatus = Time.EVENING;
          break;
        case 6:
          screenStatus = ScreenStatus.MENU_EMPTY;
          break;
      }
      //디버깅

      return ;
    }
    if(_addressController.getAddressList.isEmpty){
      screenStatus = ScreenStatus.ADDRESS_EMPTY;
      return;
    }
    //Todo: 1. 메뉴가 있을 경우 (우선순위 3)
    if(_mealController.getMeals.isNotEmpty){
      screenStatus = ScreenStatus.MENU_SELECTED;
    }
    //Todo: 2. 최근 배송 완료된게 있을 경우 (우선순위 2)
    if(_deliveryController.recentDeliveredMealDelivery != null){
      if(_deliveryController.recentDeliveredMealDelivery!.reservedTime == Time.AFTERNOON){
        screenStatus = ScreenStatus.AFTER_DELIVERY;
        timeStatus = Time.AFTERNOON;

      }else{
        screenStatus = ScreenStatus.AFTER_DELIVERY;
        timeStatus = Time.EVENING;
      }
    }
    //Todo: 3. 배송중인게 있을 경우 (우선순위 1)
    if(_deliveryController.deliveringMealDelivery != null){
      if(_deliveryController.deliveringMealDelivery!.reservedTime == Time.AFTERNOON){
        screenStatus = ScreenStatus.ON_DELIVERY;
        timeStatus = Time.AFTERNOON;
      }else{
        screenStatus = ScreenStatus.ON_DELIVERY;
        timeStatus = Time.EVENING;
      }
    }
    //Todo: 4. 메뉴가 없을 경우 (우선순위 4)

    screenStatus = ScreenStatus.MENU_EMPTY;
    debugPrint("screenStatus: $screenStatus, timeStatus: $timeStatus");
    setState(() {});
  }

  void _checkMenu2(){
    switch(screenStatus){
      case ScreenStatus.ADDRESS_EMPTY:
        _showAddressDialog();
        break;
      case ScreenStatus.MENU_SELECTED:
        _mainTitle = '반찬도시락을\n주문해볼까요?';
        _subTitle = '원하는 반찬을 원하는 끼니에 \n문앞 배송으로 든든한 한끼가 되어줄게요!';
        _buttonString = '주문하기';
        cartCount = _mealController.getMeals.length;
        break;
      case ScreenStatus.AFTER_DELIVERY:
        if(timeStatus == Time.AFTERNOON) {
          _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
          _subTitle = '맛있는 점심식사 되세요!';
          _buttonString = '배송 내역';
        }
        else{
          _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
          _subTitle = '맛있는 저녁식사 되세요!';
          _buttonString = '배송 내역';
        }
      case ScreenStatus.ON_DELIVERY:
        if(timeStatus == Time.AFTERNOON){
          _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
          _subTitle = '12시~1시 사이에 배송됩니다!';
          _buttonString = '배송 조회';
        }else{
          _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
          _subTitle = '6시~7시 사이에 배송됩니다!';
          _buttonString = '배송 조회';
        }
        break;
      default:
        _mainTitle = '반찬도시락\n메뉴를 선택해볼까요?';
        _subTitle = '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!';
        _buttonString = '반찬도시락 메뉴담기';
        break;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: 처음 들어갔을 때, 사용자 정보 가져오기
    //TODO: MealDelivery로 화면 Status 결정
    _addressController = Get.find();
    _userController = Get.find();
    _deliveryController = Get.find();
    _mealController = Get.find();
    _checkMenu1(APP_MODE);
    _checkMenu2();
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
                        : _buildMenuList(),
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
          return InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/2_home/app_bar_place.png',
                    width: 24, height: 24),
                const SizedBox(width: 8),
                controller.getAddressList.isNotEmpty
                    ? Text(
                  controller.selectedAddress.address,
                  style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR),
                )
                    : const Text('배달 주소를 설정해주세요'),
                Image.asset('assets/images/2_home/arrow_drop_down.png',
                    width: 24, height: 24),
              ],
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewAddressScreen(),
                ),
              );
            },
          );


            // DropdownButton(
            //   underline: Container(),
            //   value: controller.getAddressList.isNotEmpty
            //       ? controller.getAddressList[controller.selectedAddressIndex]
            //       : '배달 주소를 설정해주세요',
            //   items: controller.getAddressList.map((String value) {
            //     return DropdownMenuItem(
            //         value: value,
            //         child: Row(
            //           children: [
            //             Image.asset('assets/images/2_home/app_bar_place.png',
            //                 width: 24, height: 24),
            //             const SizedBox(width: 8),
            //             controller.getAddressList.isNotEmpty
            //                 ? Text(
            //               value,
            //               style: TextStyles.getTextStyle(
            //                   TextType.SUBTITLE_1, BLACK_COLOR),
            //             )
            //                 : const Text(''),
            //           ],
            //         ));
            //   }).toList(),
            //   onChanged: (String? value) async {
            //
            //     for (Address address in controller.addresses) {
            //       if (address.getAddressString == value) {
            //         await controller.setConfiguredAddress(address.deliveryAddressId);
            //       }
            //     }
            //
            //     setState(() {});
            //   });
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MealMenuScreen(),
              ),
            );
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
      //Todo: 메뉴 선택 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChoiceMenuScreen(),
        ),
      );
    }

    void order() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderScreen(),
        ),
      );
    }

    void delivery() {
      if(_deliveryController.deliveringMealDelivery == null){
        debugPrint("배송 중인 도시락 없음");
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeliveryHistoryDetailScreen(deliveryId: _deliveryController.deliveringMealDelivery!.mealDeliveryId),
        ),
      );
    }

    void delivered() {
      if(_deliveryController.recentDeliveredMealDelivery == null){
        debugPrint("배송 완료된 도시락 없음");
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeliveryHistoryDetailScreen(deliveryId: _deliveryController.recentDeliveredMealDelivery!.mealDeliveryId),
        ),
      );
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
          switch(screenStatus){
            case ScreenStatus.ADDRESS_EMPTY:
              _showAddressDialog();
              break;
            case ScreenStatus.MENU_SELECTED:
              order();
              break;
            case ScreenStatus.AFTER_DELIVERY:
              delivered();
              break;
            case ScreenStatus.ON_DELIVERY:
              delivery();
              break;
            case ScreenStatus.MENU_EMPTY:
              selectMenu();
              break;
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
              meal.mealName,
              style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${meal.mealPrice}원",
              style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
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
              itemCount: _mealController.getMeals.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildMenuCard(_mealController.getMeals[index]));
              },
            ),
          ),
        ]));
  }
}
// sampledata