import 'package:flutter/material.dart';
import 'package:hankkitoktok/component/show_warning_dialog.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style2.dart';

class FullDinigsAlert extends StatefulWidget {
  const FullDinigsAlert({super.key});

  @override
  State<FullDinigsAlert> createState() => _FullDinigsAlertState();
}

class _FullDinigsAlertState extends State<FullDinigsAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: ElevatedButton(
        onPressed: () {
          showWarningDialog(context, '풀대접 서비스를\n받지 않으실 건가요?', '돌아가기를 누르시면 풀대접 서비스는\n장바구니에 담기지 않아요.', '돌아가기','그만두기',_null);
          // 모든 문제를 풀고 제출하는 로직을 여기에 작성
        },
        child: const Text('끝내기'),
      ),),
    );
  }
  void _null(){

  }

}
