import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/controller/meal_controller.dart';
import 'package:hankkitoktok/controller/ordered_meal_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import '../const/color.dart';
import '../const/style2.dart';

import '../models/meal/ordered_meal.dart';

class Calendar extends StatefulWidget {
  final void Function(DateTime selectedDay) onDaySelected;
  final DateTime currentDate = DateTime.now();

  Calendar({
    super.key,
    required this.onDaySelected,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime nextSunday;
  late DateTime _focusedDate;

  @override
  void initState() {
    nextSunday = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: 7 - DateTime.now().weekday));

    _focusedDate = nextSunday;
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
        firstDay: nextSunday,
        lastDay: nextSunday.add(const Duration(days: 6)),
        focusedDay: _focusedDate,
        calendarFormat: CalendarFormat.week,
        headerVisible: false,
        locale: 'ko_KR',
        daysOfWeekHeight: 32,
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
        onDaySelected: (selectedDay, focusedDay) {
          // 9시간 전의 로컬 시간으로 변환
          DateTime adjustedSelectedDay =
              selectedDay.subtract(const Duration(hours: 9)).toLocal();

          setState(() {
            widget.onDaySelected(adjustedSelectedDay);
            _focusedDate = focusedDay;
          });
        },
        selectedDayPredicate: (day) {
          OrderedMealController mealController =
              Get.find<OrderedMealController>();

          return mealController.orderedWeekMeals[
                      day.subtract(const Duration(hours: 9)).toLocal()] !=
                  null &&
              mealController
                  .orderedWeekMeals[
                      day.subtract(const Duration(hours: 9)).toLocal()]![0]
                  .isVisible &&
              mealController
                  .orderedWeekMeals[
                      day.subtract(const Duration(hours: 9)).toLocal()]![1]
                  .isVisible;
        },
      ),
    );
  }
}
