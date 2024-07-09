import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/style.dart';
//import 영단어 순


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    int helloWorld; // 변수명, 함수명
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: Colors.grey,
              child: Column(
                children: [
                  _buildTitle(),
                  _buildBottomButton(),
                ],
              )
          )
      ),
    );
  }




  Widget _buildTitle() {
    return const Center(
      child: Text('한끼톡톡'),
    );
  }
  Widget _buildBottomButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white
      ),
      onPressed: () {

      },
      child: const Text('카카오 로그인'),
    );
  }
}