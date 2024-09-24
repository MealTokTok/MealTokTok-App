
// import 'package:hankkitoktok/models/meal_menu/delivered_meal_menu.dart';
// import 'package:hankkitoktok/models/meal_menu/meal_menu.dart';
//
//
// List<MealMenu> mealMenuList = [
//   MealMenu('아침 콤보', 6000, [
//     '팬케이크',
//     '베이컨',
//     '계란',
//     '커피'
//   ], [
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80'
//   ]),
//   MealMenu('점심 스페셜', 6000, [
//     '버거',
//     '감자튀김',
//     '샐러드',
//     '탄산음료'
//   ], [
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80'
//   ]),
//   MealMenu('저녁 특선', 6000, [
//     '스테이크',
//     '매쉬드 포테이토',
//     '구운 야채',
//     '와인'
//   ], [
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80'
//   ]),
//   MealMenu('채식주의자 잔치', 6000, [
//     '샐러드',
//     '야채 수프',
//     '구운 두부',
//     '주스'
//   ], [
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80',
//     'https://picsum.photos/80/80'
//   ])
// ];
//
// DeliveredMealMenu deliveredMealMenu = DeliveredMealMenu(
//     '아침 콤보',
//     6000,
//     ['팬케이크', '베이컨', '계란', '커피'],
//     [
//       'https://picsum.photos/80/80',
//       'https://picsum.photos/80/80',
//       'https://picsum.photos/80/80',
//       'https://picsum.photos/80/80'
//     ],
//     203,
//     DateTime.now());

import 'package:hankkitoktok/models/meal/meal_delivery.dart';
import 'package:hankkitoktok/models/meal/ordered_meal.dart';
import 'package:hankkitoktok/models/meal/meal.dart';
import 'package:hankkitoktok/models/order/order_post.dart';
import 'package:hankkitoktok/models/sidedish/sidedish.dart';

import '../models/enums.dart';
import '../models/meal/dish.dart';
import '../models/order/order.dart';
import '../models/user/user.dart';

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

Meal getMealById(int mealId) {
  for(Meal meal in mealMenuList){
    if(meal.mealId == mealId){
      return meal;
    }
  }
  return mealMenuList[1];
}


List<OrderedMeal> orderedMeals = [
  OrderedMeal.init(
    mealId: 1,
    reservedDate: DateTime(2024, 8, 15), // 특정 날짜로 설정
    reservedTime: Time.AFTERNOON, // 점심 시간
    includeRice: true, // 밥 포함
    hasFullDiningOption: false, // 전체 다이닝 옵션 제외
  ),
  OrderedMeal.init(
    mealId: 2,
    reservedDate: DateTime(2024, 8, 16),
    reservedTime: Time.EVENING, // 저녁 시간
    includeRice: false,
    hasFullDiningOption: true,
  ),
  OrderedMeal.init(
    mealId: 3,
    reservedDate: DateTime(2024, 8, 17),
    reservedTime: Time.AFTERNOON,
    includeRice: true,
    hasFullDiningOption: true,
  ),
  OrderedMeal.init(
    mealId: 4,
    reservedDate: DateTime(2024, 8, 17),
    reservedTime: Time.EVENING,
    includeRice: false,
    hasFullDiningOption: false,
  ),
];


// List<MealDelivery> mealDeliveries = [
//   MealDelivery.init(
//     mealDeliveryId: _requestIdCounter++,
//     orderId: 1,
//     orderedMeal: orderedMeals[0],
//     orderState: OrderState.DELIVERING,
//     deliveryState: DeliveryState.DELIVERED,
//     deliveryRequestTime: DateTime(2024, 8, 15, 12, 30),
//     orderTime: DateTime(2024, 8, 14, 14, 20),
//     deliveryStartTime: DateTime(2024, 8, 15, 12, 30),
//     deliveryCompleteTime: null,
//   ),
//   MealDelivery.init(
//     mealDeliveryId: _requestIdCounter++,
//     orderId: 2,
//     orderedMeal: orderedMeals[1],
//     orderState: OrderState.PENDING,
//     deliveryState: DeliveryState.INDELIVERING,
//     deliveryRequestTime: DateTime(2024, 8, 15, 12, 30),
//     orderTime: DateTime(2024, 8, 14, 14, 20),
//     deliveryStartTime: null,
//     deliveryCompleteTime: null,
//   ),
//   MealDelivery.init(
//     mealDeliveryId: _requestIdCounter++,
//     orderId: 3,
//     orderedMeal: orderedMeals[2],
//     orderState: OrderState.DELIVERING,
//     deliveryState: DeliveryState.PENDING,
//     deliveryRequestTime: DateTime(2024, 8, 15, 12, 30),
//     orderTime: DateTime(2024, 8, 14, 14, 20),
//     deliveryStartTime: DateTime(2024, 8, 17, 12, 30),
//     deliveryCompleteTime: null,
//   ),
//   MealDelivery.init(
//     mealDeliveryId: _requestIdCounter++,
//     orderId: 4,
//     orderedMeal: orderedMeals[3],
//     orderState: OrderState.ORDERED,
//     deliveryState: DeliveryState.PENDING,
//     deliveryRequestTime: DateTime(2024, 8, 15, 12, 30),
//     orderTime: DateTime(2024, 8, 14, 14, 20),
//     deliveryStartTime: null,
//     deliveryCompleteTime: null,
//   ),
// ];
//
// MealDelivery getMealDeliveryById(int mealDeliveryId) {
//   for(MealDelivery mealDelivery in mealDeliveries){
//     if(mealDelivery.mealDeliveryId == mealDeliveryId){
//       return mealDelivery;
//     }
//   }
//   return mealDeliveries[0];
// }
//
// MealDelivery getNextMealDelivery(String orderId) {
//   return mealDeliveries[1];
// }
//
// List<List<MealDelivery>> orderedMealsExamples = [
//   [mealDeliveries[0]],
//   [mealDeliveries[1], mealDeliveries[2]],
//   [mealDeliveries[3], mealDeliveries[0], mealDeliveries[1]],
//   [mealDeliveries[2], mealDeliveries[3], mealDeliveries[0], mealDeliveries[1]],
// ];

// Order exampleOrder = Order.init(
//   orderID: _orderIdCounter++,
//   orderType: OrderType.SCHEDULED, // 주간 결제로 설정
//   orderState: OrderState.DELIVERING, // 주문 상태 설정
//   specialInstruction: '배송 시 문 앞에 두세요.', // 요청 사항
//   userId: 1,
//
//   mealPrice: 18000,
//   deliveryPrice: 3000,
//   fullServicePrice: 5000,
//   totalPrice: 26000,
//   orderTime: DateTime(2024, 8, 14, 14, 20), // 주문 시간 설정
// );
//
// Order exampleOrder2 = Order.init(
//   orderID: _orderIdCounter++,
//   orderType: OrderType.IMMEDIATE,
//   orderState: OrderState.PENDING,
//   specialInstruction: '배송 시 연락주세요.',
//   userId: 1,
//
//   mealPrice: 12000,
//   deliveryPrice: 2000,
//   fullServicePrice: 3000,
//   totalPrice: 17000,
//   orderTime: DateTime(2024, 8, 15, 12, 30),
// );
//
// Order exampleOrder3 = Order.init(
//   orderID: _orderIdCounter++,
//   orderType: OrderType.SCHEDULED,
//   orderState: OrderState.DELIVERED,
//   specialInstruction: '부재 시 경비실에 맡겨주세요.',
//   userId: 1,
//
//   mealPrice: 24000,
//   deliveryPrice: 4000,
//   fullServicePrice: 7000,
//   totalPrice: 35000,
//   orderTime: DateTime(2024, 8, 16, 11, 45),
// );

//List<Order> orders = [exampleOrder, exampleOrder2, exampleOrder3];

// Order getOrderById(int orderId) {
//   for(Order order in orders){
//     if(order.orderID == orderId){
//       return order;
//     }
//   }
//   return orders[0];
// }

User exampleUser = User.init(
  userId: 1,
  username: 'testuser',
  nickname: '테스트유저',
  email: 'email@google.com',
  phoneNumber: '010-1234-5678',
  profileImageUrl: 'https://picsum.photos/80/80',
  birth: DateTime(1990, 1, 1),
);

User getUserById(int userId) {
  return exampleUser;
}



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

String getAddressById(int addressId) {
  return '서울시 강남구 테헤란로 123';
}
