import 'package:flutter/material.dart';
import 'package:knockknock/components/color.dart';
import 'package:knockknock/senior/component/my_appbar.dart';
import 'package:knockknock/senior/component/my_bottomnavigationbar.dart';
import 'package:knockknock/senior/screen/home_senior.dart';
import 'package:knockknock/senior/senior.inital.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _RecordPage();
}

class _RecordPage extends State<RecordPage> {
  int _selectedIndex = 0;
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
      initialIndex: _selectedIndex, // 초기 선택된 인덱스
      child: Scaffold(
        backgroundColor: _selectedIndex == 2
            ? MyColor.myBackground
            : const Color(0xffEDEDF4),
        appBar: _selectedIndex != 0
            ? null
            : MyAppBar(
                myLeadingWidth: 130,
                leadingText: '홈으로',
                leadingCallback: goHome,
              ),
        bottomNavigationBar: _selectedIndex != 0
            ? null
            : MyCustomBottomNavigationBar(onTabTapped: _onNavTapped),
        body: _selectedIndex != 0
            ? SeniorInitial(
                i: _selectedIndex,
              )
            : const ChatScreen(),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  var message_info = ['test', DateTime.utc(1944, 6, 6).toString()];
  List<dynamic> messages() {
    var messages = [];
    messages.add(message_info);
    return messages;
  }

  Widget _buildMessageWidget(List<dynamic> messages, int index) {
    final isFinalMessage = index == messages.length - 1;
    final boxColor =
        isFinalMessage ? const Color.fromRGBO(20, 174, 92, 1) : Colors.white;
    final textColor = isFinalMessage ? Colors.white : Colors.black;
    return Container(
      margin: const EdgeInsets.only(left: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 메시지 송수신 시간
          Container(
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: Text(
                messages[index][1],
                style: const TextStyle(color: Colors.black),
              )),
          // 메시지 박스 + 텍스트
          CustomPaint(
            painter: BubblePainter(color: boxColor),
            child: Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                messages[index][0],
                style: TextStyle(color: textColor, fontSize: 40),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFEDEDF4)),
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: messages().length,
              itemBuilder: (context, index) {
                return _buildMessageWidget(messages(), index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final Color color;

  BubblePainter({
    required this.color,
  });

  final _radius = 10.0;
  final _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          _x,
          0,
          size.width,
          size.height,
          bottomRight: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
          topLeft: Radius.circular(_radius),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(_x, size.height);
    path.lineTo(_x, size.height - 20);
    canvas.clipPath(path);
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          0,
          0.0,
          _x,
          size.height,
          topRight: Radius.circular(_radius),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
