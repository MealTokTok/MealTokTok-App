import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_status.freezed.dart';

@freezed
class HomeScreenStatus with _$HomeScreenStatus {
  const factory HomeScreenStatus.menuEmpty() = MenuEmpty;
  const factory HomeScreenStatus.menuSelected() = MenuSelected;
  const factory HomeScreenStatus.onDelivery(Time timeStatus) = OnDelivery;
  const factory HomeScreenStatus.afterDelivery(Time timeStatus) = AfterDelivery;
  const factory HomeScreenStatus.addressEmpty() = AddressEmpty;
}

enum Time {
  AFTERNOON,
  EVENING,
}