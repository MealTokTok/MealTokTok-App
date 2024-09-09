import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/order_detail.dart';
import 'package:hankkitoktok/component/price_info.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:hankkitoktok/functions/formatter.dart';
import 'package:hankkitoktok/models/order/order_data.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/3_view_address_screen.dart';
import '../../component/tile.dart';
import '../../controller/address_controller.dart';
import '../../models/enums.dart';
import '../../models/order/order_post.dart';

class PayAggrementScreen extends StatefulWidget {
  OrderPost orderPost;
  bool checkActivate = false;
  bool checkDisposable = false;
  bool checkAggrement = false;
  bool viewAll = false;

  PayAggrementScreen({required this.orderPost, super.key});

  @override
  State<PayAggrementScreen> createState() => _PayAggrementScreenState();
}

class _PayAggrementScreenState extends State<PayAggrementScreen> {
  late UserController userController;
  final TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    userController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrdererInfo(),
              _buildAddressInfo(),
              _buildSpecialInstructionInfo(),
              _buildOrderDetail(),
              buildPriceInfoByOrderPost(widget.orderPost),
              _buildAgreement(),
              _buildPayButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('장바구니',
          style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
  }

  Widget _buildOrdererInfo() {
    return GetBuilder(builder: (UserController userController) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('주문 내역',
                    style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.checkActivate = !widget.checkActivate;
                    });
                  },
                  icon: Image.asset(widget.checkActivate  == true
                      ? 'assets/images/3_menu_choice/arrow_down.png'
                      : 'assets/images/3_menu_choice/arrow_up.png', width: 24, height: 24),
                ),
              ],
            ),
            const SizedBox(height: 4),
            if (activate == true)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '이름: ',
                        style: TextStyles.getTextStyle(
                            TextType.BODY_2, GREY_COLOR_2)),
                    TextSpan(
                        text: userController.user!.username,
                        style: TextStyles.getTextStyle(
                            TextType.BUTTON, GREY_COLOR_2)),
                  ])),
                  const SizedBox(height: 8),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '전화번호: ',
                        style: TextStyles.getTextStyle(
                            TextType.BODY_2, GREY_COLOR_2)),
                    TextSpan(
                        text: userController.user!.phoneNumber,
                        style: TextStyles.getTextStyle(
                            TextType.BUTTON, GREY_COLOR_2)),
                  ])),
                  const SizedBox(height: 4),
                  Text("주문자 정보 변경 방법: 마이페이지 > 프로필 정보 변경",
                      style: TextStyles.getTextStyle(
                          TextType.CAPTION, SECONDARY_1)),
                ],
              )
            else
              Text(
                  '${userController.user!.username} ${userController.user!.phoneNumber}',
                  style:
                      TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
          ],
        ),
      );
    });
  }

  Widget _buildAddressInfo() {
    return GetBuilder(builder: (AddressController addressController) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('배송 주소',
                    style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(addressController.getSelectedAddress.getAddressString,
                    style:
                        TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                OutlinedButton(
                    onPressed: () {
                      //Todo: 주소 변경 페이지 푸쉬경
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAddressScreen())
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: GREY_COLOR_5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('변경',
                        style: TextStyles.getTextStyle(
                            TextType.BUTTON, GREY_COLOR_2)))
              ],
            )
          ]));
    });
  }

  Widget _buildSpecialInstructionInfo() {


    InputBorder _customBorder(double width, Color color) {
      return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          width: width,
          color: color,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("요청사항",
            style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR)),
        const SizedBox(height: 8),
        TextFormField(
          controller: editingController,
          style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR),
          cursorColor: BLACK_COLOR,
          decoration: InputDecoration(
            hintText: "예) 일회용 수저 2개 주세요!",
            hintMaxLines: 1,
            hintStyle: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_3),
            enabledBorder: _customBorder(1.6, GREY_COLOR_4),
            focusedBorder: _customBorder(1.6, GREY_COLOR_4),
          ),

        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  setState(() {
                    widget.checkDisposable = !widget.checkDisposable;
                  });
                },
                child: Image.asset(widget.checkDisposable == true
                    ? 'assets/images/3_menu_choice/checkbox_selected.png'
                    : 'assets/images/3_menu_choice/checkbox_unselected.png', width: 24, height: 24),),
            const SizedBox(width: 8),
            Text("일회용 수저,포크 안 주셔도 돼요",
                style: TextStyles.getTextStyle(TextType.CAPTION, GREY_COLOR_2)),
          ],
        )
      ]),
    );
  }

  Widget _buildOrderDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tile(title: '주문 상세'),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.viewAll = !widget.viewAll;
                });
              },
              icon: Image.asset(widget.viewAll == true
                  ? 'assets/images/3_menu_choice/arrow_down.png'
                  : 'assets/images/3_menu_choice/arrow_up.png', width: 24, height: 24),
            )
          ],
        ),
        if(widget.viewAll == false)
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(text:
            TextSpan(
                children: [
                  TextSpan(text: (widget.orderPost.orderType == OrderType.IMMEDIATE) ? "일 결제": "주간 결제", style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_2)),
                  TextSpan(text:'${widget.orderPost.orderedMeals.length}회', style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
                ]
            )
            )
          )
        else
          buildOrderDetailByOrderPost(widget.orderPost)
      ])
    );
  }

  Widget _buildAgreement() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("*[주문완료] 상태일 경우에만 주문 취소가 가능하며, 상품 미배송 시 결제하신 수단으로 환불 처리됩니다.",
              style: TextStyles.getTextStyle(TextType.CAPTION, SECONDARY_2)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("개인정보 수집 이용 및 처리",
                style: TextStyles.getTextStyle(TextType.SMALL, GREY_COLOR_6)),
            TextButton(
                onPressed: () {
                  // Todo: 개인정보 수집 이용 및 처리 페이지 푸쉬
                },
                child: Text("보기",
                    style: TextStyles.getTextStyle(
                        TextType.CAPTION, GREY_COLOR_6)))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("전자자금 결제대행 서비스 이용약관 동의",
                style: TextStyles.getTextStyle(TextType.SMALL, GREY_COLOR_6)),
            TextButton(
                onPressed: () {
                  // Todo: 전자자금 결제대행 서비스 이용약관 페이지 푸쉬
                },
                child: Text("보기",
                    style: TextStyles.getTextStyle(
                        TextType.CAPTION, GREY_COLOR_6)))
          ])
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('위 내용을 확인하였으며 결제에 동의합니다.',
                  style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.checkAggrement = !widget.checkAggrement;
                    });
                  },
                  icon: Image.asset(widget.checkAggrement == true
                      ? 'assets/images/3_menu_choice/checkbox_selected.png'
                      : 'assets/images/3_menu_choice/checkbox_unselected.png', width: 24, height: 24)),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if(widget.checkAggrement == true){
                widget.orderPost.specialInstruction = editingController.text;
                widget.orderPost.specialInstruction += widget.checkDisposable == true ? '(일회용품 o)' : '(일회용품 x)';
                //Todo: 결제 -> 결제완료 콜백 -> 주문완료 처리?
                debugPrint(widget.orderPost.toJson().toString());
                String id = await orderPost(widget.orderPost.toJson());
                //Todo: 주문완료 페이지로 이동(id 전달)
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: const Size(double.infinity, 48),
              backgroundColor:
              widget.checkAggrement == true ? PRIMARY_COLOR : GREY_COLOR_4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('${f.format(widget.orderPost.totalPrice)}원 결제하기',
                style: TextStyles.getTextStyle(TextType.BUTTON,
                    widget.checkAggrement == true ? WHITE_COLOR : GREY_COLOR_2)),
          )
        ]));
  }
}
