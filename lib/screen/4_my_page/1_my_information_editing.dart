import "package:flutter/material.dart";
import "package:hankkitoktok/component/show_warning_dialog.dart";
import "package:hankkitoktok/const/color.dart";
import "package:hankkitoktok/const/style.dart";
import "package:hankkitoktok/const/style2.dart";
import "package:hankkitoktok/convention.dart";
import "package:hankkitoktok/models/user/user.dart";
import "package:hankkitoktok/models/user/user_data.dart";
import "package:hankkitoktok/screen/4_my_page/2_my_nickname_editing.dart";
import "package:hankkitoktok/screen/4_my_page/3_delete_id.dart";

class MyInformationEditng extends StatefulWidget {

  final User? user;

  const MyInformationEditng({required this.user, super.key});

  @override
  State<MyInformationEditng> createState() => _MyInformationEditngState();
}

class _MyInformationEditngState extends State<MyInformationEditng> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "내정보 수정",
          style: myPageDfault,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 17,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: GRAY1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("약관 및 개인 정보 처리"),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "닉네임",
                            style: TextStyles.getTextStyle(TextType.BODY_2, GRAY4),
                          ),
                        ),
                        Divider(
                          color: GRAY1,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("설정"),
                        // ),

                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyNicknameEditing(user: widget.user,),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${widget.user!.nickname}",
                                    style: myPageRecordBlack16,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: GRAY4,
                                    size: 18,
                                  )
                                ],
                              ),
                            )),
                      ]),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: GRAY1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("약관 및 개인 정보 처리"),
                        // ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(
                                "대표 이메일",
                                style: myPageRecordGray14,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                'assets/images/kakao_mini.png',
                                height: 24,
                                // fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: GRAY1,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("설정"),
                        // ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.user!.email}",
                                style: myPageRecordBlack16,
                              ),
                              //디자인 변경 대비
                              // IconButton(
                              //     padding: EdgeInsets.zero, // 패딩 설정
                              //     constraints: BoxConstraints(),
                              //     onPressed: () {},
                              //     icon: const Icon(
                              //       Icons.arrow_forward_ios,
                              //       color: GRAY4,
                              //       size: 18,
                              //     )),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: GRAY1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("약관 및 개인 정보 처리"),
                        // ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Text(
                                  "휴대폰 번호",
                                  style: myPageRecordGray14,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GRAY0,
                                    foregroundColor: GRAY3,
                                    fixedSize: Size.fromHeight(28),
                                    //minimumSize: Size(65, 28),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      left: 8.0,
                                      right: 8.0,
                                    ),
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "2023. 06. 12 인증됨",
                                    style: TextStyle(
                                      color: GRAY3,
                                      fontSize: 12,
                                      fontFamily: 'Pretendard Variable',
                                      fontWeight: FontWeight.w500,
                                      //height: 0.12,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Divider(
                          color: GRAY1,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text("설정"),
                        // ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.user!.phoneNumber}",
                                style: myPageRecordBlack16,
                              ),
                              //디자인 수정 대비
                              // IconButton(
                              //     padding: EdgeInsets.zero, // 패딩 설정
                              //     constraints: BoxConstraints(),
                              //     onPressed: () {},
                              //     icon: const Icon(
                              //       Icons.arrow_forward_ios,
                              //       color: GRAY4,
                              //       size: 18,
                              //     )),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 19),
        child: Container(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                  //constraints: BoxConstraints(),
                  onPressed: () {
                    showWarningDialog(context, '로그아웃 하실 건가요?', '다시 로그인하시면 \'한끼톡톡\'서비스를\n이어서 이용하실 수 있습니다.', '돌아가기','로그아웃',null,_Logout);
                  },
                  child:  Text("로그아웃", style: TextStyles.getTextStyle(TextType.BUTTON, GRAY3)),),

              SizedBox(
                width: 8,
              ),
              Text('|', style: myPageRecordGray14500),
              SizedBox(
                width: 8,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                //constraints: BoxConstraints(),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteID()),);
                },
                child:  Text("회원탈퇴", style: TextStyles.getTextStyle(TextType.BUTTON, SECONDARY)),),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  void _Logout()  {
    _handleLogoutServiceUser();
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }


  void _handleLogoutServiceUser() async {
    bool tmp = await logout();
  }

}
