import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hankkitoktok/models/address/address.dart';
import 'package:hankkitoktok/screen/0_login_and_set_address/1_address_setting.dart';
import 'package:hankkitoktok/secrets.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';

double chungbukLatitude = 36.6298968;
double chungbukLongitude = 127.4534557;

class KakaoMapComponent extends StatefulWidget {
  Address1 address;
  KakaoMapComponent({required this.address});

  @override
  _KakaoMapComponentState createState() => _KakaoMapComponentState();
}

class _KakaoMapComponentState extends State<KakaoMapComponent> {
  final TextEditingController _detailController = TextEditingController();
  List<Marker> fmarkers = [];
  bool isProperDistance = true;
  bool isWithinDistance(double x, double y, int n) {
    const double earthRadius = 6371000;
    double radX = x * pi / 180;
    double radY = y * pi / 180;
    double radCbnuLat = 36.6283 * pi / 180;
    double radCbnuLon = 127.4561 * pi / 180;
    double dLat = radX - radCbnuLat;
    double dLon = radY - radCbnuLon;

    double a = pow(sin(dLat / 2), 2) +
        cos(radCbnuLat) * cos(radX) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;
    return distance <= n;
  }

  Future<Address1> revearseSearchAddresses(double latitude, double longitude) async {
    final String apiKey = KAKAO_REST_API_KEY; //태영님은 rest api라고 하셨었음

    final response = await http.get(
      Uri.parse('https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$longitude&y=$latitude'),
      headers: {'Authorization': 'KakaoAK $apiKey'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Address1 address = Address1.init();

      for (var document in data['documents']) {

        address = Address1.init(
          detailAddress: document['address']['address_name'],
          latitude: latitude,
          longitude: longitude,
        );
      }

      return address;
    } else {
      throw Exception('Failed to load address');
    }
  }

  @override
  Widget build(BuildContext context) {

    KakaoMapController _controller;
    debugPrint('flat: ${flatitude}');
    debugPrint('flon: ${flongitude}');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Text("주소 상세 정보 입력",style: appBarMain),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 245,
                  child: KakaoMap(
                    //apiKey: KAKAO_JAVASCRIPT_KEY,
                    center: LatLng(chungbukLatitude, chungbukLongitude),

                    onMapCreated: ((controller) async {
                      _controller = controller;
                      Marker centerMarker = Marker(
                        markerId: 'centerMarker',
                        //latLng: LatLng(36.6298968, 127.4534557),
                        latLng: LatLng(flatitude, flongitude),
                        //markerImageSrc: 'images/marker_image.png', // markerImage로 추가해야 되는데 왠지 모르게 안됨.
                      );
                      setState(() {
                        fmarkers.add(centerMarker);
                      });
                    }),
                    markers: fmarkers,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: FloatingActionButton(
                      elevation: 0,
                      shape: CircleBorder(),
                      onPressed: () async {
                        bool serviceEnabled;
                        LocationPermission permission;
                        serviceEnabled = await Geolocator.isLocationServiceEnabled();
                        if (!serviceEnabled) {
                          return Future.error('Location services are disabled.');
                        }
                        permission = await Geolocator.checkPermission();
                        if (permission == LocationPermission.denied) {
                          permission = await Geolocator.requestPermission();
                          if (permission == LocationPermission.denied) {
                            return Future.error('Location permissions are denied');
                          }
                        }

                        if (permission == LocationPermission.deniedForever) {
                          return Future.error('Location permissions are permanently denied, we cannot request permissions.');
                        }

                        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                        flatitude = position.latitude; flongitude = position.longitude;
                        Address1 adc = await revearseSearchAddresses(flatitude, flongitude);
                        if (adc != null) {
                          faddressName = adc.address;
                          //fplaceName = adc.placeName;
                        }
                      },
                      backgroundColor: Colors.white,
                      child: Icon(Icons.my_location, color: Color(0xff999999)),//아이콘이 다름. 수정 필요
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(widget.address.detailAddress,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5,),
            Text('[지번] ' + widget.address.address,style: TextStyle(color: Color(0xFF999999)),),
            SizedBox(height: 20),
            TextField(
              controller: _detailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,color: Color(0xff999999)),
                hintText: "  상세 주소 입력",
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: isWithinDistance(flatitude, flongitude, distance)? Color(0xFF999999):Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: isWithinDistance(flatitude, flongitude, distance)? Color(0xFF999999):Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: isWithinDistance(flatitude, flongitude, distance)? Color(0xFF999999):Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                if (!isWithinDistance(flatitude, flongitude, distance))
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 15,
                  ),
                SizedBox(width: 8),
                Text(
                  isWithinDistance(flatitude, flongitude, distance)
                      ? '배달이 가능한 지역이에요. 이곳으로 배달해드릴까요?'
                      : '배달이 불가능한 지역이에요. 다시 설정해주세요.',
                  style: TextStyle(
                    color: isWithinDistance(flatitude, flongitude, distance)
                        ? Colors.orange
                        : Colors.red,
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (isWithinDistance(flatitude, flongitude, distance)) {
                  setState(() {
                    fdetailedAddressName = _detailController.text;
                  });
                  //////////////////다음 페이지로 넘어가는 코드 필요
                }
              },
              child: Center(child: Text("주소 등록",style: TextStyle(color: Colors.white),)),
              style: ElevatedButton.styleFrom(
                backgroundColor: isWithinDistance(flatitude, flongitude, distance)? Colors.orange:Color(0xFFD5D5D5),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

