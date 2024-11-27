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
      dishId: map['dishId'] ?? 0,
      dishName: map['dishName'] ?? '',
      dishPrice: map['dishPrice']['amount'].toInt() ?? 0,
      imgUrl: map['imgUrl']?? '',
      dishQuantity: map['dishQuantity'] ?? 0,
      dishState: _getDishState(map['dishState']) ?? DishState.ON_SALE,
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
//
// class Dish extends BaseModel {
//   int dishId;
//   String dishName;
//   String imgUrl;
//   int dishPrice;
//   int dishQuantity;
//   String dishState;
//
//   Dish.init({
//     this.dishId = 0,
//     this.dishName = '',
//     this.imgUrl = '',
//     this.dishPrice = 0,
//     this.dishQuantity = 0,
//     this.dishState = 'ON_SALE',
//   });
//
//   @override
//   Dish fromMap(Map<String, dynamic> map) {
//     return Dish.init(
//       dishId: map['dishId'],
//       dishName: map['dishName'],
//       imgUrl: map['imgUrl'],
//       dishPrice: map['dishPrice']['amount'],
//       dishQuantity: map['dishQuantity'],
//       dishState: map['dishState'],
//     );
//   }
//
//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       'dishId': dishId,
//       'dishName': dishName,
//       'imgUrl': imgUrl,
//       'dishPrice': {
//         'amount': dishPrice,
//       },
//       'dishQuantity': dishQuantity,
//       'dishState': dishState,
//     };
//   }
// }