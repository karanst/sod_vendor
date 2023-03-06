import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  //static const Color PrimaryDark = Color(0xffB12C03);
  static const PrimaryDark = Color(0xff0047AF);
  //Color(0xff451A35);
  Color colorPrimary() {
    return Color(0xff0047AF);
      //Color(0xff451A35);
  }
  Color colorSecondary(){
    return Color(0xffffd400);
  }

  Color colorPrimaryDark() {
    return Color(0xff0047AF);
      //Color(0xff451A35);
  }

  Color colorBg1() {
    return Color(0xffFFFFFF);
  }

  Color colorBg2() {
    return Color(0xffEEF1F9);
  }

  Color colorEdit() {
    return Color(0xffEEF1F9);
  }

  Color colorTextPrimary() {
    return Color(0xff000000);
  }

  Color colorTextSecondary() {
    return Color(0xff929292);
  }
  Color colorTextGray() {
    return Color(0xff808080);
  }
  Color colorGreyLight() {
    return Color(0xffdcdcdc);
  }
  Color colorGrad2() {
    return Color(0xffFFBF00);
  }
  Color colorGrad1() {
    return Color(0xffFFDC01);
  }


  Color colorTextThird() {
    return Color(0xffBF2330);
  }

  Color colorTextFour() {
    return Color(0xff2A2A2A);
  }

  Color colorIcon() {
    return Color(0xff9c9b9b);
  }

  Color colorView() {
    return Color(0xff554747);
  }
}


extension colors on ColorScheme {
  static MaterialColor primary_app = const MaterialColor(
    0xffFC6A57,
    const <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  static const Color primary = Color(0xff0047AF);
  static const Color secondary = Color(0xff0047AF);
  static const Color secondary1 = Color(0xffD9F6CF);
  static const Color whit = Color(0xffffffff);
  static const Color fntClr =  Color(0xff222222);
  static const Color subTxtClr =  Color(0xff8e8e8e);
  static const Color black1 =  Colors.black;
  static const Color note1 = Color(0xffE8A3A3);
  static const Color note2 = Color(0xff93A1EE);
  static const Color red = Color(0xffd9595c);
  static const Color green = Color(0xff27a44b);
  static const Color textFieldClr = Color(0xfff1f1f1);
  static const Color backgroundblack = Color(0xFFCD5241);
  static const Color appColorGrey = Colors.black54;


  Color get btnColor =>
      this.brightness == Brightness.dark ? whiteTemp : primary;

  Color get lightWhite =>
      this.brightness == Brightness.dark ? darkColor : const Color(0xffffffff);

  Color get fontColor =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff222222);

  Color get fontClr =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff8e8e8e);

  Color get gray =>
      this.brightness == Brightness.dark ? darkColor3 : const Color(0xff808080);

  Color get simmerBase =>
      this.brightness == Brightness.dark ? darkColor2 : Colors.grey[300]!;

  Color get simmerHigh =>
      this.brightness == Brightness.dark ? darkColor : Colors.grey[100]!;

  static Color darkIcon = Color(0xff9B9B9B);

  static const Color grad1Color = Color(0xffFF0000);
  static const Color grad2Color = Color(0xffFBB03B);
  static const Color lightWhite2 = Color(0xffEEF2F3);

  static const Color yellow = Color(0xfffdd901);

  // static const Color red = Color(0xffd42727);

  Color get lightBlack =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff52575C);

  Color get lightBlack2 =>
      this.brightness == Brightness.dark ? white70 : const Color(0xff999999);

  static const Color darkColor = Color(0xff17242B);
  static const Color darkColor2 = Color(0xff29414E);
  static const Color darkColor3 = Color(0xff22343C);

  Color get white =>
      this.brightness == Brightness.dark ? darkColor2 : const Color(0xffFFFFFF);
  static const Color whiteTemp = Color(0xffFFFFFF);

  Color get black =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff000000);

  static const Color white10 = Colors.white10;
  static const Color white30 = Colors.white30;
  static const Color white70 = Colors.white70;

  static const Color black54 = Colors.black54;
  static const Color black12 = Colors.black12;
  static const Color disableColor = Color(0xffEEF2F9);

  static const Color blackTemp = Color(0xff000000);

  Color get black26 =>
      this.brightness == Brightness.dark ? white30 : Colors.black26;
  static const Color cardColor = Color(0xffFFFFFF);

  Color get back1 => this.brightness == Brightness.dark
      ? Color(0xff1E3039)
      : Color(0x66a2d8fe);

  Color get back2 => this.brightness == Brightness.dark
      ? Color(0xff09202C)
      : Color(0x66bdb1ff);

  Color get back3 => this.brightness == Brightness.dark
      ? Color(0xff10101E)
      : Color(0x66EFAFBF);

  Color get back4 => this.brightness == Brightness.dark
      ? Color(0xff171515)
      : Color(0x66F9DED7);

  Color get back5 => this.brightness == Brightness.dark
      ? Color(0xff0F1412)
      : Color(0x66C6F8E5);
}