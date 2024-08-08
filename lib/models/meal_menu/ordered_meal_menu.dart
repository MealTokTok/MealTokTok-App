import 'package:hankkitoktok/models/base_model.dart';
import 'package:hankkitoktok/models/meal_menu/meal_menu.dart';


class OrderedMealMenu extends MealMenu{
  int orderID;
  DateTime? deliveryCompletionTime;
  String deliveryDayOfWeek; // 수
  String deliveryTimeOfDay; // 점심
  OrderedMealMenu(super.name, super.price, super.menuList, super.menuUrlList, this.orderID, this.deliveryCompletionTime, this.deliveryDayOfWeek, this.deliveryTimeOfDay);

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return OrderedMealMenu(
      map['name'],
      map['price'],
      List<String>.from(map['menuList']),
      List<String>.from(map['menuUrlList']),
      map['orderID'],
      map['deliveriedTime'],
      map['deliveryDayOfWeek'],
      map['deliveryTimeOfDay'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'menuList': menuList,
      'menuUrlList': menuUrlList,
      'orderID': orderID,
      'deliveryCompletionTime': deliveryCompletionTime,
      'deliveryDayOfWeek': deliveryDayOfWeek,
      'deliveryTimeOfDay': deliveryTimeOfDay,
    };
  }

  //yyyy.mm.dd
  String? getDeliveryTime() {
    if (deliveryCompletionTime != null) {
      return deliveryCompletionTime.toString().substring(0, 10);
    }
    return null;
  }
  //7,000원

}