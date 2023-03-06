// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:fixerking/RideFlow/utils/PushNotificationService.dart';
// import 'package:fixerking/screen/BottomBars/bottom_bar_delivery.dart';
// import 'package:fixerking/screen/auth_view/login.dart';
// import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
// import 'package:fixerking/screen/home_screen.dart';
// import 'package:fixerking/screen/push_notification_service.dart';
// import 'package:fixerking/screen/get_started.dart';
// import 'package:fixerking/token/app_token_data.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
//
// import 'token/token_string.dart';
//
// class Fastsplash extends StatefulWidget {
//   const Fastsplash({Key? key}) : super(key: key);
//
//   @override
//   State<Fastsplash> createState() => _FastsplashState();
// }
//
// class _FastsplashState extends State<Fastsplash> {
//   String token = '';
//   String? uid;
//   String? type;
//
//   @override
//   void initState() {
//     super.initState();
//     getToken();
//     checkingLogin();
//     PushNotificationService notificationService = new PushNotificationService(context: context, onResult: (value) {  });
//     notificationService.initialise();
//
//   }
//
//   getToken() async {
//     var fcmToken = await FirebaseMessaging.instance.getToken();
//     // setState(() {
//       token = fcmToken.toString();
//     // });
//     print("FCM ID=== $token");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height + 300,
//         decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.contain,
//                 image: AssetImage(
//                     'images/splash_logo.png'
//                 ),
//             ),
//         ),
//         // child:
//         // AnimatedSplashScreen(
//         //   splash: 'images/splash_logo.png',
//         //   // backgroundColor: AppColor.PrimaryDark,
//         //   nextScreen: uid == null || uid == "" ? GetStarted() :
//         //       type == "2" ||  type == "3" || type =="4" ?
//         //           BottomBarDelivery() : BottomBar(),
//         //   splashIconSize: MediaQuery.of(context).size.height + 80,
//         //   duration: 1500,
//         //   splashTransition: SplashTransition.slideTransition,
//         // // ),
//       ),
//     );
//   }
//
//   void checkingLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       uid = prefs.getString(TokenString.userid);
//       type = prefs.getString(TokenString.type);
//     });
//     if(uid == null || uid == ""){
//       Future.delayed(Duration(
//         seconds: 3
//       ), (){
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GetStarted()));
//       });
//
//     }else{
//       Future.delayed(Duration(
//           seconds: 3
//       ), (){
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
//         type == "2" ||  type == "3" || type =="4" ?
//         BottomBarDelivery() : BottomBar()));
//       });
//     }
//   }
// }


import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar_delivery.dart';
import 'package:fixerking/screen/auth_view/login.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/screen/home_screen.dart';
import 'package:fixerking/screen/push_notification_service.dart';
import 'package:fixerking/screen/get_started.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'token/token_string.dart';

class Fastsplash extends StatefulWidget {
  const Fastsplash({Key? key}) : super(key: key);

  @override
  State<Fastsplash> createState() => _FastsplashState();
}

class _FastsplashState extends State<Fastsplash> {
  String token = '';
  String? uid;
  String? type;

  @override
  void initState() {
    super.initState();
    getToken();
    checkingLogin();
    PushNotificationService notificationService =  PushNotificationService(context: context);
    notificationService.initialise();

  }

  getToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    // setState(() {
    token = fcmToken.toString();
    // });
    print("FCM ID=== $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height + 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage(
                'images/splash_logo.png'
            ),
          ),
        ),
        // child:
        // AnimatedSplashScreen(
        //   splash: 'images/splash_logo.png',
        //   // backgroundColor: AppColor.PrimaryDark,
        //   nextScreen: uid == null || uid == "" ? GetStarted() :
        //       type == "2" ||  type == "3" || type =="4" ?
        //           BottomBarDelivery() : BottomBar(),
        //   splashIconSize: MediaQuery.of(context).size.height + 80,
        //   duration: 1500,
        //   splashTransition: SplashTransition.slideTransition,
        // // ),
      ),
    );
  }

  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
    if(uid == null || uid == ""){
      Future.delayed(Duration(
          seconds: 3
      ), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GetStarted()));
      });

    }else{
      Future.delayed(Duration(
          seconds: 3
      ), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
        type == "2" ||  type == "3" || type =="4" ?
        BottomBarDelivery() : BottomBar()));
      });
    }
  }
}
