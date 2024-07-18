import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';

import '1_home_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //--------sampleData----------
  List<String> addressList = ['충북대학교 충대로1', '충북대학교 충대로2', '충북대학교 충대로3'];
  String dropdownValue = '충북대학교 충대로1';

  List<MealMenu> mealMenuListEmpty = [];
  int _selectedIndex = 0;
  List<Widget> pages = [];

  void getUDID() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint(fcmToken ?? 'null');
  }
  @override
  void initState() {
    // TODO: 처음 들어갔을 때, 사용자 정보 가져오기
    // TODO: 사용자 정보가 없을 경우, Alter Dialog(대충 로그인 필요하다는 내용과 로그인 페이지로 이동하는 메소드)
    getUDID();
    pages = [
      HomeScreen(),

      //Todo: 페이지 추가
      const Text(
        'Index 1: 메뉴담기',
      ),
      const Text(
        'Index 2: 한끼 풀대접',
      ),
      const Text(
        'Index 1: 주문내역',
      ),
      const Text(
        'Index 2: 마이페이지',
      ),
    ];
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(_selectedIndex),
    );
  }

  Widget _buildBottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/images/2_home/bot_nav_home.png')),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/images/2_home/bot_nav_menu.png')),
          label: '메뉴담기',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/images/2_home/bot_nav_menu.png')),
          label: '한끼 풀대접',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
              AssetImage('assets/images/2_home/bot_nav_order.png')),
          label: '주문내역',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/2_home/bot_nav_my.png')),
          label: '마이페이지',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: Colors.black),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
    );
  }
}
