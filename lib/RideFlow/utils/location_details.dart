// import 'dart:async';
//
// import 'package:fixerking/RideFlow/utils/ApiBaseHelper.dart';
// import 'package:fixerking/RideFlow/utils/Session.dart';
// import 'package:fixerking/RideFlow/utils/common.dart';
// import 'package:fixerking/RideFlow/utils/constant.dart';
// import 'package:flutter/cupertino.dart';
// // import 'package:geocode/geocode.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:http/http.dart';
// import 'package:location/location.dart';
//
//
// class GetLocation{
//   LocationData? _currentPosition;
//
//   late String _address = "";
//
//   Location location1 = Location();
//
//   String firstLocation = "",lat = "",lng = "";
//
//   ValueChanged onResult;
//
//   GetLocation(this.onResult);
//
//   Future<void> getLoc() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//
//     _serviceEnabled = await location1.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location1.requestService();
//       if (!_serviceEnabled) {
//         print('ek');
//         return;
//       }
//     }
//
//     _permissionGranted = await location1.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location1.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         print('no');
//         return;
//       }
//     }
//
//     location1.onLocationChanged.listen((LocationData currentLocation) {
//       print("${currentLocation.latitude} : ${currentLocation.longitude}");
//       _currentPosition = currentLocation;print(currentLocation.latitude);
//
//       _getAddress(latitude, longitude)
//           .then((value) {
//         _address = '${value.streetNumber} ${value.streetAddress} ${value.city}';
//         //"${value.first.addressLine}";
//         firstLocation = value.streetAddress.toString();
//         print(_address);
//         lat = _currentPosition!.latitude.toString();
//         lng = _currentPosition!.longitude.toString();
//
//         updateLocation();
//         // if(latitude!=value.latitude){
//         //
//         //   print("ok");
//         //   onResult(value);
//         // }
//         if(latitude == 0){
//           latitude = _currentPosition!.latitude!;
//           longitude = _currentPosition!.longitude!;
//         }
//       });
//     });
//   }
//
//   ApiBaseHelper apiBase = new ApiBaseHelper();
//
//   bool isNetwork = false;
//
//   updateLocation() async {
//     await App.init();
//     isNetwork = await isNetworkAvailable();
//     if (isNetwork) {
//       try {
//         Map data;
//         data = {
//           "user_id": curUserId,
//           "lat": lat.toString(),
//           "lang": lng.toString()
//         };
//         var response = await post(
//             Uri.parse(baseUrl + "update_lat_lang_driver"), body: data);
//       } on TimeoutException catch (_) {
//       }
//     } else {
//     }
//   }
//
//   GeoCode geoCode = GeoCode();
//   Future<List<Address>> _getAddress(double? lat, double? lang) async {
//     final coordinates = new Coordinates(lat, lang);
//     List<Address> add =
//     await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     return add;
//   }
//   //
//   // Future<Address> _getAddress(double lat, double lang) async {
//   //   final coordinates = new Coordinates();
//   //   Address add = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   //   return add;
//   // }
//
// }
//
//
// // /Old code
// // import 'dart:async';
// //
// // import 'package:fixerking/RideFlow/utils/ApiBaseHelper.dart';
// // import 'package:fixerking/RideFlow/utils/Session.dart';
// // import 'package:fixerking/RideFlow/utils/common.dart';
// // import 'package:fixerking/RideFlow/utils/constant.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:geocoder/geocoder.dart';
// // import 'package:http/http.dart';
// // import 'package:location/location.dart';
// //
// // class GetLocation{
// //   LocationData? _currentPosition;
// //   late String _address = "";
// //   Location location1 = Location();
// //   String firstLocation = "",lat = "",lng = "";
// //   ValueChanged onResult;
// //
// //   GetLocation(this.onResult);
// //   Future<void> getLoc() async {
// //     bool _serviceEnabled;
// //     PermissionStatus _permissionGranted;
// //
// //     _serviceEnabled = await location1.serviceEnabled();
// //     if (!_serviceEnabled) {
// //       _serviceEnabled = await location1.requestService();
// //       if (!_serviceEnabled) {
// //         print('ek');
// //         return;
// //       }
// //     }
// //
// //     _permissionGranted = await location1.hasPermission();
// //     if (_permissionGranted == PermissionStatus.denied) {
// //       _permissionGranted = await location1.requestPermission();
// //       if (_permissionGranted != PermissionStatus.granted) {
// //         print('no');
// //         return;
// //       }
// //     }
// //
// //     location1.onLocationChanged.listen((LocationData currentLocation) {
// //       print("${currentLocation.latitude} : ${currentLocation.longitude}");
// //       _currentPosition = currentLocation;print(currentLocation.latitude);
// //
// //       _getAddress(_currentPosition!.latitude,
// //           _currentPosition!.longitude)
// //           .then((value) {
// //         _address = "${value.first.addressLine}";
// //         firstLocation = value.first.subLocality.toString();
// //         print(_address);
// //         lat = _currentPosition!.latitude.toString();
// //         lng = _currentPosition!.longitude.toString();
// //
// //         updateLocation();
// //         if(latitude!=value.first.coordinates.latitude){
// //
// //           print("ok");
// //           onResult(value);
// //         }
// //         if(latitude == 0){
// //           latitude = _currentPosition!.latitude!;
// //           longitude = _currentPosition!.longitude!;
// //         }
// //       });
// //     });
// //   }
// //   ApiBaseHelper apiBase = new ApiBaseHelper();
// //   bool isNetwork = false;
// //   updateLocation() async {
// //     await App.init();
// //     isNetwork = await isNetworkAvailable();
// //     if (isNetwork) {
// //       try {
// //         Map data;
// //         data = {
// //           "user_id": curUserId,
// //           "lat": lat.toString(),
// //           "lang": lng.toString()
// //         };
// //         var response = await post(
// //             Uri.parse(baseUrl + "update_lat_lang_driver"), body: data);
// //       } on TimeoutException catch (_) {
// //       }
// //     } else {
// //     }
// //   }
// //   Future<List<Address>> _getAddress(double? lat, double? lang) async {
// //     final coordinates = new Coordinates(lat, lang);
// //     List<Address> add =
// //     await Geocoder.local.findAddressesFromCoordinates(coordinates);
// //     return add;
// //   }
// //
// //
// // }

import 'package:fixerking/RideFlow/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class GetLocation{
  LocationData? _currentPosition;

  late String _address = "";
  Location location1 = Location();
  String firstLocation = "",lat = "",lng = "";
  ValueChanged onResult;

  GetLocation(this.onResult);
  Future<void> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location1.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location1.requestService();
      if (!_serviceEnabled) {
        print('ek');
        return;
      }
    }

    _permissionGranted = await location1.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location1.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('no');
        return;
      }
    }

    location1.onLocationChanged.listen((LocationData currentLocation) {
      // print("${currentLocation.latitude} : ${currentLocation.longitude}");
      _currentPosition = currentLocation;
      //print(currentLocation.latitude);

      _getAddress(double.parse(_currentPosition!.latitude.toString()),
          double.parse(_currentPosition!.longitude.toString()))
          .then((value) {
        if(value!=null){
          _address = "${value.first.geoNumber
          // first.
          // coordinates.longitude
          }";
          firstLocation = value.first.streetAddress.toString();
          lat = _currentPosition!.latitude.toString();
          lng = _currentPosition!.longitude.toString();
          onResult(value);
        }

      });
    });
  }

  Future<List<Address>?> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates();
    GeoCode geoCode = GeoCode();
    try{
      List<Address> add = (await geoCode.reverseGeocoding(latitude: lat, longitude: lang)) as List<Address> ;
      // Coordinates coordinates = await geoCode.forwardGeocoding(
      //     address: "532 S Olive St, Los Angeles, CA 90013");

      // List<Address> add = await Geocode.local.findAddressesFromCoordinates(coordinates);
      return add;
    }catch(e){
      print(e);
    }
    return null;
  }


}