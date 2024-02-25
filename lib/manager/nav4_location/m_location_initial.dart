import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/manager/nav4_location/m_location_box.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String currentUserID = auth.currentUser!.uid;

class ManagerLocationInitial extends StatefulWidget {
  final int numberofSeniors;
  const ManagerLocationInitial({super.key, required this.numberofSeniors});

  @override
  State<ManagerLocationInitial> createState() => _ManagerLocationInitial();
}

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=AIzaSyAz9sHZe25LtBkA0ujUCMy472amlfrJCes';
  }
}

class _ManagerLocationInitial extends State<ManagerLocationInitial> {
  String? _previewImageURL;
  Future<void> _getCurrentLocationData(
      double latitude, double longitude) async {
    final staticImageURL = LocationHelper.generateLocationPreviewImage(
        latitude: latitude, longitude: longitude);

    setState(() {
      _previewImageURL = staticImageURL;
    });
  }

  late ScrollController _scrollController = ScrollController();
  late List<bool> isSelected;
  late QuerySnapshot seniorInfoSnapshot;
  late QuerySnapshot locationSnapshot;
  late double lat;
  late double lng;
  late String currentLocation;
  late List<DocumentSnapshot> seniorUID_list;
  List<String> seniorNames = [];

  Future<void> readFromFirestore() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .get();
    final seniorUIDs =
        docSnapshot['seniorUIDs'] as List<dynamic>; // 현재 관리자 담당 senior의 UID 목록

    locationSnapshot = await FirebaseFirestore.instance
        .collection('location')
        .where(FieldPath.documentId, whereIn: seniorUIDs)
        .get();
    for (String seniorUID in seniorUIDs) {
      final seniorInfoSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(seniorUID)
          .get();
      Map<String, dynamic>? data = seniorInfoSnapshot.data();
      String seniorName = data?['seniorName'];
      seniorNames.add(seniorName);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    isSelected = List.generate(widget.numberofSeniors, (index) => false);
    readFromFirestore();
  }

  Future<void> onSelect(int index) async {
    Map<String, dynamic> data =
        locationSnapshot.docs[index].data() as Map<String, dynamic>;
    print(locationSnapshot);
    lat = data['LatLng'][0];
    lng = data['LatLng'][1];
    currentLocation = data['CurrentLocation'];
    setState(() {
      if (isSelected[index]) {
        isSelected[index] = !isSelected[index];
      } else {
        isSelected = List.generate(widget.numberofSeniors, (index) => false);
        isSelected[index] = !isSelected[index];
      }
      _getCurrentLocationData(lat, lng);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.myBackground,
      appBar: const ManagerAppBar(
        title: '위치',
        size: 95,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  width: 450,
                  height: 300,
                  child: _previewImageURL == null
                      ? const Text(
                          '대상을 선택해주세요',
                          textAlign: TextAlign.center,
                        )
                      : Image.network(
                          _previewImageURL!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )),
              const SizedBox(height: 20),
              SizedBox(
                width: 450,
                height: 200,
                child: Scrollbar(
                  controller: _scrollController,
                  trackVisibility: true,
                  thumbVisibility: true,
                  thickness: 5,
                  radius: const Radius.circular(20),
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: widget.numberofSeniors,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 220,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 4,
                    ),
                    itemBuilder: (BuildContext context, index) {
                      return FutureBuilder<void>(
                          future: readFromFirestore(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                '로딩 중...',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return LocationBox(
                                name: seniorNames[index],
                                bgColor: isSelected[index]
                                    ? MyColor.myMediumGrey.withOpacity(0.6)
                                    : null,
                                buttonTapped: () => onSelect(index),
                              );
                            }
                          });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 450,
                height: 200,
                padding: const EdgeInsets.all(30),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: MyColor.myWhite.withOpacity(0.7),
                ),
                child: Text(
                    isSelected.contains(true) ? currentLocation : '대상을 선택해주세요.',
                    style: const TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
