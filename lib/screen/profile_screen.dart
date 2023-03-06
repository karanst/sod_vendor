// import 'dart:async';
//
// import 'package:animated_widgets/widgets/scale_animated.dart';
// import 'package:fixerking/api/api_helper/auth_helper.dart';
// import 'package:fixerking/fast_splash.dart';
// import 'package:fixerking/modal/request/get_profile_request.dart';
// import 'package:fixerking/modal/response/get_profile_response.dart';
// import 'package:fixerking/screen/Chat_Screen.dart';
// import 'package:fixerking/screen/change_password_screen.dart';
// import 'package:fixerking/screen/main_customer_support.dart';
// import 'package:fixerking/screen/my_wallet.dart';
// import 'package:fixerking/screen/plan_history.dart';
// import 'package:fixerking/screen/profile/edit_profile_screen.dart';
// import 'package:fixerking/screen/auth_view/login_screen.dart';
// import 'package:fixerking/screen/payment_screen.dart';
// import 'package:fixerking/screen/service_history.dart';
// import 'package:fixerking/screen/profile/service_profile_screen.dart';
// import 'package:fixerking/screen/profile/view_profile_screen.dart';
// import 'package:fixerking/screen/subscription_screen.dart';
// import 'package:fixerking/token/app_token_data.dart';
// import 'package:fixerking/utility_widget/shimmer_loding_view/loding_all_page.dart';
// import 'package:fixerking/utils/toast_string.dart';
// import 'package:fixerking/utils/utility_hlepar.dart';
// import 'package:flutter/material.dart';
//
// import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:fixerking/utils/constant.dart';
// import 'package:fixerking/utils/images.dart';
// import 'package:fixerking/utils/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   StreamController<GetProfileResponse> profileResponseStram =
//       StreamController();
//   late GetProfileResponse profileResponse;
//   bool selected = false, enabled = false, edit1 = false;
//   String? walletAmount;
//
//   @override
//   void initState() {
//     super.initState();
//     // getProfile();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     profileResponseStram.close();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     changeStatusBarColor(AppColor().colorPrimary());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.PrimaryDark,
//         centerTitle: true,
//         title: Text("My Account"),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 1000),
//             curve: Curves.easeInOut,
//             width: 100.w,
//             decoration: BoxDecoration(
//               gradient: RadialGradient(
//                 center: Alignment(0.0, -0.5),
//                 colors: [
//                   AppColor().colorBg1(),
//                   AppColor().colorBg1(),
//                 ],
//                 radius: 0.8,
//               ),
//             ),
//             padding: MediaQuery.of(context).viewInsets,
//             child: Column(
//               children: [
//                 // Container(
//                 //   height: 9.92.h,
//                 //   width: 100.w,
//                 //   decoration: BoxDecoration(
//                 //    /*   image: DecorationImage(
//                 //     image: AssetImage(profileBg),
//                 //     fit: BoxFit.fill,
//                 //   )*/
//                 //   boxShadow: [
//                 //     BoxShadow(
//                 //       color: Colors.white.withOpacity(0.4),
//                 //       spreadRadius: 3,
//                 //       blurRadius: 4,
//                 //     )
//                 //   ]
//                 //   ),
//                 //   child: Center(
//                 //     child: Row(
//                 //       crossAxisAlignment: CrossAxisAlignment.center,
//                 //       children: [
//                 //         Container(
//                 //             width: 6.38.w,
//                 //             height: 6.38.w,
//                 //             alignment: Alignment.centerLeft,
//                 //             margin: EdgeInsets.only(left: 7.91.w),
//                 //             child: InkWell(
//                 //                 onTap: () {
//                 //                   Navigator.pushReplacement(
//                 //                       context,
//                 //                       MaterialPageRoute(
//                 //                           builder: (context) => BottomBar()));
//                 //                 },
//                 //                 child: Image.asset(
//                 //                   back,
//                 //                   height: 4.0.h,
//                 //                   width: 8.w,
//                 //                 )
//                 //             )),
//                 //         SizedBox(
//                 //           width: 2.08.h,
//                 //         ),
//                 //         Container(
//                 //           width: 65.w,
//                 //           child: text(
//                 //             "My Account",
//                 //             textColor: Color(0xffffffff),
//                 //             fontSize: 14.sp,
//                 //             fontFamily: fontMedium,
//                 //             isCentered: true,
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 StreamBuilder<GetProfileResponse>(
//                     stream: profileResponseStram.stream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Container(
//                           child: text(snapshot.error.toString()),
//                         );
//                       } else if (snapshot.connectionState ==
//                           ConnectionState.waiting) {
//                         return SizedBox(height: 15.h, child: LodingAllPage());
//                       }
//                       walletAmount = snapshot.data!.user!.wallet.toString();
//                       return InkWell(
//                         onTap: () async {
//                           var data = await Navigator.push(
//                               context,
//                               PageTransition(
//                                 child: ViewProfileScreen(
//                                   response: snapshot.data!,
//                                 ),
//                                 type: PageTransitionType.rightToLeft,
//                                 duration: Duration(milliseconds: 500),
//                               ));
//                           print(data);
//                           print("---------=");
//                           getProfile();
//                         },
//                         child: Container(
//                             height: 11.40.h,
//                             width: 82.91.w,
//                             margin: EdgeInsets.only(
//                                 left: 8.33.w,
//                                 right: 8.33.w,
//                                 bottom: 1.87.h,
//                                 top: 1.87.h),
//                             child: Row(
//                               children: [
//                                 ClipOval(
//                                   child: Container(
//                                     height: 9.76.h,
//                                     width: 9.76.h,
//                                     child: snapshot.data!.user!.profileImage != "" ? UtilityHlepar.convertetIMG(
//                                             snapshot.data!.user!.profileImage
//                                                 .toString(),
//                                         fit: BoxFit.cover)
//                                     : Image(
//                                       image: AssetImage(serviceProfile),
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 3.05.w,
//                                 ),
//                                 Container(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         child: text(
//                                             snapshot.data!.user!.uname.toString() ,
//                                                 // + snapshot.data!.user!.lname.toString(),
//                                             textColor: Color(0xff191919),
//                                             fontSize: 14.0.sp,
//                                             fontFamily: fontBold,
//                                             overFlow: true),
//                                       ),
//                                       SizedBox(
//                                         height: 0.5.h,
//                                       ),
//                                       Container(
//                                         child: text(
//                                           snapshot.data!.user!.email.toString(),
//                                           textColor: Color(0xff2a2a2a),
//                                           fontSize: 10.sp,
//                                           overFlow: true,
//                                           fontFamily: fontRegular,
//                                           maxLine: 2,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 2.05.w,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         PageTransition(
//                                           child: EditProfileScreen(
//                                               response: snapshot.data!),
//                                           type: PageTransitionType.rightToLeft,
//                                           duration: Duration(milliseconds: 500),
//                                         ));
//                                   },
//                                   child: Container(
//                                     height: 5.39.h,
//                                     width: 5.39.h,
//                                     decoration: boxDecoration(
//                                         radius: 100,
//                                         bgColor: AppColor().colorPrimary()),
//                                     child: Center(
//                                       child: Image.asset(
//                                         edit,
//                                         height: 2.26.h,
//                                         width: 2.26.h,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )),
//                       );
//                     }),
//                 // tabItem(context, 5, subscription, "Subscription Plans"),
//                 tabItem(context, 7, walletIcon, "My Wallet"),
//                 // tabItem(context, 1, payment, "Plan History"),
//                 // tabItem(context, 2, serviceIcon, "Service History"),
//                 // tabItem(context, 6, serviceProfile, "Chat With User"),
//                 // tabItem(context, 3, changePass, "Change Password"),
//                 tabItem(context, 4, support, "Customer Support"),
//                 SizedBox(
//                   height: 2.5.h,
//                 ),
//                 Center(
//                   child: InkWell(
//                     onTap: () async {
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       await prefs.clear();
//                       Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(builder: (context) => Fastsplash()),
//                           (route) => false);
//
//                       // setState(() {
//                       //   edit1 = true;
//                       // });
//                       // await Future.delayed(Duration(milliseconds: 200));
//                       // setState(() {
//                       //   edit1 = false;
//                       // });
//                       // Navigator.pushReplacement(
//                       //     context,
//                       //     PageTransition(
//                       //       child: LoginScreen(),
//                       //       type: PageTransitionType.rightToLeft,
//                       //       duration: Duration(milliseconds: 500),
//                       //     ));
//                     },
//                     child: ScaleAnimatedWidget.tween(
//                       enabled: edit1,
//                       duration: Duration(milliseconds: 200),
//                       scaleDisabled: 1.0,
//                       scaleEnabled: 0.9,
//                       child: Container(
//                         height: 7.09.h,
//                         width: 42.63.w,
//                         decoration: boxDecoration(
//                             radius: 15.0,
//                             bgColor: AppColor.PrimaryDark),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Center(
//                               child: Image.asset(
//                                 logout,
//                                 height: 3.82.h,
//                                 width: 3.82.h,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             text(
//                               "Log Out",
//                               textColor: Color(0xffffffff),
//                               fontSize: 10.sp,
//                               fontFamily: fontRegular,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 2.5.h,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   getProfile() async {
//     try {
//       var vendorId = await MyToken.getUserID();
//       // var vendorId = "31";
//       GetProfileRequest request = GetProfileRequest(vendorId: vendorId);
//       print(request.toString());
//
//       profileResponse = await AuthApiHelper.getProfile(request);
//       if (profileResponse.status == ToastString.success) {
//         profileResponseStram.sink.add(profileResponse);
//       } else {
//         profileResponseStram.sink.addError(profileResponse.message.toString());
//       }
//     } catch (e) {
//       UtilityHlepar.getToast(e.toString());
//       profileResponseStram.sink.addError(ToastString.msgSomeWentWrong);
//     }
//   }
//
//   Widget tabItem(BuildContext context, var pos, var icon, String title) {
//     return InkWell(
//       onTap: () {
//         if (pos == 1) {
//           Navigator.push(
//               context,
//               PageTransition(
//                 child: PlanHistory(),
//                 type: PageTransitionType.rightToLeft,
//                 duration: Duration(milliseconds: 500),
//               ));
//         }
//         if (pos == 2) {
//           Navigator.push(
//               context,
//               PageTransition(
//                 child: MainServiceHistory(),
//                 type: PageTransitionType.rightToLeft,
//                 duration: Duration(milliseconds: 500),
//               ));
//         }
//         if (pos == 3) {
//           Navigator.push(
//               context,
//               PageTransition(
//                 child: ChangeScreen(),
//                 type: PageTransitionType.rightToLeft,
//                 duration: Duration(milliseconds: 500),
//               ));
//         }
//         if (pos == 4) {
//           Navigator.push(
//               context,
//               PageTransition(
//                 child: MainCustomerSupport(),
//                 type: PageTransitionType.rightToLeft,
//                 duration: Duration(milliseconds: 500),
//               ));
//         }
//         if (pos == 5) {
//           Navigator.push(
//               context,
//               PageTransition(
//                 child: SubscriptionScreen(),
//                 type: PageTransitionType.rightToLeft,
//                 duration: Duration(milliseconds: 500),
//               ));
//         }
//         if( pos == 6){
//           Navigator.push(
//               context,
//               PageTransition(
//                 child: ChatScreen(),
//                 type: PageTransitionType.rightToLeft,
//                 duration: Duration(milliseconds: 500),
//               ));
//         }
//         if (pos == 7) {
//           Navigator.push(
//               context,
//               PageTransition(
//                 child: WalletScreen(
//                   walletAmount: walletAmount!,
//                 ),
//                 type: PageTransitionType.rightToLeft,
//                 duration: Duration(milliseconds: 500),
//               ));
//         }
//       },
//       child: Container(
//           height: 11.25.h,
//           width: 82.91.w,
//           decoration: boxDecoration(
//             showShadow: true,
//             radius: 20.0,
//             bgColor: AppColor().colorBg1(),
//           ),
//           margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
//           padding: EdgeInsets.only(left: 6.05.w, right: 3.05.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 height: 3.82.h,
//                 width: 3.82.h,
//                 child: Image(
//                   color: AppColor().colorPrimary(),
//                   image: AssetImage(icon),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Container(
//                 child: text(title,
//                     textColor: Color(0xff191919),
//                     fontSize: 10.5.sp,
//                     fontFamily: fontBold,
//                     overFlow: true),
//               ),
//               SizedBox(
//                 width: 1.05.w,
//               ),
//               Container(
//                 height: 6.32.h,
//                 width: 6.32.h,
//                 decoration: boxDecoration(
//                     radius: 100,
//                     bgColor: AppColor().colorPrimary().withOpacity(1)),
//                 child: Center(
//                   child: Icon(Icons.arrow_forward_ios_outlined, color: AppColor().colorBg1(),),
//                   // Image(
//                   //   image: AssetImage(arrowForward),
//                   //   fit: BoxFit.fill,
//                   //   height: 1.87.h,
//                   //   width: 1.80.w,
//                   // ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
