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
          // 모든 문제를 풀고 제출하는 로직을 여기에 작성
        },
        child: const Text('끝내기'),
      ),),
    );
  }
  void _null(){

  }

}
