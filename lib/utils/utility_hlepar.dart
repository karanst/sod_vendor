import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UtilityHlepar {
  // get Flutter toast MSG
  static getToast(msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Colors.red,
      // textColor: Colors.white,
      // fontSize: 16.0
    );
  }

// calculate Distance
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((double.parse(lat2.toString()) - double.parse(lat1.toString())) * p) /
            2 +
        c(double.parse(lat1.toString()) * p) *
            c(double.parse(lat2.toString()) * p) *
            (1 -
                c((double.parse(lon2.toString()) -
                        double.parse(lon1.toString())) *
                    p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  // // Get Current Location
  // getCurrentLocation() async {
  //   Position? position = await Geolocator.getLastKnownPosition();
  // }

  // check if not null data
  static String convertNA(data) {
    var convertNA = data;
    if (convertNA == "" || convertNA == null) {
      convertNA = "N/A";
    }
    return convertNA ?? "N/A";
  }

  static String convertDataTime(getFormat) {
    try {
      var dateTime = DateTime.parse(getFormat.toString());
      // var now = DateTime.now();
      // var dateTime = DateTime.parse(getFormat.toString());
      var mydatetime =
          "${DateFormat.d().format(dateTime)} ${DateFormat.LLL().format(dateTime)} ${DateFormat.y().format(dateTime)}, ${DateFormat.jm().format(dateTime)}";
      return mydatetime;
    } catch (e) {
      return "";
    }
  }

  static String convertTime({required TimeOfDay time}) {
    var calculatorTime = "";
    if (time.period == DayPeriod.am) {
      calculatorTime = "${time.hourOfPeriod} : ${time.minute} AM";
      // print("$time is AM");
    } else {
      calculatorTime = "${time.hourOfPeriod} : ${time.minute} PM";
    }

    print(calculatorTime.toString());
    // print(dateTime);
    // var mydatetime =
    //     "${DateFormat.d().format(dateTime)} ${DateFormat.LLL().format(dateTime)} ${DateFormat.y().format(dateTime)}, ${DateFormat.jm().format(dateTime)}";
    // print('dsafsadsd');
    // return mydatetime.toString().split(", ")[1].toString();
    return calculatorTime;
  }

  // for loding img
  static convertetIMG(img, {height, width, fit}) {
    return CachedNetworkImage(
      imageUrl: img ??
          "https://kinsta.com/wp-content/uploads/2014/04/free-images-for-wordpress-1024x512.png",
      height: height,
      width: height,
      fit: fit ?? BoxFit.contain,
      progressIndicatorBuilder: (context, img, downloadProgress) => Image.asset(
        // Myassets.logo,
        "images/loding_img.jpg",
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
      // CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, img, error) => Image.asset(
        "images/loding_img.jpg",
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
  // static ProgressiveImage convertIMG(img, {height, width, fit}) {
  //   return ProgressiveImage(
  //     placeholder: AssetImage('assets/loding/loding_banner_1.png'),
  //     thumbnail: NetworkImage(img),
  //     image: NetworkImage(img),
  //     height: height ?? 50,
  //     width: width ?? 50,
  //     fit: fit ?? BoxFit.cover,
  //   );
  // }
}
