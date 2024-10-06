import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/show_warning_dialog.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/controller/address_controller.dart';
import 'package:hankkitoktok/models/address/address.dart';

class AddressCardOff extends StatelessWidget {
  Address address;
  AddressController addressController;
  bool isEdit;

  AddressCardOff({
    required this.address,
    required this.addressController,
    required this.isEdit,
    super.key
  });

  void deleteAddress(){
    addressController.deleteAddress(address.deliveryAddressId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap:()async{
          await addressController.setConfiguredAddress(address.deliveryAddressId);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/1_my_page/address_card_off.png'),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.address, style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
                const SizedBox(height: 8),
                Text(address.getAddressString, style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
                if(isEdit)
                  const SizedBox(height: 8),
                if(isEdit)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: GREY_COLOR_4, width: 1),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text("수정", style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: (){
                          showWarningDialog(context, address.address, "주소를 삭제할까요?", "닫기", "주소삭제",null,deleteAddress);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: GREY_COLOR_4, width: 1),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text("삭제", style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_2)),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ],
        )
      )
    );
  }
}

class AddressCardOn extends StatelessWidget {
  Address address;
  bool isEdit;

  AddressCardOn({
    required this.address,
    required this.isEdit,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/1_my_page/address_card_on.png'),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: SECONDARY_1_LIGHT,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text("현재 설정된 주소", style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_1))),
                const SizedBox(height: 8),
                Text(address.address, style: TextStyles.getTextStyle(TextType.SUBTITLE_1, BLACK_COLOR_2)),
                const SizedBox(height: 8),
                Text(address.getAddressString, style: TextStyles.getTextStyle(TextType.BODY_2, BLACK_COLOR_2)),
                if(isEdit)
                  const SizedBox(height: 8),
                if(isEdit)
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: GREY_COLOR_4, width: 1),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text("수정", style: TextStyles.getTextStyle(TextType.BUTTON, GREY_COLOR_2)),
                    ),
                  ),
              ],
            ),
          ],
        )
    );
  }
}
