import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:hankkitoktok/const/color.dart";
import "package:hankkitoktok/const/style.dart";

class MyPageHome extends StatefulWidget {
  const MyPageHome({super.key});

  @override
  State<MyPageHome> createState() => _MyPageHomeState();
}

class _MyPageHomeState extends State<MyPageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "닉네임닉네임닉네임 ",
                    style: TextStyle(
                      color: Color(0xFF131313),
                      fontSize: 18,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w600,
                      //height: 0.08,
                      letterSpacing: -0.36,
                    ),
                  ),
                  Text(
                    "님",
                    style: myPageDfault,
                  ),
                  SizedBox(width: 8,),
                  IconButton(
                      padding: EdgeInsets.zero, // 패딩 설정
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: GRAY4,
                        size: 18,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "주문 및 배송 내역",
                                  style: myPageDfault,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: GRAY0,
                                    foregroundColor: GRAY3,
                                    fixedSize: Size.fromHeight(28),
                                   //minimumSize: Size(65, 28),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0,right: 2.0, ),
                                    elevation: 0.0,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        "더보기",
                                        style: TextStyle(
                                          color: Color(0xFF999999),
                                          fontSize: 12,
                                          fontFamily: 'Pretendard Variable',
                                          fontWeight: FontWeight.w500,
                                          //height: 0.12,
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: myPageRecordGrayNum,
                                    ),
                                    Text(
                                      "결제완료",
                                      style: myPageRecordGrayText,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: GRAY2,
                                  size: 24,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: myPageRecordGrayNum,
                                    ),
                                    Text(
                                      "주문접수",
                                      style: myPageRecordGrayText,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: GRAY2,
                                  size: 24,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: myPageRecordGrayNum,
                                    ),
                                    Text(
                                      "배송중",
                                      style: myPageRecordGrayText,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: GRAY2,
                                  size: 24,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                        color: Colors.black
                                            ,
                                        fontSize: 18,
                                        fontFamily: 'Pretendard Variable',
                                        fontWeight: FontWeight.w600,
                                         letterSpacing: -0.36,
                                      ),
                                    ),
                                    Text(
                                      "배송완료",
                                      style: TextStyle(
                                        color: Colors.black
                                            ,
                                        fontSize: 12,
                                        fontFamily: 'Pretendard Variable',
                                        fontWeight: FontWeight.w500,
                                         letterSpacing: -0.24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: GRAY1,
                      ),
                      // Padding(
                      //   padding:
                      //   EdgeInsets.symmetric(vertical: 16),
                      //   child:
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text("배달 주소 관리"),
                      // ),),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "배달 주소 관리",
                          style: myPageDfault,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
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
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "약관 및 개인 정보 처리",
                            style: myPageDfault,
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
                          child: Text(
                            "설정",
                            style: myPageDfault,
                          ),
                        ),
                        Divider(
                          color: GRAY1,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Row(
                        //     children: [
                        //       Text("앱버전"),
                        //       Text("1234560"),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "앱버전",
                                style: myPageDfault,
                              ),
                              Text(
                                "1234560",
                                style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard Variable',
                                  fontWeight: FontWeight.w400,
                                  //height: 0.11,
                                  letterSpacing: -0.28,
                                ),
                              ),
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
    );
  }
}
