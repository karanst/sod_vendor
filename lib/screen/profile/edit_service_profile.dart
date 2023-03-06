// import 'package:fixerking/api/api_helper/home_api_helper.dart';
// import 'package:fixerking/modal/request/update_service_request.dart';
// import 'package:fixerking/modal/response/get_service_profile_response.dart';
// import 'package:fixerking/modal/response/update_service_profile_response.dart';
// import 'package:fixerking/screen/auth_view/service_type_list.dart';
// import 'package:fixerking/screen/auth_view/specialization_list.dart';
// import 'package:fixerking/token/app_token_data.dart';
// import 'package:fixerking/utility_widget/utility_widget.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:fixerking/utils/constant.dart';
// import 'package:fixerking/utils/images.dart';
// import 'package:fixerking/utils/showDialog.dart';
// import 'package:fixerking/utils/toast_string.dart';
// import 'package:fixerking/utils/utility_hlepar.dart';
// import 'package:fixerking/utils/widget.dart';
// import 'package:fixerking/validation/form_validation.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sizer/sizer.dart';
//
// class EditServiceProfile extends StatefulWidget {
//   late ServiceProfileResponse profileResponse;
//   EditServiceProfile({Key? key, required this.profileResponse})
//       : super(key: key);
//
//   @override
//   State<EditServiceProfile> createState() => _EditServiceProfileState();
// }
//
// class _EditServiceProfileState extends State<EditServiceProfile> {
//   TextEditingController onpenTime = TextEditingController();
//   TextEditingController clogeTime = TextEditingController();
//   GlobalKey<FormState> _formkey = GlobalKey();
//   late bool buttonLogin = false;
//   List serviceTypeId = [];
//   List specilizationTypeId = [];
//   late String serviceName = "Service type";
//   late String specialization = "Specialization";
//   bool selected = false;
//
//   //   var serviceType = "Service type";
//   // var specialization = "Specialization";
//   @override
//   void initState() {
//     super.initState();
//     setuserdata();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//             child: Form(
//       key: _formkey,
//       child: AnimatedContainer(
//           duration: Duration(milliseconds: 1000),
//           curve: Curves.easeInOut,
//           width: 100.w,
//           decoration: BoxDecoration(
//             gradient: RadialGradient(
//               center: Alignment(0.0, -0.5),
//               colors: [
//                 AppColor().colorBg1(),
//                 AppColor().colorBg1(),
//               ],
//               radius: 0.8,
//             ),
//           ),
//           padding: MediaQuery.of(context).viewInsets,
//           child: Column(children: [
//             Container(
//               height: 9.92.h,
//               width: 100.w,
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                 image: AssetImage(profileBg),
//                 fit: BoxFit.fill,
//               )),
//               child: Center(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                         width: 6.38.w,
//                         height: 6.38.w,
//                         alignment: Alignment.centerLeft,
//                         margin: EdgeInsets.only(left: 7.91.w),
//                         child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Image.asset(
//                               back,
//                               height: 4.0.h,
//                               width: 8.w,
//                             ))),
//                     SizedBox(
//                       width: 2.08.h,
//                     ),
//                     Container(
//                       width: 65.w,
//                       child: text(
//                         "Edit Service Profile",
//                         textColor: Color(0xffffffff),
//                         fontSize: 14.sp,
//                         fontFamily: fontMedium,
//                         isCentered: true,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5.02.h,
//             ),
//
//             // new
//             Container(
//               width: 90.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 bgColor: AppColor().colorEdit(),
//               ),
//               child: InkWell(
//                 onTap: () async {
//                   print("data");
//                   serviceTypeId = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ServiceTypeList()));
//                   print(serviceTypeId);
//                   if (serviceTypeId.isNotEmpty) {
//                     setState(() {
//                       serviceName = serviceTypeId[0].toString();
//                     });
//                   }
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(3.5.w),
//                           child: Image.asset(
//                             service,
//                             width: 6.04.w,
//                             height: 5.04.w,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 40.00.w,
//                           child: Text(
//                             serviceName,
//                             softWrap: true,
//                             overflow: TextOverflow.clip,
//                             style: TextStyle(
//                               color: AppColor().colorTextFour(),
//                               fontSize: 10.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(3.5.w),
//                       child: Image.asset(
//                         down,
//                         width: 6.04.w,
//                         height: 6.04.w,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             // new line2
//             Container(
//               width: 90.99.w,
//               height: 7.46.h,
//               decoration: boxDecoration(
//                 radius: 10.0,
//                 bgColor: AppColor().colorEdit(),
//               ),
//               child: InkWell(
//                 onTap: () async {
//                   print("data");
//                   if (serviceTypeId.isNotEmpty) {
//                     specilizationTypeId = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => SpecializationList(
//                                 serviceId: serviceTypeId[1].toString())));
//                     print("===============");
//                     print(specilizationTypeId);
//                     if (specilizationTypeId.isNotEmpty) {
//                       setState(() {
//                         specialization = specilizationTypeId[0].toString();
//                       });
//                     }
//                   } else {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceType);
//                   }
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(3.5.w),
//                           child: Image.asset(
//                             special,
//                             width: 6.04.w,
//                             height: 5.04.w,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 40.00.w,
//                           child: Text(
//                             specialization,
//                             softWrap: true,
//                             overflow: TextOverflow.clip,
//                             style: TextStyle(
//                               color: AppColor().colorTextFour(),
//                               fontSize: 10.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(3.5.w),
//                       child: Image.asset(
//                         down,
//                         width: 6.04.w,
//                         height: 6.04.w,
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 2.h,
//             ),
//             // new time
//             Container(
//               width: 90.99.w,
//               child: TextFormField(
//                 readOnly: true,
//                 onTap: () => selectTime(context, from: 0),
//                 cursorColor: Colors.red,
//                 keyboardType: TextInputType.name,
//                 controller: onpenTime,
//                 validator: FormValidation.checkEmptyValidator,
//                 style: TextStyle(
//                   color: AppColor().colorTextFour(),
//                   fontSize: 10.sp,
//                 ),
//                 inputFormatters: [],
//                 decoration: InputDecoration(
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                         color: AppColor().colorEdit(),
//                         width: 1.0,
//                         style: BorderStyle.solid),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   labelText: 'Open Time',
//                   labelStyle: TextStyle(
//                     color: AppColor().colorTextFour(),
//                     fontSize: 10.sp,
//                   ),
//                   helperText: '',
//                   counterText: '',
//                   fillColor: AppColor().colorEdit(),
//                   enabled: true,
//                   filled: true,
//                   prefixIcon: Container(
//                       padding: EdgeInsets.all(3.5.w), child: Icon(Icons.watch)),
//                   suffixIcon: Container(
//                       width: 10.w,
//                       alignment: Alignment.center,
//                       child: FaIcon(
//                         FontAwesomeIcons.check,
//                         color: AppColor().colorPrimary(),
//                         size: 10.sp,
//                       )),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide:
//                         BorderSide(color: AppColor().colorEdit(), width: 5.0),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                 ),
//               ),
//             ),
//
//             // new line
//             Container(
//               width: 90.99.w,
//               child: TextFormField(
//                 readOnly: true,
//                 onTap: () => selectTime(context, from: 1),
//                 cursorColor: Colors.red,
//                 keyboardType: TextInputType.name,
//                 controller: clogeTime,
//                 validator: FormValidation.checkEmptyValidator,
//                 style: TextStyle(
//                   color: AppColor().colorTextFour(),
//                   fontSize: 10.sp,
//                 ),
//                 inputFormatters: [],
//                 decoration: InputDecoration(
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                         color: AppColor().colorEdit(),
//                         width: 1.0,
//                         style: BorderStyle.solid),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   labelText: 'Close Time',
//                   labelStyle: TextStyle(
//                     color: AppColor().colorTextFour(),
//                     fontSize: 10.sp,
//                   ),
//                   helperText: '',
//                   counterText: '',
//                   fillColor: AppColor().colorEdit(),
//                   enabled: true,
//                   filled: true,
//                   prefixIcon: Container(
//                       padding: EdgeInsets.all(3.5.w), child: Icon(Icons.watch)),
//                   suffixIcon: Container(
//                       width: 10.w,
//                       alignment: Alignment.center,
//                       child: FaIcon(
//                         FontAwesomeIcons.check,
//                         color: AppColor().colorPrimary(),
//                         size: 10.sp,
//                       )),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide:
//                         BorderSide(color: AppColor().colorEdit(), width: 5.0),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                 ),
//               ),
//             ),
//
//             InkWell(
//               onTap: () {
//                 if (_formkey.currentState!.validate()) {
//                   if (serviceTypeId.isNotEmpty &&
//                       specilizationTypeId.isNotEmpty) {
//                     setState(() {
//                       buttonLogin = true;
//                     });
//                     updateProfile();
//                   } else if (serviceTypeId.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSelectServiceType);
//                   } else if (specilizationTypeId.isEmpty) {
//                     UtilityHlepar.getToast(ToastString.msgSpecializationType);
//                   }
//                 }
//               },
//               child: UtilityWidget.lodingButton(
//                   buttonLogin: buttonLogin, btntext: "update"),
//             )
//           ])),
//     )));
//   }
//
//   var selectedTime = TimeOfDay.now();
//   var _selectedTime;
//   Future selectTime(BuildContext context, {from}) async {
//     final TimeOfDay? result = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                   // Using 12-Hour format
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
//         clogeTime.text = UtilityHlepar.convertTime(time: result);
//       }
//     });
//   }
//
//   void setuserdata() async {
//     onpenTime.text =
//         widget.profileResponse.data![0].time!.split(",")[0].replaceAll("[", "");
//     clogeTime.text =
//         widget.profileResponse.data![0].time!.split(",")[1].replaceAll("]", "");
//     setState(() {});
//   }
//
//   late UpdateServiceProfileResponse updateServiceProfileResponse;
//   void updateProfile() async {
//     MYDialog.loadingDialog(context);
//     String userid = await MyToken.getUserID();
//     String serviceType = serviceTypeId[0].toString();
//     String specilization = specilizationTypeId[0].toString();
//     String time = [onpenTime.text, clogeTime.text].toString();
//     UpdateServiceRequest request = UpdateServiceRequest(
//         userid: userid,
//         serviceType: serviceType,
//         specilization: specilization,
//         time: time);
//     print(request.tojson());
//     updateServiceProfileResponse =
//         await HomeApiHelper.updateServiceProfile(request);
//     if (updateServiceProfileResponse.responseCode == ToastString.responseCode) {
//       UtilityHlepar.getToast(updateServiceProfileResponse.message!);
//     }
//     Navigator.pop(context);
//     Navigator.pop(context);
//     Navigator.pop(context);
//     // r
//     // req
//   }
// }
