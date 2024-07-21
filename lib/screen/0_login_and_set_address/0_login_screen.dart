import 'package:flutter/material.dart';

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
                  onTap: () {
                    print("버튼 클릭");
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
}
