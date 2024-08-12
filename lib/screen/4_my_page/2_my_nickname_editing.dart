import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:hankkitoktok/const/style.dart';

class MyNicknameEditing extends StatefulWidget {
  const MyNicknameEditing({super.key});

  @override
  State<MyNicknameEditing> createState() => _MyNicknameEditingState();
}

class _MyNicknameEditingState extends State<MyNicknameEditing> {

  final TextEditingController _nickname =
  TextEditingController();
  String textValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "닉네임",
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                Text("기존 닉네임", style: myPageRecordBlack16,),
                SizedBox(height: 8,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: GRAY1,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text("닉네임", style: myPageRecordBlack14,),
                ),
                SizedBox(height: 32,),
                Text("변경할 닉네임", style: myPageRecordBlack16),
                SizedBox(height: 8,),
                Row(children: [
                  Container(
                    width: 375,
                    //너비 자유롭게 되도록 설정해둬야 함
                    height:48,
                    child: TextFormField(
                      maxLength: 10,
                      controller: _nickname,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.start,
                      style: myPageRecordBlack14,
                      decoration: InputDecoration(
                        contentPadding:EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                        labelText: "닉네임을 입력해주세요.",
                        labelStyle: myPageRecordGray14500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: GRAY1,
                            width: 1.6,

                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: GRAY1,
                            width: 1.6,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: GRAY1,
                            width: 1.6,

                          ),
                        ),
                        counterText: "",
                        suffix: Text("(${textValue.length}/10)", style: myPageRecordGray2_14_400,),

                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      onChanged: (value) {
                        setState(() {
                          textValue = value;
                        });
                      },
                      validator: (value) {
                        //띄워쓰기 입력시 거절 추가
                        if (value == null || value.isEmpty) {
                          return '닉네임을 입력해주세요.';
                        }
                        if (int.tryParse(value) == null) {
                          return '숫자로 입력해줘';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8,),
                  ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GRAY1,
                      foregroundColor: GRAY4,
                      fixedSize: Size.fromHeight(48),
                      //minimumSize: Size(48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 12.0,
                        left: 12.0,
                        right: 12.0,
                      ),
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text("중복확인", style: myPageRecordGray414500,),),
                ],),

              ],),
        ),
        floatingActionButton: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 27),
            child:Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: GRAY2,
                  foregroundColor: Colors.white,
                  fixedSize: Size.fromHeight(48),
                  //minimumSize: Size(50, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  // padding: const EdgeInsets.only(
                  //   top: 12.0,
                  //   bottom: 12.0,
                  //   left: 12.0,
                  //   right: 12.0,
                  // ),
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                ),
                child: Text("변경하기", style: myPageRecordWhite14,),),
            ),

        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
