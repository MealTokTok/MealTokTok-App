
import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/style2.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/1_address_setting.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:flutter/rendering.dart';
import 'package:hankkitoktok/service/service_area.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../const/color.dart';


class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  List<Polygon> polygons = [];

  late KakaoMapController mapController;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text("주소 상세 정보 입력", style: appBarMain),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 325,
              child: KakaoMap(
                  center: CENTER,
                  currentLevel: 6,
                  onMapCreated: ((controller) async {
                    mapController = controller;
                    polygons.add(SERVICE_AREA_1.toPolygon());

                    setState(() {});
                  }),
                  polygons: polygons
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("주소를 선택해주세요", style: TextStyles.getTextStyle(TextType.SUBTITLE_2, BLACK_COLOR)),
                  Text("[지번] 충북대학교", style: TextStyles.getTextStyle(TextType.BODY_2, GREY_COLOR_3)),
                  const SizedBox(height: 12),

                ],
              )
            )
          ]),
        ));
  }
}
