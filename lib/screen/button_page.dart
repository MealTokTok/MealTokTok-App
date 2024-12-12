import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/address_page.dart';
import 'package:hankkitoktok/models/address/address.dart';
import 'package:hankkitoktok/models/enums.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/0_login_screen.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/1_address_setting.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/3_view_address_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/0_meal_menu_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/0_set_meal_name_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_choice_menu_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_side_dish_menu_update.dart';
import 'package:hankkitoktok/screen/3_menu_choice/1_choice_menu_screen_ver2.dart';
import 'package:hankkitoktok/screen/3_menu_choice/2_order_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/tmp_full_service_screen.dart';
import 'package:hankkitoktok/screen/4_my_page/0_my_page_home.dart';
import 'package:hankkitoktok/screen/4_my_page/4_return_full_dining.dart';
import 'package:hankkitoktok/screen/4_my_page/practice.dart';
import 'package:hankkitoktok/screen/5_order/2_full_dining_selcet.dart';
import 'package:hankkitoktok/screen/5_order/3_order_state_delivered.dart';
import 'package:hankkitoktok/screen/5_order/3_order_state_delivering.dart';
import 'package:hankkitoktok/screen/5_order/3_order_state_order_fail.dart';
import 'package:hankkitoktok/secrets.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hankkitoktok/secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {

  //late OrderType _orderType = OrderType.IMMEDIATE;
  Address1 address = Address1.init(
    address: '충청북도 청주시 흥덕구 충대로 1',
    detailAddress: '충북대',
    latitude: 36.6298968,
    longitude: 127.4534557,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MealMenuScreen()),
                );
              },
              child: Text('음식메뉴 스크린'),),
//내가 만든거
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SelectMenuScreen1(meal: meal)),
//               );
//             },
//             child: Text('사이드디시메뉴'),),
//태영 메뉴 수정 및 삭제

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPageHome()),
              );
            },
            child: Text('마이페이지'),),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderScreen()),
              );
            },
            child: Text('주문페이지'),),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReturnFullDining()),
              );
            },
            child: Text('다회용기 반납'),),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Practice()),
              );
            },
            child: Text('다회용기 반납=연습장'),),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderStateDelivering()),
              );
            },
            child: Text('배송중'),),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderStateDelivered()),
              );
            },
            child: Text('배송완료'),),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeliveryAddressSettingScreen()),
              );
            },
            child: Text('지도'),),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewAddressScreen()),
              );
            },
            child: Text('지도2'),),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressPage()),
              );
            },
            child: Text('지도만 뜨도록'),),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('로그인'),),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => OrderStateOrderFail()),
          //     );
          //   },
          //   child: Text('주문 취소'),),

        ],
      )),
    );
  }
}
