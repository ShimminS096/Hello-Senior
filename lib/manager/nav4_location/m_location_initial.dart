import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';
import 'package:knockknock/manager/nav4_location/m_location_box.dart';

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
  String senioruid = "ZGL42b7A51pxoNxoJKPe"; //현재 대상 돌봄대상자의 id로 세팅할 것
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
  late double lat;
  late double lng;
  late String currentLocation;
  late List<DocumentSnapshot> seniorUID_list;
  late List<String> seniorName_list;

  Future<void> readFromFirestore() async {
    seniorInfoSnapshot =
        await FirebaseFirestore.instance.collection('location').get();
    seniorUID_list = seniorInfoSnapshot.docs;
    seniorName_list = [];
    for (DocumentSnapshot document in seniorUID_list) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String seniorName = data['SeniorName'];
      seniorName_list.add(seniorName);
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
        seniorInfoSnapshot.docs[index].data() as Map<String, dynamic>;
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
                                name: seniorName_list[index],
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
