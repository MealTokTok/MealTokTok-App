import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';

class DownMenuBar extends StatefulWidget {
  const DownMenuBar({super.key});

  @override
  State<DownMenuBar> createState() => _DownMenuBarState();
}

class _DownMenuBarState extends State<DownMenuBar> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: '반찬구성',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: '도시락주문',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: '주문내역',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'my',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedLabelStyle:
            TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w500,
              height: 0.12,
              letterSpacing: -0.24,
            ), // 선택된 라벨 스타일
            unselectedLabelStyle: TextStyle(
              color: GRAY4,
              fontSize: 12,
              fontFamily: 'Pretendard Variable',
              fontWeight: FontWeight.w400,
              height: 0.12,
              letterSpacing: -0.24,
            ),

            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
