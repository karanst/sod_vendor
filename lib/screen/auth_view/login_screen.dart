// // import 'dart:convert';
// // import 'package:animated_widgets/animated_widgets.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:fixerking/api/api_helper/ApiList.dart';
// // import 'package:fixerking/api/api_helper/auth_helper.dart';
// // import 'package:fixerking/modal/New%20models/LoginModel.dart';
// // import 'package:fixerking/modal/request/login_with_email.dart';
// // import 'package:fixerking/modal/request/login_with_phone.dart';
// // import 'package:fixerking/modal/response/login_email_response.dart';
// // import 'package:fixerking/modal/response/login_phone_response.dart';
// // import 'package:fixerking/screen/OtpScreen.dart';
// // import 'package:fixerking/screen/bottom_bar.dart';
// // import 'package:fixerking/screen/auth_view/signup_screen.dart';
// // import 'package:fixerking/token/token_string.dart';
// // import 'package:fixerking/utility_widget/customLoader.dart';
// // import 'package:fixerking/utility_widget/utility_widget.dart';
// // import 'package:fixerking/utils/images.dart';
// // import 'package:fixerking/validation/form_validation.dart';
// // import 'package:flutter/animation.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:page_transition/page_transition.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:sizer/sizer.dart';
// // import 'package:fixerking/utils/colors.dart';
// // import 'package:fixerking/utils/constant.dart';
// // import 'package:http/http.dart' as http;
// //
// // import '../../utils/widget.dart';
// //
// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //
// //   TextEditingController phoneController = new TextEditingController();
// //   TextEditingController emailController = new TextEditingController();
// //   TextEditingController passController = new TextEditingController();
// //   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// //   bool status = false;
// //   String token = '';
// //   bool selected = false, enabled = false, edit = false, buttonLogin = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     getToken();
// //     _controller = AnimationController(vsync: this);
// //     // changePage();
// //   }
// //
// //   getToken() async {
// //     var fcmToken = await FirebaseMessaging.instance.getToken();
// //     setState(() {
// //       token = fcmToken.toString();
// //     });
// //     print("FCM ID=== $token");
// //   }
// //
// //   changePage() async {
// //     await Future.delayed(Duration(milliseconds: 2000));
// //     setState(() {
// //       status = true;
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }
// //
// //   String? otp;
// //   LoginApi()async{
// //     showDialog(context: context, builder: (context){
// //       return CustomLoader(text: "Login, please wait...",);
// //     });
// //     print({"mobile========":phoneController.text,"device_token======":"$token"});
// //     var response = await  http.post(Uri.parse(VendorLogin),
// //         body: {"mobile":phoneController.text,"device_token":"$token"});
// //     print("checking response here ${response.body}");
// //     var finalStr = LoginModel.fromJson(json.decode(response.body));
// //     if(finalStr.status == "success"){
// //       Navigator.of(context).pop();
// //      setState(() {
// //        otp = finalStr.otp.toString();
// //      });
// //      print("otp here ${otp}");
// //       Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(otp: otp,mobile: phoneController.text,) ));
// //       const snackBar = SnackBar(
// //         backgroundColor: Colors.green,
// //         content: Text('Otp Send Successfully'),
// //       );
// //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //     }
// //     else {
// //       Navigator.pop(context);
// //       Fluttertoast.showToast(msg: "${finalStr.message}");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColor().colorBg2(),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: AnimatedContainer(
// //             duration: Duration(milliseconds: 1000),
// //             curve: Curves.easeInOut,
// //             width: 100.w,
// //             decoration: BoxDecoration(
// //               gradient: RadialGradient(
// //                 center: Alignment(0.0, -0.5),
// //                 colors: [
// //                   AppColor().colorBg1(),
// //                   AppColor().colorBg2(),
// //                 ],
// //                 radius: 0.8,
// //               ),
// //             ),
// //             padding: MediaQuery.of(context).viewInsets,
// //             child: Stack(
// //               // mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Container(
// //                   height: 40.65.h,
// //                   width: 100.w,
// //                   alignment: Alignment.center,
// //                   decoration: BoxDecoration(
// //                       color: AppColor.PrimaryDark,
// //                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18))
// //                   ),
// //                   child: Center(
// //                     child: Column(
// //                       children: [
// //                         SizedBox(
// //                           height: 5.08.h,
// //                         ),
// //                         appLogo(),
// //                         SizedBox(
// //                           height: 5.08.h,
// //                         ),
// //                         text(
// //                           "Login",
// //                           textColor: Color(0xffffffff),
// //                           fontSize: 22.sp,
// //                           fontFamily: fontMedium,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 Container(
// //                   padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   margin: EdgeInsets.only(top: 30.h,left: 25,right: 25),
// //                   child: Form(
// //                     key: _formKey,
// //                     child: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       children: [
// //                         SizedBox(height: 20,),
// //                         Container(
// //                             height: 55,
// //                             decoration: BoxDecoration(
// //                                 color: Color(0xffF9F9F9),
// //                                 borderRadius: BorderRadius.circular(12)
// //                             ),
// //                             child: TextFormField(
// //                               controller: phoneController,
// //                               // maxLength: 10,
// //                               validator: (v){
// //                                 if(v!.isEmpty){
// //                                   return "Please enter Email";
// //                                 }
// //                                 return null;
// //                               },
// //                               decoration: InputDecoration(
// //                                 contentPadding: EdgeInsets.only(left: 10),
// //                                 hintText: "Enter Email Id",
// //                                 // counterText: '',
// //                                 hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,),
// //                                 border: InputBorder.none,
// //                               ),
// //                               keyboardType: TextInputType.emailAddress,
// //                             )),
// //                         SizedBox(height: 30,),
// //                           InkWell(
// //                           onTap: (){
// //                            if(_formKey.currentState!.validate()){
// //                              LoginApi();
// //                            }
// //                            else{
// //                              // const snackBar = SnackBar(
// //                              //   backgroundColor: Colors.green,
// //                              //   content: Text('Something went wrong'),
// //                              // );
// //                              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //                            }
// //
// //                           },
// //                           child: Container(
// //                             height: 45,
// //                             width: MediaQuery.of(context).size.width/2,
// //                             alignment: Alignment.center,
// //                             decoration: BoxDecoration(
// //                               color: AppColor.PrimaryDark,
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                             child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),),
// //                         ),
// //                         SizedBox(height: 20,),
// //                         Container(
// //                           alignment: Alignment.center,
// //                           margin: EdgeInsets.only(top: 20),
// //                           child: InkWell(
// //                             onTap: () async {
// //                               setState(() {
// //                                 edit = true;
// //                               });
// //                               await Future.delayed(Duration(milliseconds: 200));
// //                               setState(() {
// //                                 edit = false;
// //                               });
// //                               Navigator.push(
// //                                   context,
// //                                   PageTransition(
// //                                     child: SignUpScreen(),
// //                                     type: PageTransitionType.rightToLeft,
// //                                     duration: Duration(milliseconds: 500),
// //                                   ));
// //                             },
// //                             child: ScaleAnimatedWidget.tween(
// //                               enabled: edit,
// //                               duration: Duration(milliseconds: 200),
// //                               scaleDisabled: 1.0,
// //                               scaleEnabled: 0.8,
// //                               child: RichText(
// //                                 text: new TextSpan(
// //                                   text: "Don't Have An Account? ",
// //                                   style: TextStyle(
// //                                     color: Color(0xff171717),
// //                                     fontSize: 10.sp,
// //                                     fontFamily: fontBold,
// //                                   ),
// //                                   children: <TextSpan>[
// //                                     new TextSpan(
// //                                       text: 'SignUp',
// //                                       style: TextStyle(
// //                                         color: AppColor().colorPrimary(),
// //                                         fontSize: 10.sp,
// //                                         fontFamily: fontBold,
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   appLogo(){
// //     return Container(
// //       width: 120,
// //       height: 50,
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(10.0),
// //         color: Colors.white
// //       ),
// //       child: Image.asset("images/ez_logo.png",
// //         width: 120,
// //         height: 50,
// //       ),
// //     );
// //   }
// //
// //   Widget firstSign(BuildContext context) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.start,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         SizedBox(
// //           height: 3.05.h,
// //         ),
// //
// //              Column(
// //                 children: [
// //                   Center(
// //                     child: Container(
// //                       width: 69.99.w,
// //                       // height: 9.46.h,
// //                       child: TextFormField(
// //                         cursorColor: Colors.red,
// //                         maxLength: 10,
// //                         keyboardType: TextInputType.number,
// //                         controller: phoneController,
// //                         validator: FormValidation.validateMobile,
// //                         style: TextStyle(
// //                           color: AppColor().colorTextFour(),
// //                           fontSize: 10.sp,
// //                         ),
// //                         inputFormatters: [
// //                           FilteringTextInputFormatter.digitsOnly
// //                         ],
// //                         decoration: InputDecoration(
// //                           focusedBorder: UnderlineInputBorder(
// //                             borderSide: BorderSide(
// //                                 color: AppColor().colorEdit(),
// //                                 width: 1.0,
// //                                 style: BorderStyle.solid),
// //                             borderRadius:
// //                                 BorderRadius.all(Radius.circular(10.0)),
// //                           ),
// //                           labelText: 'Phone Number',
// //                           labelStyle: TextStyle(
// //                             color: AppColor().colorTextFour(),
// //                             fontSize: 10.sp,
// //                           ),
// //                           helperText: '',
// //                           counterText: '',
// //                           fillColor: AppColor().colorEdit(),
// //                           enabled: true,
// //                           filled: true,
// //                           prefixIcon: Padding(
// //                             padding: EdgeInsets.all(4.0.w),
// //                             child: Image.asset(
// //                               phone,
// //                               width: 2.04.w,
// //                               height: 2.04.w,
// //                               fit: BoxFit.fill,
// //                             ),
// //                           ),
// //                           suffixIcon: phoneController.text.length == 10
// //                               ? Container(
// //                                   width: 10.w,
// //                                   alignment: Alignment.center,
// //                                   child: FaIcon(
// //                                     FontAwesomeIcons.check,
// //                                     color: AppColor().colorPrimary(),
// //                                     size: 10.sp,
// //                                   ))
// //                               : SizedBox(),
// //                           enabledBorder: UnderlineInputBorder(
// //                             borderSide: BorderSide(
// //                                 color: AppColor().colorEdit(), width: 5.0),
// //                             borderRadius:
// //                                 BorderRadius.all(Radius.circular(10.0)),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //         SizedBox(
// //           height: 4.75.h,
// //         ),
// //         Center(
// //           child: InkWell(
// //             onTap: () async {
// //               print(selected.toString());
// //               if (_formKey.currentState!.validate()) {
// //                 setState(() {
// //                   buttonLogin = true;
// //                 });
// //                 if (selected) {
// //                   loginWithPhone();
// //                 } else {
// //                   loginWithEmail(context);
// //                 }
// //               }
// //             },
// //             child: UtilityWidget.lodingButton(
// //                 buttonLogin: buttonLogin, btntext: "Log In"),
// //           ),
// //         ),
// //         SizedBox(
// //           height: 6.53.h,
// //         ),
// //         Center(
// //           child: Container(
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 // Container(
// //                 //     width: 9.86.w,
// //                 //     child: Divider(
// //                 //       color: AppColor().colorTextSecondary(),
// //                 //     )),
// //                 // SizedBox(
// //                 //   width: 1.w,
// //                 // ),
// //                 // text(
// //                 //   "Login With",
// //                 //   textColor: AppColor().colorTextSecondary(),
// //                 //   fontSize: 10.sp,
// //                 //   fontFamily: fontRegular,
// //                 // ),
// //                 // SizedBox(
// //                 //   width: 1.w,
// //                 // ),
// //                 // Container(
// //                 //     width: 9.86.w,
// //                 //     child: Divider(
// //                 //       color: AppColor().colorTextSecondary(),
// //                 //     )),
// //               ],
// //             ),
// //           ),
// //         ),
// //         SizedBox(
// //           height: 6.61.h,
// //         ),
// //         // Center(
// //         //   child: Image.asset(
// //         //     fb,
// //         //     height: 5.79.h,
// //         //     width: 29.30.w,
// //         //   ),
// //         // ),
// //       ],
// //     );
// //   }
// //
// //   void loginWithPhone() async {
// //     late LoginPhoneResponse response;
// //     PhoneLoginRequest request = PhoneLoginRequest(
// //         number: phoneController.text,
// //         password: passController.text,
// //         deviceToken: TokenString.deviceToken);
// //     print(request.tojson());
// //     response = await AuthApiHelper.loginPhone(request);
// //     if (response.responseCode == "1") {
// //       setTokenData(response.userId.toString(), context);
// //     }
// //     setState(() {
// //       buttonLogin = false;
// //     });
// //   }
// //
// //   void loginWithEmail(context) async {
// //     late LoginEmailResponse response;
// //     EmailLoginRequest request = EmailLoginRequest(
// //         email: emailController.text,
// //         password: passController.text,
// //         deviceToken: TokenString.deviceToken);
// //     print(request.tojson().toString());
// //     response = await AuthApiHelper.loginEmail(request);
// //     if (response.responseCode == "1") {
// //       setTokenData(response.userId.toString(), context);
// //     }
// //     setState(() {
// //       buttonLogin = false;
// //     });
// //   }
// //
// //   setTokenData(userid, context) async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     await prefs.setString(TokenString.userid, userid);
// //     Navigator.pushAndRemoveUntil(context,
// //         MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
// //   }
// // }
// //
// //
// //
//
//
//
// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:fixerking/api/api_path.dart';
// import 'package:fixerking/screen/signup.dart';
// import 'package:fixerking/screen/verify_otp.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:location/location.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../modal/New models/LoginModel.dart';
// import '../../utils/colors.dart';
//
//
// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//
//   final TextEditingController _mobileController = TextEditingController();
//
//   LocationData? locationData;
//   String _token = '';
//   dynamic loginType = 1;
//
//
//   @override
//   void initState() {
//     // getToken();
//     super.initState();
//     getToken();
//     getCurrentLocation().then((_) async {
//       setState(() {});
//     });
//   }
//
//
//   Future<LocationData?> getCurrentLocation() async {
//     print("getCurrentLocation");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
//       locationData = LocationData.fromMap({
//         "latitude": prefs.getDouble('currentLat'),
//         "longitude": prefs.getDouble('currentLon')
//       });
//     } else {
//       setCurrentLocation().then((value) {
//         if (prefs.containsKey('currentLat') &&
//             prefs.containsKey('currentLon')) {
//           locationData = LocationData.fromMap({
//             "latitude": prefs.getDouble('currentLat'),
//             "longitude": prefs.getDouble('currentLon')
//           });
//         }
//       });
//     }
//     return locationData;
//   }
//
//   getToken() {
//     FirebaseMessaging.instance.getToken().then((token) async {
//       _token = token!;
//       print(" checking token here ${_token}");
//     });
//   }
//
//   Future<LocationData?> setCurrentLocation() async {
//     var location = new Location();
//     location.requestService().then((value) async {
//       try {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         locationData = await location.getLocation();
//         await prefs.setDouble('currentLat', locationData!.latitude!);
//         await prefs.setDouble('currentLon', locationData!.longitude!);
//       } on PlatformException catch (e) {
//         if (e.code == 'PERMISSION_DENIED') {
//           print('Permission denied');
//         }
//       }
//     });
//     return locationData;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//       decoration: BoxDecoration(color: AppColor().colorBg2()),
//       child: Scaffold(
//
//         resizeToAvoidBottomInset: false,
//         backgroundColor: AppColor.PrimaryDark,
//         //   appBar: AppBar(
//         //       backgroundColor: appColorWhite,
//         //       elevation: 0,
//         //       title: Text(
//         //         "",
//         //         style: TextStyle(
//         //             fontSize: 20,
//         //             color: appColorBlack,
//         //             fontWeight: FontWeight.bold),
//         //       ),
//         //       centerTitle: true,
//         //       leading:  InkWell(
//         //       onTap: (){
//         // Navigator.of(context).pop();
//         // },
//         //   child: Container(
//         //     child: Icon(Icons.arrow_back_ios,color: backgroundblack,),
//         //   ),
//         // )
//         //   ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           // alignment: Alignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 40.0, bottom: 30, left: 20),
//               child: Text("Welcome",
//                 style: TextStyle(
//                     fontSize: 35,
//                     color: Colors.white),
//               ),
//             ),
//             _loginForm(context),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _loginForm(BuildContext context) {
//     return Expanded(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Center(
//           child: Container(
//             height: MediaQuery.of(context).size.height-120,
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width - 20,
//             decoration: BoxDecoration(
//                 color: AppColor().colorBg2(),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(30), topLeft: Radius.circular(30),)
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 applogo(),
//                 Container(height: 10.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Login",
//                       style: TextStyle(
//                           fontSize: 28,
//                           color: AppColor().colorTextPrimary(),
//                           // fontFamily: 'OpenSansBold',
//                           fontWeight: FontWeight.normal),
//                     ),
//                   ],
//                 ),
//
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 35),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.start,
//                 //     children: [
//                 //       Radio(
//                 //           value: 1,
//                 //           activeColor: backgroundblack,
//                 //           groupValue: loginType,
//                 //           onChanged: (value) {
//                 //             setState(() {
//                 //               loginType = value;
//                 //             });
//                 //           }),
//                 //       Text("Mobile"),
//                 //       Radio(
//                 //           value: 2,
//                 //           activeColor: backgroundblack,
//                 //           groupValue: loginType,
//                 //           onChanged: (value) {
//                 //             setState(() {
//                 //               loginType = value;
//                 //             });
//                 //           }),
//                 //       Text("Email"),
//                 //     ],
//                 //   ),
//                 // ),
//                 Container(height: 30.0),
//                 // loginType == 1 ?
//                 mobileLogin(),
//                 // emailType(),
//                 // Container(height: 15.0),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget mobileType(){
//   //   return Padding(
//   //     padding:  EdgeInsets.all(8.0),
//   //     child: Column(
//   //       children: [
//   //         _mobileTextfield(context),
//   //         Container(height: 30.0),
//   //         _loginButton(context),
//   //         Container(height: 30.0),
//   //         _dontHaveAnAccount(context),
//   //         Container(height: 30.0),
//   //         _createAccountButton(context)
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget mobileLogin() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 22),
//           child: TextFormField(
//             controller: _mobileController,
//             keyboardType: TextInputType.number,
//             maxLength: 10,
//             decoration: InputDecoration(
//               counterText: "",
//               // hintText: "Enter Mobile No.",
//               label: Text("Enter Mobile No.",
//                 style: TextStyle(color: Colors.black54),),
//               // prefixIcon: Icon(
//               //   Icons.call, color: AppColor().colorTextPrimary(),),
//               // border:
//               // InputBorder.none,
//               // OutlineInputBorder(
//               //     borderRadius: BorderRadius.circular(20),
//               //     borderSide: BorderSide(color: Colors.black12)
//               // ),
//               // focusedBorder: OutlineInputBorder(
//               //     borderRadius: BorderRadius.circular(20),
//               //     borderSide: BorderSide(color: Colors.black54)
//               // ),
//             ),
//           ),
//         ),
//
//         Container(height: 100.0),
//         // // _loginButton(context),
//         // Container(height: 50.0),
//         Button(),
//         SizedBox(
//           height: 13,
//         ),
//         _dontHaveAnAccount(context),
//         // Container(height: 55.0),
//         // _createAccountButton(context)
//       ],
//     );
//   }
//
//
//   // Widget emailType(){
//   //   return Column(
//   //     children: [
//   //       _emailTextfield(context),
//   //       // Container(height: 15.0),
//   //       // _passwordTextfield(context),
//   //       // Container(height: 20.0),
//   //       // _forgotPassword(),
//   //       Container(height: 30.0),
//   //       _loginButton(context),
//   //       Container(height: 30.0),
//   //       _dontHaveAnAccount(context),
//   //       Container(height: 30.0),
//   //       _createAccountButton(context)
//   //     ],
//   //   );
//   // }
//   //
//   // Widget _mobileTextfield(BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(left: 30, right: 30),
//   //     child: CustomtextField(
//   //       controller: _mobileController,
//   //       maxLength: 10,
//   //       labelText: "Mobile",
//   //       hintText: "Enter Mobile No",
//   //       keyboardType: TextInputType.phone,
//   //       textInputAction: TextInputAction.next,
//   //       prefixIcon: Icon(Icons.call, color: backgroundblack,),
//   //     ),
//   //   );
//   // }
//   //
//   // Widget _emailTextfield(BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(left: 30, right: 30),
//   //     child: CustomtextField(
//   //       controller: _emailController,
//   //       keyboardType: TextInputType.emailAddress,
//   //       maxLines: 1,
//   //       labelText: "Email",
//   //       hintText: "Enter Email",
//   //       textInputAction: TextInputAction.next,
//   //       prefixIcon: Icon(Icons.email),
//   //     ),
//   //   );
//   // }
//   //
//   // Widget _passwordTextfield(BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(left: 30, right: 30),
//   //     child: CustomtextField(
//   //       controller: _passwordController,
//   //       maxLines: 1,
//   //       labelText: "Password",
//   //       hintText: "Enter Password",
//   //       obscureText: !_obscureText,
//   //       textInputAction: TextInputAction.next,
//   //       prefixIcon: Icon(Icons.lock),
//   //       suffixIcon: IconButton(
//   //         icon: Icon(
//   //           _obscureText ? Icons.visibility : Icons.visibility_off,
//   //           color: Colors.grey,
//   //         ),
//   //         onPressed: () {
//   //           setState(() {
//   //             _obscureText = !_obscureText;
//   //           });
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }
//   //
//   // Widget _forgotPassword() {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(right: 40),
//   //     child: Align(
//   //       alignment: Alignment.topLeft,
//   //       child: GestureDetector(
//   //         onTap: () {
//   //           Navigator.push(
//   //             context,
//   //             MaterialPageRoute(builder: (context) => ForgetPass()),
//   //           );
//   //         },
//   //         child: Row(
//   //           mainAxisAlignment: MainAxisAlignment.end,
//   //           children: [
//   //             Container(
//   //               child: Text(
//   //                 "Forgot Password?",
//   //                 style: TextStyle(
//   //                   fontSize: 14,
//   //                   fontWeight: FontWeight.bold,
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   // Widget _loginButton(BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(left: 20, right: 20),
//   //     child: InkWell(
//   //       onTap: () async {
//   //         // if(loginType != 1){
//   //         //   _apiCall(context);
//   //         // } else {
//   //         if (_mobileController.text.isNotEmpty) {
//   //           LoginModel? model = await loginWithOtp();
//   //           if (model!.responseCode == "1") {
//   //             Fluttertoast.showToast(msg: model.message!);
//   //             Navigator.pushReplacement(
//   //               context, MaterialPageRoute(builder: (context) =>
//   //                 OtpScreen(
//   //                   otp: model.otp.toString(),
//   //                   email: _mobileController.text.toString(),
//   //                   // signUp: false,
//   //                 ),
//   //             ),
//   //             );
//   //             // }
//   //           }
//   //         }
//   //         else {
//   //           Fluttertoast.showToast(msg: "Enter valid mobile no.");
//   //         }
//   //       },
//   //       // },
//   //       child: SizedBox(
//   //           height: 45,
//   //           width: double.infinity,
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //                 color: AppColor().colorTextPrimary(),
//   //                 // gradient: new LinearGradient(
//   //                 //     colors: [
//   //                 //         backgroundblack,
//   //                 //         appColorGreen,
//   //                 //     ],
//   //                 //     begin: const FractionalOffset(0.0, 0.0),
//   //                 //     end: const FractionalOffset(1.0, 0.0),
//   //                 //     stops: [0.0, 1.0],
//   //                 //     tileMode: TileMode.clamp),
//   //                 border: Border.all(color: Colors.grey),
//   //                 borderRadius: BorderRadius.all(Radius.circular(15))),
//   //             height: 50.0,
//   //             // ignore: deprecated_member_use
//   //             child:
//   //             // child: loginType != 1 ? Center(
//   //             //   child: Stack(
//   //             //     children: [
//   //             //       Align(
//   //             //         alignment: Alignment.center,
//   //             //         child: Text(
//   //             //           "SIGN IN",
//   //             //           textAlign: TextAlign.center,
//   //             //           style: TextStyle(
//   //             //               color: appColorWhite,
//   //             //               fontWeight: FontWeight.bold,
//   //             //               fontSize: 15),
//   //             //         ),
//   //             //       ),
//   //             //     ],
//   //             //   ),
//   //             // )
//   //             // :
//   //             Center(
//   //               child: Stack(
//   //                 children: [
//   //                   Align(
//   //                     alignment: Alignment.center,
//   //                     child: Text(
//   //                       "Get OTP",
//   //                       textAlign: TextAlign.center,
//   //                       style: TextStyle(
//   //                         color: AppColor().colorBg2(),
//   //                         fontWeight: FontWeight.normal,
//   //                         fontSize: 15,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           )),
//   //     ),
//   //   );
//   // }
//
//   // Widget _createAccountButton(BuildContext context) {
//   //   return Padding(
//   //     padding: const EdgeInsets.only(left: 30, right: 30),
//   //     child: InkWell(
//   //       onTap: () {
//   //         Navigator.push(
//   //           context,
//   //           CupertinoPageRoute(
//   //             builder: (context) => SignUp(),
//   //           ),
//   //         );
//   //       },
//   //       child: SizedBox(
//   //           height: 60,
//   //           width: double.infinity,
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //                 color: appColorWhite,
//   //                 border: Border.all(color: Colors.grey),
//   //                 borderRadius: BorderRadius.all(Radius.circular(15))),
//   //             height: 50.0,
//   //             // ignore: deprecated_member_use
//   //             child: Center(
//   //               child: Stack(
//   //                 children: [
//   //                   Align(
//   //                     alignment: Alignment.center,
//   //                     child: Text(
//   //                       "Create an Account",
//   //                       textAlign: TextAlign.center,
//   //                       style: TextStyle(
//   //                           color: appColorBlack,
//   //                           fontWeight: FontWeight.bold,
//   //                           fontSize: 15),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           )),
//   //     ),
//   //   );
//   // }
//
//   Widget applogo() {
//     return Column(
//       children: [
//         Container(
//           height: 210,
//           width: MediaQuery
//               .of(context)
//               .size
//               .width - 140,
//           child: Image.asset(
//             'images/auth1.png',
//             fit: BoxFit.fill,
//           ),
//         ),
//         SizedBox(
//           height: 0,
//           child: Divider(
//             color: AppColor().colorTextPrimary(),
//             thickness: 2,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Button(){
//     return Container(
//       height: MediaQuery.of(context).size.height/16,
//       width: MediaQuery.of(context).size.width/1.2,
//       decoration: BoxDecoration(
//         color: AppColor().colorPrimary(),
//         borderRadius: BorderRadius.circular(20.0)
//       ),
//       child: Center(child:
//       InkWell(
//         onTap: () {
//           loginWithOtp();
//           // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//         },
//         child: Text("Get OTP",
//             style: TextStyle(color: AppColor().colorBg2(), fontSize: 18, fontWeight: FontWeight.w400)),
//       )),
//     );
//   }
//   Widget _dontHaveAnAccount(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text.rich(
//           TextSpan(
//             text: "Don\'t have an account?",
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal,
//                 color: AppColor().colorTextSecondary()
//             ),
//           ),
//         ),
//         // InkWell(
//         //   onTap: () {
//         //     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
//         //   },
//         //   child: Text("Sign Up",
//         //       style: TextStyle(
//         //           fontSize: 16,
//         //           color: AppColor.PrimaryDark, fontWeight: FontWeight.normal),   // TextButton(
//         //   //     onPressed: (){
//         //   //       Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpOtp()));
//         //   //     }, child: Text("Sign Up",
//         //   //   style: TextStyle(
//         //   //       color:  AppColor().colorTextPrimary(),
//         //   //       fontSize: 14,
//         //   //       fontWeight: FontWeight.w600
//         //   //   ),))
//         //   ),
//         // )
//         TextButton(onPressed: (){
//           Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
//         }, child: Text(
//           "Sign Up",
//           style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.normal,
//               color: AppColor().colorPrimary()
//           ),
//         ))
//       ],
//     );
//   }
//
//
//
//   Future<LoginModel?> loginWithOtp() async {
//     var request = http.MultipartRequest('POST', Uri.parse('${Apipath.sendOtpUrl}'));
//     request.fields.addAll({
//       'mobile': '${_mobileController.text}',
//       'device_token': '$_token'
//     });
//
//     http.StreamedResponse response = await request.send();
//
//     print(request);
//     print(request.fields);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       var results = LoginModel.fromJson(json.decode(str));
//       print("checking result here ${results.message}");
//       String? msg;
//       msg = results.message;
//       String otp = results.otp.toString();
//       if(results.responseCode =="1"){
//         Fluttertoast.showToast(msg:"${results.message}");
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VerifyOtp(signUp: false, otp: otp.toString(),
//           email: _mobileController.text.toString(),)));
//       } else{
//         Fluttertoast.showToast(msg:"${results.message}");
//       }
//
//       return LoginModel.fromJson(json.decode(str));
//     }
//     else {
//       return null;
//     }
//   }
// }
//
