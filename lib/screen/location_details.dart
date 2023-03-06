
import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
String address="",homeAddress="Select Address";
double latitude=0,homeLat = 0;
double longitude = 0,homeLng = 0;
// class GetLocation{
//   LocationData? _currentPosition;
//
//   late String _address = "";
//   Location location1 = Location();
//   String firstLocation = "",lat = "",lng = "";
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
//       // _getAddress(_currentPosition!.latitude,
//       //     _currentPosition!.longitude)
//       //     .then((value) {
//       //   _address = "${value.first.coordinates.longitude}";
//       //   firstLocation = value.first.subAdminArea.toString();
//       //   print(firstLocation);
//       //   lat = _currentPosition!.latitude.toString();
//       //   lng = _currentPosition!.longitude.toString();
//       //   onResult(value);
//       // });
//     });
//   }
//
//   // Future<List<Address>> _getAddress(double? lat, double? lang) async {
//   //   final coordinates = Coordinates(lat, lang);
//   //   List<Address> add = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   //   return add;
//   // }
// }

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