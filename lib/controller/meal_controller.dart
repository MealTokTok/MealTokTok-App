import 'package:hankkitoktok/functions/httpRequest.dart';
import'package:hankkitoktok/models/meal/meal.dart';
import 'package:get/get.dart';
import 'tmpdata.dart';
class MealController extends GetxController {
  late List<Meal>_meals;
  List<Meal> get getMeals => _meals;

  @override
  void onInit() {
    // TODO: 네트워크요청 -> _meals에 데이터 추가
    setMeals();
    super.onInit();
  }

  void setMeals() async {
    //_meals = await networkGetListRequest(Meal.init(), "detail_url", {});
    _meals = mealMenuList;
    update();
  }

  Meal getMealByID(int mealId) {
    return _meals.firstWhere((meal) => meal.mealId == mealId);
  }

}

