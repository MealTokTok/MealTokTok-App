import 'package:flutter/material.dart';

class MenuChoiceScreen extends StatefulWidget {
  @override
  _MenuChoiceScreenState createState() => _MenuChoiceScreenState();
}

class _MenuChoiceScreenState extends State<MenuChoiceScreen> {
  List<String> addressList = ['충북대학교 충대로1', '충북대학교 충대로2', '충북대학교 충대로3'];
  String dropdownValue = '충북대학교 충대로1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //반찬 검색 메뉴 바
            _buildSearchBar(),
            SizedBox(height: 10),
            _buildSelectedItems(),
            SizedBox(height: 20),
            _buildTabView(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: _buildFinishButton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    //Todo: 사용자가 저장한 주소로 변경

    return AppBar(
      title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("반찬 4개를 선택해 주세요"),
            TextButton(
              onPressed: () {
                //Todo: 뒤로 이동
              },
              child: Text("취소"),
            )
          ]
        )
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '반찬을 검색해 주세요.',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildSelectedItems() {
    return SizedBox();
  }

  Widget _buildTabView() {
    return SizedBox();
  }

  Widget _buildFinishButton() {
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
        '반찬 메뉴 담기',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
