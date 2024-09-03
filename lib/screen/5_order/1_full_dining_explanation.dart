import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';

class FullDiningExplanation extends StatefulWidget {
  const FullDiningExplanation({super.key});

  @override
  State<FullDiningExplanation> createState() => _FullDiningExplanationState();
}

class _FullDiningExplanationState extends State<FullDiningExplanation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "풀대접 서비스",
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
          )),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 이미지와 배경이 있는 영역
            Container(
                height: 178,
                padding: EdgeInsets.all(20),
                color: PRIMARY_COLOR, // 오렌지 색 배경
                child:

                    // 우측에 반투명한 이미지 추가
                    Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '식사만 하세요!\n나머지는 한끼톡톡이 해결해드려요!',
                          style: TextStyles.getTextStyle(
                              TextType.TITLE_2, Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '식사부터 설거지까지 오직 한끼톡톡에서만!',
                          style: TextStyles.getTextStyle(
                              TextType.BODY_1, Colors.white),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      //child: Opacity(
                      //opacity: 0.3,
                      child: Image.asset(
                        'assets/images/4_full_dining/full_dining.png',
                        // 적절한 로고 이미지 경로를 사용하세요
                        width: 164,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                      // ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      //child: Opacity(
                      //opacity: 0.3,
                      child: Image.asset(
                        'assets/images/4_full_dining/circle.png',
                        // 적절한 로고 이미지 경로를 사용하세요
                        width: 127,
                        height: 127,
                        fit: BoxFit.cover,
                      ),
                      // ),
                    ),
                  ],
                )),
            SizedBox(height: 32),
            // 설명 영역
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '풀대접 서비스란?',
                      style: TextStyles.getTextStyle(
                          TextType.TITLE_2, Colors.black),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(20),
                      height: 82,
                      decoration: BoxDecoration(
                          color: GRAY0,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  '01',
                                  style: TextStyles.getTextStyle(
                                      TextType.BODY_1, PRIMARY_COLOR),
                                ),
                              ],
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: '식사 후, 집 문 앞에 ',
                                  style: TextStyles.getTextStyle(
                                      TextType.BODY_2, Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '다회용기',
                                      style: TextStyles.getTextStyle(
                                          TextType.SUBTITLE_2, Colors.black),
                                    ),
                                    TextSpan(
                                      text: '를 놓아주시면\n저희 한끼톡톡이 ',
                                      style: TextStyles.getTextStyle(
                                          TextType.BODY_2, Colors.black),
                                    ),
                                    TextSpan(
                                      text: '청결하게 정리',
                                      style: TextStyles.getTextStyle(
                                          TextType.SUBTITLE_2, Colors.black),
                                    ),
                                    TextSpan(
                                      text: '해드려요',
                                      style: TextStyles.getTextStyle(
                                          TextType.BODY_2, Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(20),
                      height: 82,
                      decoration: BoxDecoration(
                          color: PRIMARY_LIGHT,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                '02',
                                style: TextStyles.getTextStyle(
                                    TextType.BODY_1, PRIMARY_COLOR),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: '오직, 한끼에 ',
                                style: TextStyles.getTextStyle(
                                    TextType.BODY_2, Colors.black),
                                children: [
                                  TextSpan(
                                    text: '700원으로',
                                    style: TextStyles.getTextStyle(
                                        TextType.SUBTITLE_2, Colors.black),
                                  ),
                                  TextSpan(
                                    text: '\n한끼톡톡의 풀대접 서비스를 즐겨보세요!',
                                    style: TextStyles.getTextStyle(
                                        TextType.BODY_2, Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
              foregroundColor: Colors.white,
              fixedSize: Size.fromHeight(48),
              //minimumSize: Size(50, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.all(12),
              elevation: 0.0,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              "이용하기",
              style: TextStyles.getTextStyle(TextType.BUTTON, Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
