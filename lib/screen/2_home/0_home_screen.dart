import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealMenu {
  String name;
  int price;
  List<String> memuList;
  List<String> menuUrlList;

  MealMenu(this.name, this.price, this.memuList, this.menuUrlList);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //--------sampleData----------
  List<String> addressList = ['충북대학교 충대로1', '충북대학교 충대로2', '충북대학교 충대로3'];
  String dropdownValue = '충북대학교 충대로1';
  List<dynamic> bannerImgList = [
    {
      'url': 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'action': () => print('Image 1 clicked')
    },
    {
      'url': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'action': () => print('Image 2 clicked')
    },
    {
      'url': 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'action': () => print('Image 3 clicked')
    },
    {
      'url': 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'action': () => print('Image 4 clicked')
    },
    {
      'url': 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
      'action': () => print('Image 5 clicked')
    }
  ];
  List<MealMenu> mealMenuList = [
    MealMenu('아침 콤보', 6000, [
      '팬케이크',
      '베이컨',
      '계란',
      '커피'
    ], [
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80'
    ]),
    MealMenu('점심 스페셜', 6000, [
      '버거',
      '감자튀김',
      '샐러드',
      '탄산음료'
    ], [
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80'
    ]),
    MealMenu('저녁 특선', 6000, [
      '스테이크',
      '매쉬드 포테이토',
      '구운 야채',
      '와인'
    ], [
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80'
    ]),
    MealMenu('채식주의자 잔치', 6000, [
      '샐러드',
      '야채 수프',
      '구운 두부',
      '주스'
    ], [
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80'
    ])
  ];
  List<MealMenu> mealMenuListEmpty = [];
  String userName = '시아';

  //--------sampleData----------

  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    // TODO: 처음 들어갔을 때, 사용자 정보 가져오기
    // TODO: 사용자 정보가 없을 경우, Alter Dialog(대충 로그인 필요하다는 내용과 로그인 페이지로 이동하는 메소드)
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [

                  SizedBox(height: 20),
                  _buildMenuBox(userName, mealMenuList),
                  SizedBox(height: 20),
                  //도시락 메뉴 설정하기 버튼
                ],
              ),
            ),
          ],
        )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: _buildPayButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    //Todo: 사용자가 저장한 주소로 변경

    return AppBar(
      title: DropdownButton(
          value: dropdownValue,
          items: addressList.map((String value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          }),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Todo: 첫번째 버튼 눌렀을 때 로직
          },
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            // Todo: 두번째 버튼 눌렀을 때 로직
          },
        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            // Todo: 세번째 버튼 눌렀을 때 로직
          },
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Column(
      children: [
        _buildPanelImage(),
        _buildDecorationBox(),
      ],
    );
  }

  Widget _buildDecorationBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: bannerImgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.color!
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPanelImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: bannerImgList
            .map((item) => InkWell(
                onTap: item['action'],
                child: Center(
                    child: CachedNetworkImage(
                        imageUrl: item['url'],
                        fit: BoxFit.fitWidth,
                        width: MediaQuery.of(context).size.width,
                        placeholder: (context, url) => Container(
                              child: const Center(
                                child: CupertinoActivityIndicator(
                                  radius: 25,
                                ),
                              ),
                            )))))
            .toList(),
      ),
    );
  }

  Widget _buildMenuBox(String userName, List<MealMenu> mealMenuList) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$userName님, 반찬도시락을 구매해볼까요?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildMenuList(mealMenuList),
          SizedBox(height: 20),
          _buildSelectedMenuButton(),
        ],
      ),
    );
  }

  Widget _buildSelectedMenuButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: () {
        //Todo: 메뉴 선택 페이지로 이동
      },
      child: const Row(
        children: [
          Text('반찬도시락 메뉴 추가',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildMenuList(List<MealMenu> mealMenuList) {
    return mealMenuList.isNotEmpty
        ? SizedBox(
            height: 185*mealMenuList.length+100,
            child: ListView.builder(
              itemCount: mealMenuList.length,
              itemBuilder: (context, index) {
                String mealName = mealMenuList[index].name;
                int mealPrice = mealMenuList[index].price;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(mealName, style: TextStyle(fontSize: 16)),
                        Text('$mealPrice원',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[500])),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: mealMenuList[index].memuList.length,
                          itemBuilder: (context, index2) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0,8,16,0),
                              child: Column(
                                children: [
                                  Image.network(
                                      mealMenuList[index].menuUrlList[index2]),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      mealMenuList[index].memuList[index2],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(MediaQuery.of(context).size.width*0.4, 50),
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        //Todo: 메뉴 선택 페이지로 이동
                      },
                      child: const Row(
                        children: [
                          Text('수정하기', style: TextStyle(color: Colors.black)),
                          Icon(Icons.arrow_forward, color: Colors.black,),
                        ],
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                );
              },
            ),
          )
        : const SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  '반찬을 선택하고 주문하면',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '원하는 날 반찬 배달로 든든한 한끼가 되어줄게요.',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ));
  }

  Widget _buildPayButton() {
    return ElevatedButton(
      onPressed: () {
        //Todo: 도시락 메뉴가 있을때만 활성화
        //Todo: //결제하기 버튼 눌렀을 때 로직
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: const Text(
        '주문하기',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

// sampledata
