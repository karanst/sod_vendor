// import 'dart:convert';
//
// import 'package:fixerking/api/api_path.dart';
// import 'package:fixerking/modal/LoginWithOtpModel.dart';
// import 'package:fixerking/modal/New%20models/VerifyUserModel.dart';
// import 'package:fixerking/modal/verifyOtpModel.dart';
// import 'package:fixerking/screen/bottom_bar.dart';
// import 'package:fixerking/token/token_string.dart';
// import 'package:fixerking/utility_widget/customLoader.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class VerifyOtp extends StatefulWidget {
//   final String? otp, mobile;
//    // final bool signUp;
//    VerifyOtp({Key? key, this.otp, this.mobile}) : super(key: key);
//
//   @override
//   State<VerifyOtp> createState() => _VerifyOtpState();
// }
//
// class _VerifyOtpState extends State<VerifyOtp> {
//   var apiOtp;
//   var inputOtp;
//   // ProgressDialog? pr;
//
//   @override
//   void initState() {
//     // apiOtp = widget.otp.toString();
//     super.initState();
//   }
//
//   String? resendOtp;
//
//   Future<LoginWithOtpModel?> loginWithOtp() async {
//     var request = http.MultipartRequest('POST', Uri.parse('${Apipath.sendOtpUrl}'));
//     request.fields.addAll({
//       'mobile': '${widget.mobile}',
//       'device_token': ''
//     });
//
//     http.StreamedResponse response = await request.send();
//
//     print(request);
//     print(request.fields);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       var results = LoginWithOtpModel.fromJson(json.decode(str));
//       print("checking result here ${results.message} and ${results.otp}");
//
//     setState(() {
//       resendOtp = results.otp.toString();
//     });
//
//       // return LoginWithOtpModel.fromJson(json.decode(str));
//     }
//     else {
//       print("checking fail response ${response.statusCode}");
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       // appBar: AppBar(
//       //   backgroundColor: AppColor().colorBg1(),
//       //   elevation: 0,
//       //   automaticallyImplyLeading: false,
//       //   centerTitle: true,
//       //   title: Text("Verification",style: TextStyle(color: AppColor().colorPrimary()),),
//       //   leading: InkWell(
//       //     onTap: (){
//       //       Navigator.of(context).pop();
//       //     },
//       //     child: Container(
//       //       child: Icon(Icons.arrow_back_ios,color: AppColor().colorPrimary(),),
//       //     ),
//       //   ),
//       // ),
//       backgroundColor: AppColor().colorPrimary(),
//       body: SafeArea(
//         child:  Padding(
//           padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0, bottom: 0 ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 0.0, ),
//                 child: InkWell(
//                     onTap: (){
//                       Navigator.pop(context);
//                     },
//                     child: Icon(Icons.arrow_back_ios,color: AppColor().colorBg1(),)),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height-70,
//                 decoration: BoxDecoration(
//                   color: AppColor().colorBg1(),
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),),
//                 ),
//                 child: Column(
//                   // crossAxisAlignment: CrossAxisAlignment.s,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: Text("Verification",
//                         style: TextStyle(
//                           color: AppColor().colorPrimary(),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24
//                         ),),
//                     ),
//                     // Row(
//                     //   children: [
//                     //     Padding(
//                     //       padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
//                     //       child: CircleAvatar(
//                     //         backgroundColor: Colors.white,
//                     //         child: IconButton(
//                     //           onPressed: () {
//                     //             Navigator.pop(context);
//                     //           },
//                     //           icon: Icon(Icons.arrow_back_outlined),
//                     //           color: Colors.black,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//
//                     // CircleAvatar(
//                     //   backgroundColor: Colors.white,
//                     //   radius: 60,
//                     //   child: Image(
//                     //     image: AssetImage("assets/images/ez_logo.png"),
//                     //     fit: BoxFit.fill,
//                     //   ),
//                     // ),
//                     // SizedBox(
//                     //   height: MediaQuery.of(context).size.height * 0.02,
//                     // ),
//                     Text(
//                       "Enter Your 4 Digit Code" + "\n " + "${widget.otp}",
//                        //   "${resendOtp == null ? apiOtp : resendOtp}",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           color: AppColor().colorPrimary(),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16),
//                     ),
//                     // SizedBox(
//                     //   height: height * 0.02,
//                     // ),
//                     Text(
//                       "Don't share it with any other",
//                       style: TextStyle(
//                           color: Color(0xff767676),
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14),
//                     ),
//                     SizedBox(
//                       height: height * 0.04,
//                     ),
//                     SizedBox(
//                       width: width * 0.8,
//                       child: OTPTextField(
//                         length: 4,
//                         width: MediaQuery.of(context).size.width,
//                         fieldWidth: 60,
//                         style: TextStyle(fontSize: 17),
//                         textFieldAlignment: MainAxisAlignment.spaceAround,
//                         fieldStyle: FieldStyle.box,
//                         onCompleted: (pin) {
//                           setState(() {
//                             inputOtp = pin;
//                           });
//                           print("Completed: " + pin);
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: height * 0.04,
//                     ),
//                     // Text(
//                     //   "Enter 4 Digit OTP number Sent to your Email",
//                     //   style: TextStyle(
//                     //       color: Color(0xff767676),
//                     //       fontWeight: FontWeight.w500,
//                     //       fontSize: 14),
//                     // ),
//
//                     // SizedBox(
//                     //   height: height * 0.04,
//                     // ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12, right: 12),
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: AppColor().colorPrimary(),
//                           onPrimary: Colors.white,
//                           shadowColor: Colors.white,
//                           elevation: 3,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0)),
//                           minimumSize: Size(310, 45), //////// HERE
//                         ),
//                         onPressed: () {
//                           verifyUser();
//                           // if(widget.otp == inputOtp && inputOtp.length == 4) {
//                           //   varifyOTP();
//                           // }
//                           // else{
//                           //   Fluttertoast.showToast(msg: "Enter valid otp");
//                           // }
//                         },
//                         child: Text(
//                           'Submit',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w300, fontSize: 16),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 60.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                           "Didn't received verification code? ",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 14),
//                           textAlign: TextAlign.center,
//                         ),
//                           TextButton(
//                             onPressed: (){
//                               loginWithOtp();
//                             },
//                             child: Text(
//                               "Resend",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: AppColor().colorPrimary(),
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15),
//                             ),
//                           ),],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//         // Stack(
//         //   children: [
//         //     // CustomScrollView(
//         //     //   scrollDirection: Axis.vertical,
//         //     //   shrinkWrap: true,
//         //     // ),
//         //     /*Container(
//         //       height: double.infinity,
//         //       width: double.infinity,
//         //       child: Column(
//         //         children: [
//         //           Container(
//         //             height: height * 0.3,
//         //             child: Image.asset(
//         //               "assets/images/loginappbar.png",
//         //               fit: BoxFit.fill,
//         //             ),
//         //           )
//         //         ],
//         //       ),
//         //     ),*/
//         //     ListView(
//         //       shrinkWrap: true,
//         //       physics: ClampingScrollPhysics(),
//         //       children: [
//         //         Column(
//         //           children: [
//         //             Row(
//         //               children: [
//         //                 Padding(
//         //                   padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
//         //                   child: CircleAvatar(
//         //                     backgroundColor: Colors.white,
//         //                     child: IconButton(
//         //                       onPressed: () {
//         //                         Navigator.pop(context);
//         //                       },
//         //                       icon: Icon(Icons.arrow_back_outlined),
//         //                       color: Colors.black,
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //
//         //             CircleAvatar(
//         //               backgroundColor: Colors.white,
//         //               radius: 60,
//         //               child: Image(
//         //                 image: AssetImage("assets/images/ez_logo.png"),
//         //                 fit: BoxFit.fill,
//         //               ),
//         //             ),
//         //             SizedBox(
//         //               height: MediaQuery.of(context).size.height * 0.02,
//         //             ),
//         //             Text(
//         //               "ENTER YOUR 4 DIGIT CODE" + "\nOTP ${resendOtp == null ? apiOtp : resendOtp}",
//         //               textAlign: TextAlign.center,
//         //               style: TextStyle(
//         //                   color: Colors.black,
//         //                   fontWeight: FontWeight.w600,
//         //                   fontSize: 20),
//         //             ),
//         //             SizedBox(
//         //               height: height * 0.02,
//         //             ),
//         //             Text(
//         //               "Don't share it with any other",
//         //               style: TextStyle(
//         //                   color: Color(0xff767676),
//         //                   fontWeight: FontWeight.w500,
//         //                   fontSize: 14),
//         //             ),
//         //             SizedBox(
//         //               height: height * 0.04,
//         //             ),
//         //             SizedBox(
//         //               width: width * 0.8,
//         //               child: OTPTextField(
//         //                 length: 4,
//         //                 width: MediaQuery.of(context).size.width,
//         //                 fieldWidth: 60,
//         //                 style: TextStyle(fontSize: 17),
//         //                 textFieldAlignment: MainAxisAlignment.spaceAround,
//         //                 fieldStyle: FieldStyle.box,
//         //                 onCompleted: (pin) {
//         //                   setState(() {
//         //                     inputOtp = pin;
//         //                   });
//         //                   print("Completed: " + pin);
//         //                 },
//         //               ),
//         //             ),
//         //             SizedBox(
//         //               height: height * 0.01,
//         //             ),
//         //             Text(
//         //               "Enter 4 Digit OTP number Sent to your Email",
//         //               style: TextStyle(
//         //                   color: Color(0xff767676),
//         //                   fontWeight: FontWeight.w500,
//         //                   fontSize: 14),
//         //             ),
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.center,
//         //               children: [
//         //                 Text(
//         //                   "Didn't Got Code? ",
//         //                   style: TextStyle(
//         //                       color: Colors.black,
//         //                       fontWeight: FontWeight.w600,
//         //                       fontSize: 14),
//         //                 ),
//         //                 TextButton(
//         //                   onPressed: (){
//         //                     loginWithOtp();
//         //                   },
//         //                   child: Text(
//         //                     "Resend",
//         //                     style: TextStyle(
//         //                         color: Color(0xffF4B71E),
//         //                         fontWeight: FontWeight.w600,
//         //                         fontSize: 15),
//         //                   ),
//         //                 )
//         //               ],
//         //             ),
//         //             SizedBox(
//         //               height: height * 0.04,
//         //             ),
//         //             ElevatedButton(
//         //               style: ElevatedButton.styleFrom(
//         //                 primary: AppColor().colorPrimary(),
//         //                 onPrimary: Colors.white,
//         //                 shadowColor: Colors.white,
//         //                 elevation: 3,
//         //                 shape: RoundedRectangleBorder(
//         //                     borderRadius: BorderRadius.circular(8.0)),
//         //                 minimumSize: Size(310, 50), //////// HERE
//         //               ),
//         //               onPressed: () => varifyOTP(),
//         //               child: Text(
//         //                 'Submit',
//         //                 style: TextStyle(
//         //                     fontWeight: FontWeight.w300, fontSize: 20),
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ],
//         //     )
//         //   ],
//         // ),
//       ),
//     );
//   }
//   String? userid;
//   verifyUser()async{
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     showDialog(context: context, builder: (context){
//       return CustomLoader(text: "Verifying user, please wait...",);
//     });
//     var response = await http.post(Uri.parse('${Apipath.verifyOtpUrl}'),
//         body: {"mobile":"${widget.mobile}","otp": widget.otp});
//     print("response of  verify user ${response.body}");
//     var finalStr = VerifyUserModel.fromJson(json.decode(response.body));
//     // String? msg = VerifyUserModel.fromJson(json.decode(response.body)).message;
//     if(finalStr.status == "success"){
//       setState(() {
//         userid = finalStr.userId;
//       });
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString(TokenString.userid, userid!);
//       // prefs.setString("vendorId", "${userid}");
//       // String? uid = prefs.getString("vendorId");
//       // print("checking vendor id here ${uid}");
//       Navigator.of(context).pop();
//       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
//     }
//     else{
//       Navigator.of(context).pop();
//       const snackBar = SnackBar(
//         content: Text('Invalid otp') ,
//       );
//
// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }
//   Future varifyOTP() async {
//
//     var request = http.MultipartRequest('POST', Uri.parse('${Apipath.verifyOtpUrl}'));
//     request.fields.addAll({
//       'mobile': '${widget.mobile}',
//       'otp': '$inputOtp'
//     });
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = VerifyOtpModel.fromJson(json.decode(str));
//       if(jsonResponse.responseCode == "1"){
//         String userResponseStr = json.encode(jsonResponse);
//         SharedPreferences preferences =
//         await SharedPreferences.getInstance();
//         preferences.setString(
//             SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
//         // Loader().hideIndicator(context);
//         // loginBloc.dispose();
//         // pr!.hide();
//         // if(widget.signUp == true){
//         //   Fluttertoast.showToast(msg: "Otp Verified Successfully");
//         //   Navigator.of(context).pushAndRemoveUntil(
//         //     MaterialPageRoute(
//         //       builder: (context) => SignUp(),
//         //     ),
//         //         (Route<dynamic> route) => false,
//         //   );
//         // }else{
//           Fluttertoast.showToast(msg: "User Login Successfully");
//           Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(
//               builder: (context) => BottomBar(),
//             ),
//                 (Route<dynamic> route) => false,
//           );
//         // }
//       }
//       return VerifyOtpModel.fromJson(json.decode(str));
//     }
//     else {
//     print(response.reasonPhrase);
//     }
//
//   }
// }
// class SharedPreferencesKey {
//   static const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";
//   static const String LOGGED_IN_USERRDATA = "LOGGED_IN_USERRDATA";
// }