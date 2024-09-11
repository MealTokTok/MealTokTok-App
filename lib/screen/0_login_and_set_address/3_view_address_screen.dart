import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/address_card.dart';

import 'package:hankkitoktok/controller/user_controller.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:get/get.dart';

import '../../controller/address_controller.dart';

class ViewAddressScreen extends StatefulWidget {
  const ViewAddressScreen({super.key});

  @override
  State<ViewAddressScreen> createState() => _ViewAddressScreenState();
}

class _ViewAddressScreenState extends State<ViewAddressScreen> {
  AddressController addressController = Get.find();
  bool isEdit = false;

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
            onPressed: () {
              setState(() {
                isEdit = !isEdit;
              });
            },
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
    return GetBuilder<AddressController>(
        builder: (controller) => Column(
              children: [
                AddressCardOn(
                  address: controller.selectedAddress,
                  isEdit: isEdit,
                ),
                const Divider(height: 1, color: GREY_COLOR_4),
                for (var address in controller.addresses)
                  if(address.visible)
                  Column(
                    children: [
                      AddressCardOff(
                        address: address,
                        isEdit: isEdit,
                      ),
                      const Divider(height: 1, color: GREY_COLOR_4),
                    ],
                  )
              ],
            ));
  }
}
