// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'order_status.freezed.dart';
//
// @freezed
// sealed class Order with _$Order {
//   const factory Order.loading() = OrderLoading;
//   const factory Order.userInfoData([OrderUserInfoModel? model]) =
//   OrderUserInfoData;
//   const factory Order.sheet([OrderModel? model]) = OrderSheet;
//   const factory Order.id([OrderIdModel? model]) = OrderId;
//   // 주문성공
//   const factory Order.success() = OrderSuccess;
//   // 주문 실패
//   const factory Order.error([ErrorMapper? errorMapper]) = OrderError;
//   const factory Order.cancelSuccess() = OrderCancelSuccess;
// }