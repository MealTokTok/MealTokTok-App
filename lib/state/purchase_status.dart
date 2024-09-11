// import 'package:freezed_annotation/freezed_annotation.dart';
//
// part 'purchase_status.freezed.dart';
//
// @freezed
// sealed class Purchase with _$Purchase {
//   const factory Purchase.loading() = PurchaseLoading;
//   // 클라이언트 토스페이먼츠 엑세스 관련 - 인증성공
//   const factory Purchase.tossClientSuccess() = PurchaseTossClientSuccess;
//   // 클라이언트 토스페이먼츠 엑세스 관련 - 인증실패
//   const factory Purchase.tossClientError([ErrorMapper? errorMapper]) =
//   PurchaseTossClientError;
//   // 서버 토스페이먼츠 엑세스 관련 - 토크 플라이언트 에러
//   const factory Purchase.tossAppServerSuccess([ServerSuccessPayModel? model]) =
//   PurchaseTossAppServerSuccess;
//   // 서버 토스페이먼츠 엑세스 관련 - 승인성공
//   const factory Purchase.tossAppServerError([ErrorMapper? errorMapper]) =
//   PurchaseTossAppServerError;
//   // 주문요청 - 성공
//   const factory Purchase.orderSuccess([ServerSuccessPayModel? model]) =
//   PurchaseOrderSuccess;
//   // 주문실패 - 실패
//   const factory Purchase.orderError([ErrorMapper? errorMapper]) =
//   PurchaseOrderError;
// }