import 'package:flutter/material.dart';
// import 'package:sodvendorrrrrrrrrrrrr_17/mycolor.dart';

import 'colors.dart';

Text titleText(String data, context, double fSize){
  return Text(data,
    style: TextStyle(
      fontSize: fSize,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.fontColor,
    ),);
}
Text subTitleText(String data, context, double fSize){
  return Text(data,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: fSize,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).colorScheme.fontClr,
    ),);
}
Text secTitleText(String data, context, double size ){
  return Text(data,
    style:  TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: colors.primary
      //Theme.of(context).colorScheme.fontColor,
    ),);
}
Widget drawerItem(String image, title, onPress){
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 45,
      child: Row(
        children: [
          ImageIcon(
            AssetImage(
                image
            ),
            color: colors.fntClr,
          ),
          SizedBox(width: 20,),
          Text(title,
            style: const TextStyle(
                color: colors.fntClr,
                fontSize: 18
            ),)
        ],
      ),
    ),
  );
}