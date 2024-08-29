import 'package:flutter/material.dart';

import '../const/color.dart';
import '../const/style2.dart';

class Tile extends StatelessWidget {
  final String title;
  String ? subtitle;

  Tile({
    required this.title,
    this.subtitle,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.getTextStyle(TextType.TITLE_3, BLACK_COLOR_3)),
        subtitle != null ? const SizedBox(height: 10) : const SizedBox(),
        subtitle != null ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: SECONDARY_1_LIGHT,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text(subtitle!, style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY_1)))
            : const SizedBox()

      ],
    );
  }
}