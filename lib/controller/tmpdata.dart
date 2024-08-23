import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/models/meal/ordered_meal.dart';
import 'package:hankkitoktok/models/meal/meal.dart';
import 'package:hankkitoktok/models/order/order_mini.dart';
import 'package:hankkitoktok/models/sidedish/sidedish.dart';

import '../models/enums.dart';
import '../models/meal/dish.dart';
import '../models/order/order.dart';

int _dishIdCounter = 1;
int _mealIdCounter = 1;
int _orderIdCounter = 1;
int _requestIdCounter = 1;

List<Meal> mealMenuList = [
  Meal.init(
    mealId: _mealIdCounter++,
    name: '아침 콤보',
    price: 6000,
    dishList: [
      Dish.init(dishId: _dishIdCounter++, dishName: '팬케이크', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '베이컨', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '계란', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '커피', imgUrl: 'https://picsum.photos/80/80'),
    ],
  ),
  Meal.init(
    mealId: _mealIdCounter++,
    name: '점심 스페셜',
    price: 6000,
    dishList: [
      Dish.init(dishId: _dishIdCounter++, dishName: '버거', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '감자튀김', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '샐러드', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '탄산음료', imgUrl: 'https://picsum.photos/80/80'),
    ],
  ),
  Meal.init(
    mealId: _mealIdCounter++,
    name: '저녁 특선',
    price: 6000,
    dishList: [
      Dish.init(dishId: _dishIdCounter++, dishName: '스테이크', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '매쉬드 포테이토', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '구운 야채', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '와인', imgUrl: 'https://picsum.photos/80/80'),
    ],
  ),
  Meal.init(
    mealId: _mealIdCounter++,
    name: '채식주의자 잔치',
    price: 6000,
    dishList: [
      Dish.init(dishId: _dishIdCounter++, dishName: '샐러드', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '야채 수프', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '구운 두부', imgUrl: 'https://picsum.photos/80/80'),
      Dish.init(dishId: _dishIdCounter++, dishName: '주스', imgUrl: 'https://picsum.photos/80/80'),
    ],
  ),
];


List<OrderedMeal> orderedMeals = [
  OrderedMeal.init(
    mealId: _orderIdCounter++,
    reservedDate: DateTime(2024, 8, 15), // 특정 날짜로 설정
    reservedTime: Time.LUNCH, // 점심 시간
    includeRice: true, // 밥 포함
    hasFullDiningOption: false, // 전체 다이닝 옵션 제외
  ),
  OrderedMeal.init(
    mealId: _orderIdCounter++,
    reservedDate: DateTime(2024, 8, 16),
    reservedTime: Time.DINNER, // 저녁 시간
    includeRice: false,
    hasFullDiningOption: true,
  ),
  OrderedMeal.init(
    mealId: _orderIdCounter++,
    reservedDate: DateTime(2024, 8, 17),
    reservedTime: Time.LUNCH,
    includeRice: true,
    hasFullDiningOption: true,
  ),
  OrderedMeal.init(
    mealId: _orderIdCounter++,
    reservedDate: DateTime(2024, 8, 17),
    reservedTime: Time.DINNER,
    includeRice: false,
    hasFullDiningOption: false,
  ),
];

List<MealDelivery> mealDeliveries = [
  MealDelivery.init(
    mealDeliveryId: _requestIdCounter++,
    orderId: 1,
    orderedMeal: orderedMeals[0],
    orderState: OrderState.ORDERED,
    deliveryStartTime: DateTime(2024, 8, 15, 12, 30),
    deliveryCompleteTime: null,
  ),
  MealDelivery.init(
    mealDeliveryId: _requestIdCounter++,
    orderId: 2,
    orderedMeal: orderedMeals[1],
    orderState: OrderState.PENDING,
    deliveryStartTime: null,
    deliveryCompleteTime: null,
  ),
  MealDelivery.init(
    mealDeliveryId: _requestIdCounter++,
    orderId: 3,
    orderedMeal: orderedMeals[2],
    orderState: OrderState.DELIVERED,
    deliveryStartTime: DateTime(2024, 8, 17, 12, 30),
    deliveryCompleteTime: DateTime(2024, 8, 17, 12, 45),
  ),
  MealDelivery.init(
    mealDeliveryId: _requestIdCounter++,
    orderId: 4,
    orderedMeal: orderedMeals[3],
    orderState: OrderState.DELIVERED,
    deliveryStartTime: null,
    deliveryCompleteTime: null,
  ),
];

List<List<MealDelivery>> orderedMealsExamples = [
  [mealDeliveries[0]],
  [mealDeliveries[1], mealDeliveries[2]],
  [mealDeliveries[3], mealDeliveries[0], mealDeliveries[1]],
  [mealDeliveries[2], mealDeliveries[3], mealDeliveries[0], mealDeliveries[1]],
];

Order exampleOrder = Order.init(
  orderID: _orderIdCounter++,
  orderType: OrderType.WEEK_ORDER, // 주간 결제로 설정
  orderState: OrderState.ORDERED, // 주문 상태 설정
  specialInstruction: '배송 시 문 앞에 두세요.', // 요청 사항
  userId: 12345,

  mealPrice: 18000,
  deliveryPrice: 3000,
  fullServicePrice: 5000,
  totalPrice: 26000,
  orderTime: DateTime(2024, 8, 14, 14, 20), // 주문 시간 설정
  mealDeliveries: orderedMealsExamples[0], // OrderedMeal 리스트 추가
);

Order exampleOrder2 = Order.init(
  orderID: _orderIdCounter++,
  orderType: OrderType.DAY_ORDER,
  orderState: OrderState.PENDING,
  specialInstruction: '배송 시 연락주세요.',
  userId: 54321,

  mealPrice: 12000,
  deliveryPrice: 2000,
  fullServicePrice: 3000,
  totalPrice: 17000,
  orderTime: DateTime(2024, 8, 15, 12, 30),
  mealDeliveries: orderedMealsExamples[1],
);

Order exampleOrder3 = Order.init(
  orderID: _orderIdCounter++,
  orderType: OrderType.WEEK_ORDER,
  orderState: OrderState.DELIVERED,
  specialInstruction: '부재 시 경비실에 맡겨주세요.',
  userId: 98765,

  mealPrice: 24000,
  deliveryPrice: 4000,
  fullServicePrice: 7000,
  totalPrice: 35000,
  orderTime: DateTime(2024, 8, 16, 11, 45),
  mealDeliveries: orderedMealsExamples[2],
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
