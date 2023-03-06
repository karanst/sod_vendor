import 'dart:convert';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:fixerking/api/api_helper/auth_helper.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/request/forgot_password.dart';
import 'package:fixerking/modal/response/forgot_password_response.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utility_widget/utility_widget.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/validation/form_validation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/common.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:http/http.dart' as http;

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController emailController = new TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  bool status = false;
  bool selected = false, enabled = false, edit = false;
  bool buttonLogin = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    changePage();
  }

  changePage() async {
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      status = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  int? newPass;

  Future forgetPasswordRequest() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.forgetPassUrl}'));
    request.fields.addAll({'email': '${emailController.text.toString()}'
      // '${userId.toString()}'
    });
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var data  = ForgetPassModel.fromJson(jsonDecode(str));
      Fluttertoast.showToast(msg: data.msg.toString());
      setState((){
        newPass = data.newPass;
      });

    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
          color: AppColor.PrimaryDark,),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AnimatedContainer(
              //   duration: Duration(milliseconds: 500),
              //   curve: Curves.easeInOut,
              //   margin: EdgeInsets.only(top: 16.h, bottom: 30),
              //   // width: 83.33.w,
              //   height: 50.96.h,
              //   decoration: boxDecoration(
              //       radius: 50.0, bgColor: Color(0xffffffff)),
              //   child: firstSign(context),
              // ),
              firstSign(context),
              AppBtn(
                label: "Submit",
              onPress: (){

                  forgetPasswordRequest();
                  setState(() {
                    buttonLogin = true;
                  });

                // }
              },),
              newPass ==""|| newPass ==null ?
                  SizedBox.shrink()
            :   Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text("Your new password is : ${newPass.toString()}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: AppColor().colorPrimary()
                ),),
              ),

            ],
          ),
        ),
      )
    );
  }

  Widget firstSign(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.32.h,
        ),
        Center(
          child: Container(
            height: 220,
            // wi dth: ,
            child: Image.asset(
              forgetIcon,
            ),
          ),
        ),
        Center(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              child: text(
                  "Forget Password?",
                  textColor: AppColor().colorTextPrimary(),
                  fontSize: 24.sp,
                  fontFamily: fontRegular,
                  isCentered: true,
                  maxLine: 3)),
        ),
        Center(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              child: text(
                  "Enter the Email associated with your account",
                  textColor: AppColor().colorTextSecondary(),
                  fontSize: 14.sp,
                  fontFamily: fontRegular,
                  isCentered: true,
                  maxLine: 3)),
        ),
        SizedBox(
          height: 1.87.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 8),
          child: Text("Enter Email"),
        ),
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColor().colorTextSecondary()
                    )
                  ),
                  // width: 69.99.w,
                  height: 50,
                  child: TextFormField(
                    cursorColor: Colors.red,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: FormValidation.emailVeledetion,
                    controller: emailController,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 14,
                    ),
                    inputFormatters: [],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                       border: InputBorder.none
                    )
                    // InputDecoration(
                    //   focusedBorder: UnderlineInputBorder(
                    //     borderSide: BorderSide(
                    //         color: AppColor().colorEdit(),
                    //         width: 1.0,
                    //         style: BorderStyle.solid),
                    //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //   ),
                    //   // labelText: 'Email',
                    //   labelStyle: TextStyle(
                    //     color: AppColor().colorTextFour(),
                    //     fontSize: 10.sp,
                    //   ),
                    //   helperText: '',
                    //   counterText: '',
                    //   fillColor: AppColor().colorEdit(),
                    //   // enabled: true,
                    //   // filled: true,
                    //   // prefixIcon: Padding(
                    //   //   padding: EdgeInsets.all(3.5.w),
                    //   //   child: Image.asset(
                    //   //     email,
                    //   //     width: 2.04.w,
                    //   //     height: 2.04.w,
                    //   //     fit: BoxFit.fill,
                    //   //   ),
                    //   // ),
                    //   suffixIcon: emailController.text.length == 10
                    //       ? Container(
                    //           width: 10.w,
                    //           alignment: Alignment.center,
                    //           child: FaIcon(
                    //             FontAwesomeIcons.check,
                    //             color: AppColor().colorPrimary(),
                    //             size: 10.sp,
                    //           ))
                    //       : SizedBox(),
                    //   enabledBorder: UnderlineInputBorder(
                    //     borderSide: BorderSide(
                    //         color: AppColor().colorEdit(), width: 5.0),
                    //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //   ),
                    // ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.96.h,
        ),
      ],
    );
  }



}

class ForgetPassModel {
  int? status;
  String? msg;
  int? newPass;

  ForgetPassModel({this.status, this.msg, this.newPass});

  ForgetPassModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    newPass = json['new_pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['new_pass'] = this.newPass;
    return data;
  }
}