//     _paymentWidget = PaymentWidget(clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm", customerKey: "a1b2c3d4e5f67890");
import 'package:flutter/material.dart';
import 'package:hankkitoktok/controller/user_controller.dart';
import 'package:hankkitoktok/models/order/order_data.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../functions/httpRequest.dart';
import '../../models/order/order.dart';

class PayTest extends StatefulWidget {

   String orderId;
   int price;

   PayTest({
     required this.orderId,
     required this.price,
     super.key
   });

  @override
  State<PayTest> createState() => _PayTestState();
}

class _PayTestState extends State<PayTest> {
  final UserController _userController = Get.find();



  @override
  Widget build(BuildContext context) {

    return Center(
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child:
                  PaymentWidgetExamplePage(
                    orderId: widget.orderId,
                    price: widget.price,
                    userId: _userController.user.userId.toString(),
                  )
              );
            },
            barrierColor: Colors.grey.withOpacity(0.3),
            isScrollControlled: true,
          );
        },
        child: const Text("결제하기"),
      ),
    );
  }
}

class PaymentWidgetExamplePage extends StatefulWidget {

  String userId;
  String orderId;
  int price;

  PaymentWidgetExamplePage({
    required this.userId,
    required this.orderId,
    required this.price,
    super.key});

  @override
  State<PaymentWidgetExamplePage> createState() {
    return _PaymentWidgetExamplePageState();
  }
}

class _PaymentWidgetExamplePageState extends State<PaymentWidgetExamplePage> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;

  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm", customerKey: "userId_${widget.userId}");

    _paymentWidget
        .renderPaymentMethods(
        selector: 'methods',
        amount: Amount(value: widget.price, currency: Currency.KRW, country: "KR"))
        .then((control) {
      _paymentMethodWidgetControl = control;
    });

    _paymentWidget
        .renderAgreement(selector: 'agreement')
        .then((control) {
      _agreementWidgetControl = control;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
              Expanded(
                  child: ListView(children: [
                    PaymentMethodWidget(
                      paymentWidget: _paymentWidget,
                      selector: 'methods',
                    ),
                    AgreementWidget(paymentWidget: _paymentWidget, selector: 'agreement'),
                    ElevatedButton(
                        onPressed: () async {
                          final paymentResult = await _paymentWidget.requestPayment(
                              paymentInfo: PaymentInfo(orderId: "orderId_${widget.orderId}", orderName: '도시락 주문'));

                          if (paymentResult.success != null) {
                            // 결제 성공 처리
                            String paymentKey = paymentResult.success!.paymentKey;
                            String orderId = paymentResult.success!.orderId;
                            num amount = paymentResult.success!.amount;

                            debugPrint('결제 성공: $paymentKey, $orderId, $amount');

                            Map<String,dynamic> data = {
                              'paymentKey': paymentKey,
                              'orderId': orderId,
                              'amount': amount
                            };

                            bool res = await networkRequest('/api/v1/payments/success', RequestType.POST, data);
                            if(res) {
                              print("결제 성공 요청 성공");
                            } else {
                              print("결제 성공 요청 실패");
                            }
                          } else if (paymentResult.fail != null) {
                            // 결제 실패 처리
                            String errorCode = paymentResult.fail!.errorCode;
                            String errorMessage = paymentResult.fail!.errorMessage;
                            String orderId = paymentResult.fail!.orderId;

                            debugPrint('결제 실패: $errorCode, $errorMessage, $orderId');

                            Map<String,dynamic> data = {
                              'code': errorCode,
                              'message': errorMessage,
                              'orderId': orderId
                            };
                            bool res = await networkRequest('/api/v1/payments/fail', RequestType.POST, data);
                            if(res) {
                              print("결제 실패 요청 성공");
                            } else {
                              print("결제 실패 요청 실패");
                            }
                          }
                        },
                        child: const Text('결제하기')),
                    ElevatedButton(
                        onPressed: () async {
                          final selectedPaymentMethod = await _paymentMethodWidgetControl?.getSelectedPaymentMethod();
                          print('${selectedPaymentMethod?.method} ${selectedPaymentMethod?.easyPay?.provider ?? ''}');
                        },
                        child: const Text('선택한 결제수단 출력')),
                    ElevatedButton(
                        onPressed: () async {
                          final agreementStatus = await _agreementWidgetControl?.getAgreementStatus();
                          print('${agreementStatus?.agreedRequiredTerms}');
                        },
                        child: const Text('약관 동의 상태 출력')),

                  ]))
            ])));
  }
}

