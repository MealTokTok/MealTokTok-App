import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/meal_controller.dart';
import 'package:hankkitoktok/controller/ordered_meal_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import '../const/color.dart';
import '../const/style2.dart';

import '../models/meal/ordered_meal.dart';

class Calendar extends StatefulWidget {
  final bool Function(DateTime day) selectDate;
  final void Function(DateTime selectedDay)? onDaySelected;
  final DateTime currentDate = DateTime.now();

  Calendar({
    super.key,
    required this.selectDate,
    this.onDaySelected,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime nextSunday;
  late DateTime _focusedDate;

  @override
  void initState() {

    //현재 날짜 기준 다음 주 일요일
    nextSunday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: 7 - DateTime.now().weekday));

    _focusedDate = nextSunday; // 현재 포커스된 날짜(캘린더에 나올 날짜 중 첫번째 날짜)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GREY_COLOR_4, width: 2),
      ),
      child: TableCalendar(
        firstDay: nextSunday, // 시작 날짜
        lastDay: nextSunday.add(const Duration(days: 6)), // 시작 날짜로부터 6일 후 (일요일 ~ 토요일)
        focusedDay: _focusedDate, // 현재 포커스된 날짜
        calendarFormat: CalendarFormat.week, // 주 단위로 보이기
        headerVisible: false, // 헤더 안보이기
        locale: 'ko_KR', // 한국어로 설정
        daysOfWeekHeight: 32, // 요일 높이
        // ---달력 스타일 설정---
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2),
          weekendStyle: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle:
              TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2),
          selectedTextStyle:
              TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2),
          selectedDecoration: BoxDecoration(
            color: PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
          ),
          defaultDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // ---달력 스타일 설정---
        onDaySelected: (selectedDay, focusedDay) { // 날찌를 선택하면 실행되는 부분
          // 9시간 전의 로컬 시간으로 변환
          DateTime adjustedSelectedDay =
              selectedDay.subtract(const Duration(hours: 9)).toLocal(); //우선, 선택한 날짜 정보를 adjustedSelectedDay 변수에 저장

          setState(() {
            //선택한 날짜 정보를 onDaySelected 함수에 전달
            if (widget.onDaySelected != null) {
              widget.onDaySelected!(adjustedSelectedDay);
            }

            _focusedDate = focusedDay; //선택한 날짜 정보를 _focusedDate 변수에 저장
          });
        },
        selectedDayPredicate: (day) { // 어떤 날짜가 선택된 날짜인지에 대한 정보, 컨트롤러를 통해 날짜 선택 기능 실행
          // 함수 기능
          //1. 주문 컨트롤러에 선택된 날짜에 대한 정보를 추가
          // 2. 선택된 날짜가 선택된 날짜인지에 대한 정보를 반환 (true/false)
          return widget.selectDate(day);
        },
      ),
    );
  }
}


