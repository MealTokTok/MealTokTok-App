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
      mealId: map['mealId'],
      name: map['name'],
      price: map['price'],
      dishList: List<Dish>.from(map['dishList']),
      createdAt: DateTime.parse(map['createdAt']),
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
    if(dishString.length > 2){
      return dishString.substring(0, dishString.length - 2);
    }
    else {
      return '';
    }
  }

  List<String> getDishNames(){
    List<String> dishNames = [];
    for (Dish dish in dishList) {
      dishNames.add(dish.dishName);
    }
    return dishNames;
  }

  List<String> getDishUrls(){
    List<String> dishUrls = [];
    for (Dish dish in dishList) {
      dishUrls.add(dish.imgUrl);
    }
    return dishUrls;
  }
}

