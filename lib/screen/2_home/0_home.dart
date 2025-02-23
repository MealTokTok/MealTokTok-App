import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/style.dart';
import 'package:hankkitoktok/models/meal/meal.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';
import 'package:hankkitoktok/screen/1_my_page/1_order_histories_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/0_meal_menu_screen.dart';
import 'package:hankkitoktok/screen/3_menu_choice/2_order_screen.dart';
import 'package:hankkitoktok/screen/4_my_page/0_my_page_home.dart';

import '1_home_screen.dart';

class Home extends StatefulWidget {
  int selectedIndex = 0;

  Home({required this.selectedIndex, super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //--------sampleData----------

  List<Meal> mealMenuListEmpty = [];

  List<Widget> pages = [];

  @override
  void initState() {
    pages = [
      HomeScreen(),
      MealMenuScreen(),
      OrderScreen(),
      OrderHistoriesScreen(),
      MyPageHome(),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(widget.selectedIndex),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(widget.selectedIndex),
    );
  }

  Widget _buildBottomNavigationBar(int selectedIndex) {
    return Container(
        padding: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/2_home/bot_nav_home.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                    label: '홈',
                    activeIcon: Image.asset(
                      'assets/images/2_home/bot_nav_home_selected.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/2_home/bot_nav_menu.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                    label: '반찬구성',
                    activeIcon: Image.asset(
                      'assets/images/2_home/bot_nav_menu_selected.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/2_home/bot_nav_order.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                    label: '도시락주문',
                    activeIcon: Image.asset(
                      'assets/images/2_home/bot_nav_order_selected.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/2_home/bot_nav_details.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                    label: '주문내역',
                    activeIcon: Image.asset(
                      'assets/images/2_home/bot_nav_details_selected.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/images/2_home/bot_nav_my.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                    label: 'my',
                    activeIcon: Image.asset(
                      'assets/images/2_home/bot_nav_my_selected.png',
                      width: 24.0, // 원하는 크기로 조정
                      height: 24.0, // 원하는 크기로 조정
                    ),
                  ),
                ],
                currentIndex: selectedIndex,
                onTap: _onItemTapped,
                unselectedLabelStyle: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                ),
                selectedLabelStyle: navBarStyle,
                showUnselectedLabels: true,
                backgroundColor: Colors.white,
              ),
            )));
  }
}
