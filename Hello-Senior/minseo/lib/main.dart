import 'package:flutter/material.dart';
import 'package:hello_senior/screen/emergency_senior.dart';
// import 'package:badges/badges.dart' as badges;
import 'package:hello_senior/screen/home_senior.dart';
import 'package:hello_senior/screen/record_senior.dart';
import 'package:hello_senior/screen/response_2_senior.dart';
import 'package:hello_senior/screen/response_senior.dart';

void main() {
  runApp(const MyApp());
  // runApp(const Notification());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: false,
      bottom: true,
      right: false,
      child: MaterialApp(
        title: 'layout example',
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomePage(),
          '/response': (context) => ResponsePage(),
          '/response_2': (context) => ResponseCompletePage(),
          '/record': (context) => RecordPage(),
          '/emergency': (context) => EmergencyPage(),
        },
      ),
    );
  }
}

// return Scaffold(
//     appBar: AppBar(
//       title: const Text('Buttons'),
//     ),
//     body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(onPressed: (){}, child: const Text('notification')
//             )
//           ],
//         )
//     )
// );
//   }
// }
//
// class Notification extends StatefulWidget {
//   const Notification({ Key ? key}): super(key: key);
//
//   @override
//   _NotificationState createState() => _NotificationState();
// }
//
// class _NotificationState extends State<Notification> {
//   bool _isKnocked = false;
//   void _setKnocked(){
//     setState((){
//       _isKnocked = true;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('Buttons'),
//             ),
//             body: Center(
//
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     badges.Badge(
//                         position: badges.BadgePosition.topEnd(top: -20, end: -15),
//                         badgeContent: const Text(' ?? '),
//                         badgeStyle: const badges.BadgeStyle(
//                           badgeColor: Colors.red,
//                           padding: EdgeInsets.all(40),
//                         ),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(	//모서리를 둥글게
//                                 borderRadius: BorderRadius.circular(20)),
//                             primary: Colors.blue,
//                             onPrimary: Colors.white,
//                             shadowColor: Colors.red,
//                             elevation: 15.0,
//                             textStyle: const TextStyle(fontSize: 40),
//                             minimumSize: const Size(200, 200),
//                             side: const BorderSide(
//                               color: Colors.black12, width: 10.0,
//                             ),
//                           ),
//
//                           onPressed: (){},
//                           child: const Text('알림'),
//                         )
//                     )
//                   ],
//                 )
//             )
//         )
//     );
