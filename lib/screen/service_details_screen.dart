// import 'dart:convert';
//
// import 'package:animated_widgets/animated_widgets.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:fixerking/api/api_helper/home_api_helper.dart';
// import 'package:fixerking/api/api_path.dart';
// import 'package:fixerking/modal/complete_booking_model.dart';
// import 'package:fixerking/modal/request/order_status_request.dart';
// import 'package:fixerking/modal/request/work_complete_request.dart';
// import 'package:fixerking/modal/response/get_new_order_response.dart';
// import 'package:fixerking/modal/response/update_order_status_response.dart';
// import 'package:fixerking/modal/response/work_done_response.dart';
// import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
// import 'package:fixerking/screen/payment_screen.dart';
// import 'package:fixerking/utils/app_strings.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:fixerking/utils/constant.dart';
// import 'package:fixerking/utils/images.dart';
// import 'package:fixerking/utils/showDialog.dart';
// import 'package:fixerking/utils/toast_string.dart';
// import 'package:fixerking/utils/utility_hlepar.dart';
// import 'package:fixerking/utils/widget.dart';
// import 'package:fixerking/validation/form_validation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import 'package:http/http.dart' as http;
// import '../modal/VendorOrderModel.dart';
//
// class ServiceScreenDetails extends StatefulWidget {
//   int i;
//   VendorOrderModel orderResponse;
//   ServiceScreenDetails({Key? key, required this.orderResponse, required this.i})
//       : super(key: key);
//
//   @override
//   _ServiceScreenDetailsState createState() => _ServiceScreenDetailsState();
// }
//
// class _ServiceScreenDetailsState extends State<ServiceScreenDetails> {
//   bool selected = false, enabled = false, edit = false;
//   var statusType = "";
//   int statusIndex = 0;
//   bool isComplete = false;
//   TextEditingController otpController = TextEditingController();
//   TextEditingController worktimeContoller = TextEditingController();
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   List statusList = [
//     "Pending",
//     "Confirm",
//     "Cancelled by user ",
//     "Cancelled by vendor",
//     "work done",
//     "Booking Cancel"
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     statusType = widget.orderResponse.data![widget.i].status.toString();
//     print("STATUS TYPE ==== $statusType");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("STATUS====>"+widget.orderResponse.data![widget.i].status.toString());
//     print("INDEX====>  ${widget.i.toString()}");
//     changeStatusBarColor(AppColor().colorPrimary());
//     return Scaffold(
//       backgroundColor: AppColor().colorBg1(),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 1000),
//               curve: Curves.easeInOut,
//               width: 100.w,
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
//               padding: MediaQuery.of(context).viewInsets,
//               child: Column(
//                 children: [
//                   Container(
//                     height: 9.92.h,
//                     width: 100.w,
//                     color: AppColor.PrimaryDark,
//                     child: Center(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                               width: 6.38.w,
//                               height: 6.38.w,
//                               alignment: Alignment.centerLeft,
//                               margin: EdgeInsets.only(left: 7.91.w),
//                               child: InkWell(
//                                   onTap: () {
//                                     Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => BottomBar()));
//                                   },
//                                   child: Image.asset(
//                                     back,
//                                     height: 4.0.h,
//                                     width: 8.w,
//                                   ))),
//                           SizedBox(
//                             width: 2.08.h,
//                           ),
//                           Container(
//                             width: 65.w,
//                             child: text("Booking Details",
//                                 textColor: Color(0xffffffff),
//                                 fontSize: 14.sp,
//                                 fontFamily: fontMedium,
//                                 isCentered: true),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(
//                         left: 8.33.w, right: 8.33.w, top: 1.87.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         text(
//                           "Booking ID #" +
//                               widget.orderResponse.data![widget.i].id
//                                   .toString(),
//                           textColor: Color(0xff000833),
//                           fontSize: 14.sp,
//                           fontFamily: fontBold,
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               text(
//                                 "Paid Amount",
//                                 textColor: Color(0xff000000),
//                                 fontSize: 10.sp,
//                                 fontFamily: fontBold,
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               text(
//                                 widget.orderResponse.data![widget.i].price
//                                     .toString(),
//                                 textColor: AppColor().colorPrimaryDark(),
//                                 fontSize: 10.sp,
//                                 fontFamily: fontBold,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   //SizedBox(width: 3.12.h,),
//                   Container(
//                     margin: EdgeInsets.only(
//                         left: 8.33.w, right: 8.33.w, top: 1.87.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         widget.orderResponse.data![widget.i].isPaid == "1" ? text(
//                           "Payment Status: PAID" ,
//                           textColor: Color(0xff13CE3F),
//                           fontSize: 10.sp,
//                           fontFamily: fontSemibold,
//                         ) : text(
//                           "Payment Status: UNPAID" ,
//                           textColor: Colors.red,
//                           fontSize: 10.sp,
//                           fontFamily: fontSemibold,
//                         ),
//
//                         SizedBox(width: 20,),
//
//                         dateTimeText(widget.orderResponse.data![widget.i].date!),
//                         text("${widget.orderResponse.data![widget.i].slot!}",
//                           textColor: Colors.black,
//                           fontSize: 10.sp,
//                           fontFamily: fontSemibold,
//                         ),
//
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(
//                         left: 8.33.w, right: 8.33.w, top: 1.87.h),
//                     child: Divider(
//                       height: 1.0,
//                       color: Color(0xff707070),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 1.52.h,
//                   ),
//                   text(
//                     "Customer Details",
//                     textColor: AppColor.PrimaryDark,
//                     fontSize: 14.sp,
//                     fontFamily: fontBold,
//                   ),
//                   SizedBox(
//                     height: 1.52.h,
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w),
//                     padding: EdgeInsets.only(
//                         left: 2.91.w, right: 2.91.w, top: 2.67.h),
//                     height: 23.82.h,
//                     decoration: boxDecoration(
//                       showShadow: true,
//                       radius: 20.0,
//                       bgColor: AppColor().colorBg1(),
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     text(
//                                       "Customer Name",
//                                       textColor: Color(0xff000000),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontBold,
//                                     ),
//                                     SizedBox(
//                                       height: 1.02.h,
//                                     ),
//                                     text(
//                                       widget.orderResponse.data![widget.i]
//                                           .username!,
//                                       textColor: Color(0xff757575),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontSemibold,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     text(
//                                       "Customer Contact No.",
//                                       textColor: Color(0xff000000),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontBold,
//                                     ),
//                                     SizedBox(
//                                       height: 1.02.h,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 30.0),
//                                       child: text(
//                                         "+91 " +
//                                             UtilityHlepar.convertNA(widget
//                                                 .orderResponse
//                                                 .data![widget.i]
//                                                 .mobile!),
//                                         textColor: Color(0xff757575),
//                                         fontSize: 10.sp,
//                                         fontFamily: fontSemibold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 3.42.h,
//                         ),
//                         Container(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               text(
//                                 "Customer Address",
//                                 textColor: Color(0xff000000),
//                                 fontSize: 10.sp,
//                                 fontFamily: fontBold,
//                               ),
//                               SizedBox(
//                                 height: 1.02.h,
//                               ),
//                               text(
//                                   widget.orderResponse.data![widget.i]
//                                       .address!,
//                                   textColor: Color(0xff757575),
//                                   fontSize: 9.sp,
//                                   fontFamily: fontSemibold,
//                                   maxLine: 2),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 1.52.h,
//                   ),
//                   text(
//                     "Service Details",
//                     textColor: AppColor.PrimaryDark,
//                     fontSize: 14.sp,
//                     fontFamily: fontBold,
//                   ),
//                   SizedBox(
//                     height: 1.52.h,
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w),
//                     padding: EdgeInsets.only(
//                         left: 2.91.w, right: 2.91.w, top: 2.67.h),
//                     height: 12.32.h,
//                     decoration: boxDecoration(
//                       showShadow: true,
//                       radius: 20.0,
//                       bgColor: AppColor().colorBg1(),
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     text(
//                                       "Service Type",
//                                       textColor: Color(0xff000000),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontBold,
//                                     ),
//                                     SizedBox(
//                                       height: 1.02.h,
//                                     ),
//                                     text(
//                                       widget.orderResponse.data![widget.i].resName!,
//                                       textColor: Color(0xff757575),
//                                       fontSize: 9.sp,
//                                       fontFamily: fontSemibold,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               /*Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     text(
//                                       "Duration",
//                                       textColor: Color(0xff000000),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontBold,
//                                     ),
//                                     SizedBox(
//                                       height: 1.02.h,
//                                     ),
//                                     text(
//                                       widget.orderResponse.data![widget.i].slot!
//                                         // +
//                                           // " " +
//                                           // UtilityHlepar.convertNA(widget
//                                           //     .orderResponse
//                                           //     .booking![widget.i]
//                                           //     .service!
//                                           //     .priceUnit!
//                                           // )
//                                         ,
//                                       textColor: Color(0xff757575),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontSemibold,
//                                     ),
//                                   ],
//                                 ),
//                               ),*/
//                               Container(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     text(
//                                       "Price ",
//                                       textColor: Color(0xff000000),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontBold,
//                                     ),
//                                     SizedBox(
//                                       height: 1.02.h,
//                                     ),
//                                     text(
//                                       AppStrings.currencySymbols +
//                                           " " +
//                                           UtilityHlepar.convertNA(widget
//                                               .orderResponse
//                                               .data![widget.i]
//                                               .price),
//                                       textColor: Color(0xffFD531F),
//                                       fontSize: 10.sp,
//                                       fontFamily: fontSemibold,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5.0),
//                           child: Center(
//                             child: Text(
//                               "Booking Status: ${widget.orderResponse.data![widget.i].status!}",
//                             style: TextStyle(
//                               color: Color(0xff13CE3F),
//                               fontSize: 10.sp,
//                               fontFamily: fontSemibold,
//                             ),),
//
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 1.52.h,
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: 2.91.w, right: 2.91.w, top: 2.67.h),
//                     // height: 62.62.h,
//                     width: 83.88.w,
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomLeft,
//                       tileMode: TileMode.clamp,
//                       colors: [
//                         AppColor().colorBg1(),
//                         AppColor().colorBg2(),
//                       ],
//                     )),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 1.52.h,
//                         ),
//                         DottedBorder(
//                           color: Color(0xff707070),
//                           strokeWidth: 1,
//                           dashPattern: [3],
//                           strokeCap: StrokeCap.square,
//                           radius: const Radius.circular(10),
//                           child: Container(
//                             // width: 50.69.w,
//                             // height: 4.37.h,
//                             child: Center(
//                               child: text(
//                                 "Work Status " +
//                                     UtilityHlepar.convertNA(widget
//                                         .orderResponse.data![widget.i].status
//                                         .toString()),
//                                 textColor: AppColor.PrimaryDark,
//                                 fontSize: 14.sp,
//                                 fontFamily: fontBold,
//                                 isCentered: true,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 3.02.h,
//                         ),
//                         /*statusList[4] == statusList[statusIndex]
//                             ? Container(
//                                 width: 69.99.w,
//                                 // height: 9.46.h,
//                                 child: TextFormField(
//                                   cursorColor: Colors.red,
//                                   keyboardType: TextInputType.text,
//                                   validator: FormValidation.checkEmptyValidator,
//                                   controller: worktimeContoller,
//                                   style: TextStyle(
//                                     color: AppColor().colorTextFour(),
//                                     fontSize: 10.sp,
//                                   ),
//                                   inputFormatters: [],
//                                   decoration: InputDecoration(
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColor().colorEdit(),
//                                           width: 1.0,
//                                           style: BorderStyle.solid),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                     ),
//                                     labelText: 'Enter Work Time',
//                                     labelStyle: TextStyle(
//                                       color: AppColor().colorTextFour(),
//                                       fontSize: 10.sp,
//                                     ),
//                                     helperText: '',
//                                     counterText: '',
//                                     fillColor: AppColor().colorBg1(),
//                                     enabled: true,
//                                     filled: true,
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColor().colorBg1(),
//                                           width: 5.0),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : Container(),*/
//                         widget.orderResponse.data![widget.i].aStatus == "2" && widget.orderResponse.data![widget.i].isPaid == "1"
//                             ? Container(
//                                 width: 69.99.w,
//                                 // height: 9.46.h,
//                                 child: TextFormField(
//                                   cursorColor: Colors.red,
//                                   keyboardType: TextInputType.number,
//                                   controller: otpController,
//                                   validator: FormValidation.checkEmptyValidator,
//                                   style: TextStyle(
//                                     color: AppColor().colorTextFour(),
//                                     fontSize: 10.sp,
//                                   ),
//                                   inputFormatters: [
//                                     FilteringTextInputFormatter.digitsOnly
//                                   ],
//                                   decoration: InputDecoration(
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColor().colorEdit(),
//                                           width: 1.0,
//                                           style: BorderStyle.solid),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                     ),
//                                     labelText: 'Enter Customer OTP',
//                                     labelStyle: TextStyle(
//                                       color: AppColor().colorTextFour(),
//                                       fontSize: 10.sp,
//                                     ),
//                                     helperText: '',
//                                     counterText: '',
//                                     fillColor: AppColor().colorBg1(),
//                                     enabled: true,
//                                     filled: true,
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColor().colorBg1(),
//                                           width: 5.0),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0)),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : Container()
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 3.02.h,
//                   ),
//
//                   /*statusList[4] ==
//                               widget.orderResponse.data![widget.i].status
//                                   .toString() ||
//                           statusList[5] ==
//                               widget.orderResponse.data![widget.i].status
//                                   .toString()
//                       ? Container()
//                       : SizedBox(
//                           height: 60,
//                           child: ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: statusList.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, int i) {
//                                 return InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       statusType = statusList[i].toString();
//                                       statusIndex = i;
//                                     });
//                                   },
//                                   child: Container(
//                                     height: 8.h,
//                                     alignment: Alignment.center,
//                                     margin: EdgeInsets.all(5),
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 15,
//                                     ),
//                                     decoration: BoxDecoration(
//                                         color: widget.orderResponse
//                                                     .data![widget.i].status
//                                                     .toString()
//                                                     .toLowerCase() ==
//                                                 statusList[i]
//                                                     .toString()
//                                                     .toLowerCase()
//                                             ? Colors.green
//                                             : statusList.indexOf(widget
//                                                         .orderResponse
//                                                         .data![widget.i]
//                                                         .status!) >=
//                                                     i
//                                                 ? Colors.green
//                                                 : statusIndex == i
//                                                     ? Colors.red
//                                                     : Colors.grey.withOpacity(0.5),
//                                         // : statusIndex == i
//                                         //     ? Colors.black
//                                         //     : Colors.red,
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     child: Text(
//                                       statusList[i],
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                   SizedBox(
//                     height: 3.02.h,
//                   ),*/
//
//                   widget.orderResponse.data![widget.i].aStatus == "2" && widget.orderResponse.data![widget.i].isPaid == "1"
//                       ? InkWell(
//                     onTap: () async {
//                       if(otpController.text.isNotEmpty){
//                         CompleteBookingModel cmplteModel = await completeBooking();
//                         if(cmplteModel.responseCode == "1"){
//                           UtilityHlepar.getToast("${cmplteModel.msg}");
//                           Navigator.pop(context);
//                         }
//                       } else {
//                         UtilityHlepar.getToast("Please Enter OTP");
//                       }
//                     },
//                     child: Container(
//                       child: text("Complete Work"),
//                       height: 8.h,
//                       width: 90.w,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           color: AppColor.PrimaryDark,
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                   )
//                       : Container(),
//                   SizedBox(
//                     height: 2.02.h,
//                   ),
//
//                   // Container(
//                   //   margin: EdgeInsets.only(top: 0,left: 20,right: 20),
//                   //   alignment: Alignment.center,
//                   //   height: 40,
//                   //   decoration: BoxDecoration(
//                   //     color: AppColor().colorPrimary(),
//                   //     borderRadius: BorderRadius.circular(6),
//                   //   ),
//                   //   child: Text("Cancel Booking",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   late UpdateStatusResponse statusResponse;
//
//   Future completeBooking() async {
//
//     var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}complete_booking'));
//     request.fields.addAll({
//       'id': '${widget.orderResponse.data![widget.i].id}',
//       'otp': '${otpController.text.toString()}'
//     });
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       return CompleteBookingModel.fromJson(json.decode(str));
//     }
//     else {
//       return null;
//     }
//
//   }
//
//   updateStatus() async {
//     // statusList.singleWhere((i) => i == statusList[statusIndex]);
//     print(statusList.indexOf(statusList[statusIndex]));
//     print(statusList.indexOf(widget.orderResponse.data![widget.i].status!) >
//         statusIndex);
//     if (statusList.indexOf(widget.orderResponse.data![widget.i].status!) > statusIndex) {
//       UtilityHlepar.getToast(ToastString.statusAlreadyUpdate);
//     } else {
//       if (statusList[4] == statusList[statusIndex]) {
//         workeDone();
//       } else {
//         workeNotDone();
//       }
//     }
//   }
//
//   dateTimeText(String date){
//     DateTime dateTime =DateTime.parse(date);
//     return text(
//       DateFormat("dd-MMM-yyyy").format(dateTime),
//       textColor: Color(0xff2E2E2E),
//       fontSize: 10.sp,
//       fontFamily: fontSemibold,
//     );
//   }
//
//   String formatedTime(TimeOfDay selectedTime) {
//     DateTime tempDate = DateFormat.Hms().parse(selectedTime.hour.toString() +
//         ":" +
//         selectedTime.minute.toString() +
//         ":" +
//         '0' +
//         ":" +
//         '0');
//     var dateFormat = DateFormat("h:mm a");
//     return (dateFormat.format(tempDate));
//   }
//
//   late WorkDoneResponse workDoneResponse;
//
//   workeDone() async {
//     if (_formKey.currentState!.validate()) {
//       MYDialog.loadingDialog(context);
//       String bookingId = widget.orderResponse.data![widget.i].id.toString();
//       String otp = otpController.text;
//       String workHours = worktimeContoller.text;
//       WorkDoneRequest request =
//           WorkDoneRequest(bookingId: bookingId, otp: otp, workHours: workHours);
//       print(request.tojson());
//       workDoneResponse = await HomeApiHelper.workCompletedStatus(request);
//       Navigator.pop(context);
//       UtilityHlepar.getToast(workDoneResponse.message);
//       if (workDoneResponse.responseCode == ToastString.responseCode) {
//         Navigator.pop(context);
//       }
//     }
//   }
//
//   workeNotDone() async {
//     String id = widget.orderResponse.data![widget.i].id.toString();
//     String status = statusType;
//     OrderStatusRequest request = OrderStatusRequest(id: id, statusType: status);
//     print(request.tojson());
//     statusResponse = await HomeApiHelper.updateOrderStatus(request);
//     UtilityHlepar.getToast(statusResponse.message);
//     if (statusResponse.responseCode == ToastString.responseCode) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => BottomBar()),
//           (route) => false);
//     }
//   }
//
// }
//
