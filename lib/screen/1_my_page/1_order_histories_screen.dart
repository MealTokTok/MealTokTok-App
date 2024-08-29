import 'package:flutter/material.dart';
import 'package:hankkitoktok/controller/tmpdata.dart';
import 'package:hankkitoktok/models/order/order.dart';
import 'package:hankkitoktok/models/meal/meal_delivery.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

import '../../component/delivery.dart';
import '../../component/payment.dart';
import '../../const/color.dart';
import '../../const/style2.dart';

import 'package:get/get.dart';

import '../../controller/list_view_scroll_controller.dart';

enum HistoryType { PAYMENT, DELIVERY }

class OrderHistoriesScreen extends StatefulWidget {
  const OrderHistoriesScreen({super.key});

  @override
  State<OrderHistoriesScreen> createState() => _OrderHistoriesScreenState();
}

class _OrderHistoriesScreenState extends State<OrderHistoriesScreen> {
  late final ListViewScrollController listViewScrollController;

  @override
  void initState() {
    // TODO: 네트워크 요청으로 결제내역 받기
    listViewScrollController = Get.put(ListViewScrollController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: _buildAppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Obx(() => DropdownButtonHideUnderline(
                          child: DropdownButton2(
                        customButton: Container(
                          padding: const EdgeInsets.fromLTRB(12, 4, 8, 4),
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: GREY_COLOR_4,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(listViewScrollController.dropdownValue.value,
                                  style: TextStyles.getTextStyle(
                                      TextType.BUTTON, GREY_COLOR_2)),
                              Image.asset(
                                  "assets/images/3_menu_choice/arrow_down.png",
                                  width: 24,
                                  height: 24,
                                  color: GREY_COLOR_2),
                            ],
                          ),
                        ),
                        items: listViewScrollController.dropdownValues
                            .map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value,
                                style: TextStyles.getTextStyle(
                                    TextType.BUTTON, BLACK_COLOR_2)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            listViewScrollController.dropdownValue.value =
                                value;
                          }
                        },
                      ))),
                  _buildListView()
                ],
              ),
            ),
          )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('주문 및 배송내역',
          style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR_3)),
      surfaceTintColor: Colors.transparent,
      bottom: TabBar(
        labelStyle: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_3),
        unselectedLabelStyle:
            TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_3),
        indicatorColor: PRIMARY_COLOR,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const <Widget>[
          Tab(
            text: '결제 내역',
          ),
          Tab(
            text: '배송 내역',
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Expanded(
          child: TabBarView(
            children: <Widget>[
              Obx(
                  () =>listViewScrollController.orderHistories.isNotEmpty ? ListView.separated(
                    controller:
                    listViewScrollController.orderScrollController.value,
                    itemCount: listViewScrollController.orderHistories.length,
                    itemBuilder: (context, index) {
                      return Payment(
                        order: listViewScrollController.orderHistories[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: GREY_COLOR_4,
                        thickness: 1,
                      );
                    },
                  ) : _buildEmptyListView(HistoryType.PAYMENT),
              ),
              Obx(
                  ()=>listViewScrollController.mealDeliveryHistories.isNotEmpty ? ListView.separated(
                    controller:
                    listViewScrollController.deliveryScrollController.value,
                    itemCount:
                    listViewScrollController.mealDeliveryHistories.length,
                    itemBuilder: (context, index) {
                      return Delivery(
                        mealDelivery: listViewScrollController
                            .mealDeliveryHistories[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: GREY_COLOR_4,
                        thickness: 1,
                      );
                    },
                  ) : _buildEmptyListView(HistoryType.DELIVERY),
              )
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildEmptyListView(HistoryType historyType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            historyType == HistoryType.PAYMENT ? '결제하신 내역이 없어요' : '배송중인 내역이 없어요.',
            style: TextStyles.getTextStyle(TextType.TITLE_3, GREY_COLOR_2),
          ),
          const SizedBox(height: 4),
          Image.asset(
            'assets/images/1_my_page/delivery_history_empty.png',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
