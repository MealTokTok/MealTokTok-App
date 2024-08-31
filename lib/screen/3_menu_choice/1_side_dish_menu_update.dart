import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SideDish{
  String name ='';
  String type ='';
  String src = '';
  SideDish({String name='', String type='', String src = ''}){
    this.name= name;
    this.type= type;
    this.src= src;
  }
}

List<SideDish> listSideDish = [];

List<SideDish> sampleSideDishes = [
  SideDish(name: '고추장볶음', type: '볶음', src: r'assets/image/3_menu_choice/gochujangbokkeum.jpg'),
  SideDish(name: '메추리알조림', type: '조림', src: r'assets/image/3_menu_choice/quailEggJorim.jpg'),
  SideDish(name: '오이무침', type: '무침', src: r'assets/image/3_menu_choice/cucumberMuchim.jpg'),
  SideDish(name: '깍두기', type: '김치/젓갈', src: r'assets/image/3_menu_choice/kaktugi.jpg'),
  SideDish(name: '무생채', type: '무침', src: r'assets/image/3_menu_choice/musaengchae.jpg'),
  SideDish(name: '감자조림', type: '조림', src: r'assets/image/3_menu_choice/potatoJorim.jpg'),
  SideDish(name: '김치볶음', type: '볶음', src: 'https://example.com/kimchiBokkeum.jpg'),
  SideDish(name: '오징어젓갈', type: '김치/젓갈', src: 'https://example.com/squidJeotgal.jpg'),
  SideDish(name: '배추김치', type: '김치/젓갈', src: 'https://example.com/baechuKimchi.jpg'),
  SideDish(name: '양파절임', type: '절임', src: 'https://example.com/onionPickles.jpg'),
];


class SelectMenuScreen extends StatefulWidget {
  @override
  State<SelectMenuScreen> createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenuScreen> {
  String obentoName = ''; // 도시락 이름
  String sideDishType = '';
  List<SideDish> selectedSideDish = []; // 선택된 사이드디쉬 리스트
  List<SideDish> listSideDish = sampleSideDishes; // 화면에 표시할 사이드디쉬 리스트
  List<SideDish> allListSideDish = sampleSideDishes; // 모든 사이드디쉬

  void searchSideDish() {
    setState(() {
      if (sideDishType != '') {
        listSideDish = allListSideDish
            .where((sideDish) => sideDish.type == sideDishType)
            .toList();
      } else {
        listSideDish = allListSideDish; // 필터 해제 시 모든 사이드디쉬를 표시
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("메뉴 구성", style: TextStyle(fontSize: 18)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // 삭제 버튼 클릭 시 동작
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red), // 글씨 색상
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Colors.grey), // 테두리 색상
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // 버튼 배경 색상
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0), // 테두리 모서리 둥글기
                ),
              ),
            ),
            child: Text("삭제"),
          ),
        ],
      )
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('반찬 도시락 이름'),
            SizedBox(height: 5),
            TextField(
              cursorColor: Color(0xFF999999),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                hintText: "      이름을 입력해주세요.                               (0/10)",
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('원하는 반찬 4개를 선택해주세요.'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: selectedSideDish.isEmpty
                  ? [Container(width: 50, height: 97)]
                  : selectedSideDish.map((sideDish) {
                return Column(children: [
                  Row(children: [
                    SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                sideDish.src,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSideDish.remove(sideDish);
                                  });// X 버튼을 눌렀을 때 실행할 동작
                                },
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                    SizedBox(width: 4),
                  ]),
                  Text(sideDish.name,
                      style: TextStyle(
                          fontSize: 13, fontStyle: FontStyle.normal)),
                ]);
              }).toList(),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                // 반찬 이름 받아서 밑에 이미지 띄우기
              },
              cursorColor: Color(0xFF999999),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                prefixIcon: Icon(Icons.search),
                hintText: "반찬명을 검색해주세요.",
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (sideDishType == '볶음')
                                sideDishType = '';
                              else
                                sideDishType = '볶음';
                            });
                            searchSideDish();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: sideDishType == '볶음'
                                ? Colors.orange
                                : Color(0xFFE9E9E9),
                            foregroundColor: sideDishType == '볶음'
                                ? Colors.white
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8.0), // 둥근 모서리 적용
                            ),
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                          ),
                          child: Text('볶음'),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (sideDishType == '조림')
                                sideDishType = '';
                              else
                                sideDishType = '조림';
                            });
                            searchSideDish();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: sideDishType == '조림'
                                ? Colors.orange
                                : Color(0xFFE9E9E9),
                            foregroundColor: sideDishType == '조림'
                                ? Colors.white
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8.0), // 둥근 모서리 적용
                            ),
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                          ),
                          child: Text('조림'),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (sideDishType == '무침')
                                sideDishType = '';
                              else
                                sideDishType = '무침';
                            });
                            searchSideDish();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: sideDishType == '무침'
                                ? Colors.orange
                                : Color(0xFFE9E9E9),
                            foregroundColor: sideDishType == '무침'
                                ? Colors.white
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8.0), // 둥근 모서리 적용
                            ),
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                          ),
                          child: Text('무침'),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (sideDishType == '절임')
                                sideDishType = '';
                              else
                                sideDishType = '절임';
                            });
                            searchSideDish();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: sideDishType == '절임'
                                ? Colors.orange
                                : Color(0xFFE9E9E9),
                            foregroundColor: sideDishType == '절임'
                                ? Colors.white
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8.0), // 둥근 모서리 적용
                            ),
                            padding: EdgeInsets.symmetric(vertical: 4.0),
                          ),
                          child: Text('절임'),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (sideDishType == '김치/젓갈')
                                sideDishType = '';
                              else
                                sideDishType = '김치/젓갈';
                            });
                            searchSideDish();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: sideDishType == '김치/젓갈'
                                ? Colors.orange
                                : Color(0xFFE9E9E9),
                            foregroundColor: sideDishType == '김치/젓갈'
                                ? Colors.white
                                : Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8.0), // 둥근 모서리 적용
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0),
                          ),
                          child: Text('김치/젓갈'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: listSideDish.length,
                      itemBuilder: (context, index) {
                        final sideDish = listSideDish[index];
                        return Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (selectedSideDish.length < 4 &&
                                      !selectedSideDish.contains(sideDish)) {
                                    setState(() {
                                      selectedSideDish.add(sideDish);
                                    });
                                    print(
                                        'Selected Side Dish: ${sideDish.name}');
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    sideDish.src,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              sideDish.name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextButton(
          onPressed: () {
            //다음 페이지로 넘어가는 기능
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // 둥근 모서리 적용
            ),
          ),
          child: Text('반찬 도시락 구매'),
        ),
      ),
    );
  }
}

