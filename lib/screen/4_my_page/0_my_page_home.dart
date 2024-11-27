import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:hankkitoktok/const/color.dart";
import "package:hankkitoktok/const/style.dart";
import "package:hankkitoktok/const/style2.dart";
import "package:hankkitoktok/controller/user_controller.dart";
import "package:hankkitoktok/functions/httpRequest.dart";
import "package:hankkitoktok/models/delivery/delivery_status.dart";
import "package:hankkitoktok/models/user/user.dart";
import "package:hankkitoktok/models/user/auth_data.dart";
import "package:hankkitoktok/screen/4_my_page/1_my_information_editing.dart";
import 'package:get/get.dart';
import "../1_my_page/1_order_histories_screen.dart";
import "../2_home/2_notification_screen.dart";
import "../3_menu_choice/0_meal_menu_screen.dart";

class MyPageHome extends StatefulWidget {
  const MyPageHome({super.key});

  @override
  State<MyPageHome> createState() => _MyPageHomeState();
}

class _MyPageHomeState extends State<MyPageHome> {
  //int userId;
  int? _pending;
  int? _deliveryRequested;
  int? _delivering;
  int? _delivered;
  int? _fulldining;
  UserController _userController = Get.find();

  int cartCount = 0;
  int alarmCount = 0;

  //UserController _userController = Get.put(UserController());

  // User _user = User(
  //   userId: 0,
  //   username: '',
  //   nickname: '',
  //   email: '',
  //   phoneNumber: '',
  //   profileImageUrl: '',
  //   birth: '',
  // );

  Map<String, dynamic>? queryParams;

  Map<String, dynamic> _queryParams(String query) {
    return queryParams = {
      'deliveryState': query,
    };
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    //_user = await networkGetRequest111(User(userId: 0, username: '', nickname: '', email: '', phoneNumber: '', profileImageUrl: '', birth: ''), 'api/v1/user/my',null );
    _pending = await networkGetRequest222(
        'api/v1/meal-deliveries/count', _queryParams('PENDING'));
    _deliveryRequested = await networkGetRequest222(
        'api/v1/meal-deliveries/count', _queryParams('DELIVERY_REQUESTED'));
    _delivering = await networkGetRequest222(
        'api/v1/meal-deliveries/count', _queryParams('DELIVERING'));
    _delivered = await networkGetRequest222(
        'api/v1/meal-deliveries/count', _queryParams('DELIVERED'));
    _fulldining = await networkGetRequest222(
        'api/v1/full-dinings/full-dinings/collect-requested/count', null);
    debugPrint("User data: ${_userController.user.nickname}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GRAY0,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: GRAY0,
        elevation: 0,
        // 그림자 없앰
        title: Text('My',
            style: TextStyles.getTextStyle(TextType.TITLE_2, Colors.black)),
        centerTitle: false, // 왼쪽 정렬
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(

                    "${_userController.user.nickname} ",
                    style: TextStyle(
                      color: Color(0xFF131313),
                      fontSize: 18,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w600,
                      //height: 0.08,
                      letterSpacing: -0.36,
                    ),
                  ),
                  Text(
                    "님",
                    style: myPageDfault,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                      padding: EdgeInsets.zero, // 패딩 설정
                      constraints: BoxConstraints(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyInformationEditng(
                              user: _userController.user,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: GRAY4,
                        size: 18,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "주문 및 배송 내역",
                                  style: myPageDfault,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GRAY0,
                                    foregroundColor: GRAY3,
                                    fixedSize: Size.fromHeight(28),
                                    //minimumSize: Size(65, 28),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.only(
                                      top: 4.0,
                                      bottom: 4.0,
                                      left: 8.0,
                                      right: 2.0,
                                    ),
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrderHistoriesScreen(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "더보기",
                                        style: TextStyle(
                                          color: Color(0xFF999999),
                                          fontSize: 12,
                                          fontFamily: 'Pretendard Variable',
                                          fontWeight: FontWeight.w500,
                                          //height: 0.12,
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: myPageRecordGrayNum,
                                    ),
                                    Text(
                                      "결제완료",
                                      style: myPageRecordGrayText,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: GRAY2,
                                  size: 24,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: myPageRecordGrayNum,
                                    ),
                                    Text(
                                      "주문접수",
                                      style: myPageRecordGrayText,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: GRAY2,
                                  size: 24,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: myPageRecordGrayNum,
                                    ),
                                    Text(
                                      "배송중",
                                      style: myPageRecordGrayText,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: GRAY2,
                                  size: 24,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Pretendard Variable',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.36,
                                      ),
                                    ),
                                    Text(
                                      "배송완료",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Pretendard Variable',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: GRAY1,
                      ),
                      // Padding(
                      //   padding:
                      //   EdgeInsets.symmetric(vertical: 16),
                      //   child:
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text("배달 주소 관리"),
                      // ),),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ,
                              //   ),
                              //);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "반납해야 할 다회용기",
                                  style: myPageDfault,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 16.0), // 안쪽 여백
                                  decoration: BoxDecoration(
                                    color: PRIMARY_COLOR, // 배경색
                                    borderRadius:
                                        BorderRadius.circular(12.0), // 둥근 모서리
                                  ),
                                  child: Text(
                                    '${_fulldining}건', // 텍스트 내용
                                    style: TextStyles.getTextStyle(TextType.BUTTON, Colors.black)
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Divider(
                        color: GRAY1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "배달 주소 관리",
                          style: myPageDfault,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("약관 및 개인 정보 처리"),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "약관 및 개인 정보 처리",
                            style: myPageDfault,
                          ),
                        ),
                        Divider(
                          color: GRAY1,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("설정"),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "설정",
                            style: myPageDfault,
                          ),
                        ),
                        Divider(
                          color: GRAY1,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Row(
                        //     children: [
                        //       Text("앱버전"),
                        //       Text("1234560"),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "앱버전",
                                style: myPageDfault,
                              ),
                              Text(
                                "1234560",
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard Variable',
                                  fontWeight: FontWeight.w400,
                                  //height: 0.11,
                                  letterSpacing: -0.28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

