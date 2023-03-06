// import 'dart:async';
// import 'dart:convert';
// import 'package:animated_widgets/widgets/scale_animated.dart';
// import 'package:fixerking/api/api_helper/home_api_helper.dart';
// import 'package:fixerking/api/api_path.dart';
// import 'package:fixerking/modal/RemoveServiceModel.dart';
// // import 'package:fixerking/modal/VendorServiceModel.dart';
// import 'package:fixerking/modal/request/get_service_profile_request.dart';
// import 'package:fixerking/modal/response/get_service_profile_response.dart';
// import 'package:fixerking/screen/edit_services.dart';
// import 'package:fixerking/screen/profile/edit_service_profile.dart';
// import 'package:fixerking/token/app_token_data.dart';
// import 'package:fixerking/utility_widget/shimmer_loding_view/loding_all_page.dart';
// import 'package:fixerking/utils/toast_string.dart';
// import 'package:fixerking/utils/utility_hlepar.dart';
// import 'package:flutter/material.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:fixerking/utils/constant.dart';
// import 'package:fixerking/utils/images.dart';
// import 'package:http/http.dart' as http;
// import 'package:fixerking/utils/widget.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:sizer/sizer.dart';
//
// import '../edit_service_profile_screen.dart';
//
// class ServiceProfileScreen extends StatefulWidget {
//   const ServiceProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   _ServiceProfileScreenState createState() => _ServiceProfileScreenState();
// }
//
// class _ServiceProfileScreenState extends State<ServiceProfileScreen> {
//   bool selected = false, enabled = false, edit = false;
//   StreamController<ServiceProfileResponse> responseSteam = StreamController();
//
//   @override
//   void initState() {
//     super.initState();
//     // getServiceProfile();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     responseSteam.close();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     changeStatusBarColor(AppColor().colorPrimary());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.PrimaryDark,
//         centerTitle: true,
//         title: Text("Service List"),
//         automaticallyImplyLeading: true,
//       ),
//       backgroundColor: AppColor().colorBg1(),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 1000),
//             curve: Curves.easeInOut,
//             width: 100.w,
//             decoration: BoxDecoration(
//               gradient: RadialGradient(
//                 center: Alignment(0.0, -0.5),
//                 colors: [
//                   AppColor().colorBg1(),
//                   AppColor().colorBg1(),
//                 ],
//                 radius: 0.8,
//               ),
//             ),
//             padding: MediaQuery.of(context).viewInsets,
//             child: Column(
//               children: [
//                 // Container(
//                 //   height: 9.92.h,
//                 //   width: 100.w,
//                 //   decoration: BoxDecoration(
//                 //       image: DecorationImage(
//                 //     image: AssetImage(profileBg),
//                 //     fit: BoxFit.fill,
//                 //   )),
//                 //   child: Center(
//                 //     child: Row(
//                 //       crossAxisAlignment: CrossAxisAlignment.center,
//                 //       children: [
//                 //         Container(
//                 //             width: 6.38.w,
//                 //             height: 6.38.w,
//                 //             alignment: Alignment.centerLeft,
//                 //             margin: EdgeInsets.only(left: 7.91.w),
//                 //             child: InkWell(
//                 //                 onTap: () {
//                 //                   Navigator.pop(context);
//                 //                 },
//                 //                 child: Image.asset(
//                 //                   back,
//                 //                   height: 4.0.h,
//                 //                   width: 8.w,
//                 //                 ))),
//                 //         SizedBox(
//                 //           width: 2.08.h,
//                 //         ),
//                 //         Container(
//                 //           width: 65.w,
//                 //           child: text(
//                 //             "Service List",
//                 //             textColor: Color(0xffffffff),
//                 //             fontSize: 14.sp,
//                 //             fontFamily: fontMedium,
//                 //             isCentered: true,
//                 //           ),
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 2.02.h,
//                 ),
//                 /*FutureBuilder(
//                     future: getVendorServices(),
//                     builder: (BuildContext context, AsyncSnapshot snapshot) {
//                       VendorServiceModel vendorModel = snapshot.data;
//                       if (snapshot.hasData) {
//                         return vendorModel.responseCode == "1"
//                             ? Container(
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: ClampingScrollPhysics(),
//                                   itemCount: vendorModel.data!.length,
//                                   itemBuilder: (context, index) {
//                                     return Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       margin: EdgeInsets.all(10.0),
//                                       child: Column(
//                                         children: [
//                                           ListTile(
//                                             leading: Container(
//                                               width: 100,
//                                               // height: 200,
//                                               child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(10.0),
//                                                 child: vendorModel.data![index]
//                                                             .serviceImage == ""
//                                                     ? Image.asset(
//                                                         "images/Placeholder.png")
//                                                     : Image.network(
//                                                         "${vendorModel.data![index].serviceImage}",
//                                                         fit: BoxFit.cover,
//                                                         width: 100,
//                                                         height: 200,
//                                                       ),
//                                               ),
//                                             ),
//                                             title: Text(
//                                               "${vendorModel.data![index].serviceName}",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16),
//                                             ),
//                                             subtitle: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 8.0,
//                                                 ),
//                                                 Text(
//                                                     "${vendorModel.data![index].categotyName}"),
//                                                 SizedBox(
//                                                   height: 5.0,
//                                                 ),
//                                                 Text(
//                                                     "₹ ${vendorModel.data![index].serviceFees}"),
//                                                 SizedBox(
//                                                   height: 5.0,
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text.rich(
//                                                         TextSpan(children: [
//                                                       WidgetSpan(
//                                                           child: Icon(
//                                                         Icons
//                                                             .watch_later_outlined,
//                                                         size: 15,
//                                                       )),
//                                                       TextSpan(
//                                                           text:
//                                                               " ${vendorModel.data![index].serviceTime}"),
//                                                     ])),
//                                                     Text.rich(
//                                                         TextSpan(children: [
//                                                       WidgetSpan(
//                                                           child: Icon(
//                                                         Icons.star,
//                                                         color: Colors.yellow,
//                                                         size: 15,
//                                                       )),
//                                                       TextSpan(text:
//                                                               " ${vendorModel.data![index].serviceRatings}"),
//                                                     ])),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: 5.0,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Divider(
//                                             indent: 15.0,
//                                             endIndent: 15.0,
//                                             thickness: 1.0,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceAround,
//                                             children: [
//                                               TextButton.icon(
//                                                 onPressed: () async{
//                                                   bool result = await Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                           builder: (context) => EditServices(
//                                                               serviceName: vendorModel
//                                                                   .data![index]
//                                                                   .serviceName,
//                                                               catId: vendorModel
//                                                                   .data![index]
//                                                                   .catId,
//                                                               serviceCharge:
//                                                                   vendorModel
//                                                                       .data![index]
//                                                                       .perMinitePrice,
//                                                               serviceTime: vendorModel
//                                                                   .data![index]
//                                                                   .serviceTime,
//                                                               childCatId: vendorModel
//                                                                   .data![index]
//                                                                   .childcatId,
//                                                               subCatId: vendorModel
//                                                                   .data![index]
//                                                                   .subcatId,
//                                                               serviceId:
//                                                                   vendorModel
//                                                                       .data![
//                                                                           index]
//                                                                       .id,
//                                                               serviceImage: vendorModel
//                                                                   .data![index]
//                                                                   .serviceImage,
//                                                               finalAmount:
//                                                                   vendorModel
//                                                                       .data![
//                                                                           index]
//                                                                       .serviceFees,
//                                                               childName:
//                                                                   vendorModel
//                                                                       .data![
//                                                                           index]
//                                                                       .childName,
//                                                               subName: vendorModel
//                                                                   .data![index]
//                                                                   .subName,
//                                                               serviceDescription:
//                                                                   vendorModel
//                                                                       .data![
//                                                                           index]
//                                                                       .serviceDescription,
//                                                             issue: vendorModel
//                                                                 .data![
//                                                             index].issue,
//                                                             modelName: vendorModel
//                                                                 .data![
//                                                             index].modelName,
//                                                           )));
//                                                   if(result == true){
//                                                     setState(() {
//
//                                                     });
//                                                   }
//                                                 },
//                                                 icon: Icon(
//                                                     Icons.edit_note_outlined,
//                                                     size: 18),
//                                                 label: Text("Edit Service"),
//                                                 style: TextButton.styleFrom(
//                                                     primary: AppColor()
//                                                         .colorPrimaryDark()),
//                                               ),
//                                               TextButton.icon(
//                                                 onPressed: () async {
//                                                   RemoveServiceModel?
//                                                       removeModel =
//                                                       await removeServices(
//                                                           vendorModel
//                                                               .data![index].id);
//                                                   if (removeModel!.responseCode == "1") {
//                                                     UtilityHlepar.getToast(
//                                                         "Service Deleted Successfully!");
//                                                     setState(() {
//                                                       getVendorServices();
//                                                     });
//                                                   }
//                                                 },
//                                                 icon: Icon(Icons.delete_rounded,
//                                                     size: 18),
//                                                 label: Text("Delete"),
//                                                 style: TextButton.styleFrom(
//                                                     primary: Colors.green),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               )
//                             : Center(
//                                 child: Text("${vendorModel.message}"),
//                               );
//                       } else if (snapshot.hasError) {
//                         return Icon(Icons.error_outline);
//                       } else {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                     }),*/
//                 SizedBox(
//                   height: 4.02.h,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   late ServiceProfileResponse profileResponse;
//
//   void getServiceProfile() async {
//     try {
//       var userid = await MyToken.getUserID();
//       ServiceProfileRequest request = ServiceProfileRequest(userId: userid);
//       profileResponse = await HomeApiHelper.getServiceProfile(request);
//       if (profileResponse.responseCode == ToastString.responseCode) {
//         responseSteam.sink.add(profileResponse);
//       } else {
//         responseSteam.sink.addError(profileResponse.message!);
//       }
//     } catch (e) {
//       UtilityHlepar.getToast(e.toString());
//       responseSteam.sink.addError(ToastString.msgSomeWentWrong);
//     }
//   }
//
//   // Future _refresh() async {
//   //   await Future.delayed(Duration(milliseconds: 1000));
//   //
//   //   return getVendorServices();
//   // }
//
//   // Future getVendorServices() async {
//   //   var userId = await MyToken.getUserID();
//   //
//   //   var request = http.MultipartRequest(
//   //       'POST', Uri.parse('${Apipath.BASH_URL}get_vendor_service'));
//   //   request.fields.addAll({'v_id': '$userId'});
//   //   print(request);
//   //   print(request.fields);
//   //   http.StreamedResponse response = await request.send();
//   //
//   //   if (response.statusCode == 200) {
//   //     final str = await response.stream.bytesToString();
//   //     print(str.toString());
//   //     return VendorServiceModel.fromJson(json.decode(str));
//   //   } else {
//   //     return null;
//   //   }
//   // }
//
//   Future<RemoveServiceModel?> removeServices(id) async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}remove_service'));
//     request.fields.addAll({'service_id': '$id'});
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       return RemoveServiceModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
// }
