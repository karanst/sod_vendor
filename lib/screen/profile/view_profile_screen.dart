import 'package:animated_widgets/animated_widgets.dart';
import 'package:fixerking/modal/response/get_profile_response.dart';
import 'package:fixerking/screen/profile/edit_profile_screen.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/common.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/widget.dart';

class ViewProfileScreen extends StatefulWidget {
  late GetProfileResponse response;

  ViewProfileScreen({Key? key, required this.response}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool status = false;
  bool selected = false, enabled = false, edit1 = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorBg1(),
      body: SafeArea(
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
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(top: 18.h),
                  width: 99.33.w,
                  height: 72.05.h,
                  child: firstSign(context),
                ),
                Container(
                  height: 17.89.h,
                  width: 100.w,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 3.h),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(signUpBg),
                    fit: BoxFit.fill,
                  )),
                  child: Row(
                    children: [
                      Container(
                          width: 6.38.w,
                          height: 6.38.w,
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 7.91.w),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                back,
                                height: 4.0.h,
                                width: 8.w,
                              ))),
                      SizedBox(
                        width: 2.08.h,
                      ),
                      Container(
                        width: 65.w,
                        child: text("My Profile",
                            textColor: Color(0xffffffff),
                            fontSize: 14.sp,
                            fontFamily: fontMedium,
                            isCentered: true),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10.49.h,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipOval(
                        child: Container(
                          height: 14.66.h,
                          width: 14.66.h,
                          child: UtilityHlepar.convertetIMG(
                              // widget.response.path! +
                                  widget.response.user!.profileImage!,
                              fit: BoxFit.cover),
                          // child: Image(
                          //   image: AssetImage(editProfile),
                          //   fit: BoxFit.cover,
                          //   height: 14.66.h,
                          //   width: 14.66.h,
                          // ),
                        ),
                      ),
                      // Container(
                      //   height: 4.39.h,
                      //   width: 4.39.h,
                      //   margin: EdgeInsets.only(right: 5.w, bottom: 1.h),
                      //   decoration: boxDecoration(
                      //       radius: 100, bgColor: AppColor().colorPrimary()),
                      //   child: Center(
                      //     child: Image.asset(
                      //       edit,
                      //       height: 2.26.h,
                      //       width: 2.26.h,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget firstSign(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 9.92.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "User Name",
                textColor: Color(0xff8A8787),
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                widget.response.user!.uname.toString(),
                textColor: Color(0xff202442),
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.02.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Email",
                textColor: Color(0xff8A8787),
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                widget.response.user!.email.toString(),
                textColor: Color(0xff202442),
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.02.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Mobile Number",
                textColor: Color(0xff8A8787),
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "+91 " + widget.response.user!.mobile.toString(),
                textColor: Color(0xff202442),
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Password",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         "000000000",
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 3.02.h,
        ),
        /*Container(
          margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Aadhar Card No.",
                textColor: Color(0xff8A8787),
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                widget.response.data!.aadharCardNo.toString(),
                textColor: Color(0xff202442),
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3.02.h,
        ),*/
        Container(
          margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Permanent Address",
                textColor: Color(0xff8A8787),
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              Container(
                width: 33.88.w,
                child: text(widget.response.user!.address.toString(),
                    textColor: Color(0xff202442),
                    fontSize: 10.sp,
                    isEnd: true,
                    fontFamily: fontBold,
                    maxLine: 3),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Website",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.website.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Twitter",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.tLink.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Instagram",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.iLink.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 3.02.h,
        ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "LinkedIn",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.lLink.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Why Antsnest",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.joinAntsnest.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Equipment",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.equipments.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Birthday",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.birthday.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 3.02.h,
        // ),
        // Container(
        //   margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w, bottom: 1.87.h),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       text(
        //         "Language",
        //         textColor: Color(0xff8A8787),
        //         fontSize: 10.sp,
        //         fontFamily: fontRegular,
        //       ),
        //       text(
        //         widget.response.user!.jsonData!.language.toString(),
        //         textColor: Color(0xff202442),
        //         fontSize: 10.sp,
        //         fontFamily: fontBold,
        //       ),
        //     ],
        //   ),
        // ),
        Center(
          child: Container(
            child: InkWell(
              onTap: () async {
                setState(() {
                  enabled = true;
                  selected = true;
                });
                await Future.delayed(Duration(milliseconds: 200));
                setState(() {
                  enabled = false;
                });
                await Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: EditProfileScreen(
                        response: widget.response,
                      ),
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 500),
                    ));
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
                      radius: 15.0, bgColor: AppColor().colorPrimaryDark()),
                  child: Center(
                    child: text(
                      "Edit Profile",
                      textColor: Color(0xffffffff),
                      fontSize: 14.sp,
                      fontFamily: fontRegular,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1.46.h,
        ),
      ],
    );
  }
}
