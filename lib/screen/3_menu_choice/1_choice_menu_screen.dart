import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoiceMenuScreen extends StatefulWidget {
  @override
  _ChoiceMenuScreenState createState() => _ChoiceMenuScreenState();
}

class _ChoiceMenuScreenState extends State<ChoiceMenuScreen>
    with TickerProviderStateMixin {
  List<List<Map<String, dynamic>>> menuList = [
    [
      {'name': '오징어볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '돼지불고기', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '소시지볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '감자볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '버섯볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '야채볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '오징어볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '돼지불고기', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '소시지볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '감자볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '버섯볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
      {'name': '야채볶음', 'image': 'https://picsum.photos/80/80', 'food_type': '볶음'},
    ],
    [
      {'name': '두부조림', 'image': 'https://picsum.photos/80/80', 'food_type': '조림'},
      {'name': '감자조림', 'image': 'https://picsum.photos/80/80', 'food_type': '조림'},
      {'name': '무조림', 'image': 'https://picsum.photos/80/80', 'food_type': '조림'},
      {'name': '꽁치조림', 'image': 'https://picsum.photos/80/80', 'food_type': '조림'},
      {'name': '장조림', 'image': 'https://picsum.photos/80/80', 'food_type': '조림'},
      {'name': '고등어조림', 'image': 'https://picsum.photos/80/80', 'food_type': '조림'},
    ],
    [
      {'name': '미역줄기무침', 'image': 'https://picsum.photos/80/80', 'food_type': '무침'},
      {'name': '콩나물무침', 'image': 'https://picsum.photos/80/80', 'food_type': '무침'},
      {'name': '시금치무침', 'image': 'https://picsum.photos/80/80', 'food_type': '무침'},
      {'name': '고사리나물', 'image': 'https://picsum.photos/80/80', 'food_type': '무침'},
      {'name': '도라지무침', 'image': 'https://picsum.photos/80/80', 'food_type': '무침'},
      {'name': '무생채', 'image': 'https://picsum.photos/80/80', 'food_type': '무침'},
    ],
    [
      {'name': '배추김치', 'image': 'https://picsum.photos/80/80', 'food_type': '김치/절임/젓갈'},
      {'name': '깍두기', 'image': 'https://picsum.photos/80/80', 'food_type': '김치/절임/젓갈'},
      {'name': '동치미', 'image': 'https://picsum.photos/80/80', 'food_type': '김치/절임/젓갈'},
      {'name': '오이소박이', 'image': 'https://picsum.photos/80/80', 'food_type': '김치/절임/젓갈'},
      {'name': '열무김치', 'image': 'https://picsum.photos/80/80', 'food_type': '김치/절임/젓갈'},
      {'name': '갓김치', 'image': 'https://picsum.photos/80/80', 'food_type': '김치/절임/젓갈'},
    ],
  ];

  List<Map<String, dynamic>> selectedMenu = [];
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('반찬 메뉴 구성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('반찬을 선택해주세요. (최대 4개)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: '반찬명을 검색해주세요.',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            _buildCurrentMenu(),
            _buildTabbar(),
            SizedBox(height: 20),
            Expanded(child: _buildTapContent()),
            ElevatedButton(
              onPressed: selectedMenu.length > 0
                  ? () {
                      // 다음 버튼을 눌렀을 때의 동작
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text('다음',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("선택한 반찬"),
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedMenu.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              selectedMenu.remove(selectedMenu[index]);
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                selectedMenu[index]['image'],
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  selectedMenu[index]['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  Widget _buildTabbar() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '볶음'),
            Tab(text: '조림'),
            Tab(text: '무침'),
            Tab(text: '김치/절임/젓갈'),
          ],
        ),
      ],
    );
  }

  Widget _buildTapContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildTabMenu(menuList[0]),
        _buildTabMenu(menuList[1]),
        _buildTabMenu(menuList[2]),
        _buildTabMenu(menuList[3]),
      ],
    );
  }

  Widget _buildTabMenu(List<Map<String,dynamic>> tabMenuList) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: tabMenuList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (selectedMenu.length < 4) {
              setState(() {
                if (selectedMenu.contains(tabMenuList[index])) {
                  selectedMenu.remove(tabMenuList[index]);
                } else {
                  selectedMenu.add(tabMenuList[index]);
                }
              });
            }
          },
          child: Column(
            children: [
              Image.network(
                tabMenuList[index]['image'],
              ),
              SizedBox(
                width: 80,
                child: Text(
                  tabMenuList[index]['name'],
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
