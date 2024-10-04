import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';

class DeleteID extends StatefulWidget {
  @override
  _DeleteIDState createState() => _DeleteIDState();
}

class _DeleteIDState extends State<DeleteID> {
  bool isAgreed = false;
  //String? selectedReason;
  OverlayEntry? _dropdownOverlay;
  final LayerLink _layerLink = LayerLink();
  String _selectedValue = '선택해주세요.';
  bool _isDropdownOpen = false;

  List<String> items = [
    '반찬 서비스가 불만족해요. (종류, 맛, 신선도 등)',
    '배달 서비스가 불만족해요. (잦은 배달지연, 오배송 등)',
    '고객 서비스가 불만족해요. (불친절한 응대, 응대 지연 등)',
    '앱 기능이 불만족해요. (버그, 속도 저하 등)',
    '더 이상 어플이 필요하지 않아요. (주소지 변경, 개인사유 등)',
    '기타',
  ];

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _showDropdown() {
    _dropdownOverlay = _createOverlayEntry();
    Overlay.of(context)!.insert(_dropdownOverlay!);
  }

  void _removeDropdown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, 60), // position of dropdown
          child: Material(
            elevation: 0,
            //borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                    color: GRAY1,
                    width: 1.6// Set border color to gray
                ),
              ),
              child: Column(
                children: items.map((item) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedValue = item;
                        _removeDropdown();
                        _isDropdownOpen = false;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Text(item, style: TextStyles.getTextStyle(TextType.BUTTON, Color(0xFF646464)),),
                        ),
                        Divider(
                          color: GRAY1,
                          height: 1.6,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "회원 탈퇴",
          style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black),
        ),
        centerTitle: true,
        leading: Container(
          height: 24,
          width: 24,
          padding: EdgeInsets.all(8),
          child: IconButton(
            iconSize: 24,
            onPressed: () {},
            icon: Image.asset(
              'assets/images/1_my_page/left_arrow.png',
            ),
          ),
        )
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '정말 탈퇴하실 건가요?',
                style: TextStyles.getTextStyle(TextType.TITLE_2, Colors.black),
              ),
              SizedBox(height: 12),
              Text(
                '탈퇴 시 유의사항을 확인해주세요.',
                style:
                    TextStyles.getTextStyle(TextType.SUBTITLE_1, Colors.black),
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('\u2022 '),
                      SizedBox(
                        height: 18,
                      )
                    ],
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '탈퇴시 \'한끼톡톡\'계정이 삭제되며 해당 계정은 ',
                          style: TextStyles.getTextStyle(
                              TextType.BODY_2, Color(0xFF646464)),
                        children: <TextSpan>[
                          TextSpan(
                            text: '1개월 간 서비스 재가입이 불가능 ',
                            style: TextStyles.getTextStyle(
                                TextType.BODY_2, SECONDARY),
                          ),
                          TextSpan(
                            text: '합니다.',
                            style: TextStyles.getTextStyle(
                                TextType.BODY_2, Color(0xFF646464)),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('\u2022 '),
                      SizedBox(
                        height: 18,
                      )
                    ],
                  ),
                  Expanded(
                    child: Text(
                      '수집된 개인정보 및 \'한끼톡톡\' 계정에 저장된 모든 정보(배송 및 결제정보 기록, 담은 반찬, 풀대접 서비스 등) 삭제되어 복구할 수 없습니다.',
                      style: TextStyles.getTextStyle(
                          TextType.BODY_2, Color(0xFF646464)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                '계정을 삭제하는 이유가 궁금해요.',
                style:
                    TextStyles.getTextStyle(TextType.SUBTITLE_1, Colors.black),
              ),
              SizedBox(height: 8),
              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onTap: _toggleDropdown,
                  child: Container(
                    padding:
                    const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: GRAY1, width: 1.6),

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_selectedValue,  style: _selectedValue=='선택해주세요.'?TextStyles.getTextStyle(TextType.BUTTON, GRAY3):TextStyles.getTextStyle(TextType.BUTTON, Colors.black),),
                        _isDropdownOpen?Image.asset('assets/images/1_my_page/down_arrow.png',height: 24,width: 24,
                        ):Image.asset('assets/images/1_my_page/up_arrow.png',height: 24,width: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // DropdownButtonFormField<String>(
              //   // icon: Image.asset(
              //   //   'assets/images/1_my_page/down_arrow.png',width: 24, height: 24
              //   // ),
              //
              //   decoration: InputDecoration(
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: const BorderSide(color: GRAY1, width: 1.6),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(12),
              //       borderSide: const BorderSide(color: GRAY1, width: 1.6),
              //     ),
              //     contentPadding: EdgeInsets.all(12),
              //   ),
              //   hint: Text(
              //     '선택해주세요.',
              //     style: TextStyles.getTextStyle(TextType.BUTTON, GRAY3),
              //   ),
              //   value: selectedReason,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       selectedReason = newValue;
              //     });
              //   },
              //   items: <String>[
              //     '반찬 서비스가 불만족해요.(종류, 맛, 신선도 등)',
              //     '배달 서비스가 불만족해요.(잦은 배달지연, 오배송 등)',
              //     '고객 서비스가 불반족해요.(불친절한 응대, 응대 지연 등)',
              //     '앱기능이 불만족해요.(버그, 속도 저하 등)',
              //     '더이상 어플이 필요하지 않아요.(주소지 변경, 개인사유 등)',
              //     '기타',
              //   ].map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Container(
                height: 48,
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        side: BorderSide(
                          color: GRAY2,
                          width: 1,
                        ),
                        value: isAgreed,
                        activeColor: PRIMARY_COLOR,
                        onChanged: (bool? newValue) {
                          setState(() {
                            isAgreed = newValue ?? false;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isAgreed = !isAgreed;
                          });
                        },
                        child: Text(
                          '회원 탈퇴 유의 사항을 확인했으며 동의합니다.',
                          style: TextStyle(
                            color: Color(0xFF141414),
                            fontSize: 16,
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w500,
                            height: 0.09,
                            letterSpacing: -0.41,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isAgreed
                      ? () async{
                          // 탈퇴 처리 로직 추가
                    await networkRequest('api/v1/user/my}', RequestType.DELETE, {

                      "reason ": _selectedValue,


                    });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAgreed ? SECONDARY_2 : GRAY2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    '탈퇴하기',
                    style:
                        TextStyles.getTextStyle(TextType.BUTTON, Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
