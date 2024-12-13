import "package:flutter/material.dart";
import "package:kakao_map_plugin/kakao_map_plugin.dart";

class WebviewTest extends StatefulWidget {
  const WebviewTest({super.key});

  @override
  State<WebviewTest> createState() => _WebviewTestState();
}

class _WebviewTestState extends State<WebviewTest> {


  Set<Marker> markers = {}; // 마커 변수
  late KakaoMapController mapController; // 지도 컨트롤러 변수

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      body: KakaoMap(
        onMapCreated: ((controller) async {
          mapController = controller;

          markers.add(Marker(
            markerId: UniqueKey().toString(),
            latLng: await mapController.getCenter(),
          ));

          setState(() { });
        }),
        markers: markers.toList(),
        center: LatLng(37.3608681, 126.9306506),
      ),
    );
  }
}
