import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';

//더 해야할 것: text style 통일, 지도 마커 수정, 주소 등록 후 페이지, 맵 누르면 위치 이동 버튼

TextStyle normalgrey14 = TextStyle(color: Color(0xff999999),fontSize: 16.0,fontWeight: FontWeight.normal,letterSpacing: -1.0);
TextStyle appBarMain = TextStyle(color: Colors.black,fontSize: 18.0, fontWeight: FontWeight.normal);
//연결할 변수들
String faddressName = '';
String fplaceName = '';
String fdetailedAddressName = '';
double flatitude = 0.0;
double flongitude = 0.0;
int distance = 300;//meter, 충북대 중앙으로부터 허용거리

class addressDocuments{
  String placeName = '';
  String detailedPlaceName = '';
  String addressName = '';
  double latitude = 0.0;
  double longitude = 0.0;
}

class DeliveryAddressSettingScreen extends StatefulWidget {
  @override
  _DeliveryAddressSettingScreenState createState() =>
      _DeliveryAddressSettingScreenState();
}

class _DeliveryAddressSettingScreenState
    extends State<DeliveryAddressSettingScreen> {
  final TextEditingController _controller = TextEditingController();
  List<addressDocuments?> _addresses = [];
  String? _error;

  Future<List<addressDocuments?>> searchAddresses(String query) async {
    final String apiKey = 'Rest api key';

    final response = await http.get(
      Uri.parse('https://dapi.kakao.com/v2/local/search/keyword.json?query=$query'),
      headers: {'Authorization': 'KakaoAK $apiKey'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<addressDocuments?> places = [];

      for (var document in data['documents']) {
        addressDocuments ad = addressDocuments();
        ad.addressName = document['address_name'];
        ad.placeName = document['place_name'];
        ad.latitude = double.parse(document['y']);
        ad.longitude = double.parse(document['x']);
        places.add(ad);
      }

      return places;
    } else {
      throw Exception('Failed to load places');
    }
  }

  void _selectAddress(addressDocuments address) async {
    fplaceName = address.placeName;
    faddressName = address.addressName;
    flatitude = address.latitude;
    flongitude = address.longitude;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressDetailPage(selectedAddress: address),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("배달 주소 설정",style:appBarMain),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("어디로 배달해드릴까요?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("현재 충북대학교 근처만 배달이 가능해요",style: normalgrey14,),
            SizedBox(height: 25),
            TextField(
              controller: _controller,
              cursorColor: Color(0xFF999999),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,color: Color(0xff999999)),
                hintText: "건물명, 도로명, 또는 지번으로 검색",
                hintStyle: TextStyle(
                  color: Color(0xFF999999),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: Color(0xFF999999),
                  ),
                ),
              ),
              onSubmitted: (value) async{
                _addresses = await searchAddresses(value);
                setState(() {});
              },
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(left: 16.0, right: 24.0),
              child: Divider(
                color: Colors.grey[400],
                thickness: 1,
              ),
            ),
            SizedBox(height: 15),
            if (_error != null)
              Text(
                _error!,
                style: TextStyle(color: Colors.red),
              ),
            if (_addresses.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _addresses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        padding: EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[400]!, width: 1),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (_addresses[index] != null) {
                              addressDocuments document = _addresses[index]!;
                              _selectAddress(document);
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide.none,
                            ),
                          ),
                          child: Text((_addresses[index]?.addressName ?? '') + '\n' +
                              (_addresses[index]?.placeName ?? ''),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (_addresses.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("도로명 + 건물번호"),
                    SizedBox(height: 3),
                    Text("예시) 서초로 38길 12"),
                    SizedBox(height: 15),
                    Text("지역명(동/리) + 번지"),
                    SizedBox(height: 3),
                    Text("예시) 서초로 1498-5"),
                    SizedBox(height: 15),
                    Text("지역명(동/리) + 건물명(아파트명)"),
                    SizedBox(height: 3),
                    Text("예시) 서초동 한끼톡톡빌딩"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AddressDetailPage extends StatefulWidget {
  final addressDocuments selectedAddress;
  AddressDetailPage({required this.selectedAddress});

  @override
  _AddressDetailPageState createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  final TextEditingController _detailController = TextEditingController();
  KakaoMapController? _controller;
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

  Future<addressDocuments?> revearseSearchAddresses(double latitude, double longitude) async {
    final String apiKey = 'Rest api key';

    final response = await http.get(
      Uri.parse('https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$longitude&y=$latitude'),
      headers: {'Authorization': 'KakaoAK $apiKey'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      addressDocuments? places;

      for (var document in data['documents']) {
        addressDocuments ad = addressDocuments();
        ad.addressName = document['address']['address_name'];
        ad.latitude = latitude;
        ad.longitude = longitude;
        places = ad;
      }

      return places;
    } else {
      throw Exception('Failed to load address');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    center: LatLng(flatitude, flongitude),
                    onMapCreated: ((controller) async {
                      _controller = controller;
                      Marker centerMarker = Marker(
                        markerId: 'centerMarker',
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
                        if (!serviceEnabled) {.
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
                        addressDocuments? adc = await revearseSearchAddresses(flatitude, flongitude);
                        if (adc != null) {
                          faddressName = adc.addressName;
                          fplaceName = adc.placeName;
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
            Text(widget.selectedAddress.addressName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5,),
            Text('[지번] ' + widget.selectedAddress.placeName,style: TextStyle(color: Color(0xFF999999)),),
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
