import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/four_image.dart';
import 'package:hankkitoktok/component/order_detail.dart';
import 'package:hankkitoktok/const/style.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';
import 'package:hankkitoktok/functions/httpRequest.dart';
import 'package:hankkitoktok/models/order/order.dart';
import 'package:intl/intl.dart';
import 'package:hankkitoktok/models/enums.dart';
import '../../component/price_info.dart';
import '../../const/color.dart';
import '../../const/style2.dart';
import '../../functions/formatter.dart';
import '../../models/meal/ordered_meal.dart';
import '../../models/order/order_user.dart';
import '../../models/user/user.dart';

class OrderHistoryDetailScreen extends StatefulWidget {
  final int orderId;

  final formatter = NumberFormat('#,###');

  OrderHistoryDetailScreen({required this.orderId, super.key});

  @override
  State<OrderHistoryDetailScreen> createState() =>
      _OrderHistoryDetailScreen1State();
}

class _OrderHistoryDetailScreen1State extends State<OrderHistoryDetailScreen> {

  late OrderState orderState;
  late Order order;
  late User user;
  void getOrderData() {
    setState(() {
      // order = await networkGetRequest(
      //     model, "/api/v1/orders/${widget.orderId}", null);
      order = Order.init();
      for(var item in orders){
        if(item.orderID == widget.orderId){
          order = item;
        }
      }
      orderState = order.orderState!;

    });
    int userId = order.userId;
    setState(() {
      user = exampleUser; //userId 가 userId인 유저
      //   user = await networkGetRequest(
      //       model, "/api/v1/user/$userId", null);
      // });
    });

  }

  @override
  void initState() {
    getOrderData();
    super.initState();
  }
  //Todo: 수정
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
              _buildOrderInfo(),
              const Divider(thickness: 4, color: GREY_COLOR_0),
              _buildRequestInfo(),
              const Divider(thickness: 4, color: GREY_COLOR_0),
              buildOrderDetailByOrder(order),
              const Divider(thickness: 4, color: GREY_COLOR_0),
              buildPriceInfoByOrder(order),
              const SizedBox(height: 128.0), //Todo: 수정
              _buildRemoveButton(),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: Text('상세내역', style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR_3)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildOrderInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문 정보', style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
          const SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '주문번호: ', style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                TextSpan(
                    text: order.orderID.toString(),
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '구매일시: ', style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
                TextSpan(
                    text: order.orderDateString,
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '주문자: ', style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
                TextSpan(
                    text: user.username,
                    style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '휴대폰: ', style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
                TextSpan(
                    text: user.phoneNumber,
                    style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
              ],
            ),
          ),
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
            Text('요청 사항', style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
            const SizedBox(height: 8.0),
            Text(order.specialInstruction, style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_3)),
          ],
        ));
  }




  //
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
              child: Text("구매내역 삭제", style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_2)),
            )));
  }
}
