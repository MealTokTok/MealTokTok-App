import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';


void showWarningDialog(BuildContext context, String title, String content, String leftbutton, String rightbutton, Function? leftButtonFunction, Function? rightButtonFunction) {

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0), // 둥근 모서리
        ),
        contentPadding: EdgeInsets.all(20.0), // 내부 여백
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${title}',
              //'풀대접 서비스를\n받지 않으실건가요?',
              style: TextStyles.getTextStyle(TextType.TITLE_2,Colors.black),
            ),

            Text(
              '${content}',
              //'돌아가기를 누르시면 풀대접 서비스는\n장바구니에 담기지 않아요.',
              style: TextStyles.getTextStyle(TextType.BODY_2,GRAY4),
            ),
            // SizedBox(height: 20),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if(leftButtonFunction != null) leftButtonFunction();
            },
            child: Text(
              '${leftbutton}',
              //'돌아가기',
              style: TextStyles.getTextStyle(TextType.BUTTON,GRAY4),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(12),
              backgroundColor: GRAY1, // 배경색
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
              ),
              minimumSize: Size(124, 48),
            ),
          ),
          TextButton(
            onPressed: () {
              rightButtonFunction();
              Navigator.of(context).pop();
              if(rightButtonFunction != null) rightButtonFunction();
            },
            child: Text(
              '${rightbutton}',
              //'그만두기',
              style: TextStyles.getTextStyle(TextType.BUTTON,Colors.white),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(12),
              backgroundColor: PRIMARY_COLOR, // 주황색 배경
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
              ),
              minimumSize: Size(124, 48),
            ),
          ),
        ],
      );
    },
  );
}