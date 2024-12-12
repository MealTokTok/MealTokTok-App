
/// 서비스 지역을 나타내는 정보들이 있는 파일입니다.

import 'package:flutter/material.dart';
import 'package:hankkitoktok/const/color.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';


LatLng CENTER = LatLng(36.6298968, 127.4534557); // 서비스 중심구역 폴리곤 좌표
List<LatLng> SOUTH_KOREA = [
  LatLng(39.105648, 129.293848),
  LatLng(37.472782, 131.597259),
  LatLng(34.743466, 129.259321),
  LatLng(33.810255, 128.903499),
  LatLng(32.599185, 125.157071),
  LatLng(34.458362, 124.150105),
  LatLng(37.659740, 124.972107),
]; // 한국 전체 폴리곤 좌표


class ServiceArea { // 서비스구역 클래스

  final String polygonId; //폴리곤 ID
  final List<LatLng> path; // 폴리곤 좌표

  ServiceArea({required this.polygonId, required this.path});

  Polygon toPolygon() { // 서비스 구역 정보를 폴리곤으로 변환
    return Polygon(
      polygonId: polygonId,
      points: SOUTH_KOREA,
      holes: [path],
      fillOpacity: 0.5,
      fillColor: PRIMARY_COLOR,
    );
  }

}

ServiceArea SERVICE_AREA_1 = ServiceArea(
  polygonId: 'polygon_1',
  path: [
    LatLng(36.635400, 127.468905),
    LatLng(36.628714, 127.468642),
    LatLng(36.626179, 127.469368),
    LatLng(36.624042, 127.470657),
    LatLng(36.622447, 127.467225),
    LatLng(36.624128, 127.463895),
    LatLng(36.620503, 127.459343),
    LatLng(36.619876, 127.457968),
    LatLng(36.617622, 127.458544),
    LatLng(36.617091, 127.455674),
    LatLng(36.617172, 127.452608),
    LatLng(36.616825, 127.450613),
    LatLng(36.617298, 127.449688),
    LatLng(36.618122, 127.449068),
    LatLng(36.621127, 127.447459),
    LatLng(36.621977, 127.447122),
    LatLng(36.625881, 127.447140),
    LatLng(36.626639, 127.445898),
    LatLng(36.632120, 127.447588),
    LatLng(36.634085, 127.447462),
  ]
);
