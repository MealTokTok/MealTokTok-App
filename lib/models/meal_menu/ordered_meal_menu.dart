import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/meal_menu/meal_menu.dart';


class DeliveredMealMenu extends MealMenu{
  int orderNumber;
  DateTime deliveryCompletionTime;

  DeliveredMealMenu(String name, int price, List<String> menuList, List<String> menuUrlList, this.orderNumber, this.deliveryCompletionTime)
      : super(name, price, menuList, menuUrlList);

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return DeliveredMealMenu(
      map['name'],
      map['price'],
      List<String>.from(map['menuList']),
      List<String>.from(map['menuUrlList']),
      map['orderNumber'],
      map['deliveriedTime'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'menuList': menuList,
      'menuUrlList': menuUrlList,
      'orderNumber': orderNumber,
      'deliveryCompletionTime': deliveryCompletionTime,
    };
  }

}