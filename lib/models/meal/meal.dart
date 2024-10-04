import 'package:hankkitoktok/models/base_model.dart';

import 'dish.dart';

class Meal extends BaseModel {
  int mealId;
  String name;
  int price;
  List<Dish> dishList;
  DateTime? createdAt;

  Meal.init({
    this.mealId = 0,
    this.name = '',
    this.price = 0,
    this.dishList = const [],
    this.createdAt,
  });

  @override
  Meal fromMap(Map<String, dynamic> map) {
    return Meal.init(
      mealId: map['meal']['mealId'] ?? 0,
      name: map['meal']['mealName'] ?? '',
      price: map['meal']['mealPrice']['amount'] ?? 0,
      dishList: (map['dishes'] as List).map((dishMap) => Dish.init().fromMap(dishMap)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
    };
  }

  String getDishString() {
    String dishString = '';
    for (Dish dish in dishList) {
      dishString += '${dish.dishName}, ';
    }
    if (dishString.length > 2) {
      return dishString.substring(0, dishString.length - 2);
    } else {
      return '';
    }
  }

  List<String> getDishNames() {
    List<String> dishNames = [];
    for (Dish dish in dishList) {
      dishNames.add(dish.dishName);
    }
    return dishNames;
  }

  List<String> getDishUrls() {
    List<String> dishUrls = [];
    for (Dish dish in dishList) {
      dishUrls.add(dish.imgUrl);
    }
    return dishUrls;
  }
}

class Meal1 extends BaseModel {
  int mealId;
  String mealName;
  int mealPrice;
  List<Dish1> dishes;

  Meal1.init({
    this.mealId = 0,
    this.mealName = '',
    this.mealPrice = 0,
    this.dishes = const [],
  });

  @override
  Meal1 fromMap(Map<String, dynamic> map) {
    return Meal1.init(
      mealId: map['meal']['mealId'],
      mealName: map['meal']['mealName'],
      mealPrice: map['meal']['mealPrice']['amount'],
      dishes:
          (map['dishes'] as List).map((dish) => Dish1.init().fromMap(dish)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'mealName': mealName,
      'mealPrice': {'amount': mealPrice},
      'dishes': dishes.map((dish) => dish.toJson()).toList(),
    };
  }
  List<String> getDishNames() {
    List<String> dishNames = [];
    for (Dish1 dish in dishes) {
      dishNames.add(dish.dishName);
    }
    return dishNames;
  }
  List<String> getDishUrls() {
    List<String> dishUrls = [];
    for (Dish1 dish in dishes) {
      dishUrls.add(dish.imgUrl);
    }
    return dishUrls;
  }
}
