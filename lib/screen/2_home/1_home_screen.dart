import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/component/four_image.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';
import 'package:hankkitoktok/const/style.dart';
import 'package:hankkitoktok/models/meal_menu/ordered_meal_menu.dart';
import 'package:hankkitoktok/models/meal_menu/meal_menu.dart';
import 'package:hankkitoktok/screen/2_home/2_notification_screen.dart';

enum ScreenStatus { AFTER_DELIVERY, MENU_EMPTY, MENU_SELECTED, ON_DELIVERY }

enum TimeStatus { LUNCH, DINNER }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //--------sampleData----------
  List<String> addressList = ['충북대학교 충대로1', '충북대학교 충대로2', '충북대학교 충대로3'];
  List<String> addressListEmpty = [];
  String dropdownValue = '충북대학교 충대로1';
  String _buttonString = '반찬도시락 메뉴담기';
  String _mainTitle = '반찬도시락\n메뉴를 선택해볼까요?';
  String _subTitle = '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!';
  ScreenStatus screenStatus = ScreenStatus.MENU_EMPTY;
  TimeStatus timeStatus = TimeStatus.LUNCH;
  int cartCount = 1;
  int alarmCount = 0;
  int containerCount = 30;

  int testStatus = 1;

  //--------sampleData----------

  List<MealMenu> mealMenuListEmpty = [];

  void _checkAddress() {
    if (addressList.isEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _showAddressDialog();
      });
    }
  }

  void _checkMenu() {
    if (testStatus == 1) {
      //Todo 조건: menu empty
      setState(() {
        screenStatus = ScreenStatus.MENU_EMPTY;
        _mainTitle = '반찬도시락\n메뉴를 선택해볼까요?';
        _subTitle = '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!';
        _buttonString = '반찬도시락 메뉴담기';
      });
    }
    if (testStatus == 2) {
      //Todo 조건: mealmenu is not empty
      setState(() {
        screenStatus = ScreenStatus.MENU_SELECTED;
        _mainTitle = '반찬도시락을\n주문해볼까요?';
        _subTitle = '원하는 반찬을 원하는 끼니에 \n문앞 배송으로 든든한 한끼가 되어줄게요!';
        _buttonString = '주문하기';
      });
    }
    if (testStatus == 3) {
      // Todo 조건: 배송 중, 점심

      setState(() {
        screenStatus = ScreenStatus.ON_DELIVERY;
        timeStatus = TimeStatus.LUNCH;
        _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
        _subTitle = '12시~1시 사이에 배송됩니다!';
        _buttonString = '배송 조회';
      });
    }
    if (testStatus == 4) {
      // Todo: 조건: 배송 중, 저녁
      setState(() {
        screenStatus = ScreenStatus.ON_DELIVERY;
        timeStatus = TimeStatus.DINNER;
        _mainTitle = '주문하신 반찬도시락이\n배송중입니다!';
        _subTitle = '6시~7시 사이에 배송됩니다!';
        _buttonString = '배송 조회';
      });
    }
    if (testStatus == 5) {
      // Todo: 조건: 배송 후, 점심
      setState(() {
        screenStatus = ScreenStatus.AFTER_DELIVERY;
        timeStatus = TimeStatus.LUNCH;
        _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
        _subTitle = '맛있는 점심식사 되세요!';
        _buttonString = '배송 내역';
      });
    }
    if (testStatus == 6) {
      // Todo: 조건: 배송 후, 점심
      setState(() {
        screenStatus = ScreenStatus.AFTER_DELIVERY;
        timeStatus = TimeStatus.DINNER;
        _mainTitle = '주문하신 반찬도시락\n배달이 완료되었습니다!';
        _subTitle = '맛있는 저녁식사 되세요!';
        _buttonString = '배송 내역';
      });
    }
  }

  @override
  void initState() {
    // TODO: 처음 들어갔을 때, 사용자 정보 가져오기
    _checkAddress();
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
              _buildBanner(containerCount),
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
                            ? _buildAfterDelivery(orderedMealMenu)
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
      title: DropdownButton(
          underline: Container(),
          value: dropdownValue,
          items: addressList.map((String value) {
            return DropdownMenuItem(
                value: value,
                child: Row(
                  children: [
                    Image.asset('assets/images/2_home/app_bar_place.png',
                        width: 24, height: 24),
                    const SizedBox(width: 8),
                    addressList.isNotEmpty
                        ? Text(
                            value,
                            style: addressStyle,
                          )
                        : const Text(''),
                  ],
                ));
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          }),
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
        surfaceTintColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('배달 주소를\n설정하지 않았어요!',
                style: dialogTitleStyle),
            Text('배달 주소를 설정하고\n반찬도시락을 주문해보세요!', style: dialogContentStyle),
            const SizedBox(height: 10),
            Center(
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
                  style: buttonTextStyle,
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
                          Text(
                            '다회용기를 보냉백에 넣어\n문앞에 놔주세요',
                            style: bannerStyle1,
                          ),
                          const SizedBox(height: 10),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(text: '반납할 ', style: bannerStyle4),
                            TextSpan(
                                text: '다회용기 $containerCount개',
                                style: bannerStyle5),
                          ]))
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '식사 후 귀찮은 설거지까지\n한끼톡톡에서 다!',
                            style: bannerStyle1,
                          ),
                          const SizedBox(height: 10),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(text: '한끼 풀대접', style: bannerStyle2),
                            TextSpan(text: ' 오픈!', style: bannerStyle3),
                          ]))
                        ],
                      ),
                Image(
                  image: AssetImage('assets/images/2_home/banner_image.png'),
                  width: 120,
                  height: 120,
                )
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
            child: Text(
          _buttonString,
          style: buttonTextStyle,
        )));
  }

  Widget _buildAfterDeliveryTitle() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _mainTitle,
            style: mainTitleStyle,
          ),
          const SizedBox(height: 16),
          Text(
            _subTitle,
            style: mainSubtitleStyle,
          ),
        ],
      ),
      const Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 32),
          child: Image(
              image: AssetImage('assets/images/2_home/main_on_delivery.png')),
        ),
      )
    ]);
  }

  Widget _buildMainTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _mainTitle,
          style: mainTitleStyle,
        ),
        const SizedBox(height: 16),
        Text(
          _subTitle,
          style: mainSubtitleStyle,
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

  Widget _buildAfterDelivery(OrderedMealMenu orderedMealMenu) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("배송된 반찬도시락", style: menuListTitleStyle),
        Text("주문번호 ${orderedMealMenu.orderID}",
            style: menuListTextButtonStyle),
      ]),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildFourImage(orderedMealMenu.menuUrlList, 80, 80),
          const SizedBox(width: 16), //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderedMealMenu.name,
                style: orderMenuTitleStyle,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${orderedMealMenu.price}원",
                style: orderPriceStyle,
              ),
              //객체 안에있는 리스트 수 만큼 메뉴 텍스트 추가
              for (int i = 0; i < orderedMealMenu.menuList.length; i++)
                Text(
                  orderedMealMenu.menuList[i],
                  style: orderMenuStyle,
                ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 32),
    ]);
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

  Widget _buildMenuCard(MealMenu mealMenu) {
    List<String> imageList = mealMenu.menuUrlList;
    return Column(
      children: [
        buildFourImage(imageList, 60, 60),
        const SizedBox(height: 8),
        SizedBox(
          width: 120,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              mealMenu.name,
              style: orderMenuStyle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "${mealMenu.price}원",
              style: menuPriceStyle,
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildMenuList(List<MealMenu> mealMenuList) {
    return SizedBox(
        height: 304,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("내가 담은 반찬 도시락", style: menuListTitleStyle),
              InkWell(
                  onTap: () {
                    //Todo: 메뉴 수정 페이지로 이동
                  },
                  child: Row(
                    children: [
                      Text("수정", style: menuListTextButtonStyle),
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
              itemCount: mealMenuList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildMenuCard(mealMenuList[index]));
              },
            ),
          ),
        ]));
  }
}
// sampledata
