import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/meal_menu/ordered_meal_menu.dart';

class Order extends BaseModel {
  int orderID; //주문번호
  DateTime orderDate; // 주문닐짜
  String orderStatus; // 주문상태 (주문완료, 배송중, 배송완료)
  String orderType; // 주문타입 (일 결제, 주간 결제)
  int orderNumberDay; //주문횟수
  int orderNumberWeek;

  String orderAddress; // 주문주소
  String orderDetailAddress; // 상세주소
  String customerName; // 주문자 이름
  String customerPhoneNumber; // 주문자 전화번호

  String requestMessage; // 요청사항


  List<OrderedMealMenu> orderedMealMenuList; // 주문한 도시락 리스트(주간 결제일 경우 2개이상, 일 결제일 경우 1개이상)
  int washingService; // 세척서비스 횟수 (orderNumber 이하의 횟수)
  int washingServicePrice; // 세척서비스 가격
  int menuPrice; // 주문가격
  int deliveryPrice; // 배송비
  int totalPrice; // 총 가격

  Order(
      this.orderID,
      this.orderDate,
      this.orderStatus,
      this.orderType,
      this.orderNumberDay,
      this.orderNumberWeek,
      this.orderAddress,
      this.orderDetailAddress,
      this.customerName,
      this.customerPhoneNumber,
      this.requestMessage,
      this.orderedMealMenuList,
      this.washingService,
      this.washingServicePrice,
      this.menuPrice,
      this.deliveryPrice,
      this.totalPrice);

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return Order(
        map['orderID'],
        DateTime.parse(map['orderDate']),
        map['orderStatus'],
        map['orderType'],
        map['orderNumberDay'],
        map['orderNumberWeek'],
        map['orderAddress'],
        map['orderDetailAddress'],
        map['customerName'],
        map['customerPhoneNumber'],
        map['requestMessage'],
        List<OrderedMealMenu>.from(map['orderedMealMenuList']),
        map['washingService'],
        map['washingServicePrice'],
        map['menuPrice'],
        map['deliveryPrice'],
        map['totalPrice'])
    ;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'orderID': orderID,
      'orderDate': orderDate.toIso8601String(),
      'orderStatus': orderStatus,
      'orderType': orderType,
      'orderNumberDay': orderNumberDay,
      'orderNumberWeek': orderNumberWeek,
      'orderAddress': orderAddress,
      'orderDetailAddress': orderDetailAddress,
      'customerName': customerName,
      'customerPhoneNumber': customerPhoneNumber,
      'requestMessage': requestMessage,
      'orderedMealMenuList': orderedMealMenuList.map((item) => item.toJson()).toList(),
      'washingService': washingService,
      'washingServicePrice': washingServicePrice,
      'menuPrice': menuPrice,
      'deliveryPrice': deliveryPrice,
      'totalPrice': totalPrice
    };
  }

  //수, 금, 토
  String get dayOfWeekInitial {
    List<String> dayOfWeekList = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

    var initialsSet = Set<String>();

    for (var item in orderedMealMenuList) {
      initialsSet.add(item.deliveryDayOfWeek[0]);
    }
    List<String> sortedInitials = [];
    for (var dayOfWeek in dayOfWeekList) {
      String initial = dayOfWeek[0];
      if (initialsSet.contains(initial)) {
        sortedInitials.add(initial);
      }
    }

    return sortedInitials.join(', ');
  }

  //2024년 06월 29일 오후 14:20
  String get orderDateString {
    return '${orderDate.year}년 ${orderDate.month}월 ${orderDate.day}일 ${orderDate.hour}:${orderDate.minute}';
  }


  List<List<dynamic>> get combinedMenuList {
    //수 - 저녁(메뉴이름) 형식으로 반환
    List<String> menuTitles = orderedMealMenuList.map((item) => '${item.deliveryDayOfWeek[0]}-${item.deliveryTimeOfDay}(${item.name})').toList();
    // 두부조림, 김치볶음밥, 김치, 된장국
    List<String> mealItems = orderedMealMenuList.map((item) => item.menuList.join(', ')).toList();


    List<List<dynamic>> combinedList = [];
    for (int i = 0; i < menuTitles.length; i++) {
      combinedList.add([menuTitles[i],orderedMealMenuList[i].price,mealItems[i]]);
    }

    return combinedList;
  }

  List<String> get getOrderTimeList {
    var map = Map<String, Set<String>>();
    List<String> dayOfWeekList = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];

    for (var item in orderedMealMenuList) {
      if (map[item.deliveryDayOfWeek] == null) {
        map[item.deliveryDayOfWeek] = Set<String>();
      }
      map[item.deliveryDayOfWeek]!.add(item.deliveryTimeOfDay);
    }

    List<String> result = [];
    for (var dayOfWeek in dayOfWeekList) {
      if (map[dayOfWeek] != null) {
        // 시간 순서로 정렬: "점심" 먼저, "저녁" 다음
        var sortedTimes = map[dayOfWeek]!.toList()..sort((a, b) {
          if (a == b) return 0;
          if (a == '점심') return -1;
          if (b == '점심') return 1;
          return 0;
        });
        result.add('$dayOfWeek ${sortedTimes.join(', ')}');
      }
    }
    return result;
  }

}
