import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/models/address/address.dart';

class AddressCard extends StatelessWidget {
  Address address;
  bool isSelected = false;

  AddressCard({
    required this.address,
    required this.isSelected,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap:(){

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/1_my_page/address_card${isSelected ? 'on' : 'off'}.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(isSelected)
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
              ],
            ),
          ],
        )
      )
    );
  }
}
