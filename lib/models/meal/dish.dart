import '../base_model.dart';

class Dish extends BaseModel{
  int dishId;
  String dishName;
  String imgUrl;

  Dish.init({
    this.dishId = 0,
    this.dishName = '',
    this.imgUrl = '',

});

  @override
  Dish fromMap(Map<String, dynamic> map) {
    return Dish.init(
      dishId: map['dishId'],
      dishName: map['dishName'],
      imgUrl: map['imgUrl'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'dishId': dishId
    };
  }

}