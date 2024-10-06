import 'package:hankkitoktok/functions/httpRequest.dart';
import'package:hankkitoktok/models/meal/meal.dart';
import 'package:get/get.dart';
import 'tmpdata.dart';

// 자신의 메뉴의 상태 관리를 하는 컨트롤러

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
    _meals = await networkGetListRequest(Meal.init(), 'api/v1/meals', null);
    update();
  }

  Meal getMealByID(int mealId) {
    return _meals.firstWhere((meal) => meal.mealId == mealId);
  }

  Future<void> deleteMeal(int mealId) async {
    var data = {
      'mealId': mealId
    };
    await networkRequest('api/v1/meals', RequestType.DELETE, data);
    setMeals();
  }

  Future<void> addMeal(String mealName, int mealPrice, List<String> dishIds)async{
    var data = {
      'mealName': mealName,
      'mealPrice': mealPrice,
      'dishIds': dishIds
    };
    await networkRequest('api/v1/meals', RequestType.POST, data);
    setMeals();
  }

}

