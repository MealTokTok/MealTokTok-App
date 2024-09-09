import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';

enum TextType {
  TITLE_1,
  TITLE_2,
  TITLE_3,
  SUBTITLE_1,
  SUBTITLE_2,
  BODY_1,
  BODY_2,
  BUTTON,
  CAPTION,
  SMALL,
}

class TextStyles {
  static const TextStyle title1 = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w700, // bold
    fontSize: 28,
    height: 1.5, // line-height / font-size -> 42px / 28px
    letterSpacing: -0.015, // -0.015em
    color: Colors.black,
  );

  static const TextStyle title2 = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w700, // bold
    fontSize: 20,
    height: 1.5, // line-height / font-size -> 30px / 20px
    letterSpacing: -0.015, // -0.015em
    color: Colors.black,
  );

  static const TextStyle title3 = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w600, // semi-bold
    fontSize: 18,
    height: 1.5, // line-height / font-size -> 27px / 18px
    letterSpacing: -0.015, // -0.015em
    color: Colors.black,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w600, // semi-bold
    fontSize: 16,
    height: 1.3, // line-height / font-size -> 21px / 16px
    letterSpacing: -0.015, // -0.015em
    color: Colors.black,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w600, // semi-bold
    fontSize: 14,
    height: 1.5, // line-height / font-size -> 21px / 14px
    letterSpacing: -0.02, // -0.02em
    color: Colors.black,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w400, // regular
    fontSize: 16,
    height: 1.5, // line-height / font-size -> 24px / 16px
    letterSpacing: -0.02, // -0.02em
    color: Colors.black,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w400, // regular
    fontSize: 14,
    height: 1.5, // line-height / font-size -> 21px / 14px
    letterSpacing: -0.02, // -0.02em
    color: Colors.black,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w500, // medium
    fontSize: 14,
    height: 1.5, // line-height / font-size -> 21px / 14px
    letterSpacing: -0.02, // -0.02em
    color: Colors.black,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w500, // medium
    fontSize: 12,
    height: 1.5, // line-height / font-size -> 18px / 12px
    letterSpacing: -0.02, // -0.02em
    color: Colors.black,
  );

  static const TextStyle small = TextStyle(
    fontFamily: 'Pretendard Variable',
    fontWeight: FontWeight.w400, // medium
    fontSize: 12,
    height: 1.5, // line-height / font-size -> 18px / 12px
    letterSpacing: -0.02, // -0.02em
    color: Colors.black,
  );

  static TextStyle getTextStyle(TextType textType, Color color){
    switch (textType) {
      case TextType.TITLE_1:
        return title1.copyWith(color: color);
      case TextType.TITLE_2:
        return title2.copyWith(color: color);
      case TextType.TITLE_3:
        return title3.copyWith(color: color);
      case TextType.SUBTITLE_1:
        return subtitle1.copyWith(color: color);
      case TextType.SUBTITLE_2:
        return subtitle2.copyWith(color: color);
      case TextType.BODY_1:
        return body1.copyWith(color: color);
      case TextType.BODY_2:
        return body2.copyWith(color: color);
      case TextType.BUTTON:
        return button.copyWith(color: color);
      case TextType.CAPTION:
        return caption.copyWith(color: color);
      case TextType.SMALL:
        return small.copyWith(color: color);

      default:
        return body1.copyWith(color: color);
    }
  }

}

TextStyle noName = const TextStyle(
  color: PRIMARY_COLOR,
  fontFamily: 'Pretendard',
  fontWeight: FontWeight.w700, // Weight 700
  fontSize: 24,                // Size 24px
  height: 1.5,             // Line height 36px (must be relative to fontSize)
  letterSpacing: -0.48,        // Letter spacing -2% of fontSize
);

TextStyle badgeStyle = const TextStyle(
  fontSize: 8,
  fontWeight: FontWeight.w500,
  color: WHITE_COLOR,
);
