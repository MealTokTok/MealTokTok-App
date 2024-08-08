import 'package:hankkitoktok/models/meal_menu/ordered_meal_menu.dart';
import 'package:hankkitoktok/models/meal_menu/meal_menu.dart';
import 'package:hankkitoktok/models/order/order_mini.dart';
import 'package:hankkitoktok/models/sidedish/sidedish.dart';

import '../models/order/order.dart';

List<MealMenu> mealMenuList = [
  MealMenu('아침 콤보', 6000, [
    '팬케이크',
    '베이컨',
    '계란',
    '커피'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ]),
  MealMenu('점심 스페셜', 6000, [
    '버거',
    '감자튀김',
    '샐러드',
    '탄산음료'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ]),
  MealMenu('저녁 특선', 6000, [
    '스테이크',
    '매쉬드 포테이토',
    '구운 야채',
    '와인'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ]),
  MealMenu('채식주의자 잔치', 6000, [
    '샐러드',
    '야채 수프',
    '구운 두부',
    '주스'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ])
];

OrderedMealMenu orderedMealMenu = OrderedMealMenu(
    '아침 콤보',
    6000,
    ['팬케이크', '베이컨', '계란', '커피'],
    [
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80',
      'https://picsum.photos/80/80'
    ],
    203,
    DateTime.now(),
    '수',
    '점심',
    );

List<SideDish> sideDishList = [
  SideDish('무침', '베이컨', 'https://picsum.photos/80/80'),
  SideDish('무침', '계란', 'https://picsum.photos/80/80'),
  SideDish('조림', '샐러드', 'https://picsum.photos/80/80'),
  SideDish('조림', '감자튀김', 'https://picsum.photos/80/80'),
  SideDish('볶음', '탄산음료', 'https://picsum.photos/80/80'),
  SideDish('볶음', '와인', 'https://picsum.photos/80/80'),
  SideDish('절임', '야채 수프', 'https://picsum.photos/80/80'),
  SideDish('절임', '무슨무슨절임', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '구운 두부', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '주스', 'https://picsum.photos/80/80'),
  SideDish('무침', '베이컨', 'https://picsum.photos/80/80'),
  SideDish('무침', '계란', 'https://picsum.photos/80/80'),
  SideDish('조림', '샐러드', 'https://picsum.photos/80/80'),
  SideDish('조림', '감자튀김', 'https://picsum.photos/80/80'),
  SideDish('볶음', '탄산음료', 'https://picsum.photos/80/80'),
  SideDish('볶음', '와인', 'https://picsum.photos/80/80'),
  SideDish('절임', '야채 수프', 'https://picsum.photos/80/80'),
  SideDish('절임', '무슨무슨절임', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '구운 두부', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '주스', 'https://picsum.photos/80/80'),
  SideDish('무침', '베이컨', 'https://picsum.photos/80/80'),
  SideDish('무침', '계란', 'https://picsum.photos/80/80'),
  SideDish('조림', '샐러드', 'https://picsum.photos/80/80'),
  SideDish('조림', '감자튀김', 'https://picsum.photos/80/80'),
  SideDish('볶음', '탄산음료', 'https://picsum.photos/80/80'),
  SideDish('볶음', '와인', 'https://picsum.photos/80/80'),
  SideDish('절임', '야채 수프', 'https://picsum.photos/80/80'),
  SideDish('절임', '무슨무슨절임', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '구운 두부', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '주스', 'https://picsum.photos/80/80'),
  SideDish('무침', '베이컨', 'https://picsum.photos/80/80'),
  SideDish('무침', '계란', 'https://picsum.photos/80/80'),
  SideDish('조림', '샐러드', 'https://picsum.photos/80/80'),
  SideDish('조림', '감자튀김', 'https://picsum.photos/80/80'),
  SideDish('볶음', '탄산음료', 'https://picsum.photos/80/80'),
  SideDish('볶음', '와인', 'https://picsum.photos/80/80'),
  SideDish('절임', '야채 수프', 'https://picsum.photos/80/80'),
  SideDish('절임', '무슨무슨절임', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '구운 두부', 'https://picsum.photos/80/80'),
  SideDish('김치/젓갈', '주스', 'https://picsum.photos/80/80'),
];

OrderedMealMenu orderedMeal1 = OrderedMealMenu(
  '아침 콤보',
  6000,
  ['팬케이크', '베이컨', '계란', '커피'],
  [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ],
  1,
  DateTime.now(),
  '수요일',
  '점심',
);

OrderedMealMenu orderedMeal2 = OrderedMealMenu(
  '점심 콤보',
  8000,
  ['샌드위치', '샐러드', '주스', '과일'],
  [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ],
  2,
  DateTime.now(),
  '목요일',
  '저녁',
);

OrderedMealMenu orderedMeal3 = OrderedMealMenu(
  '저녁 콤보',
  7000,
  ['스테이크', '감자', '야채', '음료'],
  [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ],
  3,
  DateTime.now(),
  '목요일',
  '저녁',
);

OrderedMealMenu orderedMeal4 = OrderedMealMenu(
  '스페셜 콤보',
  10000,
  ['랍스터', '샐러드', '와인', '디저트'],
  [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ],
  4,
  DateTime.now(),
  '목요일',
  '저녁',
);

// Order 테스트 데이터 생성
Order order1 = Order(
  111,
  DateTime.now(),
  '배송 중',
  '일 결제',
  1,
  0,
  '서울특별시 강남구',
  '101동 101호',
  '홍길동',
  '010-1234-5678',
  '문 앞에 놓아주세요.',
  [orderedMeal1],
  1,
  3000,
  6000,
  3000,
  9000,
);

Order order2 = Order(
  222,
  DateTime.now(),
  '배송 완료',
  '주간 결제',
  0,
  2,
  '서울특별시 서초구',
  '202동 202호',
  '김철수',
  '010-8765-4321',
  '배송 완료 후 전화주세요.',
  [orderedMeal1, orderedMeal2],
  2,
  5000,
  14000,
  3000,
  22000,
);

Order order3 = Order(
  333,
  DateTime.now(),
  '배송 대기',
  '주간 결제',
  0,
  3,
  '서울특별시 송파구',
  '303동 303호',
  '박영희',
  '010-1234-4321',
  '배송 전 미리 연락 바랍니다.',
  [orderedMeal1, orderedMeal2, orderedMeal3],
  0,
  7000,
  21000,
  5000,
  33000,
);

Order order4 = Order(
  444,
  DateTime.now(),
  '배송 중',
  '일 결제',
  1,
  0,
  '서울특별시 강동구',
  '404동 404호',
  '최미나',
  '010-5678-8765',
  '부재 시 경비실에 맡겨주세요.',
  [orderedMeal3],
  1,
  3000,
  7000,
  3000,
  10000,
);

Order order5 = Order(
  555,
  DateTime.now(),
  '배송 완료',
  '주간 결제',
  0,
  4,
  '서울특별시 중구',
  '505동 505호',
  '이민호',
  '010-8765-1234',
  '특별 요청 사항 없음.',
  [orderedMeal1, orderedMeal2, orderedMeal3, orderedMeal4],
  4,
  9000,
  31000,
  7000,
  47000,
);

List<Order> orderList = [order1, order2, order3, order4, order5];

List<OrderMini> orderMiniList = orderList.map((order) => OrderMini(
  order.orderID,
  order.orderDate,
  order.orderStatus,
  order.orderType,
  order.orderNumberDay,
  order.orderNumberWeek,
  order.washingService,
  order.washingServicePrice,
  order.menuPrice,
  order.deliveryPrice,
)).toList();



