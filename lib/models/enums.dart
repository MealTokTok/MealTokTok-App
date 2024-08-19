
enum DayOfWeek {
  SUNDAY,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY
}

DayOfWeek stringToDayOfWeek(String value) {
  if(value == 'SUNDAY'){
    return DayOfWeek.SUNDAY;
  }
  else if(value == 'MONDAY'){
    return DayOfWeek.MONDAY;
  }
  else if(value == 'TUESDAY'){
    return DayOfWeek.TUESDAY;
  }
  else if(value == 'WEDNESDAY'){
    return DayOfWeek.WEDNESDAY;
  }
  else if(value == 'THURSDAY'){
    return DayOfWeek.THURSDAY;
  }
  else if(value == 'FRIDAY'){
    return DayOfWeek.FRIDAY;
  }
  else if(value == 'SATURDAY'){
    return DayOfWeek.SATURDAY;
  }
  else{
    throw Exception('Invalid DayOfWeek');
  }
}

enum Time {
  LUNCH,
  DINNER
}

Time stringToTime(String value) {
  if(value == 'LUNCH'){
    return Time.LUNCH;
  }
  else if(value == 'DINNER'){
    return Time.DINNER;
  }
  else{
    throw Exception('Invalid Time');
  }
}

enum OrderType{
  DAY_ORDER,
  WEEK_ORDER
}

OrderType stringToOrderType(String value) {
  if(value == 'DAY_ORDER'){
    return OrderType.DAY_ORDER;
  }
  else if(value == 'WEEK_ORDER'){
    return OrderType.WEEK_ORDER;
  }
  else{
    throw Exception('Invalid OrderType');
  }
}

enum OrderState {
  ORDERED,
  PENDING,
  DELIVERING,
  DELIVERED,
}

OrderState stringToOrderState(String value) {
  if(value == 'ORDERED'){
    return OrderState.ORDERED;
  }
  else if(value == 'PENDING'){
    return OrderState.PENDING;
  }
  else if(value == 'DELIVERING'){
    return OrderState.DELIVERING;
  }
  else if(value == 'DELIVERED'){
    return OrderState.DELIVERED;
  }
  else{
    throw Exception('Invalid OrderState');
  }
}

enum TimeType { BEFORE_LUNCH, AFTER_LUNCH, AFTER_DINNER }
