import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/four_image.dart';
import 'package:hankkitoktok/const/style.dart';
import 'package:hankkitoktok/models/order/order.dart';
import 'package:intl/intl.dart';

import '../../const/color.dart';
import '../../models/meal_menu/ordered_meal_menu.dart';

enum OrderStatus { NOT_DELIVERED, DELIVERED }

class OrderHistoryDetailScreen extends StatelessWidget {
  final Order order;
  late final OrderStatus orderStatus;
  final formatter = NumberFormat('#,###');
  OrderHistoryDetailScreen({required this.order, super.key}) {
    orderStatus = order.orderStatus == '배송 완료'
        ? OrderStatus.DELIVERED
        : OrderStatus.NOT_DELIVERED;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: WHITE_COLOR,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (orderStatus == OrderStatus.NOT_DELIVERED)
                  ? _buildOrderInfo()
                  : _buildMealInfo(),
              const Divider(thickness: 4, color: GREY_COLOR_0),
              (orderStatus == OrderStatus.NOT_DELIVERED)
                  ? _buildRequestInfo()
                  : _buildDeliveryInfo(),
              const Divider(thickness: 4, color: GREY_COLOR_0),
              _buildOrderDetail(),
              const Divider(thickness: 4, color: GREY_COLOR_0),
              _buildPriceInfo(),
              const SizedBox(height: 128.0), //Todo: 수정
              (orderStatus == OrderStatus.NOT_DELIVERED)
                  ? _buildRemoveButton()
                  : const SizedBox(),
              const SizedBox(height: 32.0),
            ],
          ),
        )
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      surfaceTintColor: WHITE_COLOR,
      title: Text('상세내역', style: myPageAppBarTextStyle),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildOrderInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문 정보', style: blockTitleTextStyle2),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '주문번호: ', style: blockContentTextStyle),
                TextSpan(
                    text: order.orderID.toString(),
                    style: blockContentBoldTextStyle),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '구매일시: ', style: blockContentTextStyle),
                TextSpan(
                    text: order.orderDateString,
                    style: blockContentBoldTextStyle),
              ],
            ),
          ),
          Text('주문자: ${order.customerName}', style: blockContentTextStyle),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '휴대폰: ', style: blockContentTextStyle),
                TextSpan(
                    text: order.customerPhoneNumber,
                    style: blockContentBoldTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text("배송 상품", style: blockTitleTextStyle2),
          const SizedBox(height: 8.0),
          for (OrderedMealMenu meal in order.orderedMealMenuList)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: GREY_COLOR_4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildFourImage(meal.menuUrlList, 40, 40),
                      const SizedBox(width: 4.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(meal.getDeliveryTime() ?? "",
                              style: blockContentTextStyle),
                          Text(meal.name,
                              style: blockContentTextStyle2),
                          Text(meal.price.toString(),
                              style: blockContentBoldTextStyle2),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0)
              ],
            )
        ],
      ),
    );
  }

  Widget _buildRequestInfo() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('요청 사항', style: blockTitleTextStyle2),
            const SizedBox(height: 8.0),
            Text(order.requestMessage, style: blockContentTextStyle),
          ],
        ));
  }

  Widget _buildDeliveryInfo(){
    return Padding(
       padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('배송 정보', style: blockTitleTextStyle2
          ),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '주문번호: ', style: blockContentTextStyle),
                TextSpan(
                    text: order.orderID.toString(),
                    style: blockContentBoldTextStyle),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '배송주소: ', style: blockContentTextStyle),
                TextSpan(
                    text: '${order.orderAddress} ${order.orderDetailAddress}',
                    style: blockContentBoldTextStyle),
              ],
            ),
          ),
          Text('받는사람: ${order.customerName}', style: blockContentTextStyle),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '연락처: ', style: blockContentTextStyle),
                TextSpan(
                    text: order.customerPhoneNumber,
                    style: blockContentBoldTextStyle),
              ],
            ),
          ),
        ],
      ),
      );
  }

  Widget _buildOrderDetail(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문내역', style: blockTitleTextStyle2),
          const SizedBox(height: 8.0),
          Text('주문방식: ${order.orderType}', style: blockContentTextStyle),
          const SizedBox(height: 8.0),
          Text('요일: ${order.dayOfWeekInitial}', style: blockContentTextStyle),
          const SizedBox(height: 8.0),
          Text('시간', style: blockContentTextStyle),
            for (String orderTime in order.getOrderTimeList)
              Text(orderTime, style: blockContentTextStyle),
            const SizedBox(height: 8.0),
          Text('메뉴', style: blockContentTextStyle),
            for (List<dynamic> menu in order.combinedMenuList)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(menu[0], style: blockContentTextStyle),
                      Text("${formatter.format(menu[1])}원", style: blockContentBoldTextStyle),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(menu[2], style: blockContentTextStyle),
                  const SizedBox(height: 8.0),
                ],
              ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("총 횟수", style: blockContentPrimaryTextStyle),
              Text("${order.orderType == "일 결제" ? order.orderNumberDay : order.orderNumberWeek}회", style:blockContentPrimaryTextStyle),
            ],
          )
        ],
      )
    );
  } //Todo: 오류수정

  Widget _buildPriceInfo(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("결제 금액", style: blockTitleTextStyle),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("주문 금액", style: blockContentTextStyle2),
              Text("${formatter.format(order.menuPrice)}원", style: blockContentBoldTextStyle2),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("배달 금액", style: blockContentTextStyle2),
              Text("${formatter.format(order.deliveryPrice)}원", style: blockContentBoldTextStyle2),
            ],
          ),
          const SizedBox(height: 4.0),
          (order.washingService > 0) ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("풀결제 서비스 금액", style: blockContentTextStyle2),
              Text("${formatter.format(order.washingServicePrice)}원", style: blockContentBoldTextStyle2),
            ],
          ) : const SizedBox(),
          (order.washingService > 0) ? const SizedBox(height: 4.0) : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("최종 결제 금액", style: blockTitleTextStyle),
              Text("${formatter.format(order.totalPrice)}원", style: blockContentBoldTextStyle2),
            ],
          ),
        ],
      )
    );
  }

  Widget _buildRemoveButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: GREY_COLOR_5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text("구매내역 삭제", style: removeButtonTextStyle),
          )
        )
    );
  }
}
