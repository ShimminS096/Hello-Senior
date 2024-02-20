import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/manager/m_components/m_app_bar.dart';

class SeniorProfile extends StatefulWidget {
  final Map<String, dynamic> seniorInfo;
  final int index;

  const SeniorProfile({
    super.key,
    required this.seniorInfo,
    required this.index,
  });

  @override
  State<SeniorProfile> createState() =>
      _SeniorProfileState(seniorInfo: seniorInfo, index: index);
}

class _SeniorProfileState extends State<SeniorProfile> {
  final Map<String, dynamic> seniorInfo;
  final int index;

  _SeniorProfileState({
    Key? key,
    required this.seniorInfo,
    required this.index,
  });

  String _address = '';
  String _guardianPhoneNumber = '';
  String _speciality = '';

  //초기화하지 않은 상태
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  bool isSeniorEditing = false;

  @override
  void initState() {
    super.initState();
  }

  // 컨트롤러의 값을 변수에 할당하는 함수
  void updateControllers() {
    if (mounted) {
      setState(() {
        _address = _addressController.text;
        _guardianPhoneNumber = _guardianController.text;
        _speciality = _specialityController.text;
      });
    }
  }

  void onEditSeniorProfile() async {
    //버튼을 눌렀을 때, 현재 상태 변경
    if (mounted) {
      setState(() {
        isSeniorEditing = !isSeniorEditing;
      });
    }
    //변경된 값 전달하기
    updateControllers();
    if (!isSeniorEditing) {
      await updateFirestoreData();
    }
  }

  //firestore에 변경된 필드값 보내기
  Future<void> updateFirestoreData() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String uid = seniorInfo['seniorUID'];

    _firestore.collection('users').doc(uid).update({
      'address': _address,
      'protectorPhoneNumber': _guardianPhoneNumber,
      'detail': _speciality,
    });
  }

  //firestore에서 현재 유저의 문서 가져오기
  void fetchSeniorInfo() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String uid = widget.seniorInfo['seniorUID'];

    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(uid).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
      if (mounted) {
        setState(() {
          //변수에 필드값 할당하기
          _address = data['address'] ?? '';
          _guardianPhoneNumber = data['protectorPhoneNumber'] ?? '';
          _speciality = data['detail'] ?? '';

          //편집 모드가 아니라면(편집 모드 사용 전이라면), 가져온 필드값을 Controller에 넣어주기
          if (!isSeniorEditing) {
            _addressController.text = _address;
            _guardianController.text = _guardianPhoneNumber;
            _specialityController.text = _speciality;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchSeniorInfo();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColor.myBackground,
      appBar: ManagerAppBar(
        size: 56,
        actionTap: () {
          onEditSeniorProfile();
          if (!isSeniorEditing) {
            updateFirestoreData();
          }
        },
        actionchild: isSeniorEditing
            ? const Text(
                "완료",
                style: TextStyle(
                    color: MyColor.myBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )
            : const Text(
                "편집",
                style: TextStyle(
                    color: MyColor.myBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 450,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/user_profile.jpg",
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      seniorInfo['seniorName'],
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 450,
                height: 240,
                decoration: BoxDecoration(
                  color: MyColor.myWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 450,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 200,
                              child: Text(
                                "전화번호",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              seniorInfo['phoneNumber'],
                              style: const TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                      color: MyColor.myLightGrey,
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(
                      width: 450,
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              width: 200,
                              child: Padding(
                                padding: EdgeInsets.only(top: 7),
                                child: Text(
                                  "주소",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller:
                                    isSeniorEditing ? _addressController : null,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: MyColor.myBlack,
                                ),

                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText:
                                      isSeniorEditing ? "주소를 입력하세요" : _address,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: MyColor.myBlue),
                                  ),
                                ),
                                enabled: isSeniorEditing,
                                onChanged: (value) {
                                  setState(() {
                                    _address = value;
                                  });
                                }, // 추가: 편집 모드에 따라 편집 가능 여부 설정
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                      color: MyColor.myLightGrey,
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(
                      width: 450,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 200,
                              child: Text(
                                "보호자 연락처",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                  controller: isSeniorEditing
                                      ? _guardianController
                                      : null,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: MyColor.myBlack,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: isSeniorEditing
                                        ? "010-XXXX-XXXX"
                                        : _guardianPhoneNumber,
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: MyColor.myBlue),
                                    ),
                                  ),
                                  enabled: isSeniorEditing,
                                  onChanged: (value) {
                                    setState(() {
                                      _guardianPhoneNumber = value;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: 450,
                height: 300, // 기본 높이
                decoration: BoxDecoration(
                  color: MyColor.myWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      width: 450,
                      height: 60,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Text(
                          "특이사항",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 0,
                      color: MyColor.myLightGrey,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        child: TextField(
                            controller:
                                isSeniorEditing ? _specialityController : null,
                            style: const TextStyle(
                              fontSize: 22,
                              color: MyColor.myBlack,
                            ),
                            maxLines: null,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText:
                                  isSeniorEditing ? "내용을 수정하세요" : _speciality,
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: MyColor.myBlue),
                              ),
                            ),
                            enabled: isSeniorEditing,
                            onChanged: (value) {
                              setState(() {
                                _speciality = value;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
