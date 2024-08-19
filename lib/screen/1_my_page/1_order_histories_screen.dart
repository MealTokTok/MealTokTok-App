// import 'package:flutter/material.dart';
// import 'package:hankkitoktok/const/color.dart';
// import 'package:hankkitoktok/controller/tmpdata.dart';
// import 'package:hankkitoktok/functions/httpRequest.dart';
// import 'package:hankkitoktok/models/order/order_mini.dart';
//
// import '../../models/order/order.dart';
// import '2_order_history_detail_screen.dart';
// import 'package:hankkitoktok/models/enums.dart';
//
// class OrderHistoriesScreen extends StatefulWidget {
//   const OrderHistoriesScreen({super.key});
//
//   @override
//   State<OrderHistoriesScreen> createState() => _OrderHistoryScreenState();
// }
//
// class _OrderHistoryScreenState extends State<OrderHistoriesScreen> {
//   String dropdownValue = '전체보기';
//   late List<OrderMini> orderList;
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//   void initializeOrderList() async {
//     OrderMini orderMini = OrderMini.init(orderTime: DateTime.now());
//     orderList = await networkGetListRequest<OrderMini>(orderMini, 'order/getOrderList', null);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: _buildAppBar(),
//         body: Column(
//           children: [
//             Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 alignment: Alignment.bottomRight,
//                 height: 44,
//                 child: DropdownButton(
//                   value: dropdownValue,
//                   items: const [
//                     DropdownMenuItem(
//                       child: Text('전체보기'),
//                       value: '전체보기',
//                     ),
//                     DropdownMenuItem(
//                       child: Text('상세보기'),
//                       value: '상세보기',
//                     ),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       dropdownValue = value.toString();
//                     });
//                   },
//                 )),
//             Expanded(
//               child: ListView.separated(
//                 itemCount: orderList.length,
//                 itemBuilder: (context, index) {
//                   return OrderTile(
//                     order: orderList[index],
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) {
//                   return const Divider();
//                 },
//               ),
//             ),
//           ],
//         ));
//   }
// }
//
// AppBar _buildAppBar() {
//   return AppBar(
//     title: const Text('주문 및 배송내역'),
//     centerTitle: true,
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//   );
// }
//
// class OrderTile extends StatelessWidget {
//   final OrderMini order;
//   late final String orderString;
//
//   OrderTile({required this.order}) {
//     orderString = _getOrderString();
//   }
//
//   String _getOrderString() {
//     //return '${order.orderType} - ${(order.orderType == '주간 결제') ?order.orderNumberWeek : order.orderNumberDay}${(order.orderType == '주간 결제') ? '일 구독' : '회'}: ${order.menuPrice}원';
//     return "내용 1";
//   }
//
//   String _getDeliveryString() {
//     return '배달비: ${order.deliveryPrice}원';
//   }
//
//   String _getWashingServiceString() {
//     //return '풀대접 서비스 ${order.washingService}회: ${order.washingServicePrice}원';
//     return "내용 2";
//   }
//
//   //yyyy.mm.dd
//   String _getDateString(DateTime date) {
//     return date.toString().substring(0, 10);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//               decoration: BoxDecoration(
//                 color: order.orderState == OrderState.DELIVERED
//                     ? Colors.green
//                     : PRIMARY_COLOR,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Text(
//                 order.orderState == OrderState.DELIVERED
//                     ? '배송완료'
//                     : '배송중',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             Row(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 8.0),
//                     Text(_getDateString(order.orderTime),
//                         style: const TextStyle(color: BLACK_COLOR)),
//                     const SizedBox(height: 8.0),
//                   ],
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                     onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => OrderHistoryDetailScreen(
//                                   orderId: order.orderId,
//                                 )));
//                     },
//                     child: SizedBox(
//                         height: 28,
//                         child: Center(
//                             child: Row(
//                               children: [
//
//                                 const Text(
//                                   '상세보기',
//                                   style: TextStyle(color: GREY_COLOR_3, fontSize: 12),
//                                 ),
//                                 Image.asset(
//                                   'assets/images/1_my_page/arrow_right.png',
//                                   width: 24,
//                                   height: 24,
//                                   color: GREY_COLOR_3,
//                                 ),
//
//                               ],
//                             )
//                         )
//                     )
//                 ),
//               ],
//             ),
//
//             Text(_getOrderString(),
//                 style: const TextStyle(color: BLACK_COLOR)),
//             const SizedBox(height: 8.0),
//             Text(_getDeliveryString(),
//                 style: const TextStyle(color: BLACK_COLOR)),
//             const SizedBox(height: 8.0),
//             // (order.washingService > 0)
//             //     ? Text(_getWashingServiceString(),
//             //         style: const TextStyle(color: BLACK_COLOR))
//             //     : const SizedBox(),
//           ],
//         ));
//   }
// }
