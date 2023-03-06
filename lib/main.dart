// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:fixerking/fast_splash.dart';
// import 'package:fixerking/screen/push_notification_service.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:fixerking/utils/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sizer/sizer.dart';
//
// Future<void> main() async {
//   if(Platform.isAndroid) {
//     AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
//   }
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   changeStatusBarColor(AppColor().colorPrimary());
//   // FirebaseMessaging.onMessageOpenedApp(myForgroundMessageHandler);
//   FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
//
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     systemNavigationBarColor: Colors.transparent, // navigation bar color
//     statusBarColor: AppColor().colorPrimaryDark(), // status bar color
//   ));
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Sizer(builder: (context, orientation, deviceType) {
//       return MaterialApp(
//         title: 'SOD Vendor',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           canvasColor: Theme.of(context).colorScheme.lightWhite,
//           cardColor: Theme.of(context).colorScheme.white,
//           dialogBackgroundColor: Theme.of(context).colorScheme.white,
//           iconTheme: Theme.of(context).iconTheme.copyWith(color: colors.primary),
//           primarySwatch: colors.primary_app,
//           primaryColor: Theme.of(context).colorScheme.lightWhite,
//           fontFamily: 'Poppins',
//           brightness: Brightness.light,
//           textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(),
//         ),
//         //ThemeData.light(),
//         themeMode: ThemeMode.light,
//         initialRoute: "/",
//         // home: SplashScreen(),
//         home: Fastsplash(),
//       );
//     });
//   }
// }
//


import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/fast_splash.dart';
import 'package:fixerking/screen/push_notification_service.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  if(Platform.isAndroid) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  changeStatusBarColor(AppColor().colorPrimary());
  // FirebaseMessaging.onMessageOpenedApp(myForgroundMessageHandler);
  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: AppColor().colorPrimaryDark(), // status bar color
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'SOD Vendor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Theme.of(context).colorScheme.lightWhite,
          cardColor: Theme.of(context).colorScheme.white,
          dialogBackgroundColor: Theme.of(context).colorScheme.white,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: colors.primary),
          primarySwatch: colors.primary_app,
          primaryColor: Theme.of(context).colorScheme.lightWhite,
          fontFamily: 'Poppins',
          brightness: Brightness.light,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(),
        ),
        //ThemeData.light(),
        themeMode: ThemeMode.light,
        initialRoute: "/",
        // home: SplashScreen(),
        home: Fastsplash(),
      );
    });
  }
}
