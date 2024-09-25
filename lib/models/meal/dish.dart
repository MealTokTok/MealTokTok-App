import '../base_model.dart';

enum DishState {
  ON_SALE,
}

class Dish extends BaseModel{
  int dishId;
  String dishName;
  int dishPrice;
  String imgUrl;
  int dishQuantity;
  DishState? dishState;

  Dish.init({
    this.dishId = 0,
    this.dishName = '',
    this.dishPrice = 0,
    this.imgUrl = '',
    this.dishQuantity = 0,
    this.dishState = DishState.ON_SALE
});

  @override
  Dish fromMap(Map<String, dynamic> map) {
    return Dish.init(
      dishId: map['dishId'],
      dishName: map['dishName'],
      dishPrice: map['dishPrice']['amount'],
      imgUrl: map['imgUrl'],
      dishQuantity: map['dishQuantity'],
      dishState: _getDishState(map['dishState'])
    );
  }

  DishState? _getDishState(String? dishStateStr) {
    // Enum 변환에서 안전하게 처리, null 허용
    if (dishStateStr == null) return null;
    return DishState.values.firstWhere(
          (e) => e.toString().split('.').last == dishStateStr,
      orElse: () => DishState.ON_SALE,  // 기본값 설정
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'dishId': dishId,
      "dishName": dishName,
      "dishPrice": {
        "amount": dishPrice
      },
      "imgUrl": imgUrl,
      "dishQuantity": dishQuantity,
      "dishState": dishState.toString().split('.').last
    };
  }

}