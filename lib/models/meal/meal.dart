import 'package:hankkitoktok/models/base_model.dart';

import 'dish.dart';

class Meal extends BaseModel {
  int mealId;
  String mealName;
  int mealPrice;
  //bool isDeleted;
  List<Dish> dishes;

  Meal.init({
    this.mealId = 0,
    this.mealName = '',
    this.mealPrice = 0,
    //this.isDeleted = false,
    this.dishes = const [],
  });

  @override
  Meal fromMap(Map<String, dynamic> map) {
    return Meal.init(
      mealId: map['meal']['mealId'] ?? 0,
      mealName: map['meal']['mealName'] ?? '',
      mealPrice: map['meal']['mealPrice']['amount'].toInt() ?? 0,
      //isDeleted: map['meal']['isDeleted'] ?? false,
      dishes: (map['dishes'] as List).map((dishMap) => Dish.init().fromMap(dishMap)).toList(),
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
    for (Dish dish in dishes) {
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
    for (Dish dish in dishes) {
      dishNames.add(dish.dishName);
    }
    return dishNames;
  }

  List<String> getDishUrls() {
    List<String> dishUrls = [];
    for (Dish dish in dishes) {
      dishUrls.add(dish.imgUrl);
    }
    return dishUrls;
  }
}



class Meal1 extends BaseModel {
  int mealId;
  String mealName;
  int mealPrice;
  List<Dish> dishes;

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
          (map['dishes'] as List).map((dish) => Dish.init().fromMap(dish)).toList(),
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
    for (Dish dish in dishes) {
      dishNames.add(dish.dishName);
    }
    return dishNames;
  }
  List<String> getDishUrls() {
    List<String> dishUrls = [];
    for (Dish dish in dishes) {
      dishUrls.add(dish.imgUrl);
    }
    return dishUrls;
  }
}
