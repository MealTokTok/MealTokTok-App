import 'package:hankkitoktok/models/base_model.dart';

class MealMenu extends BaseModel{
  String name;
  int price;
  List<String> menuList;
  List<String> menuUrlList;
  DateTime? createdAt;

  MealMenu(this.name, this.price, this.menuList, this.menuUrlList, {DateTime? createdAt})
      : this.createdAt = createdAt ?? DateTime.now();

  @override
  BaseModel fromMap(Map<String, dynamic> map) {
    return MealMenu(
      map['name'],
      map['price'],
      List<String>.from(map['menuList']),
      List<String>.from(map['menuUrlList']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'menuList': menuList,
      'menuUrlList': menuUrlList,
      'createdAt': createdAt?.toIso8601String() ?? '',
    };
  }
}
