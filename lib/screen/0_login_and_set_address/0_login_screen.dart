import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Color(0xFFFFF9F0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/splash.png',
                    width: 148,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 27),
                child:
                    // IconButton(
                    //   onPressed: (){},
                    //   icon: Image.asset(
                    //     'assets/images/kakao_login.png',
                    //     width: MediaQuery.of(context).size.width,
                    //     // fit: BoxFit.cover,
                    //   ),
                    // ),
                    InkWell(
                  onTap: () async {
                    await signInKaKao();
                  },
                  child: Image.asset(
                    'assets/images/kakao_login.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: Image.asset(
                //     'assets/images/kakao_login.png',
                //     fit: BoxFit.cover,
                //   ),
                // ),

                // child: SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   child: ElevatedButton.icon(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFFFFAA35),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8)),
                //     ),
                //     onPressed: () {
                //       // Respond to button press
                //     },
                //     icon: Image.asset(
                //       'assets/images/splash.png',
                //       width: 24.0,
                //       // fit: BoxFit.cover,
                //     ),
                //     label: const Text(
                //       "카카오로 시작하기",
                //       style: TextStyle(color: Colors.white, fontSize: 14),
                //     ),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInKaKao() async {
// 카카오 로그인 구현 예제

// 카카오톡 실행 가능 여부 확인
// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk().then((value){
          print("access token: ${value.accessToken}");
          print("expires_at: ${value.expiresAt}");
          print("refresh token: ${value.refreshToken}");
          print("refresh token expires at: ${value.refreshTokenExpiresAt}");
          print("scopes: ${value.scopes}");
          print("-------idToken-------");
          print("id_token: ${value.idToken}");
          print("---------------------");
          //여기에 페이지 이동 넣기
        });
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount().then((value){
            print('value from kakao $value');
            //여기에 이동 경로 넣기
          });
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
}
