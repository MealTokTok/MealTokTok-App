import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/kakao_map_component.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/1_address_setting.dart';
import 'package:hankkitoktok/screen/1_my_page/1_order_histories_screen.dart';
import 'package:hankkitoktok/screen/2_home/0_home.dart';
import 'package:hankkitoktok/screen/2_home/1_home_screen.dart';
import 'package:hankkitoktok/screen/4_pay_choice/pay_test.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/0_login_screen.dart';
import 'package:hankkitoktok/screen/webview_test.dart';
import '../models/address/address.dart';
import '0_login_and_set_address/3_view_address_screen.dart';
import '3_menu_choice/2_order_screen.dart';
import '4_my_page/0_my_page_home.dart';

class TestScreen extends StatelessWidget {

  const TestScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {

    Address1 address = Address1.init(
      address: '충청북도 청주시 흥덕구 충대로 1',
      detailAddress: '충북대',
      latitude: 36.6298968,
      longitude: 127.4534557,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
                children: [
                  _buildButton("login", context, LoginPage()),
                  _buildButton("home", context, Home()),
                  _buildButton("order_screen", context, OrderScreen()),
                  _buildButton("order_histories", context, OrderHistoriesScreen()),
                  _buildButton("my_page", context, MyPageHome()),
                  _buildButton("pay", context, PayTest(orderId: "1", price: 1000)),
                  _buildButton("map1", context, DeliveryAddressSettingScreen()),
                  _buildButton("map2", context, ViewAddressScreen()),
                  _buildButton("webview", context, WebviewTest()),
                  _buildButton("kakaoMap", context, KakaoMapComponent(address: address)),
                ]
            )
        )
      )
    );
  }

  Widget _buildButton(String text, BuildContext context, Widget nextPage)
  {
    return Padding(
        padding: EdgeInsets.all(16),
        child: OutlinedButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => nextPage
                  )
              );
            },
            child: Text(
                text
            )
        )
    );
  }
}

//DeliveryAddressSettingScreen
//ViewAddressScreen
//AddressDetailPage1