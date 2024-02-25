import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/emergency_2_senior.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/screen/profile_senior.dart';
import 'package:knockknock/senior/screen/record_senior.dart';
import 'package:knockknock/senior/senior.inital.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> _updateLocationInFirestore(
    String addr, double lat, double lng) async {
  try {
    currentSeniorUID = 'Y3wkpcrAscFryYYo4UOn'; //해당 돌봄대상자의 UID로 수정
    await FirebaseFirestore.instance
        .collection('location')
        .doc(currentSeniorUID)
        .update({
      'CurrentLocation': addr,
      'LatLng': [lat, lng],
    });
  } catch (e) {
    print("Error updating todo: $e");
  }
}

String addr = "로딩 중...";
String managerName = '김 아무개';
String nokPhoneNumber = '010-1234-5678';
String currentSeniorUID = 'Y3wkpcrAscFryYYo4UOn'; //현재 유저 아이디 하드코딩

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmergencyPage();
}

class _EmergencyPage extends State<EmergencyPage> {
  late double lat = 0;
  late double lng = 0;
  Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _permissionGranted;
  @override
  void initState() {
    super.initState();
    _locateMe();
    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    _locateMe();
    Timer.periodic(const Duration(minutes: 5), (timer) {
      _locateMe();
    });
  }

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    await location.getLocation().then((res) {
      setState(() {
        lat = res.latitude!;
        lng = res.longitude!;
      });
    });
    setState(() {
      addr = getPlaceAddress(lat, lng).toString();
    });
  }

  Future<String> getPlaceAddress(double lat, double lng) async {
    var GOOGLE_API_KEY = 'AIzaSyAz9sHZe25LtBkA0ujUCMy472amlfrJCes';
    final url = Uri.parse(
        'https://maps.google.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final response = await http.post(url, body: {
      'key': 'value',
    });
    if (response.statusCode == 200) {
      String addr =
          await jsonDecode(response.body)['results'][0]['formatted_address'];
      return addr;
    } else {
      throw Exception('Failed to fetch address');
    }
  }

  int _selectedIndex = 2;
  void goHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 하단 네비게이션 바의 아이템 개수
      initialIndex: 2,
      child: Scaffold(
        backgroundColor: _selectedIndex == 2
            ? const Color(0xffeeccca)
            : MyColor.myBackground,
        appBar: _selectedIndex != 2
            ? null
            : MyAppBar(
                leadingText: '홈으로',
                leadingCallback: goHome,
                myLeadingWidth: 130,
              ),
        bottomNavigationBar: _selectedIndex != 2
            ? null
            : MyCustomBottomNavigationBar(onTabTapped: _onNavTapped),
        body: _selectedIndex != 2
            ? SeniorInitial(
                i: _selectedIndex,
              )
            : Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: MyColor.myBackground),
                child: Stack(
                  children: [
                    //사회복지사 프로필+이름
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 50,
                      child: SizedBox(
                        width: 354,
                        height: 200,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/basic_profile.png'),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 170,
                              child: SizedBox(
                                child: Text(
                                  managerName + ' 사회복지사',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 30,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0.06,
                                    letterSpacing: -0.53,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //위치+연락처 정보
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 370,
                      child: Container(
                        width: 30,
                        height: 300,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Center(
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 250,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.transparent, // 투명 배경
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: const Color(0xFFCCCCCC),
                                    width: 4), // 회색 테두리
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //위치
                                  const Icon(
                                    Icons.location_on,
                                    size: 70,
                                    color: MyColor.myRed,
                                  ),
                                  FutureBuilder<String>(
                                    future: getPlaceAddress(lat, lng),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text(
                                          '로딩 중...',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.center,
                                        );
                                      } else {
                                        String emergencyAddr =
                                            snapshot.data.toString();
                                        _updateLocationInFirestore(
                                            emergencyAddr, lat, lng);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                            snapshot.data ?? 'GPS를 켜주세요.',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              '보호자 연락처',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              width: 250,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.transparent, // 투명 배경
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: const Color(0xFFCCCCCC),
                                    width: 4), // 회색 테두리
                              ),
                              child: Text(
                                nokPhoneNumber,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ]),
                        ),
                      ),
                    ),
                    // Red box
                    Positioned(
                      child: Container(
                        decoration: ShapeDecoration(
                          color: const Color(0x00f24822).withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    ),
                    // 긴급 전송 버튼
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 250,
                      child: OutlinedButton(
                        onPressed: () async {
                          FirebaseFirestore.instance
                              .collection('emergencyCall')
                              .doc(currentSeniorUID)
                              .update({
                            'isEmergency': true,
                          });
                          String address = await getPlaceAddress(lat, lng);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmergencyCompletePage(
                                    address: address ?? 'Unknown')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size(333, 70),
                          backgroundColor: MyColor.myRed,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        child: const Text(
                          '연락처 & 위치 정보 전송',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                      ),
                    ), // '긴급 상황이십니까?'
                    const Positioned(
                      left: 0,
                      right: 0,
                      top: 335,
                      child: SizedBox(
                        width: 201,
                        height: 34,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                top: -5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 30,
                                      color: MyColor.myRed,
                                    ),
                                    Text(
                                      '  긴급 상황이십니까?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: MyColor.myRed,
                                        fontSize: 20,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w800,
                                        height: 0,
                                        letterSpacing: -0.38,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
