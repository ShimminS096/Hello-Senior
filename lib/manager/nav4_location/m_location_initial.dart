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
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyAz9sHZe25LtBkA0ujUCMy472amlfrJCes';
  }
}

class _ManagerLocationInitial extends State<ManagerLocationInitial> {
  String? _previewImageURL;

  Future<void> _getCurrentLocationData() async {
    // final locData = await Location().getLocation();
    // final staticImageURL = LocationHelper.generateLocationPreviewImage(
    //     latitude: locData.latitude, longitude: locData.longitude);

    // 원래는 위 주석처리된 부분으로 위치정보를 받아와야함. 지금은 뉴욕의 위도&경도 더미데이터를 넣어놓았습니다.
    final staticImageURL = LocationHelper.generateLocationPreviewImage(
        latitude: 37.5519, longitude: 126.9918);

    setState(() {
      _previewImageURL = staticImageURL;
    });
  }

  late ScrollController _scrollController = ScrollController();
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    isSelected = List.generate(widget.numberofSeniors, (index) => false);
  }

  void onSelect(int index) {
    setState(() {
      if (isSelected[index]) {
        isSelected[index] = !isSelected[index];
      } else {
        isSelected = List.generate(widget.numberofSeniors, (index) => false);
        isSelected[index] = !isSelected[index];
      }
      _getCurrentLocationData();
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
                      return LocationBox(
                        name: '길정수',
                        bgColor: isSelected[index]
                            ? MyColor.myMediumGrey.withOpacity(0.6)
                            : null,
                        buttonTapped: () => onSelect(index),
                      );
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
                    isSelected.contains(true)
                        ? "선택된 index : ${isSelected.indexOf(true)}"
                        : '대상을 선택해주세요.',
                    style: const TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
