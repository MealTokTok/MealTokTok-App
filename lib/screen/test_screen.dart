import 'package:flutter/material.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/1_address_setting.dart';
import 'package:hankkitoktok/screen/1_my_page/1_order_histories_screen.dart';
import 'package:hankkitoktok/screen/2_home/0_home.dart';
import 'package:hankkitoktok/screen/2_home/1_home_screen.dart';
import 'package:hankkitoktok/screen/4_pay_choice/pay_test.dart';

import '3_menu_choice/2_order_screen.dart';
import '4_my_page/0_my_page_home.dart';

class TestScreen extends StatelessWidget {

  const TestScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            children: [
              _buildButton("home", context, Home(selectedIndex: 0,)),
              _buildButton("order_screen", context, OrderScreen()),
              _buildButton("order_histories", context, OrderHistoriesScreen()),
              _buildButton("my_page", context, MyPageHome()),
              //_buildButton("pay", context, PayTest(id: "1")),
              _buildButton("map", context, DeliveryAddressSettingScreen())

            ]
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