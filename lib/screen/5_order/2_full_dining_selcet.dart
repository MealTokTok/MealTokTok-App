import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/calendar.dart';
import 'package:hankkitoktok/component/full_dining_calendar.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:table_calendar/table_calendar.dart';


class FullDiningSelcet extends StatefulWidget {
  const FullDiningSelcet({super.key});

  @override
  State<FullDiningSelcet> createState() => _FullDiningSelcetState();
}

class _FullDiningSelcetState extends State<FullDiningSelcet> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '풀대점 서비스 구매',
                style: TextStyles.getTextStyle(TextType.TITLE_3, Colors.black)
              ),
              SizedBox(height: 12),
              Container(
                height: 37,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: SECONDARY_1.withAlpha(20), // 배경색 설정
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '반찬 도시락을 선택한 끼니에 다회용기로 배송됩니다.',
                  style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_1),
                ),
              ),
              SizedBox(height: 8),
//캘린더

              FullDiningCalendar(
                selectDate: (day) {
                  // 선택된 날짜가 월, 수, 금인지 확인하는 로직
                  return day.weekday == DateTime.monday ||
                      day.weekday == DateTime.wednesday ||
                      day.weekday == DateTime.friday;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                    '수요일, 금요일, 토요일',
                    style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black)
                  ),
                  Text(
                    '총 3회',
                    style: TextStyles.getTextStyle(TextType.BODY_1, Colors.black)
                  ),
                ],
              ),
              SizedBox(width: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    '최종 금액',
                    style:TextStyles.getTextStyle(TextType.TITLE_3, Colors.black)
                  ),
                  Row(
                    children: [
                      Text(
                        '1,995 원',
                        style: TextStyles.getTextStyle(TextType.TITLE_3, Colors.black)
                      ),
                      SizedBox(width: 8,),
                      Text(
                        '2,100원',
                        style:  TextStyle(
                          color: GRAY3,
                          fontSize: 12,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                          height: 0.12,
                          letterSpacing: -0.24,
                        ),
                      ),
                    ],
                  )

                ],
              ),

            ],
          ),
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
              "장바구니에 담기",
              style: TextStyles.getTextStyle(TextType.BUTTON, Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
