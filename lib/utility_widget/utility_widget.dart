import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UtilityWidget {
  static AnimatedContainer lodingButton({required buttonLogin, btntext}) {
    return AnimatedContainer(
      width: buttonLogin ? 40.0.w : 69.99.w,
      height: buttonLogin ? 8.0.h : 6.46.h,
      decoration:
          boxDecoration(radius: 15.0, bgColor: AppColor.PrimaryDark),
      duration: Duration(microseconds: 750),
      curve: Curves.bounceOut,
      child: Center(
        child: buttonLogin
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : text(
                btntext ?? "",
                textColor: Color(0xffffffff),
                fontSize: 14.sp,
                fontFamily: fontRegular,
              ),
      ),
    );
  }
}
