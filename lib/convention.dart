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

///////////////////////////////
// ### 커밋 규칙
//
// - `feat` : 기능 구현
// - `style` : 기능에 영향을 주지 않는 CSS 스타일링
// - `refactor` : 기능상 큰 변화는 없지만 성능 최적화, 추상화, 코드 수 감소 등을 진행했을 경우
// - `fix` : 에러 및 장애대응
// - `docs` : README 와 같은 문서 작업
// - `chore` : 기타 라이브러리/프레임워크 버전 업, 패키지 매니저 설정 변경, 등의 위 경우에 해당하지 않는 모든 작업