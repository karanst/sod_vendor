import 'dart:convert';

import 'package:fixerking/api/api_helper/ApiList.dart';
import 'package:fixerking/modal/New%20models/VerifyUserModel.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../token/token_string.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/widget.dart';

class OtpScreen extends StatefulWidget {
  final String? otp;
  final String? mobile;
  OtpScreen({this.otp,this.mobile, required String email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OtpFieldController otpController = OtpFieldController();
  String? userid;
  String? enteredOtp;
  verifyUser()async{
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(context: context, builder: (context){
      return CustomLoader(text: "Verifying user, please wait...",);
    });
    var response = await http.post(Uri.parse(VerifyUser),body: {"mobile":"${widget.mobile}","otp": widget.otp});
    print("response of  verify user ${response.body}");
    var finalStr = VerifyUserModel.fromJson(json.decode(response.body));
    String? msg = VerifyUserModel.fromJson(json.decode(response.body)).message;
    if(finalStr.status == "success"){
      setState(() {
        userid = finalStr.userId;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(TokenString.userid, userid!);
      // prefs.setString("vendorId", "${userid}");
      // String? uid = prefs.getString("vendorId");
      // print("checking vendor id here ${uid}");
      Navigator.of(context).pop();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
    }
    else{
      Navigator.of(context).pop();
     const snackBar = SnackBar(
        content: Text('Invalid otp') ,
      );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("okkk ${widget.mobile}");
    return Scaffold(
      backgroundColor: AppColor().colorBg2(),
      body: SafeArea(
        child:SingleChildScrollView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            width: 100.w,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.5),
                colors: [
                  AppColor().colorBg1(),
                  AppColor().colorBg2(),
                ],
                radius: 0.8,
              ),
            ),
            padding: MediaQuery.of(context).viewInsets,
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 24.65.h,
                  width: 100.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColor.PrimaryDark,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18),bottomRight: Radius.circular(18))
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 3.08.h,
                        ),
                        // appLogo(),
                        text(
                          "Verify OTP",
                          textColor: Color(0xffffffff),
                          fontSize: 22.sp,
                          fontFamily: fontMedium,
                        ),
                        SizedBox(
                          height: 3.08.h,
                        ),
                        text(
                          "OTP : ${widget.otp}",
                          textColor: Color(0xffffffff),
                          fontSize: 18.sp,
                          fontFamily: fontMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                  margin: EdgeInsets.only(top: 20.h,left: 25,right: 25),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10,bottom: 20),
                      //   child: Text("Verify OTP",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 10,bottom: 20),
                        child: Text("We have send you a code of 4 digit on your email ",textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey ,fontSize: 14,fontWeight: FontWeight.w400),),
                      ),
                      OTPTextField(
                        controller: otpController,
                        length: 4,
                        keyboardType: TextInputType.number,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceEvenly,
                        fieldWidth: 50,
                        contentPadding: EdgeInsets.all(11),
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 15,
                        otpFieldStyle: OtpFieldStyle(
                            backgroundColor: Color(0xffFFFFFF),
                            disabledBorderColor: Colors.white
                        ),
                        style: TextStyle(fontSize: 17, height: 2.2),
                        onChanged: (pin) {
                          print("checking pin here ${pin}");
                        },
                        onCompleted: (pin) {
                          if (pin.isNotEmpty && pin.length == 4) {
                            setState(() {
                              enteredOtp = pin;
                            });
                          } else {

                          }
                        },
                      ),
                      // Container(
                      //     height: 55,
                      //     decoration: BoxDecoration(
                      //         color: Color(0xffF9F9F9),
                      //         borderRadius: BorderRadius.circular(12)
                      //     ),
                      //     child: TextFormField(
                      //       controller: phoneController,
                      //       decoration: InputDecoration(
                      //         contentPadding: EdgeInsets.only(left: 10),
                      //         hintText: "Phone Number",
                      //         hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,),
                      //         border: InputBorder.none,
                      //       ),
                      //       keyboardType: TextInputType.number,
                      //     )),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          if(widget.otp == enteredOtp){
                            verifyUser();
                          } else {
                            UtilityHlepar.getToast("Please Enter Correct OTP");
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width/2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColor.PrimaryDark,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("Verify OTP",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),),
                      ),
                      SizedBox(height: 10,),
                      Text("Resend Otp",style: TextStyle(decoration: TextDecoration.underline),),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                // Text("${widget.otp}")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
