
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
  AFTERNOON,
  EVENING
}

Time stringToTime(String value) {
  if(value == 'LUNCH'){
    return Time.AFTERNOON;
  }
  else if(value == 'EVENING'){
    return Time.EVENING;
  }
  else{
    throw Exception('Invalid Time');
  }
}

enum OrderType{
  IMMEDIATE,
  SCHEDULED
}

OrderType stringToOrderType(String value) {
  if(value == 'IMMEDIATE'){
    return OrderType.IMMEDIATE;
  }
  else if(value == 'SCHEDULED'){
    return OrderType.SCHEDULED;
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

enum DeliveryState {
  PENDING,
  INDELIVERING,
  DELIVERED,
}

enum CollectingState {
  NOT_COLLECTED,
  COLLECT_REQUESTED,
  COLLECTED
}

CollectingState stringToCollecting(String value) {
  if(value == 'NOT_COLLECTED'){
    return CollectingState.NOT_COLLECTED;
  }
  else if(value == 'COLLECT_REQUESTED'){
    return CollectingState.COLLECT_REQUESTED;
  }
  else if(value == 'COLLECTED'){
    return CollectingState.COLLECTED;
  }
  else{
    throw Exception('Invalid CollectingState');
  }
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

enum TimeType { BEFORE_LUNCH, AFTER_LUNCH, AFTER_EVENING }
