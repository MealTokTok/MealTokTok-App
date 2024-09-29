import 'package:hankkitoktok/models/base_model.dart';

class DishCategory extends BaseModel {
  int categoryId;  // categoryId 필드
  String categoryName;  // categoryName 필드

  DishCategory.init({
    this.categoryId = 0,
    this.categoryName = '',
  });

  @override
  DishCategory fromMap(Map<String, dynamic> map) {
    return DishCategory.init(
      categoryId: map['categoryId'],
      categoryName: map['categoryName'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }
}
