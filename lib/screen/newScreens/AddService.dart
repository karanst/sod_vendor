// import 'dart:convert';
// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:fixerking/modal/ModelCategoryModel.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:fixerking/api/api_path.dart';
// import 'package:fixerking/modal/AddServicesModel.dart';
// import 'package:fixerking/modal/ServiceCategoryModel.dart';
// import 'package:fixerking/modal/ServiceChildCategoryModel.dart';
// import 'package:fixerking/modal/VisitChargeModel.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sizer/sizer.dart';
// import 'package:time_picker_sheet/widget/sheet.dart';
// import 'package:time_picker_sheet/widget/time_picker.dart';
// import 'package:flutter_native_image/flutter_native_image.dart';
// import '../../modal/ServiceSubCategoryModel.dart';
// import '../../modal/country_model.dart';
// import '../../modal/state_model.dart';
// import '../../token/app_token_data.dart';
// import '../../utility_widget/utility_widget.dart';
// import '../../utils/colors.dart';
// import '../../utils/constant.dart';
// import '../../utils/images.dart';
// import '../../utils/toast_string.dart';
// import '../../utils/utility_hlepar.dart';
// import '../../utils/widget.dart';
// import '../auth_view/signup_screen.dart';
// import '../bottom_bar.dart';
// import 'package:http/http.dart' as http;
//
// class AddServices extends StatefulWidget {
//   const AddServices({Key? key}) : super(key: key);
//
//   @override
//   State<AddServices> createState() => _AddServicesState();
// }
//
// class _AddServicesState extends State<AddServices> {
//   TextEditingController onpenTime = new TextEditingController();
//   TextEditingController imageC = new TextEditingController();
//   TextEditingController closeTime = new TextEditingController();
//   TextEditingController serviceCharge = new TextEditingController();
//   TextEditingController expertsC = new TextEditingController();
//   TextEditingController serviceName = new TextEditingController();
//   TextEditingController serviceIssue = new TextEditingController();
//   TextEditingController descriptionController = new TextEditingController();
//   TextEditingController servicePrice = new TextEditingController();
//
//   TextEditingController serviceLocation = TextEditingController();
//   TextEditingController serviceOfferedController  = TextEditingController();
//   // TextEditingController descriptionController = TextEditingController();
//   final ImagePicker imagePicker = ImagePicker();
//
//
//   GlobalKey<FormState> _formKey = GlobalKey();
//
//   bool buttonLogin = false;
//   String? selectedCategory, selectSubCategory, selectChildCategory, selectModel;
//   double perMinServiceCharge = 0.0;
//   String? visitingCharge;
//   String? issue;
//   List serviceTypeId = [];
//   List specilizationTypeId = [];
//   String finalCharges = "0";
//   File? servicePic;
//   var storeId;
//   var imagePathList;
//   DateTime dateTimeSelected = DateTime.now();
//   String showImage = '';
//   String service_price = "";
//   String service_name = "";
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;
//   List<CountryData> countryList = [];
//   List<StateData> stateList = [];
//   List _selectedItems = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCountries();
//   }
//    File? _finalPhoto;
//
//   List pickedImageList = [];
//   // imageFromCamera()async{
//   // List<XFile>? imagesList = await ImagePicker.platform.getMultiImage();
//   //   setState(() {
//   //     pickedImageList.add(imagesList);
//   //   });
//   //   print("checking images here ${pickedImageList.length}");
//   //   for(var i=0;i< pickedImageList.length;i++){
//   //     print(" new image here ${pickedImageList[i]}");
//   //   }
//   //   Navigator.of(context).pop();
//   // }
//
//   Future getState() async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
//     request.fields.addAll({'country_id': '$selectedCountry'});
//     http.StreamedResponse response = await request.send();
//     print(request);
//     print(request.fields);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = StateModel.fromJson(json.decode(str));
//       if (jsonResponse.responseCode == "1") {
//         setState(() {
//           stateList = jsonResponse.data!;
//         });
//       }
//       return StateModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   void _showMultiSelect() async {
//     // // a list of selectable items
//     // // these items can be hard-coded or dynamically fetched from a database/API
//     // final List _items = [
//     //   {
//     //     "id":"1",
//     //     "name":"Flutter"
//     //   },
//     //   {
//     //     "id":"2",
//     //     "name":"Node.js"
//     //   },
//     //   {
//     //     "id":"3",
//     //     "name":"React Native"
//     //   },
//     // ];
//
//     final List? results = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return MultiSelect( selectedState: selectedState.toString(),);
//       },
//     );
//
//     // Update UI
//     if (results != null) {
//       setState(() {
//         _selectedItems = results;
//       });
//       print("this is result == ${_selectedItems.toString()}");
//     }
//   }
//
//   Future getCountries() async {
//     var request =
//     http.Request('GET', Uri.parse('${Apipath.BASH_URL}get_countries'));
//     http.StreamedResponse response = await request.send();
//     print(request);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = CountryModel.fromJson(json.decode(str));
//
//       if (jsonResponse.responseCode == "1") {
//         setState(() {
//           countryList = jsonResponse.data!;
//         });
//       }
//       return CountryModel.fromJson(json.decode(str));
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//                 Container(
//                   height: 9.92.h,
//                   width: 100.w,
//                   decoration: BoxDecoration(
//                     color: AppColor.PrimaryDark
//                   ),
//                   child: Center(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 6.38.w,
//                             height: 6.38.w,
//                             alignment: Alignment.centerLeft,
//                             margin: EdgeInsets.only(left: 7.91.w),
//                             child: InkWell(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Image.asset(
//                                   back,
//                                   height: 4.0.h,
//                                   width: 8.w,
//                                 ))),
//                         SizedBox(
//                           width: 2.08.h,
//                         ),
//                         Container(
//                           width: 65.w,
//                           child: text(
//                             "Add Services",
//                             textColor: Color(0xffffffff),
//                             fontSize: 14.sp,
//                             fontFamily: fontMedium,
//                             isCentered: true,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 secondSign(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget secondSign(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 2.62.h,
//           ),
//           text(
//             "Service Offered",
//             textColor: AppColor().colorPrimary(),
//             fontSize: 14.sp,
//             fontFamily: fontBold,
//           ),
//           SizedBox(
//             height: 2.96.h,
//           ),
//
//           // SERVICE NAME
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceName,
//                   maxLines: 1,
//                   keyboardType: TextInputType.text,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Name",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.miscellaneous_services,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 1.5.h,
//           ),
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceLocation,
//                   // maxLines: 2,
//                   keyboardType: TextInputType.multiline,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Location",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.location_on_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           // SERVICE CATEGORY
//           SizedBox(
//             height: 2.5.h,
//           ),
//           Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 color:  AppColor().colorEdit(),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   isExpanded: true,
//                   hint: Row(
//                     children: [
//                       Image.asset(
//                         country,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Select Country',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   items: countryList
//                       .map((item) => DropdownMenuItem<String>(
//                     value: item.id,
//                     child: Text(
//                       item.name!,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ))
//                       .toList(),
//                   value: selectedCountry,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCountry = value as String;
//                       print("selectedCategory=>" +
//                           selectedCountry.toString());
//                       getState();
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     color: AppColor.PrimaryDark,
//                   ),
//                   iconSize: 14,
//                   buttonHeight: 50,
//                   buttonWidth: 160,
//                   buttonPadding:
//                   const EdgeInsets.only(left: 14, right: 14),
//                   buttonDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     color: AppColor().colorEdit(),
//                   ),
//                   buttonElevation: 0,
//                   itemHeight: 40,
//                   itemPadding:
//                   const EdgeInsets.only(left: 14, right: 14),
//                   dropdownMaxHeight: 300,
//                   dropdownPadding: null,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   dropdownElevation: 8,
//                   scrollbarRadius: const Radius.circular(40),
//                   scrollbarThickness: 6,
//                   scrollbarAlwaysShow: true,
//                 ),
//               )),
//           SizedBox(
//             height: 15,
//           ),
//           //STATE
//           Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 color:AppColor().colorEdit(),
//               ),
//               child:DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   isExpanded: true,
//                   hint: Row(
//                     children: [
//                       Image.asset(
//                         city,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Select State',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   items: stateList
//                       .map((item) =>
//                       DropdownMenuItem<String>(
//                         value: item.id,
//                         child: Text(
//                           item.name!,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight:
//                             FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                           overflow:
//                           TextOverflow.ellipsis,
//                         ),
//                       ))
//                       .toList(),
//                   value: selectedState,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedState = value as String;
//                       print("selected State===>" +
//                           selectedState.toString());
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     color: AppColor.PrimaryDark,
//                   ),
//                   iconSize: 14,
//                   buttonHeight: 50,
//                   buttonWidth: 160,
//                   buttonPadding: const EdgeInsets.only(
//                       left: 14, right: 14),
//                   buttonDecoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(14),
//                     color:AppColor().colorEdit(),
//                   ),
//                   buttonElevation: 0,
//                   itemHeight: 40,
//                   itemPadding: const EdgeInsets.only(
//                       left: 14, right: 14),
//                   dropdownMaxHeight: 300,
//                   dropdownPadding: null,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(14),
//                   ),
//                   dropdownElevation: 8,
//                   scrollbarRadius:
//                   const Radius.circular(40),
//                   scrollbarThickness: 6,
//                   scrollbarAlwaysShow: true,
//                 ),
//               ),
//               // FutureBuilder(
//               //     future: getState(),
//               //     builder: (BuildContext context,
//               //         AsyncSnapshot snapshot) {
//               //       if (snapshot.hasData) {
//               //         return DropdownButtonHideUnderline(
//               //           child: DropdownButton2(
//               //             isExpanded: true,
//               //             hint: Row(
//               //               children: [
//               //                 Image.asset(
//               //                   city,
//               //                   width: 6.04.w,
//               //                   height: 5.04.w,
//               //                   fit: BoxFit.fill,
//               //                   color: AppColor.PrimaryDark,
//               //                 ),
//               //                 SizedBox(
//               //                   width: 4,
//               //                 ),
//               //                 Expanded(
//               //                   child: Text(
//               //                     'Select State',
//               //                     style: TextStyle(
//               //                       fontSize: 14,
//               //                       fontWeight: FontWeight.normal,
//               //                     ),
//               //                     overflow: TextOverflow.ellipsis,
//               //                   ),
//               //                 ),
//               //               ],
//               //             ),
//               //             items: stateList
//               //                 .map((item) =>
//               //                 DropdownMenuItem<String>(
//               //                   value: item.id,
//               //                   child: Text(
//               //                     item.name!,
//               //                     style: const TextStyle(
//               //                       fontSize: 14,
//               //                       fontWeight:
//               //                       FontWeight.bold,
//               //                       color: Colors.black,
//               //                     ),
//               //                     overflow:
//               //                     TextOverflow.ellipsis,
//               //                   ),
//               //                 ))
//               //                 .toList(),
//               //             value: selectedState,
//               //             onChanged: (value) {
//               //               setState(() {
//               //                 selectedState = value as String;
//               //                 print("selected State===>" +
//               //                     selectedState.toString());
//               //               });
//               //             },
//               //             icon: const Icon(
//               //               Icons.arrow_forward_ios_outlined,
//               //               color: AppColor.PrimaryDark,
//               //             ),
//               //             iconSize: 14,
//               //             buttonHeight: 50,
//               //             buttonWidth: 160,
//               //             buttonPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             buttonDecoration: BoxDecoration(
//               //               borderRadius:
//               //               BorderRadius.circular(14),
//               //               color:AppColor().colorEdit(),
//               //             ),
//               //             buttonElevation: 0,
//               //             itemHeight: 40,
//               //             itemPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             dropdownMaxHeight: 300,
//               //             dropdownPadding: null,
//               //             dropdownDecoration: BoxDecoration(
//               //               borderRadius:
//               //               BorderRadius.circular(14),
//               //             ),
//               //             dropdownElevation: 8,
//               //             scrollbarRadius:
//               //             const Radius.circular(40),
//               //             scrollbarThickness: 6,
//               //             scrollbarAlwaysShow: true,
//               //           ),
//               //         );
//               //       } else if (snapshot.hasError) {
//               //         return Icon(Icons.error_outline);
//               //       } else {
//               //         return Center(
//               //             child: CircularProgressIndicator());
//               //       }
//               //     })
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           // CITY
//           // _selectedItems.isEmpty ?
//           InkWell(
//             onTap: (){
//               _showMultiSelect();
//             },
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color:  AppColor().colorEdit(),
//                 ),
//                 // boxDecoration(
//                 //   radius: 10.0,
//                 // ),
//                 child: _selectedItems.isEmpty ?
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10.0, right: 10),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         city,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 8),
//                         child: Text(
//                           'Select Multiple Cities',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black54,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//                     :  Wrap(
//                   children: _selectedItems
//                       .map((item){
//                     print("okok ${item.id}");
//                     selectedCity = item.id;
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 8.0, right: 8),
//                       child: Chip(
//                         label:
//                         Text(
//                             "${item.name}"
//                           //item.name
//                         ),
//                       ),
//                     );
//                   })
//                       .toList(),
//                 )
//               // FutureBuilder(
//               //     future: getCities(),
//               //     builder: (BuildContext context,
//               //         AsyncSnapshot snapshot) {
//               //       if (snapshot.hasData) {
//               //         return DropdownButtonHideUnderline(
//               //           child: DropdownButton2(
//               //             isExpanded: true,
//               //             hint: Row(
//               //               children: [
//               //                 Image.asset(
//               //                   city,
//               //                   width: 6.04.w,
//               //                   height: 5.04.w,
//               //                   fit: BoxFit.fill,
//               //                   color: AppColor.PrimaryDark,
//               //                 ),
//               //                 SizedBox(
//               //                   width: 4,
//               //                 ),
//               //                 Expanded(
//               //                   child: Text(
//               //                     'Select Multiple Cities',
//               //                     style: TextStyle(
//               //                       fontSize: 14,
//               //                       fontWeight: FontWeight.normal,
//               //                     ),
//               //                     overflow: TextOverflow.ellipsis,
//               //                   ),
//               //                 ),
//               //               ],
//               //             ),
//               //             items: cityList.map((item) {
//               //               return DropdownMenuItem<String>(
//               //                 value: item.id,
//               //                 enabled: false,
//               //                 child: StatefulBuilder(
//               //                   builder: (context, menuSetState) {
//               //                     final _isSelected =
//               //                         selectedCities
//               //                             .contains(item);
//               //                     print("SLECTED CITY");
//               //                     return InkWell(
//               //                       onTap: () {
//               //                         _isSelected
//               //                             ? selectedCities
//               //                                 .remove(item.id)
//               //                             : selectedCities
//               //                                 .add(item.id!);
//               //                         setState(() {});
//               //                         menuSetState(() {});
//               //                       },
//               //                       child: Container(
//               //                         height: double.infinity,
//               //                         padding: const EdgeInsets
//               //                                 .symmetric(
//               //                             horizontal: 16.0),
//               //                         child: Row(
//               //                           children: [
//               //                             _isSelected
//               //                                 ? const Icon(Icons
//               //                                     .check_box_outlined)
//               //                                 : const Icon(Icons
//               //                                     .check_box_outline_blank),
//               //                             const SizedBox(
//               //                                 width: 16),
//               //                             Text(
//               //                               item.name!,
//               //                               style:
//               //                                   const TextStyle(
//               //                                 fontSize: 14,
//               //                               ),
//               //                             ),
//               //                           ],
//               //                         ),
//               //                       ),
//               //                     );
//               //                   },
//               //                 ),
//               //               );
//               //             }).toList(),
//               //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
//               //             value: selectedCities.isEmpty
//               //                 ? null
//               //                 : selectedCities.last,
//               //             onChanged: (value) {},
//               //             buttonHeight: 50,
//               //             buttonWidth: 160,
//               //             buttonPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             buttonDecoration: BoxDecoration(
//               //               borderRadius:
//               //                   BorderRadius.circular(14),
//               //               color: Color(0xffF9F9F9),
//               //             ),
//               //             buttonElevation: 0,
//               //             itemHeight: 40,
//               //             itemPadding: const EdgeInsets.only(
//               //                 left: 14, right: 14),
//               //             dropdownMaxHeight: 300,
//               //             dropdownPadding: null,
//               //             dropdownDecoration: BoxDecoration(
//               //               borderRadius:
//               //                   BorderRadius.circular(14),
//               //             ),
//               //             dropdownElevation: 8,
//               //             scrollbarRadius:
//               //                 const Radius.circular(40),
//               //             scrollbarThickness: 6,
//               //             scrollbarAlwaysShow: true,
//               //             selectedItemBuilder: (context) {
//               //               return cityList.map(
//               //                 (item) {
//               //                   return Container(
//               //                     // alignment: AlignmentDirectional.center,
//               //                     padding:
//               //                         const EdgeInsets.symmetric(
//               //                             horizontal: 16.0),
//               //                     child: Text(
//               //                       selectedCities.join(','),
//               //                       style: const TextStyle(
//               //                         fontSize: 14,
//               //                         overflow:
//               //                             TextOverflow.ellipsis,
//               //                       ),
//               //                       maxLines: 1,
//               //                     ),
//               //                   );
//               //                 },
//               //               ).toList();
//               //             },
//               //           ),
//               //         );
//               //       } else if (snapshot.hasError) {
//               //         return Icon(Icons.error_outline);
//               //       } else {
//               //         return Center(
//               //             child: CircularProgressIndicator());
//               //       }
//               //     })
//             ),
//           ),
//
//           SizedBox(
//             height: 2.5.h,
//           ),
//           Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//               ),
//               child: FutureBuilder(
//                   future: getServiceCategory(),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     ServiceCategoryModel serviceModel = snapshot.data;
//                     if (snapshot.hasData) {
//                       return DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           isExpanded: true,
//                           hint: Row(
//                             children: [
//                               Image.asset(
//                                 service,
//                                 width: 6.04.w,
//                                 height: 5.04.w,
//                                 fit: BoxFit.fill,
//                                 color: AppColor.PrimaryDark,
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//
//                               Expanded(
//                                 child: Text(
//                                   'Select Category',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           items: serviceModel.data!
//                               .map((item) => DropdownMenuItem<String>(
//                             value: item.id,
//                             child: Text(
//                               item.cName!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                               .toList(),
//                           value: selectedCategory,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedCategory = value as String;
//                               // // serviceName.text = serviceModel.data!
//                               //     .firstWhere((element) => element.id == value)
//                               //     .cName
//                               //     .toString();
//                               print("selectedCategory=>" +
//                                   selectedCategory.toString() +
//                                   "serviceName" +
//                                   serviceName.text);
//                             });
//                             print("CATEGORY ID== $selectedCategory");
//                           },
//                           icon: const Icon(
//                             Icons.arrow_forward_ios_outlined,
//                             color: AppColor.PrimaryDark,
//                           ),
//                           iconSize: 14,
//                           buttonHeight: 50,
//                           buttonWidth: 160,
//                           buttonPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           buttonDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             color: AppColor().colorEdit(),
//                           ),
//                           buttonElevation: 0,
//                           itemHeight: 40,
//                           itemPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           dropdownMaxHeight: 300,
//                           dropdownPadding: null,
//                           dropdownDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           dropdownElevation: 8,
//                           scrollbarRadius: const Radius.circular(40),
//                           scrollbarThickness: 6,
//                           scrollbarAlwaysShow: true,
//                         ),
//                       );
//                     }
//                     else if (snapshot.hasError) {
//                       print("ERROR===" + snapshot.error.toString());
//                       return Icon(Icons.error_outline);
//                     }
//                     else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   })),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           // SERVICE SUBCATEGORY
//           Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 // bgColor: AppColor().colorEdit(),
//               ),
//               child: FutureBuilder(
//                   future: getServicesSubCategory(selectedCategory),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     ServiceSubCategoryModel subCatModel = snapshot.data;
//                     print("SUB CAT DATA=== $subCatModel");
//                     if (snapshot.hasData) {
//                       return DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           isExpanded: true,
//                           hint: Row(
//                             children: [
//                               Image.asset(
//                                 special,
//                                 width: 6.04.w,
//                                 height: 5.04.w,
//                                 fit: BoxFit.fill,
//                                 color: AppColor.PrimaryDark,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Select Sub Category',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           items: subCatModel.data!
//                               .map((item) => DropdownMenuItem<String>(
//                             value: item.id,
//                             child: Text(
//                               item.cName!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                               .toList(),
//                           value: selectSubCategory,
//                           onChanged: (value) {
//                             setState(() {
//                               selectSubCategory = value as String;
//                             });
//                             print("SUB CATEGORY ID== $selectSubCategory");
//                           },
//                           icon: const Icon(
//                             Icons.arrow_forward_ios_outlined,
//                             color: AppColor.PrimaryDark,
//                           ),
//                           iconSize: 14,
//                           buttonHeight: 50,
//                           buttonWidth: 160,
//                           buttonPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           buttonDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             color: AppColor().colorEdit(),
//                           ),
//                           buttonElevation: 0,
//                           itemHeight: 40,
//                           itemPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           dropdownMaxHeight: 300,
//                           dropdownPadding: null,
//                           dropdownDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           dropdownElevation: 8,
//                           scrollbarRadius: const Radius.circular(40),
//                           scrollbarThickness: 6,
//                           scrollbarAlwaysShow: true,
//                         ),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Icon(Icons.error_outline);
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   })),
//           SizedBox(
//             height: 2.62.h,
//           ),
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 // height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceOfferedController,
//                    maxLines: 3,
//                   keyboardType: TextInputType.multiline,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Offered use ( , ) ",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     // prefixIcon: Icon(
//                     //   Icons.miscellaneous_services,
//                     //   color: AppColor.PrimaryDark,
//                     // ),
//                   ),
//                 )),
//           ),
//
//           // Container(
//           //     margin: EdgeInsets.only(left: 30),
//           //     child: Row(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: [
//           //     Container(
//           //         decoration:BoxDecoration(
//           //           color: AppColor().colorPrimary(),
//           //           borderRadius: BorderRadius.circular(100)
//           //         ),
//           //         child: Icon(Icons.add,color: Colors.white,size: 15,)),
//           //     SizedBox(width: 8,),
//           //     Text("Add More")
//           //   ],
//           // )),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           //service Description
//           Card(
//             elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: descriptionController,
//                   // maxLines: 2,
//                   keyboardType: TextInputType.multiline,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Description",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.description,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           /*//SERVICE EXPERTS
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.0),
//             ),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: expertsC,
//                   inputFormatters: [LengthLimitingTextInputFormatter(5)],
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Experts",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.credit_card_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),*/
//           //SERVICE PRICE
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.0),
//             ),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: serviceCharge,
//                   inputFormatters: [LengthLimitingTextInputFormatter(5)],
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Amount",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.credit_card_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//          /* // Service TIME
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: onpenTime,
//                   textAlignVertical: TextAlignVertical.center,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     hintText: "Service Time (in Hrs.)",
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
//                     prefixIcon: Icon(
//                       Icons.watch,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                   onTap: () async {
//                     _openTimePickerSheet(context);
//                   },
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),*/
//
//           // SERVICE IMAGE
//           GestureDetector(
//             onTap: () {
//               // getImagePicker();
//               getFromGallery();
//             //  imageFromCamera();
//             },
//             child: Card(
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14.0)),
//               color: AppColor().colorEdit(),
//               child: Container(
//                 width: 80.99.w,
//                 height: 10.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child:
//                 // servicePic != null
//                 imagePathList.isNotEmpty
//                     ? Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           // crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.image,
//                               color: AppColor.PrimaryDark,
//                             ),
//                             SizedBox(
//                               width: 6,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.65,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                   itemCount: imagePathList.length,
//                                   itemBuilder: (context,index){
//                                 return Padding(
//                                   padding: EdgeInsets.only(top: 5,bottom: 5),
//                                   child: Text("${imagePathList[index]}"),
//                                 );
//                               })
//                               // Text(
//                               //   "$servicePic",
//                               //   overflow: TextOverflow.ellipsis,
//                               // ),
//                             )
//                           ],
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.image,
//                               color: AppColor.PrimaryDark,
//                             ),
//                             SizedBox(
//                               width: 6,
//                             ),
//                             Text("Upload service image"),
//                           ],
//                         ),
//                       ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           Center(
//             child: InkWell(
//               onTap: () async {
//                 print(" values area here ${selectedCity} and ${selectedState} and ${selectedCountry}");
//                  var userId = await MyToken.getUserID();
//                 if (_formKey.currentState!.validate()) {
//                   if (selectedCategory!.isNotEmpty &&
//                       selectSubCategory!.isNotEmpty &&
//                       serviceCharge.text.isNotEmpty) {
//                     setState(() {
//                       buttonLogin = true;
//                     });
//                     Map<String, String> param = {
//                     'name': '${serviceName.text.toString()}',
//                     'description': '${descriptionController.text}',
//                     'cat_id': '$selectedCategory',
//                     'scat_id': '$selectSubCategory',
//                     'vid': '$userId',
//                     'price': '${serviceCharge.text.toString()}',
//                      'country_id': "${selectedCountry.toString()}",
//                      "state_id" : "${selectedState.toString()}",
//                       "city_id":"${selectedCity.toString()}",
//                       "service_offered":"${serviceOfferedController.text}"
//                     };
//                     print("ADD SERVICE PARAM=====" + param.toString());
//                     AddServicesModel addModel = await addServices(param);
//                     if (addModel.responseCode == "1") {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => BottomBar()));
//                       UtilityHlepar.getToast(addModel.message);
//                     } else {
//                       UtilityHlepar.getToast(addModel.message);
//                     }
//                   }
//                   else if (selectedCategory!.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceType);
//                   }
//                   else if (selectSubCategory!.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceSubType);
//                   }
//                   else if (serviceCharge.text.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgServiceCharge);
//                   }
//                   else if(servicePic == null){
//                     UtilityHlepar.getToast("Service Image Required");
//                   }
//                 }
//               },
//               child: UtilityWidget.lodingButton(
//                   buttonLogin: buttonLogin, btntext: 'Submit'),
//             ),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//         ],
//       ),
//     );
//   }
//
//   var selectedTime = TimeOfDay.now();
//
//   Future selectTime(BuildContext context, {from}) async {
//     final TimeOfDay? result = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 // Using 12-Hour format
//                   alwaysUse24HourFormat: false),
//               // If you want 24-Hour format, just change alwaysUse24HourFormat to true
//               child: child!);
//         });
//     if (result != null) {
//       setState(() {
//         _selectedTime = result.format(context);
//         print(_selectedTime.toString());
//       });
//     }
//     print("===========");
//     print(_selectedTime.toString());
//     print(result!.hour);
//     print(result.minute);
//     print(result.period);
//     print(UtilityHlepar.convertTime(time: result));
//     setState(() {
//       if (from == 0) {
//         onpenTime.text = UtilityHlepar.convertTime(time: result);
//       } else {
//         closeTime.text = UtilityHlepar.convertTime(time: result);
//       }
//     });
//   }
//
//   String? _selectedTime;
//
//   Future<void> showTimePikar() async {
//     final TimeOfDay? result = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 // Using 12-Hour format
//                   alwaysUse24HourFormat: false),
//               // If you want 24-Hour format, just change alwaysUse24HourFormat to true
//               child: child!);
//         });
//     if (result != null) {
//       setState(() {
//         _selectedTime = result.format(context);
//         print(_selectedTime.toString());
//       });
//     }
//   }
//
//   Future<ServiceCategoryModel?> getServiceCategory() async {
//     // var userId = await MyToken.getUserID();
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//           '${Apipath.BASH_URL}get_categories_list',
//         ));
//     print(request);
//
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       return ServiceCategoryModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   Future<ServiceSubCategoryModel?> getServicesSubCategory(catId) async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));
//
//     request.fields.addAll({'p_id': '$catId'});
//
//     print(request);
//     print(request.fields);
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       print(str);
//       return ServiceSubCategoryModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   Future addServices(param) async {
//     print("ADD SERVICE PARAM=====" + param.toString());
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}add_restaurant'));
//     request.fields.addAll(param);
//     request.files.add(
//         await http.MultipartFile.fromPath('res_image', imagePathList.toString()));
//     print(request.files);
//     http.StreamedResponse response = await request.send();
//     print(request.toString());
//     print(request.fields.toString());
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       print(str.toString());
//       return AddServicesModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   getImagePicker() async {
//    /* var imageTemporary;
//     var image = await ImagePickerGC.pickImage(
//         context: context, source: ImgSource.Gallery);
//     if (image == null) return;
//     imageTemporary = File(image.path);
//     setState(() {
//       showImage = image.path;
//     });
//     var base64Image = '';
//     if (imageTemporary.toString().isNotEmpty) {
//       var _image = File(imageTemporary.path);
//       File FileCompressed = await FlutterNativeImage.compressImage(_image.path,
//           quality: 100, percentage: 50);
//       List<int> imagebytes = FileCompressed.readAsBytesSync();
//       base64Image = base64Encode(imagebytes);
//       setState(() {
//         servicePic = _image;
//       });
//       print("SERVICE PIC === ${servicePic.toString()}");
//     }*/
//     try {
//       final image = await ImagePicker().getImage(source: ImageSource.gallery);
//       if(image == null) return;
//       final imageTemp = File(image.path);
//       setState(() => servicePic = imageTemp);
//       print("SERVICE PIC === $servicePic");
//     } on PlatformException catch(e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   Future<void> getFromGallery() async {
//
//     var result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//     );
//     if (result != null) {
//       setState(() {
//           // servicePic = File(result.files.single.path.toString());
//       });
//       imagePathList.add(result.paths.toString());
//       print("SERVICE PIC === ${imagePathList.length}");
//     } else {
//       // User canceled the picker
//     }
//
//   }
//
//   TextEditingController usernameController = TextEditingController();
//   File? file;
//   String profileUrl = "";
//   String url = "";
//
//   void _openTimePickerSheet(BuildContext context) async {
//     final result = await TimePicker.show<DateTime?>(
//       context: context,
//       sheet: TimePickerSheet(
//         sheetTitle: 'Select Service Time',
//         minuteTitle: 'Minute',
//         hourTitle: 'Hour',
//         saveButtonText: 'Save',
//       ),
//     );
//
//     if (result != null) {
//       setState(() {
//         dateTimeSelected = result;
//         service_price = visitingCharge.toString();
//         onpenTime.text = "0${dateTimeSelected.hour}:${dateTimeSelected.minute == 0 ? "0${dateTimeSelected.minute}" : dateTimeSelected.minute} ";
//       });
//       /*if (onpenTime.text.isNotEmpty && serviceCharge.text.isNotEmpty) {
//         // var totalCharges = (int.parse(visitingCharge!) + int.parse(serviceCharge.text.toString()));
//         // print("TOTAL CHARGES=== $totalCharges");
//         // perMinServiceCharge = totalCharges/60;
//         // print("PERMINUTE SERVICE CHARGE=== ${perMinServiceCharge.toStringAsFixed(2)}");
//         var parts = onpenTime.text.toString().split(':');
//         var hrsToMinute = (int.parse(parts[0].padLeft(2, '0')) * 60);
//         print("hrs min======$hrsToMinute");
//         var finalTime = hrsToMinute + int.parse(parts[1].padLeft(2, '0'));
//         print("FINAL TIME===== $finalTime");
//         var amount = (int.parse(visitingCharge!) + (int.parse(serviceCharge.text.toString()) * finalTime));
//         print("AMOUNT==== $amount");
//         setState(() {
//           finalCharges = amount.toString();
//           servicePrice.text = finalCharges;
//         });
//       }*/
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fixerking/modal/City_model.dart';
import 'package:fixerking/modal/ModelCategoryModel.dart';
import 'package:fixerking/modal/New%20models/VerifyUserModel.dart';
import 'package:fixerking/modal/New%20models/VerifyUserPlanModel.dart';
import 'package:fixerking/modal/state_model.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:path/path.dart' as path;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/AddServicesModel.dart';
import 'package:fixerking/modal/ServiceCategoryModel.dart';
import 'package:fixerking/modal/ServiceChildCategoryModel.dart';
import 'package:fixerking/modal/VisitChargeModel.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import '../../modal/ServiceSubCategoryModel.dart';
import '../../modal/country_model.dart';
import '../../token/app_token_data.dart';
import '../../utility_widget/utility_widget.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/images.dart';
import '../../utils/toast_string.dart';
import '../../utils/utility_hlepar.dart';
import '../../utils/widget.dart';
import '../BottomBars/bottom_bar.dart';
import 'package:http/http.dart' as http;
//
// class AddServices extends StatefulWidget {
//   const AddServices({Key? key}) : super(key: key);
//
//   @override
//   State<AddServices> createState() => _AddServicesState();
// }
//
// class _AddServicesState extends State<AddServices> {
//   TextEditingController onpenTime = new TextEditingController();
//   TextEditingController imageC = new TextEditingController();
//   TextEditingController closeTime = new TextEditingController();
//   TextEditingController serviceCharge = new TextEditingController();
//   TextEditingController expertsC = new TextEditingController();
//   TextEditingController serviceName = new TextEditingController();
//   TextEditingController serviceIssue = new TextEditingController();
//   TextEditingController descriptionController = new TextEditingController();
//   TextEditingController servicePrice = new TextEditingController();
//   GlobalKey<FormState> _formKey = GlobalKey();
//
//   TextEditingController serviceLocation = TextEditingController();
//   TextEditingController serviceOfferedController  = TextEditingController();
//
//   bool buttonLogin = false;
//   String? selectedCategory, selectSubCategory, selectChildCategory, selectModel;
//   double perMinServiceCharge = 0.0;
//   String? visitingCharge;
//   String? issue;
//   var imagePathList;
//   List serviceTypeId = [];
//   List specilizationTypeId = [];
//   List<StateData> stateList = [];
//   String finalCharges = "0";
//   File? servicePic;
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;
//   List<CityData> cityList = [];
//   List<CountryData> countryList = [];
//   var storeId;
//   DateTime dateTimeSelected = DateTime.now();
//   String showImage = '';
//   String service_price = "";
//   String service_name = "";
//
//     Future getState() async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
//     request.fields.addAll({'country_id': '$selectedCountry'});
//     http.StreamedResponse response = await request.send();
//     print(request);
//     print(request.fields);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = StateModel.fromJson(json.decode(str));
//       if (jsonResponse.responseCode == "1") {
//         setState(() {
//           stateList = jsonResponse.data!;
//         });
//       }
//       return StateModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//     Future getCountries() async {
//     var request =
//     http.Request('GET', Uri.parse('${Apipath.BASH_URL}get_countries'));
//     http.StreamedResponse response = await request.send();
//     print(request);
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = CountryModel.fromJson(json.decode(str));
//
//       if (jsonResponse.responseCode == "1") {
//         setState(() {
//           countryList = jsonResponse.data!;
//         });
//       }
//       return CountryModel.fromJson(json.decode(str));
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//   Future getCities() async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
//     request.fields.addAll({'state_id': '$selectedState'});
//     print(request);
//     print(request.fields);
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       /*var fullResponse = json.decode(str);
//       serviceList = fullResponse["data"];
//       print(serviceList.length);
//       setState(() {});
//       boolList = serviceList.map((element) {
//         return false;
//       }).toList();
//       serviceList.forEach((element) {
//         boolServiceMapList[element["id"]] = false;
//       });
//       print(boolServiceMapList.length);
//       print(boolList.length);*/
//       final jsonResponse = CityModel.fromJson(json.decode(str));
//       if (jsonResponse.responseCode == "1") {
//         setState(() {
//           cityList = jsonResponse.data!;
//         });
//       }
//       return CityModel.fromJson(json.decode(str));
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getVerifyUser();
//     getCountries();
//
//   }
//
//   String? isPlanAvailable;
//   getVerifyUser()async{
//     var userId = await MyToken.getUserID();
//     var headers = {
//       'Cookie': 'ci_session=srt9h3cbg9qnkvhgnetmb006uqvle65d'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/antsnest/uploads/chats/api/check_user_plan'));
//     request.fields.addAll({
//       'user_id': '${userId}'
//     });
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var result = await response.stream.bytesToString();
//       print("result here ${result}");
//       final jsonResponse = VerifyUserPlanModel.fromJson(json.decode(result));
//       print("final here ${jsonResponse.responseCode}");
//           setState(() {
//             isPlanAvailable = jsonResponse.responseCode;
//           });
//       print("checking response here ${jsonResponse.msg} and ${jsonResponse.responseCode}");
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//             child: isPlanAvailable == "0" ?
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               height: MediaQuery.of(context).size.height/1.05,
//               decoration: BoxDecoration(
//                 gradient: RadialGradient(
//                   center: Alignment(0.0, -0.5),
//                   colors: [
//                     AppColor().colorBg1(),
//                     AppColor().colorBg1(),
//                   ],
//                   radius: 0.8,
//                 ),
//               ),
//               child: Center(
//                 child: Text("Do not have any active plan, please activate",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
//               ),
//             ) : Column(
//               children: [
//                 Container(
//                   height: 9.92.h,
//                   width: 100.w,
//                   decoration: BoxDecoration(
//                       color: AppColor.PrimaryDark
//                   ),
//                   child: Center(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                             width: 6.38.w,
//                             height: 6.38.w,
//                             alignment: Alignment.centerLeft,
//                             margin: EdgeInsets.only(left: 7.91.w),
//                             child: InkWell(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Image.asset(
//                                   back,
//                                   height: 4.0.h,
//                                   width: 8.w,
//                                 ))),
//                         SizedBox(
//                           width: 2.08.h,
//                         ),
//                         Container(
//                           width: 65.w,
//                           child: text(
//                             "Add Services",
//                             textColor: Color(0xffffffff),
//                             fontSize: 14.sp,
//                             fontFamily: fontMedium,
//                             isCentered: true,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 secondSign(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget secondSign(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 2.62.h,
//           ),
//           text(
//             "Service Offered",
//             textColor: AppColor().colorPrimary(),
//             fontSize: 14.sp,
//             fontFamily: fontBold,
//           ),
//           SizedBox(
//             height: 2.96.h,
//           ),
//           // SERVICE NAME
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceName,
//                   maxLines: 1,
//                   keyboardType: TextInputType.text,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Name",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.miscellaneous_services,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceLocation,
//                   maxLines: 1,
//                   keyboardType: TextInputType.text,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Location",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.miscellaneous_services,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//       Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 color:  AppColor().colorEdit(),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   isExpanded: true,
//                   hint: Row(
//                     children: [
//                       Image.asset(
//                         country,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Select Country',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   items: countryList
//                       .map((item) => DropdownMenuItem<String>(
//                     value: item.id,
//                     child: Text(
//                       item.name!,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ))
//                       .toList(),
//                   value: selectedCountry,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCountry = value as String;
//                       print("selectedCategory=>" +
//                           selectedCountry.toString());
//                        getState();
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     color: AppColor.PrimaryDark,
//                   ),
//                   iconSize: 14,
//                   buttonHeight: 50,
//                   buttonWidth: 160,
//                   buttonPadding:
//                   const EdgeInsets.only(left: 14, right: 14),
//                   buttonDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     color: AppColor().colorEdit(),
//                   ),
//                   buttonElevation: 0,
//                   itemHeight: 40,
//                   itemPadding:
//                   const EdgeInsets.only(left: 14, right: 14),
//                   dropdownMaxHeight: 300,
//                   dropdownPadding: null,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   dropdownElevation: 8,
//                   scrollbarRadius: const Radius.circular(40),
//                   scrollbarThickness: 6,
//                   scrollbarAlwaysShow: true,
//                 ),
//               )),
//           SizedBox(
//             height: 2.5.h,
//           ),
//       Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 color:AppColor().colorEdit(),
//               ),
//               child:DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   isExpanded: true,
//                   hint: Row(
//                     children: [
//                       Image.asset(
//                         city,
//                         width: 6.04.w,
//                         height: 5.04.w,
//                         fit: BoxFit.fill,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Select State',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   items: stateList
//                       .map((item) =>
//                       DropdownMenuItem<String>(
//                         value: item.id,
//                         child: Text(
//                           item.name!,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight:
//                             FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                           overflow:
//                           TextOverflow.ellipsis,
//                         ),
//                       ))
//                       .toList(),
//                   value: selectedState,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedState = value as String;
//                       print("selected State===>" +
//                           selectedState.toString());
//                     });
//                     getCities();
//                   },
//                   icon: const Icon(
//                     Icons.arrow_forward_ios_outlined,
//                     color: AppColor.PrimaryDark,
//                   ),
//                   iconSize: 14,
//                   buttonHeight: 50,
//                   buttonWidth: 160,
//                   buttonPadding: const EdgeInsets.only(
//                       left: 14, right: 14),
//                   buttonDecoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(14),
//                     color:AppColor().colorEdit(),
//                   ),
//                   buttonElevation: 0,
//                   itemHeight: 40,
//                   itemPadding: const EdgeInsets.only(
//                       left: 14, right: 14),
//                   dropdownMaxHeight: 300,
//                   dropdownPadding: null,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius:
//                     BorderRadius.circular(14),
//                   ),
//                   dropdownElevation: 8,
//                   scrollbarRadius:
//                   const Radius.circular(40),
//                   scrollbarThickness: 6,
//                   scrollbarAlwaysShow: true,
//                 ),
//               ),
//       ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           Container(
//             width: 80.99.w,
//             height: 7.46.h,
//             decoration: boxDecoration(
//               radius: 10.0,
//               color:AppColor().colorEdit(),
//             ),
//             child:DropdownButtonHideUnderline(
//               child: DropdownButton2(
//                 isExpanded: true,
//                 hint: Row(
//                   children: [
//                     Image.asset(
//                       city,
//                       width: 6.04.w,
//                       height: 5.04.w,
//                       fit: BoxFit.fill,
//                       color: AppColor.PrimaryDark,
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Expanded(
//                       child: Text(
//                         'Select City',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.normal,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 items: cityList
//                     .map((item) =>
//                     DropdownMenuItem<String>(
//                       value: item.id,
//                       child: Text(
//                         item.name!,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight:
//                           FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                         overflow:
//                         TextOverflow.ellipsis,
//                       ),
//                     ))
//                     .toList(),
//                 value: selectedCity,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCity = value as String;
//                     print("selected State===>" +
//                         selectedCity.toString());
//                   });
//                 },
//                 icon: const Icon(
//                   Icons.arrow_forward_ios_outlined,
//                   color: AppColor.PrimaryDark,
//                 ),
//                 iconSize: 14,
//                 buttonHeight: 50,
//                 buttonWidth: 160,
//                 buttonPadding: const EdgeInsets.only(
//                     left: 14, right: 14),
//                 buttonDecoration: BoxDecoration(
//                   borderRadius:
//                   BorderRadius.circular(14),
//                   color:AppColor().colorEdit(),
//                 ),
//                 buttonElevation: 0,
//                 itemHeight: 40,
//                 itemPadding: const EdgeInsets.only(
//                     left: 14, right: 14),
//                 dropdownMaxHeight: 300,
//                 dropdownPadding: null,
//                 dropdownDecoration: BoxDecoration(
//                   borderRadius:
//                   BorderRadius.circular(14),
//                 ),
//                 dropdownElevation: 8,
//                 scrollbarRadius:
//                 const Radius.circular(40),
//                 scrollbarThickness: 6,
//                 scrollbarAlwaysShow: true,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: serviceOfferedController,
//                   maxLines: 3,
//                   keyboardType: TextInputType.text,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Offered give in ( , )",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     // prefixIcon: Icon(
//                     //   Icons.miscellaneous_services,
//                     //   color: AppColor.PrimaryDark,
//                     // ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           // SERVICE CATEGORY
//           Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//               ),
//               child: FutureBuilder(
//                   future: getServiceCategory(),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     ServiceCategoryModel serviceModel = snapshot.data;
//                     if (snapshot.hasData) {
//                       return DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           isExpanded: true,
//                           hint: Row(
//                             children: [
//                               Image.asset(
//                                 service,
//                                 width: 6.04.w,
//                                 height: 5.04.w,
//                                 fit: BoxFit.fill,
//                                 color: AppColor.PrimaryDark,
//                               ),
//                               SizedBox(
//                                 width: 4,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Select Category',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           items: serviceModel.data!
//                               .map((item) => DropdownMenuItem<String>(
//                             value: item.id,
//                             child: Text(
//                               item.cName!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                               .toList(),
//                           value: selectedCategory,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedCategory = value as String;
//                               // // serviceName.text = serviceModel.data!
//                               //     .firstWhere((element) => element.id == value)
//                               //     .cName
//                               //     .toString();
//                               print("selectedCategory=>" +
//                                   selectedCategory.toString() +
//                                   "serviceName" +
//                                   serviceName.text);
//                             });
//                             print("CATEGORY ID== $selectedCategory");
//                           },
//                           icon: const Icon(
//                             Icons.arrow_forward_ios_outlined,
//                             color: AppColor.PrimaryDark,
//                           ),
//                           iconSize: 14,
//                           buttonHeight: 50,
//                           buttonWidth: 160,
//                           buttonPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           buttonDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             color: AppColor().colorEdit(),
//                           ),
//                           buttonElevation: 0,
//                           itemHeight: 40,
//                           itemPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           dropdownMaxHeight: 300,
//                           dropdownPadding: null,
//                           dropdownDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           dropdownElevation: 8,
//                           scrollbarRadius: const Radius.circular(40),
//                           scrollbarThickness: 6,
//                           scrollbarAlwaysShow: true,
//                         ),
//                       );
//                     }
//                     else if (snapshot.hasError) {
//                       print("ERROR===" + snapshot.error.toString());
//                       return Icon(Icons.error_outline);
//                     }
//                     else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   })),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           // SERVICE SUBCATEGORY
//           Container(
//               width: 80.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 // bgColor: AppColor().colorEdit(),
//               ),
//               child: FutureBuilder(
//                   future: getServicesSubCategory(selectedCategory),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     ServiceSubCategoryModel subCatModel = snapshot.data;
//                     print("SUB CAT DATA=== $subCatModel");
//                     if (snapshot.hasData) {
//                       return DropdownButtonHideUnderline(
//                         child: DropdownButton2(
//                           isExpanded: true,
//                           hint: Row(
//                             children: [
//                               Image.asset(
//                                 special,
//                                 width: 6.04.w,
//                                 height: 5.04.w,
//                                 fit: BoxFit.fill,
//                                 color: AppColor.PrimaryDark,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Select Sub Category',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           items: subCatModel.data!
//                               .map((item) => DropdownMenuItem<String>(
//                             value: item.id,
//                             child: Text(
//                               item.cName!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ))
//                               .toList(),
//                           value: selectSubCategory,
//                           onChanged: (value) {
//                             setState(() {
//                               selectSubCategory = value as String;
//                             });
//                             print("SUB CATEGORY ID== $selectSubCategory");
//                           },
//                           icon: const Icon(
//                             Icons.arrow_forward_ios_outlined,
//                             color: AppColor.PrimaryDark,
//                           ),
//                           iconSize: 14,
//                           buttonHeight: 50,
//                           buttonWidth: 160,
//                           buttonPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           buttonDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             color: AppColor().colorEdit(),
//                           ),
//                           buttonElevation: 0,
//                           itemHeight: 40,
//                           itemPadding:
//                           const EdgeInsets.only(left: 14, right: 14),
//                           dropdownMaxHeight: 300,
//                           dropdownPadding: null,
//                           dropdownDecoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           dropdownElevation: 8,
//                           scrollbarRadius: const Radius.circular(40),
//                           scrollbarThickness: 6,
//                           scrollbarAlwaysShow: true,
//                         ),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Icon(Icons.error_outline);
//                     } else {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                   })),
//           SizedBox(
//             height: 2.62.h,
//           ),
//
//           //service Description
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: descriptionController,
//                   // maxLines: 2,
//                   keyboardType: TextInputType.multiline,
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Description",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.description,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           /*//SERVICE EXPERTS
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.0),
//             ),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: expertsC,
//                   inputFormatters: [LengthLimitingTextInputFormatter(5)],
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Experts",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.credit_card_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),*/
//
//           //SERVICE PRICE
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.0),
//             ),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: serviceCharge,
//                   inputFormatters: [LengthLimitingTextInputFormatter(5)],
//                   textAlignVertical: TextAlignVertical.center,
//                   decoration: InputDecoration(
//                     hintText: "Service Charges",
//                     border: InputBorder.none,
//                     contentPadding:
//                     EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
//                     prefixIcon: Icon(
//                       Icons.credit_card_outlined,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//
//           /* // Service TIME
//           Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14.0)),
//             color: AppColor().colorEdit(),
//             child: Container(
//                 width: 80.99.w,
//                 height: 7.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child: TextFormField(
//                   controller: onpenTime,
//                   textAlignVertical: TextAlignVertical.center,
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     hintText: "Service Time (in Hrs.)",
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
//                     prefixIcon: Icon(
//                       Icons.watch,
//                       color: AppColor.PrimaryDark,
//                     ),
//                   ),
//                   onTap: () async {
//                     _openTimePickerSheet(context);
//                   },
//                 )),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),*/
//
//           // SERVICE IMAGE
//           GestureDetector(
//             onTap: () {
//               // getImagePicker();
//               getFromGallery();
//             },
//             child: Card(
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14.0)),
//               color: AppColor().colorEdit(),
//               child: Container(
//                 width: 80.99.w,
//                 height: 10.46.h,
//                 decoration: boxDecoration(
//                   radius: 14.0,
//                   bgColor: AppColor().colorEdit(),
//                 ),
//                 child:
//                 // servicePic != null
//                    imagePathList != null
//                     ? Padding(
//                   padding: EdgeInsets.all(10.0),
//                   child: Row(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(
//                         Icons.image,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 6,
//                       ),
//                       // Container(
//                       //   width: MediaQuery.of(context).size.width * 0.65,
//                       //   child: ListView.builder(
//                       //     shrinkWrap: true,
//                       //       itemCount: imagePathList.length,
//                       //       itemBuilder: (c,i){
//                       //     return Container(
//                       //       width: MediaQuery.of(context).size.width/2,
//                       //       padding:  EdgeInsets.only(top: 5,bottom: 5),
//                       //       child: Text("${imagePathList[i]}"),
//                       //     );
//                       //   })
//                       //   // Text(
//                       //   //   "$servicePic",
//                       //   //   overflow: TextOverflow.ellipsis,
//                       //   // ),
//                       // SizedBox(
//                       //         width: MediaQuery.of(context).size.width * 0.65,
//                       //         child: ListView.builder(
//                       //           shrinkWrap: true,
//                       //             itemCount: imagePathList.length,
//                       //             itemBuilder: (context,index){
//                       //           return Padding(
//                       //             padding: EdgeInsets.only(top: 5,bottom: 5),
//                       //             child: Text("${imagePathList[index]}"),
//                       //           );
//                       //         })
//                       //         // Text(
//                       //         //   "$servicePic",
//                       //         //   overflow: TextOverflow.ellipsis,
//                       //         // ),
//                       //       ),
//                       Container(
//                         height: 50,
//                         width: MediaQuery.of(context).size.width * 0.65,
//                         child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: imagePathList.length,
//                             itemBuilder: (c,i){
//                               print("checking here ${imagePathList[i]}");
//                           return Padding(
//                             padding:  EdgeInsets.only(bottom: 5),
//                             child: Text("${imagePathList[i]}"),
//                           );
//                         }),
//                       ),
//                     ],
//                   ),
//                 )
//                     : Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.image,
//                         color: AppColor.PrimaryDark,
//                       ),
//                       SizedBox(
//                         width: 6,
//                       ),
//                       Text("Upload service image"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//           Center(
//             child: InkWell(
//               onTap: () async {
//                 var userId = await MyToken.getUserID();
//                 if (_formKey.currentState!.validate()) {
//                   if (selectedCategory!.isNotEmpty &&
//                       selectSubCategory!.isNotEmpty &&
//                       serviceCharge.text.isNotEmpty) {
//                     setState(() {
//                       buttonLogin = true;
//                     });
//                     Map<String, String> param = {
//                       'name': '${serviceName.text.toString()}',
//                       'description': '${descriptionController.text}',
//                       'cat_id': '$selectedCategory',
//                       'scat_id': '$selectSubCategory',
//                       'vid': '$userId',
//                       'price': '${serviceCharge.text.toString()}',
//                       'country_id': "${selectedCountry.toString()}",
//                       "state_id":"${selectedCity.toString()}",
//                       "city_id":"${selectedCity.toString()}",
//                       "service_offered":"${serviceOfferedController.text}",
//                     };
//                     print("ADD SERVICE PARAM=====" + param.toString());
//                     AddServicesModel addModel = await addServices(param);
//                     if (addModel.responseCode == "1") {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => BottomBar()));
//                       UtilityHlepar.getToast(addModel.message);
//                     } else {
//                       UtilityHlepar.getToast(addModel.message);
//                     }
//                   }
//                   else if (selectedCategory!.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceType);
//                   }
//                   else if (selectSubCategory!.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceSubType);
//                   }
//                   else if (serviceCharge.text.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgServiceCharge);
//                   }
//                   else if(servicePic == null){
//                     UtilityHlepar.getToast("Service Image Required");
//                   }
//                 }
//               },
//               child: UtilityWidget.lodingButton(
//                   buttonLogin: buttonLogin, btntext: 'Submit'),
//             ),
//           ),
//           SizedBox(
//             height: 2.5.h,
//           ),
//         ],
//       ),
//     );
//   }
//
//   var selectedTime = TimeOfDay.now();
//
//   Future selectTime(BuildContext context, {from}) async {
//     final TimeOfDay? result = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 // Using 12-Hour format
//                   alwaysUse24HourFormat: false),
//               // If you want 24-Hour format, just change alwaysUse24HourFormat to true
//               child: child!);
//         });
//     if (result != null) {
//       setState(() {
//         _selectedTime = result.format(context);
//         print(_selectedTime.toString());
//       });
//     }
//     print("===========");
//     print(_selectedTime.toString());
//     print(result!.hour);
//     print(result.minute);
//     print(result.period);
//     print(UtilityHlepar.convertTime(time: result));
//     setState(() {
//       if (from == 0) {
//         onpenTime.text = UtilityHlepar.convertTime(time: result);
//       } else {
//         closeTime.text = UtilityHlepar.convertTime(time: result);
//       }
//     });
//   }
//
//   String? _selectedTime;
//
//   Future<void> showTimePikar() async {
//     final TimeOfDay? result = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                 // Using 12-Hour format
//                   alwaysUse24HourFormat: false),
//               // If you want 24-Hour format, just change alwaysUse24HourFormat to true
//               child: child!);
//         });
//     if (result != null) {
//       setState(() {
//         _selectedTime = result.format(context);
//         print(_selectedTime.toString());
//       });
//     }
//   }
//
//   Future<ServiceCategoryModel?> getServiceCategory() async {
//     // var userId = await MyToken.getUserID();
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//           '${Apipath.BASH_URL}get_categories_list',
//         ));
//     print(request);
//
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       return ServiceCategoryModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   Future<ServiceSubCategoryModel?> getServicesSubCategory(catId) async {
//     var request = http.MultipartRequest(
//         'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));
//
//     request.fields.addAll({'p_id': '$catId'});
//
//     print(request);
//     print(request.fields);
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       print(str);
//       return ServiceSubCategoryModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//
//
//   Future addServices(param) async {
//
//     print("ADD SERVICE PARAM=====" + param.toString());
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Apipath.BASH_URL}add_restaurant'));
//     request.fields.addAll(param);
//     // List<MultipartFile> newList = [];
//     // for(var img in imagePathList){
//     //   if(img != ""){
//     //     var multipartFile =  await http.MultipartFile.fromPath('res_image' , File(img).path, filename:img.split('/').last);
//     //     newList.add(multipartFile);
//     //   }
//     // }
//    // request.files.addAll(newList);
//   for(var i=0;i<imagePathList.length;i++){
//     request.files.add(
//         await http.MultipartFile.fromPath('res_image[]', imagePathList[i].toString()));
//   }
//
//     print(request.files);
//
//     http.StreamedResponse response = await request.send();
//
//
//
//
//
//
//
//
//     print(request.toString());
//     print(request.fields.toString());
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       print(str.toString());
//       return AddServicesModel.fromJson(json.decode(str));
//     } else {
//       return null;
//     }
//   }
//
//   getImagePicker() async {
//     /* var imageTemporary;
//     var image = await ImagePickerGC.pickImage(
//         context: context, source: ImgSource.Gallery);
//     if (image == null) return;
//     imageTemporary = File(image.path);
//     setState(() {
//       showImage = image.path;
//     });
//     var base64Image = '';
//     if (imageTemporary.toString().isNotEmpty) {
//       var _image = File(imageTemporary.path);
//       File FileCompressed = await FlutterNativeImage.compressImage(_image.path,
//           quality: 100, percentage: 50);
//       List<int> imagebytes = FileCompressed.readAsBytesSync();
//       base64Image = base64Encode(imagebytes);
//       setState(() {
//         servicePic = _image;
//       });
//       print("SERVICE PIC === ${servicePic.toString()}");
//     }*/
//     try {
//       final image = await ImagePicker().getImage(source: ImageSource.gallery);
//       if(image == null) return;
//       final imageTemp = File(image.path);
//       setState(() => servicePic = imageTemp);
//       print("SERVICE PIC === $servicePic");
//     } on PlatformException catch(e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//     Future<void> getFromGallery() async {
//       var result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//         allowMultiple: true,
//       );
//       if (result != null) {
//         setState(() {
//           // servicePic = File(result.files.single.path.toString());
//         });
//         imagePathList = result.paths.toList();
//         // imagePathList.add(result.paths.toString()).toList();
//         print("SERVICE PIC === ${imagePathList.length}");
//       } else {
//         // User canceled the picker
//       }
//     }
//
//
//   TextEditingController usernameController = TextEditingController();
//   File? file;
//   String profileUrl = "";
//   String url = "";
//
//   void _openTimePickerSheet(BuildContext context) async {
//     final result = await TimePicker.show<DateTime?>(
//       context: context,
//       sheet: TimePickerSheet(
//         sheetTitle: 'Select Service Time',
//         minuteTitle: 'Minute',
//         hourTitle: 'Hour',
//         saveButtonText: 'Save',
//       ),
//     );
//
//     if (result != null) {
//       setState(() {
//         dateTimeSelected = result;
//         service_price = visitingCharge.toString();
//         onpenTime.text = "0${dateTimeSelected.hour}:${dateTimeSelected.minute == 0 ? "0${dateTimeSelected.minute}" : dateTimeSelected.minute} ";
//       });
//       /*if (onpenTime.text.isNotEmpty && serviceCharge.text.isNotEmpty) {
//         // var totalCharges = (int.parse(visitingCharge!) + int.parse(serviceCharge.text.toString()));
//         // print("TOTAL CHARGES=== $totalCharges");
//         // perMinServiceCharge = totalCharges/60;
//         // print("PERMINUTE SERVICE CHARGE=== ${perMinServiceCharge.toStringAsFixed(2)}");
//         var parts = onpenTime.text.toString().split(':');
//         var hrsToMinute = (int.parse(parts[0].padLeft(2, '0')) * 60);
//         print("hrs min======$hrsToMinute");
//         var finalTime = hrsToMinute + int.parse(parts[1].padLeft(2, '0'));
//         print("FINAL TIME===== $finalTime");
//         var amount = (int.parse(visitingCharge!) + (int.parse(serviceCharge.text.toString()) * finalTime));
//         print("AMOUNT==== $amount");
//         setState(() {
//           finalCharges = amount.toString();
//           servicePrice.text = finalCharges;
//         });
//       }*/
//     }
//   }
// }