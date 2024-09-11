import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:table_calendar/table_calendar.dart';

class FullDiningCalendar extends StatefulWidget {
  //final void Function(DateTime selectedDay) onDaySelected;
  final bool Function(DateTime day) selectDate;
  final DateTime currentDate = DateTime.now();

  FullDiningCalendar({
    super.key,
    //required this.onDaySelected,
    required this.selectDate,
  });

  @override
  State<FullDiningCalendar> createState() => _CalendarState();
}

class _CalendarState extends State<FullDiningCalendar> {
  late DateTime nextSunday;
  late DateTime _focusedDate;
  late List<DateTime> preSelectedDays;

  @override
  void initState() {
    // 현재 날짜 기준 다음 주 일요일
    nextSunday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: 7 - DateTime.now().weekday));

    _focusedDate = nextSunday; // 현재 포커스된 날짜(캘린더에 나올 날짜 중 첫번째 날짜)

    // 월, 수, 금을 기준으로 미리 선택된 날짜들을 설정
    preSelectedDays = [
      nextSunday.add(Duration(days: 1)), // 월요일
      nextSunday.add(Duration(days: 3)), // 수요일
      nextSunday.add(Duration(days: 5)), // 금요일
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 108,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GRAY1, width: 1),
      ),
      child: TableCalendar(
        firstDay: nextSunday,
        // 시작 날짜
        lastDay: nextSunday.add(const Duration(days: 6)),
        // 시작 날짜로부터 6일 후 (일요일 ~ 토요일)
        focusedDay: _focusedDate,
        // 현재 포커스된 날짜
        calendarFormat: CalendarFormat.week,
        // 주 단위로 보이기
        headerVisible: true,
        // 헤더
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          // 포맷 변경 버튼 비활성화
          titleCentered: false,
          // 제목(연도 및 월)을 가운데 정렬
          titleTextStyle: TextStyles.getTextStyle(TextType.SUBTITLE_1, Colors.black),
          leftChevronVisible: false,
          // 이전 달로 이동하는 아이콘 비활성화
          rightChevronVisible: false, // 다음 달로 이동하는 아이콘 비활성화
        ),
        locale: 'ko_KR',
        // 한국어로 설정
        daysOfWeekHeight: 32,

        // 요일 높이
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyles.getTextStyle(TextType.BODY_2, GRAY4),
          weekendStyle: TextStyles.getTextStyle(TextType.BODY_2, GRAY4),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyles.getTextStyle(TextType.BODY_2, Colors.black),
          weekendTextStyle: TextStyles.getTextStyle(TextType.BODY_2, Color(0xFFFF0000)), // 주말 중 일요일 날짜 숫자를 빨간색으로 표시
          selectedTextStyle: TextStyles.getTextStyle(TextType.BODY_2, Colors.black),
          selectedDecoration: BoxDecoration(
            color: Colors.orange,
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
        // onDaySelected: (selectedDay, focusedDay) {
        //   // 9시간 전의 로컬 시간으로 변환
        //   DateTime adjustedSelectedDay = selectedDay.subtract(const Duration(hours: 9)).toLocal();
        //
        //   setState(() {
        //     widget.onDaySelected(adjustedSelectedDay); // 선택한 날짜 정보를 onDaySelected 함수에 전달
        //     _focusedDate = focusedDay; // 선택한 날짜 정보를 _focusedDate 변수에 저장
        //   });
        // },
        selectedDayPredicate: (day) {
          // 월, 수, 금이 선택된 날짜로 표시되도록 설정
          return preSelectedDays.any((selectedDay) =>
              selectedDay.year == day.year &&
              selectedDay.month == day.month &&
              selectedDay.day == day.day);
        },
      ),
    );
  }
}
