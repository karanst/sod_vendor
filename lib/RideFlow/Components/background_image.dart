// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:qcabs_driver/OrderMapBloc/order_map_bloc.dart';
// import 'package:qcabs_driver/OrderMapBloc/order_map_state.dart';
//
// import '../map_utils.dart';
//
// class BackgroundImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<OrderMapBloc>(
//       create: (context) => OrderMapBloc()..loadMap(),
//       child: BackgroundImageBody(),
//     );
//   }
// }
//
// class BackgroundImageBody extends StatefulWidget {
//   const BackgroundImageBody({Key? key}) : super(key: key);
//
//   @override
//   _BackgroundImageBodyState createState() => _BackgroundImageBodyState();
// }
//
// class _BackgroundImageBodyState extends State<BackgroundImageBody> {
//   Completer<GoogleMapController> _mapController = Completer();
//   GoogleMapController? mapStyleController;
//   Set<Marker> _markers = {};
//
//   @override
//   void initState() {
//     rootBundle.loadString('assets/map_style.txt').then((string) {
//       mapStyle = string;
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OrderMapBloc, OrderMapState>(builder: (context, state) {
//         print('polyyyy' + state.polylines.toString());
//         return GoogleMap(
//     polylines: state.polylines,
//     mapType: MapType.normal,
//     initialCameraPosition: kGooglePlex,
//     markers: _markers,
//     onMapCreated: (GoogleMapController controller) async {
//       _mapController.complete(controller);
//       mapStyleController = controller;
//       mapStyleController!.setMapStyle(mapStyle);
//       setState(() {
//         _markers.add(
//           Marker(
//             markerId: MarkerId('mark1'),
//             position: LatLng(37.42796133580664, -122.085749655962),
//             icon: markerss.first,
//           ),
//         );
//         _markers.add(
//           Marker(
//             markerId: MarkerId('mark2'),
//             position: LatLng(37.42496133180663, -122.081743655960),
//             icon: markerss[0],
//           ),
//         );
//         _markers.add(
//           Marker(
//             markerId: MarkerId('mark3'),
//             position: LatLng(37.42196183580660, -122.089743655967),
//             icon: markerss[0],
//           ),
//         );
//       });
//     },
//         );
//       });
//   }
// }
