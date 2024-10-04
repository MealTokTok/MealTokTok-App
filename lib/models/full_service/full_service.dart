import 'package:hankkitoktok/models/base_model.dart';

class DiningData extends BaseModel {
  int fullDiningId;
  int mealDeliveryId;
  String collectState;
  DateTime? collectedDateTime;

  DiningData.init({
    this.fullDiningId = 0,
    this.mealDeliveryId = 0,
    this.collectState = 'NOT_COLLECTED',
    this.collectedDateTime,
  });

  @override
  DiningData fromMap(Map<String, dynamic> map) {
    return DiningData.init(
      fullDiningId: map['fullDiningId'],
      mealDeliveryId: map['mealDeliveryId'],
      collectState: map['collectState'],
      collectedDateTime: map['collectedDateTime'] != null
          ? DateTime.parse(map['collectedDateTime'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'fullDiningId': fullDiningId,
      'mealDeliveryId': mealDeliveryId,
      'collectState': collectState,
      'collectedDateTime': collectedDateTime?.toString(),
    };
  }
}