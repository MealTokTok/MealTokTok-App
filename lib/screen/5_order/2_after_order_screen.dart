import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/models/order/order_data.dart';

import '../../component/order_detail.dart';
import '../../const/style2.dart';
import '../../models/enums.dart';
import '../../models/order/order.dart';
import '../2_home/1_home_screen.dart';

class AfterOrderScreen extends StatelessWidget {
  String orderId;
  AfterOrderScreen({
    required this.orderId,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    print("orderId: $orderId");
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAfterOrderCard(),
                  OrderCards(orderId: orderId),
                  const SizedBox(height: 40),
                  _buildHomeButton(context),
                ]
            ),
          )
      )
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("주문 완료", style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR_2)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Image.asset("assets/images/3_menu_choice/close.png"),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen()
                    //Todo: HomeScreen status 변경
              ), (route)=>false
            );
          },
        )
      ],
    );
  }

  Widget _buildAfterOrderCard(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("주문이 완료되었어요 :)", style: TextStyles.getTextStyle(TextType.TITLE_2, BLACK_COLOR)),
            const SizedBox(height: 8),
            Text("맛있게 준비해 배송해드릴게요!", style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR)),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/3_menu_choice/after_order.png"),
            )
          ],
        )
    );
  }

  Widget _buildHomeButton(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ElevatedButton(
          onPressed: () {
            //TODO: 풀대접 서비스 페이지 보기
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen()
                )
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(0, 48),
            backgroundColor: PRIMARY_COLOR,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(8),
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                  child: Text('테스트',
                      style:
                      TextStyles.getTextStyle(
                          TextType.BUTTON,
                          WHITE_COLOR)))))
    );
  }

}

class OrderCards extends StatefulWidget {
  String orderId;
   OrderCards({
     required this.orderId,
     super.key
  });

  @override
  State<OrderCards> createState() => _OrderCardsState();
}

class _OrderCardsState extends State<OrderCards> {

  Order order = Order.init();
  bool showOrderDetail = false;
  @override
  initState() {
    getOrder();
    super.initState();
  }

  void getOrder() async {
    order = await networkGetOrder(widget.orderId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: GREY_COLOR_1, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("주문번호", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
                Text("${order.orderID}", style: TextStyles.getTextStyle(TextType.SUBTITLE_2, PRIMARY_COLOR)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: GREY_COLOR_1, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("배달 주소", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
                const SizedBox(height: 8),
                Text("임시 배달주소", style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: GREY_COLOR_1, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("주문내역", style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
                    IconButton(
                        onPressed: (){
                          setState(() {
                            showOrderDetail = !showOrderDetail;
                          });
                        },
                        icon: Image.asset("assets/images/3_menu_choice/${showOrderDetail ? "arrow_up" : "arrow_down"}.png", width: 24, height: 24)
                    )
                  ],
                ),
                const SizedBox(height: 8),
                (showOrderDetail == false) ?
                Text("${order.orderType == OrderType.IMMEDIATE ? '일 결제' : '주간결제'} - ${order.totalMealDeliveryCount}회", style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2))
                    : buildAfterOrderDetailByOrder(order),
              ],
            ),
          ),
        ],
      )
    );
  }
}
