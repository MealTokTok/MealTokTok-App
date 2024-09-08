import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/address_card.dart';

import 'package:hankkitoktok/controller/user_controller.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:get/get.dart';

class ViewAddressScreen extends StatelessWidget {
  UserController userController = Get.find<UserController>();

  ViewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearchBox(),
              _buildAddressList(),
            ],
          ),
        )));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('주소 설정',
          style: TextStyles.getTextStyle(TextType.BODY_1, BLACK_COLOR_3)),
      surfaceTintColor: Colors.transparent,
      actions: [
        TextButton(
            onPressed: () {},
            child: Text("편집",
                style: TextStyles.getTextStyle(TextType.BUTTON, BLACK_COLOR_2)))
      ],
    );
  }

  Widget _buildSearchBox() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: GREY_COLOR_4, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset('assets/images/1_my_page/search.png',
                    width: 24, height: 24, color: GREY_COLOR_3),
                const SizedBox(width: 8),
                Text('건물명, 도로명, 또는 지번으로 검색',
                    style:
                        TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_3)),
              ],
            ),
          ),
        ));
  }

  Widget _buildAddressList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: userController.addresses.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GetBuilder<UserController>(
                builder: (controller) => AddressCard(
                    address: controller.addresses[index],
                    isSelected: controller.selectedAddressIndex == index)));
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 1, color: GREY_COLOR_4);
      },
    );
  }
}
