import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:fixerking/utils/colors.dart';

import 'constant.dart';

Widget text(
  String text, {
  var fontSize = textSizeMedium,
  textColor = const Color(0xffffffff),
  var fontFamily = fontRegular,
  var isCentered = false,
  var isEnd = false,
  var maxLine = 2,
  var latterSpacing = 0.25,
  var textAllCaps = false,
  var isLongText = false,
  var overFlow = false,
  var decoration = false,
}) {
  return Text(
    textAllCaps
        ? UtilityHlepar.convertNA(text).toUpperCase()
        : UtilityHlepar.convertNA(text),
    textAlign: isCentered
        ? TextAlign.center
        : isEnd
            ? TextAlign.end
            : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    softWrap: true,
    overflow: overFlow ? TextOverflow.ellipsis : TextOverflow.clip,
    style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration:
            decoration ? TextDecoration.underline : TextDecoration.none),
  );
}
 setSnackBar(String msg) {
  return SnackBar(
    backgroundColor: AppColor().colorPrimary(),
    content: Text(
      "$msg",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    ),
  );
}
BoxDecoration boxDecoration(
    {double radius = spacing_middle,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
            BoxShadow(
                color: AppColor().colorView().withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 1)
          ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

changeStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color, // navigation bar color
      statusBarColor: color,
      statusBarIconBrightness: Brightness.dark // status bar color
      ));
}

BoxDecoration boxDecoration2(
    {double radius = spacing_middle,
    Color color = Colors.transparent,
    Color bgColor = Colors.white,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor,
    boxShadow: showShadow
        ? [
            BoxShadow(
                color: AppColor().colorView(), blurRadius: 6, spreadRadius: 2)
          ]
        : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
  );
}

class NewButton extends StatefulWidget {
  var textContent;
  bool selected = false;
  //   var icon;
  VoidCallback onPressed;

  NewButton({
    @required this.textContent,
    required this.onPressed,
    required this.selected,
    //   @required this.icon,
  });

  @override
  quizButtonState createState() => quizButtonState();
}

class quizButtonState extends State<NewButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
          width: !widget.selected ? 100.w : 15.w,
          duration: Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColor().colorView().withOpacity(0.15),
                  blurRadius: 1,
                  spreadRadius: 1)
            ],
            gradient: new LinearGradient(
              colors: [
                !widget.selected ? AppColor().colorPrimary() : Colors.white,
                !widget.selected ? AppColor().colorPrimary() : Colors.white,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              /*  begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),*/
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: !widget.selected
              ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Center(
                      child: text(widget.textContent,
                          textColor: Colors.white,
                          fontFamily: fontMedium,
                          textAllCaps: false,
                          fontSize: 14.sp),
                    ),
                  ],
                )
              : CircularProgressIndicator(
                  color: AppColor().colorPrimary(),
                )),
    );
  }
}

