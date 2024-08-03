import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';
import 'package:get/get.dart';

import '../../const/color.dart';
import '2_notification_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //--------sampleData----------
  List<String> addressList = ['충북대학교 충대로1', '충북대학교 충대로2', '충북대학교 충대로3'];
  List<String> addressListEmpty = [];
  String dropdownValue = '충북대학교 충대로1';
  //--------sampleData----------

  bool onDelivery = true;
  List<MealMenu> mealMenuListEmpty = [];
  late String _buttonState;
  void _checkAddress() {
    if (addressList.isEmpty) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _showAddressDialog();
      });
    }
  }

  @override
  void initState() {
    // TODO: 처음 들어갔을 때, 사용자 정보 가져오기
    _checkAddress();
    if (onDelivery) {
      _buttonState = '배송 조회';
    } else if(mealMenuList.isEmpty) {
      _buttonState = '반찬도시락 메뉴담기';
    } else {
      _buttonState = '주문하기';
    }
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
              _buildBanner(),
              const SizedBox(height: 10),
              _buildMainBox(mealMenuList, onDelivery),
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
                    Image.asset('assets/images/2_home/app_bar_place.png'),
                    const SizedBox(width: 8),
                    addressList.isNotEmpty ?Text(
                      value,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ) : const Text(''),
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
          icon: Image.asset('assets/images/2_home/app_bar_bag.png'),
          onPressed: () {
            // Todo: 첫번째 버튼 눌렀을 때 로직
          },
        ),
        IconButton(
          icon: Image.asset('assets/images/2_home/app_bar_alarm.png'),
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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('배달 주소를\n설정하지 않았어요!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('배달 주소를 설정하고\n반찬도시락을 주문해보세요!', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Center(
              child: Image(
                image: AssetImage('assets/images/2_home/alert_dialog_delivery.png'),
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
              onPressed: (){
                debugPrint("배달 주소 설정 버튼 클릭");
                //Todo: 배달주소 설정 페이지 이동
              },
              child: const Center(
                child: Text(
                  '주소 설정하기',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: InkWell(
            onTap: () {
              debugPrint("Panel Clicked");
              //Todo: 풀대접 서비스 페이지 이동
            },
            child:
                const Image(image: AssetImage('assets/images/2_home/banner.png'))));
  }

  Widget _buildSelectedMenuButton() {

    void selectMenu(){
      debugPrint("메뉴 담기 버튼 클릭");
      //Todo: 메뉴 선택 페이지로 이동
    }
    void order(){
      debugPrint("주문하기 버튼 클릭");
      //Todo: 주문하기 페이지로 이동
    }
    void delivery(){
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
          if (_buttonState=='배송 조회') {
            delivery();
          } else if(_buttonState=='반찬도시락 메뉴담기') {
            selectMenu();
          } else {
            order();
          }

        },
        child: Center(
            child: Text(
          _buttonState,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        )));
  }

  Widget _buildMainBox(List<MealMenu> mealMenuList, bool onDelivery) {


    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '반찬도시락을 \n주문해볼까요?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                '원하는 반찬을 선택하고 주문하면 \n든든한 한끼가 되어줄게요!',
                style: TextStyle(fontSize: 16),
              ),
              //_buildMenuList(mealMenuList),
            ],
          ),
          const SizedBox(height: 20),
          onDelivery
              ? _buildOnDelivery()
              : mealMenuList.isEmpty
                  ? _buildMenuEmpty()
                  : _buildMenuList(mealMenuList),
          const SizedBox(height: 10),
          _buildSelectedMenuButton(),
        ],
      ),
    );
  }

  Widget _buildOnDelivery() {
    return const SizedBox(
      height: 304,
      child: Center(
        child: Image(image: AssetImage('assets/images/2_home/main_on_delivery.png')),
      ),
    );
  }

  Widget _buildMenuEmpty() {
    return const SizedBox(
      height: 304,
      child: Center(
        child: Image(image: AssetImage('assets/images/2_home/main_not_select_menu.png')),
      ),
    );
  }

  Widget _buildMenuCard(MealMenu mealMenu) {
    List<String> imageList = mealMenu.menuUrlList;
    return Column(
      children: [
        Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[0],
                      width: 60,
                      height: 60,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[1],
                      width: 60,
                      height: 60,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[2],
                      width: 60,
                      height: 60,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageList[3],
                      width: 60,
                      height: 60,
                    ),
                  )
                ],
              )
            ])),
        const SizedBox(height: 8),
        SizedBox(
          width: 120,
          child: Text(
            '${mealMenu.name}\n6000원',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
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
              const Text("내가 담은 반찬 도시락", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              InkWell(
                  onTap: () {
                    //Todo: 메뉴 수정 페이지로 이동
                  },
                  child: const Row(
                    children: [
                      Text("수정", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Image(
                          image: AssetImage(
                              'assets/images/2_home/arrow_right.png')),
                    ],
                  ))
            ],
          ),
          const SizedBox(height: 10),
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
