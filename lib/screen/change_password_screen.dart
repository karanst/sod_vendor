import 'package:animated_widgets/animated_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fixerking/api/api_helper/auth_helper.dart';
import 'package:fixerking/fast_splash.dart';
import 'package:fixerking/modal/request/change_password_request.dart';
import 'package:fixerking/modal/response/change_password_response.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utility_widget/utility_widget.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/showDialog.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:fixerking/validation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ChangeScreen extends StatefulWidget {
  const ChangeScreen({Key? key}) : super(key: key);

  @override
  _ChangeScreenState createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  bool selected = false, enabled = false, edit = false;
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController cnewPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorPrimary());
    return Scaffold(
      backgroundColor: AppColor().colorBg1(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Change Password"),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              width: 100.w,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.0, -0.5),
                  colors: [
                    AppColor().colorBg1(),
                    AppColor().colorBg1(),
                  ],
                  radius: 0.8,
                ),
              ),
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                children: [
                  // Container(
                  //   height: 9.92.h,
                  //   width: 100.w,
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //     image: AssetImage(profileBg),
                  //     fit: BoxFit.fill,
                  //   )),
                  //   child: Center(
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //             width: 6.38.w,
                  //             height: 6.38.w,
                  //             alignment: Alignment.centerLeft,
                  //             margin: EdgeInsets.only(left: 7.91.w),
                  //             child: InkWell(
                  //                 onTap: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //                 child: Image.asset(
                  //                   back,
                  //                   height: 4.0.h,
                  //                   width: 8.w,
                  //                 ))),
                  //         SizedBox(
                  //           width: 2.08.h,
                  //         ),
                  //         Container(
                  //           width: 65.w,
                  //           child: text(
                  //             "Change Password",
                  //             textColor: Color(0xffffffff),
                  //             fontSize: 14.sp,
                  //             fontFamily: fontMedium,
                  //             isCentered: true,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 1.52.h,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.52.h,
                        ),
                        Container(
                          width: 83.33.w,
                          // height: 6.79.h,
                          decoration: boxDecoration(
                            showShadow: true,
                            radius: 20.0,
                            bgColor: AppColor().colorBg1(),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.red,
                            keyboardType: TextInputType.text,
                            // obscureText: true,
                            controller: oldPassword,
                            validator: FormValidation.checkEmptyValidator,
                            style: TextStyle(
                              color: AppColor().colorTextFour(),
                              fontSize: 10.sp,
                            ),
                            inputFormatters: [],
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor().colorEdit(),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              labelText: 'Enter Your Old Password',
                              labelStyle: TextStyle(
                                color: AppColor().colorTextFour(),
                                fontSize: 10.sp,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  lock,
                                  width: 2.04.w,
                                  height: 2.04.w,
                                  color: AppColor.PrimaryDark,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              fillColor: AppColor().colorBg1(),
                              enabled: true,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor().colorBg1(), width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.52.h,
                        ),
                        Container(
                          width: 83.33.w,
                          // height: 6.79.h,
                          decoration: boxDecoration(
                            showShadow: true,
                            radius: 20.0,
                            bgColor: AppColor().colorBg1(),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.red,
                            keyboardType: TextInputType.text,
                            // obscureText: true,
                            controller: newPassword,
                            validator: FormValidation.checkEmptyValidator,
                            style: TextStyle(
                              color: AppColor().colorTextFour(),
                              fontSize: 10.sp,
                            ),
                            inputFormatters: [],
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor().colorEdit(),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              labelText: 'Enter New Password',
                              labelStyle: TextStyle(
                                color: AppColor().colorTextFour(),
                                fontSize: 10.sp,
                              ),
                              fillColor: AppColor().colorBg1(),
                              enabled: true,
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  lock,
                                  width: 2.04.w,
                                  height: 2.04.w,
                                  color: AppColor.PrimaryDark,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor().colorBg1(), width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.52.h,
                        ),
                        // Container(
                        //   width: 83.33.w,
                        //   height: 6.79.h,

                        //   child:text(
                        //     "Your New Password must be Different From Your Previous Passwords.",
                        //     textColor: Color(0xffFD531F),
                        //     fontSize: 10.sp,
                        //     fontFamily: fontSemibold,
                        //     maxLine: 2
                        //   ) ,
                        // ),
                        SizedBox(
                          height: 1.52.h,
                        ),
                        Container(
                          width: 83.33.w,
                          // height: 6.79.h,
                          decoration: boxDecoration(
                            showShadow: true,
                            radius: 20.0,
                            bgColor: AppColor().colorBg1(),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.red,
                            keyboardType: TextInputType.text,
                            // obscureText: true,
                            controller: cnewPassword,
                            validator: FormValidation.checkEmptyValidator,
                            // controller: emailController,
                            style: TextStyle(
                              color: AppColor().colorTextFour(),
                              fontSize: 10.sp,
                            ),
                            inputFormatters: [],
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor().colorEdit(),
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              labelText: 'Confirm New Password',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.asset(
                                  lock,
                                  width: 2.04.w,
                                  height: 2.04.w,
                                  color:AppColor.PrimaryDark,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: AppColor().colorTextFour(),
                                fontSize: 10.sp,
                              ),
                              fillColor: AppColor().colorBg1(),
                              enabled: true,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor().colorBg1(), width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.02.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          validatPassword();
                        }
                        // setState(() {
                        //   enabled = true;
                        // });
                        // await Future.delayed(Duration(milliseconds: 200));
                        // setState(() {
                        //   enabled = false;
                        // });
                        // Navigator.pop(context);
                        //    Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500),));
                      },
                      child: ScaleAnimatedWidget.tween(
                        enabled: enabled,
                        duration: Duration(milliseconds: 200),
                        scaleDisabled: 1.0,
                        scaleEnabled: 0.9,
                        child: Container(
                          width: 69.99.w,
                          height: 6.46.h,
                          decoration: boxDecoration(
                              radius: 15.0,
                              bgColor: AppColor.PrimaryDark),
                          child: Center(
                            child: text(
                              "Save",
                              textColor: Color(0xffffffff),
                              fontSize: 14.sp,
                              fontFamily: fontRegular,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.02.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  late ChangePasswordResponse response;
  void changeMyPassword() async {
    MYDialog.loadingDialog(context);
    var userId = await MyToken.getUserID();
    ChangePasswordRequest request = ChangePasswordRequest(
        userId: userId,
        password: oldPassword.text,
        newPassword: newPassword.text);
    response = await AuthApiHelper.changePassword(request);
    Navigator.pop(context);
    UtilityHlepar.getToast(response.message);
    if (response.responseCode == ToastString.responseCode) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Fastsplash()),
          (route) => false);
    }
  }

  validatPassword() {
    if (cnewPassword.text == newPassword.text) {
      changeMyPassword();
    } else {
      UtilityHlepar.getToast(ToastString.msgpConfomPassword);
    }
  }
}
