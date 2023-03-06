
import 'dart:async';
import 'dart:convert';

// import 'package:dotted_line/dotted_line.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fixerking/RideFlow/DrawerPages/Home/offline_page.dart';
import 'package:fixerking/RideFlow/DrawerPages/Rides/ride_info_page.dart';
import 'package:fixerking/api/api_helper/auth_helper.dart';
import 'package:fixerking/modal/request/get_profile_request.dart';
import 'package:fixerking/modal/response/get_profile_response.dart';
import 'package:fixerking/new%20model/GetProfileModel.dart';
import 'package:fixerking/new%20model/delivery_booking_model.dart';
import 'package:fixerking/new%20model/food_delivery_model.dart';
import 'package:fixerking/new%20model/labour_request_model.dart';
import 'package:fixerking/new%20model/new_food_delivery_model.dart';
import 'package:fixerking/screen/Booking%20Details/delivery_service_details.dart';
import 'package:fixerking/screen/Booking%20Details/event_services_details.dart';
import 'package:fixerking/screen/Booking%20Details/order_food_delivery.dart';
import 'package:fixerking/screen/Booking%20Details/order_food_details.dart';
import 'package:fixerking/screen/Booking%20Details/parcel_service_details.dart';
import 'package:fixerking/screen/delivery_details.dart';
import 'package:fixerking/screen/newScreens/AddService.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/screen/notification_screen.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../modal/RemoveServiceModel.dart';
import '../new model/Get_vendor_order_Model.dart';
import '../new model/VendorBookingModel.dart';
import '../token/app_token_data.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;

import '../utils/utility_hlepar.dart';
import 'edit_services.dart';

class ManageService extends StatefulWidget {
  final bool? isIcon;
  final int? index;
  const ManageService({Key? key,  this.isIcon, this.index}) : super(key: key);

  @override
  State<ManageService> createState() => _ManageServiceState();
}

class _ManageServiceState extends State<ManageService> {
  TextEditingController onpenTime = new TextEditingController();
  TextEditingController imageC = new TextEditingController();
  TextEditingController closeTime = new TextEditingController();
  TextEditingController serviceCharge = new TextEditingController();
  TextEditingController serviceName = new TextEditingController();
  TextEditingController serviceIssue = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController servicePrice = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  bool buttonLogin = false;
  String? selectedCategory, selectSubCategory, selectChildCategory, selectModel;
  double perMinServiceCharge = 0.0;
  String? visitingCharge;
  String? issue;
  List serviceTypeId = [];
  List specilizationTypeId = [];
  String finalCharges = "0";
  var servicePic;
  var storeId;
  DateTime dateTimeSelected = DateTime.now();
  String showImage = '';
  String service_price = "";
  String service_name = "";
  int _selectedIndex = 0;
  int _selectedIndex1 = 0;

  String? roleName;

  StreamController<GetProfileResponse> profileResponseStram = StreamController();
  late GetProfileResponse profileResponse;

  String? deliveryType;

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    type = prefs.getString(TokenString.type);

    var headers = {
      'Cookie': 'ci_session=3ab2e0bfe4c2535c351d13c7ca58f780dce6aa8f'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${Apipath.getProfileApi}'));
    request.fields.addAll({
      'vid': '${uid.toString()}'
      //'$uid'
    });
    print("this is request =====>>>>> ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var result = GetProfileModel.fromJson(json.decode(str));
      deliveryType = result.data![0].deliveryType;
      // prefs.setString(TokenString.approvalStatus, approvalStatus!);
      print("this is delivery type ====>>> ${deliveryType.toString()}");
      return GetProfileModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  String? roles;
  String? type;

  @override
  void initState() {
    super.initState();
    checkingLogin();
    getProfile();
    _selectedIndex = widget.index!;


    // getProfile();

    // if (roleName == "Labour") {
    //   getLabourServices();
    // } else {
    //   getDeliveryServices();
    // }
  }

  Future getFoodOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.getVendorOrders}'));
    request.fields.addAll({
      'v_id': '$uid',
      'status': _selectedIndex == 0
          ? '2'
          : _selectedIndex == 1
          ? '3'
          : _selectedIndex == 2 ?
          '4'
          :'1'
    });
    print('request here ${request.fields}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = GetVendorOrderModel.fromJson(json.decode(str));
      print("ssssssssssss ${datas} and ${datas.status} and ${datas.orders}");
      return GetVendorOrderModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future getFoodDeliveryOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request =
    http.MultipartRequest('POST', Uri.parse('${Apipath.getFoodDeliveryOrdersUrl}'));
    request.fields.addAll({
      'v_id': '$uid',
      'status': _selectedIndex == 0
          ? '2'
          : _selectedIndex == 1
          ? '3'
          : _selectedIndex == 2 ?
      '4'
          :'1'
    });
    print('request here ${request.fields}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = NewFoodDeliveryModel.fromJson(json.decode(str));
      print("ssssssssssss ${datas} and ${datas.status} and ${datas.orders}");
      return NewFoodDeliveryModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future getDeliveryBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.getDeliveryBooking}'));
    request.fields.addAll({
          'driver_id':'$uid',
      'type':'${type.toString()}',
      'status': _selectedIndex == 0
          ?'1,2'
          : _selectedIndex == 1
          ?'3'
          : _selectedIndex == 2
          ?'4'
          :'0'
    });
    print("this is ride request ${request.fields.toString()}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = DeliveryBookingModel.fromJson(json.decode(str));
      print("ssssssssssss ${datas} and ${datas.msg} and ${datas.totalAmount}");
      return DeliveryBookingModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }


  String? uid;

  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid).toString();
      type = prefs.getString(TokenString.type).toString();
    });
    print("this id uid ${uid.toString()} aand ${type}");
  }


  cardWidgetFoodDelivery(NewFoodDeliveryModel? model, int i) {
    return InkWell(
      onTap: () {
        // if(type == "2") {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               OrderFoodDelivery(
        //                 data: model.orders![i],
        //               )));
        // }else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NewOrderFoodDeliver(
                      data: model!.orders![i],
                      type: type.toString(),
                      uid: uid.toString(),
                    )));
        // }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 5,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            // padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.PrimaryDark),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 12.0, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model!.orders![i].username}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Id",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.orders![i].orderId}",
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.orders![i].date}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "₹ ${model.orders![i].total}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 15, right: 15),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Address",
                //         style: TextStyle(
                //             color: AppColor().colorPrimary(),
                //             fontWeight: FontWeight.normal),
                //       ),
                //       Container(
                //         width: 220,
                //         //MediaQuery.of(context).size.width / 1.7,
                //         child: Text(
                //           "${model.orders![i].address}",
                //           maxLines: 2,
                //           style: TextStyle(
                //               color: AppColor().colorPrimary(),
                //               fontWeight: FontWeight.w600,
                //               overflow: TextOverflow.ellipsis
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                //   child: DottedLine(
                //     // direction: Axis.horizontal,
                //     lineLength: 320,
                //     lineThickness: 1.0,
                //     dashLength: 4.0,
                //     dashColor: AppColor().colorPrimary(),
                //     // dashGradient: [Colors.red, Colors.blue],
                //     dashRadius: 0.0,
                //     dashGapLength: 4.0,
                //     dashGapColor: Colors.transparent,
                //     // dashGapGradient: [Colors.red, Colors.blue],
                //     dashGapRadius: 0.0,
                //   ),
                // ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorPrimary(),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 110,
                            decoration: BoxDecoration(
                                color: _selectedIndex == 0
                                    ? Colors.amber
                                    : _selectedIndex == 1
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: _selectedIndex == 0
                                ? Text(
                              "Ongoing",
                              style: TextStyle(color: colors.primary,
                                  fontWeight: FontWeight.w600),
                            )
                                : _selectedIndex == 1
                                ? Text(
                              "Complete",
                              style:
                              TextStyle(color: colors.whiteTemp,
                                  fontWeight: FontWeight.w600),
                            )
                                : Text("Cancelled",
                                style: TextStyle(
                                    color: colors.whiteTemp,
                                    fontWeight: FontWeight.w600))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cardWidget(GetVendorOrderModel model, int i) {
    return InkWell(
      onTap: () {
        // if(type == "2") {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               OrderFoodDelivery(
        //                 data: model.orders![i],
        //               )));
        // }else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OrderFoodDetails(
                        data: model.orders![i],
                        type: type.toString(),
                        uid: uid.toString(),
                      )));
        // }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            // padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.PrimaryDark),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.orders![i].username}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Id",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.orders![i].orderId}",
                        maxLines: 2,
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.orders![i].date}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "₹ ${model.orders![i].total}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 15, right: 15),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Address",
                //         style: TextStyle(
                //             color: AppColor().colorPrimary(),
                //             fontWeight: FontWeight.normal),
                //       ),
                //       Container(
                //         width: 220,
                //         //MediaQuery.of(context).size.width / 1.7,
                //         child: Text(
                //           "${model.orders![i].address}",
                //           maxLines: 2,
                //           style: TextStyle(
                //               color: AppColor().colorPrimary(),
                //               fontWeight: FontWeight.w600,
                //               overflow: TextOverflow.ellipsis
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                //   child: DottedLine(
                //     // direction: Axis.horizontal,
                //     lineLength: 320,
                //     lineThickness: 1.0,
                //     dashLength: 4.0,
                //     dashColor: AppColor().colorPrimary(),
                //     // dashGradient: [Colors.red, Colors.blue],
                //     dashRadius: 0.0,
                //     dashGapLength: 4.0,
                //     dashGapColor: Colors.transparent,
                //     // dashGapGradient: [Colors.red, Colors.blue],
                //     dashGapRadius: 0.0,
                //   ),
                // ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorPrimary(),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 110,
                            decoration: BoxDecoration(
                                color: _selectedIndex == 0
                                    ? Colors.amber
                                    : _selectedIndex == 1
                                        ? Colors.green
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: _selectedIndex == 0
                                ? Text(
                                    "Ongoing",
                                    style: TextStyle(color: colors.primary,
                                        fontWeight: FontWeight.w600),
                                  )
                                : _selectedIndex == 1
                                    ? Text(
                                        "Complete",
                                        style:
                                            TextStyle(color: colors.whiteTemp,
                                                fontWeight: FontWeight.w600),
                                      )
                                    : Text("Cancelled",
                                        style: TextStyle(
                                            color: colors.whiteTemp,
                                            fontWeight: FontWeight.w600))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // cardWidget2(GetVendorOrderModel model, int i) {
  //   return InkWell(
  //     onTap: () {
  //       // if(type == "2") {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     OrderFoodDelivery(
  //                       data: model.orders![i],
  //                     )));
  //       // }else {
  //       //   Navigator.push(
  //       //       context,
  //       //       MaterialPageRoute(
  //       //           builder: (context) =>
  //       //               OrderFoodDetails(
  //       //                 data: model.orders![i],
  //       //                 type: type.toString(),
  //       //                 uid: uid.toString(),
  //       //               )));
  //       // }
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(4.0),
  //       child: Card(
  //         elevation: 5,
  //         shape:
  //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //         child: Container(
  //           // padding: EdgeInsets.all(12),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: AppColor.PrimaryDark),
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           child: Column(
  //             children: [
  //               Padding(
  //                 padding:
  //                 const EdgeInsets.only(top: 12.0, left: 15, right: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "Name",
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.normal),
  //                     ),
  //                     Text(
  //                       "${model.orders![i].username}",
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.w600),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 4.0, bottom: 4, left: 15, right: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "Order Id",
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.normal),
  //                     ),
  //                     Text(
  //                       "${model.orders![i].orderId}",
  //                       maxLines: 2,
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.w600),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //
  //
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 4.0, bottom: 4, left: 15, right: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "Date & Time",
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.normal),
  //                     ),
  //                     Text(
  //                       "${model.orders![i].date}",
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.w600,
  //                           overflow: TextOverflow.ellipsis),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //
  //               Padding(
  //                 padding: const EdgeInsets.only(
  //                     top: 4.0, bottom: 4, left: 15, right: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       "Amount",
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.normal),
  //                     ),
  //                     Text(
  //                       "₹ ${model.orders![i].total}",
  //                       style: TextStyle(
  //                           color: AppColor().colorPrimary(),
  //                           fontWeight: FontWeight.w600),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               // Padding(
  //               //   padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 15, right: 15),
  //               //   child: Row(
  //               //     crossAxisAlignment: CrossAxisAlignment.start,
  //               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               //     children: [
  //               //       Text(
  //               //         "Address",
  //               //         style: TextStyle(
  //               //             color: AppColor().colorPrimary(),
  //               //             fontWeight: FontWeight.normal),
  //               //       ),
  //               //       Container(
  //               //         width: 220,
  //               //         //MediaQuery.of(context).size.width / 1.7,
  //               //         child: Text(
  //               //           "${model.orders![i].address}",
  //               //           maxLines: 2,
  //               //           style: TextStyle(
  //               //               color: AppColor().colorPrimary(),
  //               //               fontWeight: FontWeight.w600,
  //               //               overflow: TextOverflow.ellipsis
  //               //           ),
  //               //         ),
  //               //       )
  //               //     ],
  //               //   ),
  //               // ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               // Padding(
  //               //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
  //               //   child: DottedLine(
  //               //     // direction: Axis.horizontal,
  //               //     lineLength: 320,
  //               //     lineThickness: 1.0,
  //               //     dashLength: 4.0,
  //               //     dashColor: AppColor().colorPrimary(),
  //               //     // dashGradient: [Colors.red, Colors.blue],
  //               //     dashRadius: 0.0,
  //               //     dashGapLength: 4.0,
  //               //     dashGapColor: Colors.transparent,
  //               //     // dashGapGradient: [Colors.red, Colors.blue],
  //               //     dashGapRadius: 0.0,
  //               //   ),
  //               // ),
  //               Container(
  //                 height: 60,
  //                 width: MediaQuery.of(context).size.width,
  //                 decoration: BoxDecoration(
  //                     color: AppColor().colorPrimary(),
  //                     borderRadius: BorderRadius.only(
  //                         bottomLeft: Radius.circular(12),
  //                         bottomRight: Radius.circular(12))),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Container(
  //                           alignment: Alignment.center,
  //                           height: 25,
  //                           width: 110,
  //                           decoration: BoxDecoration(
  //                               color: _selectedIndex == 0
  //                                   ? Colors.amber
  //                                   : _selectedIndex == 1
  //                                   ? Colors.green
  //                                   : Colors.red,
  //                               borderRadius: BorderRadius.circular(10)),
  //                           child: _selectedIndex == 0
  //                               ? Text(
  //                             "Ongoing",
  //                             style: TextStyle(color: colors.primary,
  //                                 fontWeight: FontWeight.w600),
  //                           )
  //                               : _selectedIndex == 1
  //                               ? Text(
  //                             "Complete",
  //                             style:
  //                             TextStyle(color: colors.whiteTemp,
  //                                 fontWeight: FontWeight.w600),
  //                           )
  //                               : Text("Cancelled",
  //                               style: TextStyle(
  //                                   color: colors.whiteTemp,
  //                                   fontWeight: FontWeight.w600))),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  cardWidget1(VendorBookingModel model, int i) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventServiceDetails(
                  data: model.data![i],
                )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            // padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.PrimaryDark),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, bottom:8, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text("${model.data![i].username}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Job",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.data![i].products![0].artistName}",
                        // maxLines: 2,
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "₹ ${model.data![i].subtotal}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.data![i].date}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                //   child: DottedLine(
                //     // direction: Axis.horizontal,
                //     lineLength: 320,
                //     lineThickness: 1.0,
                //     dashLength: 4.0,
                //     dashColor: AppColor().colorPrimary(),
                //     // dashGradient: [Colors.red, Colors.blue],
                //     dashRadius: 0.0,
                //     dashGapLength: 4.0,
                //     dashGapColor: Colors.transparent,
                //     // dashGapGradient: [Colors.red, Colors.blue],
                //     dashGapRadius: 0.0,
                //   ),
                // ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorPrimary(),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 110,
                            decoration: BoxDecoration(
                                color: _selectedIndex == 0
                                    ? Colors.amber
                                    : _selectedIndex == 1
                                        ? Colors.green
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: _selectedIndex == 0
                                ? Text(
                                    "Ongoing",
                                    style: TextStyle(color: colors.primary,
                                        fontWeight: FontWeight.w600),
                                  )
                                : _selectedIndex == 1
                                    ? Text(
                                        "Complete",
                                        style:
                                            TextStyle(color: colors.whiteTemp,
                                                fontWeight: FontWeight.w600),
                                      )
                                    : Text("Cancelled",
                                        style: TextStyle(
                                            color: colors.whiteTemp,
                                            fontWeight: FontWeight.w600))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cardWidgetDelivery(DeliveryBookingModel model, int i) {
    return InkWell(
      onTap: () {
        if(model.rides![i].bookingsType == "ride_booking"){
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             OfflinePage('${model.rides![i].bookingId}')));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RideInfoPage(model.rides![i])));
        }else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ParcelDetails(
                        data: model.rides![i],
                        type : type.toString()
                      )));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            // padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.PrimaryDark),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.rides![i].username}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${model.rides![i].dateAdded}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pickup Location",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          "${model.rides![i].pickupAddress}",
                          maxLines: 2,
                          style: TextStyle(
                              color: AppColor().colorPrimary(),
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Drop Location",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Container(
                        width: 180,
                        //MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          "${model.rides![i].dropAddress}",
                          maxLines: 2,
                          style: TextStyle(
                              color: AppColor().colorPrimary(),
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "₹ ${model.rides![i].amount}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                //   child: DottedLine(
                //     // direction: Axis.horizontal,
                //     lineLength: 320,
                //     lineThickness: 1.0,
                //     dashLength: 4.0,
                //     dashColor: AppColor().colorPrimary(),
                //     // dashGradient: [Colors.red, Colors.blue],
                //     dashRadius: 0.0,
                //     dashGapLength: 4.0,
                //     dashGapColor: Colors.transparent,
                //     // dashGapGradient: [Colors.red, Colors.blue],
                //     dashGapRadius: 0.0,
                //   ),
                // ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorPrimary(),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 110,
                            decoration: BoxDecoration(
                                color: _selectedIndex == 0
                                    ? Colors.amber
                                    : _selectedIndex == 1
                                        ? Colors.green
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: _selectedIndex == 0
                                ? Text(
                                    "Ongoing",
                                    style: TextStyle(color: colors.primary,
                                    fontWeight: FontWeight.w600
                                    ),
                                  )
                                : _selectedIndex == 1
                                    ? Text(
                                        "Complete",
                                        style:
                                            TextStyle(color: colors.whiteTemp,
                                                fontWeight: FontWeight.w600),
                                      )
                                    : Text("Cancelled",
                                        style: TextStyle(
                                            color: colors.whiteTemp,
                                            fontWeight: FontWeight.w600))),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColor().colorPrimary(),
    leading:
        widget.isIcon! ?
    IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back_ios),
    )
        : SizedBox.shrink(),
        // : SizedBox.shrink(),
    title: Text(
      type == "1" ?
          "My Orders":
      "My Bookings",
      style: TextStyle(color: AppColor().colorBg1()),
    ),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationScreen()));
          },
          icon: Icon(
            Icons.notifications,
            color: AppColor().colorBg1(),
          ))
    ],
      ),
      body: SingleChildScrollView(
      child: Container(
    padding: EdgeInsets.only(top: 5),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        color: AppColor().colorSecondary(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        )),
    child: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColor().colorBg1(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            )),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8, top: 25, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          setState(() {
                            _selectedIndex = 0;
                          });
                          if(type =="1"){
                            await  getFoodOrders();
                          }
                          else if(type =="2" || type =="3" ||type =="4"){

                            await getDeliveryBooking();
                          }else {
                            await getVendorBooking();
                          }
                        },
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    //AppColor().colorTextGray(),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2,
                                    spreadRadius: 1.0)
                              ],
                              border: Border.all(color: _selectedIndex == 0 ? Colors.amber : AppColor().colorPrimary()),
                              color: _selectedIndex == 0
                                  ? Colors.amber
                                  : Colors.white,
                              // _selectedIndex == Colors.cyan
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text("Ongoing",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                      color: _selectedIndex == 0
                                          ? colors.primary
                                          : colors.blackTemp))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          setState(() {
                            _selectedIndex = 1;
                          });
                          if(type =="1"){
                            await  getFoodOrders();
                          }
                          else if(type =="2" || type =="3" ||type =="4"){

                            await getDeliveryBooking();
                          }else {
                            await getVendorBooking();
                          }
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    //AppColor().colorTextGray(),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2,
                                    spreadRadius: 1.0)
                              ],
                              border: Border.all(color: _selectedIndex == 1 ? Colors.green : AppColor().colorPrimary()),
                              color: _selectedIndex == 1
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text("Complete",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                      color: _selectedIndex == 1
                                          ? colors.whiteTemp
                                          : colors.blackTemp))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          setState(() {
                            _selectedIndex = 2;
                          });
                          if(type =="1"){
                            await  getFoodOrders();
                          }
                          else if(type =="2" || type =="3" ||type =="4"){

                            await getDeliveryBooking();
                          }else {
                            await getVendorBooking();
                          }
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    //AppColor().colorTextGray(),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2,
                                    spreadRadius: 1.0)
                              ],
                              border: Border.all(color: _selectedIndex == 2 ? Colors.red : AppColor().colorPrimary()),
                              color: _selectedIndex == 2
                                  ? Colors.red
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Cancelled",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                                color: _selectedIndex == 2
                                    ? colors.whiteTemp
                                    : colors.blackTemp),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              type == "2"?
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          setState(() {
                            _selectedIndex1 = 0;
                          });
                          // if(type =="1"){
                          //   await  getFoodOrders();
                          // }
                          // else if(type =="2" || type =="3" ||type =="4"){
                          //
                          //   await getDeliveryBooking();
                          // }else {
                          //   await getVendorBooking();
                          // }
                        },
                        child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    //AppColor().colorTextGray(),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2,
                                    spreadRadius: 1.0)
                              ],
                              border: Border.all(color: _selectedIndex1 == 0 ? Colors.amber : AppColor().colorPrimary()),
                              color: _selectedIndex1 == 0
                                  ? Colors.amber
                                  : Colors.white,
                              // _selectedIndex == Colors.cyan
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text("Rides",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _selectedIndex1 == 0
                                          ? colors.primary
                                          : colors.blackTemp))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async{
                          setState(() {
                            _selectedIndex1 = 1;
                          });
                          // if(type =="1"){
                          //   await  getFoodOrders();
                          // }
                          // else if(type =="2" || type =="3" ||type =="4"){
                          //
                          //   await getDeliveryBooking();
                          // }else {
                          //   await getVendorBooking();
                          // }
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    //AppColor().colorTextGray(),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2,
                                    spreadRadius: 1.0)
                              ],
                              border: Border.all(color: _selectedIndex1 == 1 ? Colors.green : AppColor().colorPrimary()),
                              color: _selectedIndex1 == 1
                                  ? Colors.green
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text("Delivery Services",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _selectedIndex1 == 1
                                          ? colors.whiteTemp
                                          : colors.blackTemp))),
                        ),
                      ),
                    ),

                  ],
                ),
              )
              :SizedBox.shrink(),
              // type == "1"
              //     ? FutureBuilder(
              //         future: getFoodOrders(),
              //         builder:
              //             (BuildContext context, AsyncSnapshot snapshot) {
              //           GetVendorOrderModel? model = snapshot.data;
              //
              //           if (snapshot.hasData) {
              //             return model!.responseCode == "1"
              //                 ? Container(
              //                     decoration: BoxDecoration(
              //                         borderRadius:
              //                             BorderRadius.circular(20)),
              //                     child: ListView.builder(
              //                         shrinkWrap: true,
              //                         physics: ScrollPhysics(),
              //                         itemCount: model.orders!.length,
              //                         itemBuilder: (context, i) {
              //                           return cardWidget(model, i);
              //                         }),
              //                   )
              //                 : Container(
              //                     height: 100,
              //                     child: Center(
              //                         child: Text(roles == "Food"
              //                             ? "No Orders Found!!"
              //                             : "No Jobs Found!!")),
              //                   );
              //           } else if (snapshot.hasError) {
              //             return Icon(Icons.error_outline);
              //           } else {
              //             return Container(
              //                 height:
              //                     MediaQuery.of(context).size.height / 1.5,
              //                 child: Center(
              //                     child: CircularProgressIndicator()));
              //           }
              //         })
              type == "1"
                  ? Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FutureBuilder(
                    future: getFoodOrders(),
                    builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        GetVendorOrderModel? model = snapshot.data;
                        return model!.responseCode == "1"
                            ? ListView.builder(
                            shrinkWrap: true,
                            physics:
                            NeverScrollableScrollPhysics(),
                            itemCount: model.orders!.length,
                            itemBuilder: (context, i) {
                              return cardWidget(model, i);
                            })
                            : Container(
                          height: 100,
                          child: Center(
                              child: Text(roles != "Food"
                                  ? "No Jobs Found!!"
                                  : "No Orders Found!!")),
                        );
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error_outline);
                      } else {
                        return Container(
                            height: MediaQuery.of(context).size.height /
                                1.5,
                            child: Center(
                                child: CircularProgressIndicator()));
                      }
                    }),
              )
                  : type == "3" || type == "4"
                      ? FutureBuilder(
                          future: getDeliveryBooking(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            DeliveryBookingModel? model = snapshot.data;

                            if (snapshot.hasData) {
                              return model!.responseCode == "1"
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: model.rides!.length,
                                          itemBuilder: (context, i) {
                                            return cardWidgetDelivery(
                                                model, i);
                                          }),
                                    )
                                  : Container(
                                      height: 100,
                                      child: Center(
                                          child: Text(roles != "Food"
                                              ? "No Jobs Found!!"
                                              : "No Orders Found!!")),
                                    );
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          1.5,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }
                          })
              : type =="2"?
              _selectedIndex1 == 1 ?
               FutureBuilder(
                   future: getFoodDeliveryOrders(),
                   builder: (BuildContext context,
                       AsyncSnapshot snapshot) {
                     NewFoodDeliveryModel? model = snapshot.data;

                     if (snapshot.hasData) {
                       return model!.responseCode == "1"
                           ? Container(
                         decoration: BoxDecoration(
                             borderRadius:
                             BorderRadius.circular(20)),
                         child: ListView.builder(
                             shrinkWrap: true,
                             physics:
                             NeverScrollableScrollPhysics(),
                             itemCount: model.orders!.length,
                             itemBuilder: (context, i) {
                               return cardWidgetFoodDelivery(model, i);
                             }),
                       )
                           : Container(
                         height: 100,
                         child: Center(
                             child: Text(roles != "Food"
                                 ? "No Jobs Found!!"
                                 : "No Orders Found!!")),
                       );
                     } else if (snapshot.hasError) {
                       return Icon(Icons.error_outline);
                     } else {
                       return Container(
                           height:
                           MediaQuery.of(context).size.height /
                               1.5,
                           child: Center(
                               child: CircularProgressIndicator()));
                     }
                   })
              : FutureBuilder(
                  future: getDeliveryBooking(),
                  builder: (BuildContext context,
                      AsyncSnapshot snapshot) {
                    DeliveryBookingModel? model = snapshot.data;

                    if (snapshot.hasData) {
                      return model!.responseCode == "1"
                          ? Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(20)),
                        child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics:
                            NeverScrollableScrollPhysics(),
                            itemCount: model.rides!.length,
                            itemBuilder: (context, i) {
                              return cardWidgetDelivery(
                                  model, i);
                            }),
                      )
                          : Container(
                        height: 100,
                        child: Center(
                            child: Text(roles != "Food"
                                ? "No Jobs Found!!"
                                : "No Orders Found!!")),
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Container(
                          height:
                          MediaQuery.of(context).size.height /
                              1.5,
                          child: Center(
                              child: CircularProgressIndicator()));
                    }
                  })
                      : FutureBuilder(
                          future: getVendorBooking(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            VendorBookingModel? model = snapshot.data;
                            if (snapshot.hasData) {
                              return model!.responseCode == "1"
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: model.data!.length,
                                          itemBuilder: (context, i) {
                                            return cardWidget1(model, i);
                                            // Padding(
                                            //   padding: const EdgeInsets.all(15.0),
                                            //   child: Card(
                                            //     shape: RoundedRectangleBorder(
                                            //         borderRadius: BorderRadius.circular(25)
                                            //     ),
                                            //     elevation: 5,
                                            //     child: Container(
                                            //       padding: EdgeInsets.all(20),
                                            //       // height: 250,
                                            //       width: MediaQuery.of(context).size.width,
                                            //       child: Column(
                                            //           crossAxisAlignment: CrossAxisAlignment.start,
                                            //           children: [
                                            //             Row(
                                            //               mainAxisAlignment: MainAxisAlignment.end,
                                            //               children: [
                                            //                 Icon(Icons.calendar_month, color: AppColor().colorPrimary(),
                                            //                   size: 16,),
                                            //                 Text(model.data![i].date.toString(),
                                            //                   style: TextStyle(
                                            //                       fontWeight: FontWeight.normal,
                                            //                       fontSize: 16
                                            //                   ),
                                            //                 ),
                                            //               ],
                                            //             ),
                                            //
                                            //             Text(model.data![i].username.toString(),
                                            //               style: TextStyle(
                                            //                   fontWeight: FontWeight.bold,
                                            //                   fontSize: 20,
                                            //                   color: AppColor().colorPrimary()
                                            //               ),
                                            //             ),
                                            //             Padding(
                                            //               padding: const EdgeInsets.only(top: 10.0),
                                            //               child: Row(
                                            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //                 children: [
                                            //                   Text("Service Type : ",
                                            //                     style: TextStyle(
                                            //                       fontWeight: FontWeight.normal,
                                            //                       fontSize: 16,
                                            //                       // color: AppColor().colorPrimary()
                                            //                     ),
                                            //                   ),
                                            //                   Text("${model.data![i].requirement.toString()}",
                                            //                     style: TextStyle(
                                            //                         fontSize: 16,
                                            //                         fontWeight: FontWeight.bold,
                                            //                         color: AppColor().colorPrimary()
                                            //                     ),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //             Padding(
                                            //               padding: const EdgeInsets.only(top: 10.0),
                                            //               child: Row(
                                            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //                 children: [
                                            //                   Text("No. of person : ",
                                            //                     style: TextStyle(
                                            //                       fontWeight: FontWeight.normal,
                                            //                       fontSize: 16,
                                            //                       // color: AppColor().colorPrimary()
                                            //                     ),
                                            //                   ),
                                            //                   Text("${model.data![i].quantity.toString()}",
                                            //                     style: TextStyle(
                                            //                         fontSize: 16,
                                            //                         fontWeight: FontWeight.bold,
                                            //                         color: AppColor().colorPrimary()
                                            //                     ),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //             Padding(
                                            //               padding: const EdgeInsets.only(top: 10.0),
                                            //               child: Row(
                                            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //                 children: [
                                            //                   Text("Per day charges : ",
                                            //                     style: TextStyle(
                                            //                       fontWeight: FontWeight.normal,
                                            //                       fontSize: 16,
                                            //                       // color: AppColor().colorPrimary()
                                            //                     ),
                                            //                   ),
                                            //                   Text("₹ ${model.data![i].amount.toString()}",
                                            //                     style: TextStyle(
                                            //                         fontSize: 16,
                                            //                         fontWeight: FontWeight.bold,
                                            //                         color: AppColor().colorPrimary()
                                            //                     ),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //             model.data![i].status.toString() =="0" ?
                                            //             Padding(
                                            //               padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                                            //               child: Row(
                                            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //                 children: [
                                            //                   ElevatedButton(
                                            //                       style: ElevatedButton.styleFrom(
                                            //                           primary: AppColor().colorTextSecondary(),
                                            //                           fixedSize: Size(MediaQuery.of(context).size.width/2.8, 40),
                                            //                           shape: RoundedRectangleBorder(
                                            //                               borderRadius: BorderRadius.circular(10)
                                            //                           )
                                            //                       ),
                                            //                       onPressed: (){
                                            //                         // updateRequestFunction("${model.data![i].id.toString()}", "2");
                                            //                       },
                                            //                       child: Text("Reject",
                                            //                         style: TextStyle(
                                            //                             color: AppColor().colorBg1()
                                            //                         ),)),
                                            //                   ElevatedButton(
                                            //                       style: ElevatedButton.styleFrom(
                                            //                           primary: AppColor().colorPrimary(),
                                            //                           fixedSize: Size(MediaQuery.of(context).size.width/2.8, 40),
                                            //                           shape: RoundedRectangleBorder(
                                            //                               borderRadius: BorderRadius.circular(10)
                                            //                           )
                                            //                       ),
                                            //                       onPressed: (){
                                            //                         // updateRequestFunction("${model.data![i].id.toString()}","1");
                                            //                       },
                                            //                       child: Text("Accept",
                                            //                         style: TextStyle(
                                            //                             color: AppColor().colorBg1()
                                            //                         ),)),
                                            //                 ],
                                            //               ),
                                            //             )
                                            //                 : SizedBox.shrink(),
                                            //             // model.data![i].status.toString() =="0" ?
                                            //             // Center(
                                            //             //   child: InkWell(
                                            //             //     onTap: (){
                                            //             //       showDialog(
                                            //             //         context: context,
                                            //             //         builder: (context) {
                                            //             //           return Padding(
                                            //             //             padding: const EdgeInsets.symmetric(vertical: 170),
                                            //             //             child: StatefulBuilder(
                                            //             //               builder: (context, setState) {
                                            //             //                 return AlertDialog(
                                            //             //                   contentPadding: EdgeInsets.only( left: 15, right: 15, top: 0),
                                            //             //                   shape: RoundedRectangleBorder(
                                            //             //                       borderRadius: BorderRadius.circular(20)
                                            //             //                   ),
                                            //             //                   title: Padding(
                                            //             //                     padding: const EdgeInsets.only(bottom: 15.0),
                                            //             //                     child: Center(
                                            //             //                       child: Text("Edit Booking",
                                            //             //                         style: TextStyle(
                                            //             //                             color: AppColor().colorPrimary()
                                            //             //                         ),),
                                            //             //                     ),
                                            //             //                   ),
                                            //             //                   content: Column(
                                            //             //                     children: [
                                            //             //                       Padding(
                                            //             //                         padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                                            //             //                         child: Container(
                                            //             //                           child: TextFormField( controller: amountController,
                                            //             //                             keyboardType: TextInputType.number,
                                            //             //                             validator: (v){
                                            //             //                               if(v!.isEmpty){
                                            //             //                                 return "Enter Amount";
                                            //             //                               }
                                            //             //                             },
                                            //             //                             decoration: InputDecoration(
                                            //             //                                 hintText: "Charges per person",
                                            //             //                                 border: OutlineInputBorder(
                                            //             //                                     borderRadius: BorderRadius.circular(7),
                                            //             //                                     borderSide: BorderSide(color: AppColor().colorTextPrimary().withOpacity(0.5))
                                            //             //                                 )
                                            //             //                             ),),
                                            //             //                         ),
                                            //             //                       ),
                                            //             //                       Padding(
                                            //             //                         padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                                            //             //                         child: Container(
                                            //             //                           height: 90,
                                            //             //                           padding: EdgeInsets.only(left: 10),
                                            //             //                           decoration: BoxDecoration(
                                            //             //                             borderRadius: BorderRadius.circular(7),
                                            //             //                             border: Border.all(color: AppColor().colorTextPrimary().withOpacity(0.5)),
                                            //             //                             // borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                                            //             //                           ),
                                            //             //                           child: TextFormField(
                                            //             //                             controller: commentController,
                                            //             //                             // keyboardType: TextInputType.,
                                            //             //                             // validator: (v){
                                            //             //                             //   if(v!.isEmpty){
                                            //             //                             //     return "Job Requirement is needed!";
                                            //             //                             //   }
                                            //             //                             // },
                                            //             //                             decoration: InputDecoration(
                                            //             //                               hintText: "Comment",
                                            //             //                               border: InputBorder.none,
                                            //             //                               // OutlineInputBorder(
                                            //             //                               //     borderRadius: BorderRadius.circular(7),
                                            //             //                               //     borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                                            //             //                               // )
                                            //             //                             ),),
                                            //             //                         ),
                                            //             //                       ),
                                            //             //                     ],
                                            //             //                   ),
                                            //             //                   actions: <Widget>[
                                            //             //                     Row(
                                            //             //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //             //                       children: [
                                            //             //                         ElevatedButton(
                                            //             //                           onPressed: (){
                                            //             //                             Navigator.pop(context);
                                            //             //                           },
                                            //             //                           child: Text(
                                            //             //                             "Cancel",
                                            //             //                             style: TextStyle(
                                            //             //                                 color: AppColor().colorBg1()
                                            //             //                             ),
                                            //             //                           ),
                                            //             //                           style: ElevatedButton.styleFrom(
                                            //             //                               fixedSize: Size(MediaQuery.of(context).size.width/3, 40),
                                            //             //                               primary: AppColor().colorTextSecondary(),
                                            //             //                               shape: RoundedRectangleBorder(
                                            //             //                                   borderRadius: BorderRadius.circular(10)
                                            //             //                               )
                                            //             //                           ),),
                                            //             //                         ElevatedButton(
                                            //             //                           onPressed: (){
                                            //             //
                                            //             //                           },
                                            //             //                           child: Text(
                                            //             //                             "Update",
                                            //             //                             style: TextStyle(
                                            //             //                                 color: AppColor().colorBg1()
                                            //             //                             ),
                                            //             //                           ),
                                            //             //                           style: ElevatedButton.styleFrom(
                                            //             //                               fixedSize: Size(MediaQuery.of(context).size.width/3, 40),
                                            //             //                               primary: AppColor().colorPrimary(),
                                            //             //                               shape: RoundedRectangleBorder(
                                            //             //                                   borderRadius: BorderRadius.circular(10)
                                            //             //                               )
                                            //             //                           ),)
                                            //             //                       ],
                                            //             //                     ),
                                            //             //
                                            //             //                   ],
                                            //             //                 );
                                            //             //               },
                                            //             //             ),
                                            //             //           );
                                            //             //         },
                                            //             //       );
                                            //             //     },
                                            //             //     child: Container(
                                            //             //       height: 40,
                                            //             //       width: MediaQuery.of(context).size.width/2.8,
                                            //             //       decoration: BoxDecoration(
                                            //             //           color: AppColor().colorBg1(),
                                            //             //           borderRadius: BorderRadius.circular(10),
                                            //             //           border: Border.all(color: AppColor.PrimaryDark)
                                            //             //       ),
                                            //             //       child: Center(
                                            //             //         child: Text(
                                            //             //           "Edit",
                                            //             //           style: TextStyle(
                                            //             //               fontWeight: FontWeight.bold,
                                            //             //               color: AppColor.PrimaryDark
                                            //             //           ),
                                            //             //         ),
                                            //             //       ),
                                            //             //     ),
                                            //             //   ),
                                            //             // )
                                            //             //     : SizedBox.shrink(),
                                            //             model.data![i].status.toString() =="1" ?
                                            //             Padding(
                                            //               padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                                            //               child: Center(
                                            //                 child: Text("Accepted",
                                            //                   style: TextStyle(
                                            //                       fontWeight: FontWeight.bold,
                                            //                       fontSize: 18,
                                            //                       color: Colors.green
                                            //                   ),),
                                            //               ),
                                            //             )
                                            //                 : SizedBox.shrink(),
                                            //             model.data![i].status.toString() =="2" ?
                                            //             Padding(
                                            //               padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                                            //               child: Center(
                                            //                 child: Text("Declined",
                                            //                   style: TextStyle(
                                            //                       fontWeight: FontWeight.bold,
                                            //                       fontSize: 18,
                                            //                       color: Colors.red
                                            //                   ),),
                                            //               ),
                                            //             )
                                            //                 : SizedBox.shrink(),
                                            //             model.data![i].status.toString() =="3" ?
                                            //             Text("Rejected by user",
                                            //               style: TextStyle(
                                            //                   fontWeight: FontWeight.bold,
                                            //                   fontSize: 18,
                                            //                   color: AppColor().colorTextSecondary()
                                            //               ),)
                                            //                 : SizedBox.shrink()
                                            //           ]
                                            //       ),
                                            //     ),
                                            //   ),
                                            // );

                                            ///////////////////////////////////////////////////////////
                                            //   InkWell(
                                            //   // onTap: model.data![i].acceptReject ==
                                            //   //         ToastString.responseCode
                                            //   //     ? () {
                                            //   //         // gotOderInfo(model.data!, i);
                                            //   //         getNewOders(model.data![i].vId);
                                            //   //       }
                                            //   //     : () {
                                            //   //         UtilityHlepar.getToast(
                                            //   //             ToastString.pleaseAccept);
                                            //   //       },
                                            //   child: Container(
                                            //     width: 83.33.w,
                                            //     height: 37.20.h,
                                            //     margin: EdgeInsets.only(
                                            //         left: 8.33.w,
                                            //         right: 8.33.w,
                                            //         bottom: 1.87.h),
                                            //     decoration: boxDecoration(
                                            //         radius: 32.0,
                                            //         bgColor: AppColor().colorBg1()),
                                            //     child: Column(
                                            //       children: [
                                            //         Container(
                                            //           margin: EdgeInsets.symmetric(
                                            //               horizontal: 4.44.w,
                                            //               vertical: 3.90.h),
                                            //           child: Row(
                                            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //             children: [
                                            //               // Container(
                                            //               //   height: 8.81.h,
                                            //               //   width: 8.81.h,
                                            //               //   margin: EdgeInsets.only(right: 5),
                                            //               //   child: ClipOval(
                                            //               //     child: UtilityHlepar.convertetIMG(
                                            //               //         snapshot.data!.booking![i]
                                            //               //             .service!.serviceImage,
                                            //               //         fit: BoxFit.cover),
                                            //               //   ),
                                            //               // ),
                                            //               Container(
                                            //                 child: Column(
                                            //                   mainAxisAlignment:
                                            //                       MainAxisAlignment.start,
                                            //                   crossAxisAlignment:
                                            //                       CrossAxisAlignment
                                            //                           .start,
                                            //                   children: [
                                            //                     Container(
                                            //                       child: Row(
                                            //                         mainAxisAlignment:
                                            //                             MainAxisAlignment
                                            //                                 .spaceBetween,
                                            //                         crossAxisAlignment:
                                            //                             CrossAxisAlignment
                                            //                                 .center,
                                            //                         children: [
                                            //                           Container(
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                                   MainAxisAlignment
                                            //                                       .start,
                                            //                               crossAxisAlignment:
                                            //                                   CrossAxisAlignment
                                            //                                       .start,
                                            //                               children: [
                                            //                                 // text(
                                            //                                 //   "${model.data![i].}",
                                            //                                 //   textColor:
                                            //                                 //       Color(0xff191919),
                                            //                                 //   fontSize:
                                            //                                 //       14.sp,
                                            //                                 //   fontFamily:
                                            //                                 //       fontBold,
                                            //                                 // ),
                                            //
                                            //
                                            //                                 // RatingBar.builder(
                                            //                                 //   initialRating: 4,
                                            //                                 //   minRating: 1,
                                            //                                 //   tapOnlyMode: true,
                                            //                                 //   direction:
                                            //                                 //       Axis.horizontal,
                                            //                                 //   allowHalfRating:
                                            //                                 //       true,
                                            //                                 //   itemCount: 5,
                                            //                                 //   itemSize: 1.18.h,
                                            //                                 //   itemPadding: EdgeInsets
                                            //                                 //       .symmetric(
                                            //                                 //           horizontal:
                                            //                                 //               1.0),
                                            //                                 //   itemBuilder:
                                            //                                 //       (context, _) =>
                                            //                                 //           Icon(
                                            //                                 //     Icons.star,
                                            //                                 //     color:
                                            //                                 //         Colors.amber,
                                            //                                 //   ),
                                            //                                 //   onRatingUpdate:
                                            //                                 //       (rating) {
                                            //                                 //     print(rating);
                                            //                                 //   },
                                            //                                 // ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                           SizedBox(
                                            //                             width: 12.34.w,
                                            //                           ),
                                            //                           Container(
                                            //                             child: Row(
                                            //                               children: [
                                            //                                 Container(
                                            //                                     height: 1.40.h,
                                            //                                     width: 1.40.h,
                                            //                                     child:
                                            //                                         Image(
                                            //                                       image: AssetImage(
                                            //                                           calender),
                                            //                                       fit: BoxFit
                                            //                                           .fill,
                                            //                                     )),
                                            //                                 SizedBox(
                                            //                                   width: 5,
                                            //                                 ),
                                            //                                 text(
                                            //                                   model
                                            //                                       .data![i]
                                            //                                       .quantity
                                            //                                       .toString(),
                                            //                                   textColor:
                                            //                                       Color(
                                            //                                           0xff191919),
                                            //                                   fontSize:
                                            //                                       7.sp,
                                            //                                   fontFamily:
                                            //                                       fontRegular,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                         ],
                                            //                       ),
                                            //                     ),
                                            //                     SizedBox(
                                            //                       height: 2.04.h,
                                            //                     ),
                                            //                     Container(
                                            //                       child: Row(
                                            //                         mainAxisAlignment:
                                            //                             MainAxisAlignment
                                            //                                 .spaceBetween,
                                            //                         crossAxisAlignment:
                                            //                             CrossAxisAlignment
                                            //                                 .start,
                                            //                         children: [
                                            //                           Container(
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                                   MainAxisAlignment
                                            //                                       .start,
                                            //                               crossAxisAlignment:
                                            //                                   CrossAxisAlignment
                                            //                                       .start,
                                            //                               children: [
                                            //                                 text(
                                            //                                   "Service Type",
                                            //                                   textColor:
                                            //                                       Color(
                                            //                                           0xff191919),
                                            //                                   fontSize:
                                            //                                       7.sp,
                                            //                                   fontFamily:
                                            //                                       fontRegular,
                                            //                                 ),
                                            //                                 text(
                                            //                                   model
                                            //                                       .data![i].requirement
                                            //                                       .toString(),
                                            //                                   textColor:
                                            //                                       Color(
                                            //                                           0xff191919),
                                            //                                   fontSize:
                                            //                                       10.sp,
                                            //                                   fontFamily:
                                            //                                       fontMedium,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                           SizedBox(
                                            //                             width: 6.34.w,
                                            //                           ),
                                            //                           Container(
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                                   MainAxisAlignment
                                            //                                       .start,
                                            //                               crossAxisAlignment:
                                            //                                   CrossAxisAlignment
                                            //                                       .start,
                                            //                               children: [
                                            //                                 text(
                                            //                                   AppStrings.currencySymbols +
                                            //                                       " " +
                                            //                                      model.data![i].amount.toString(),
                                            //                                   textColor: AppColor().colorPrimaryDark(),
                                            //                                   fontSize: 10.sp,
                                            //                                   fontFamily: fontMedium,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                           SizedBox(
                                            //                             width: 20.34.w,
                                            //                           ),
                                            //                           model.data![i].status == "0"
                                            //                               ? Container(
                                            //                             padding: EdgeInsets.all(8.0),
                                            //                             alignment: Alignment.center,
                                            //                             decoration: BoxDecoration(
                                            //                               borderRadius: BorderRadius.circular(10.0),
                                            //                               color: Colors.red
                                            //                             ),
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                               MainAxisAlignment
                                            //                                   .start,
                                            //                               crossAxisAlignment:
                                            //                               CrossAxisAlignment
                                            //                                   .start,
                                            //                               children: [
                                            //                                 text("UNPAID",
                                            //                                   textColor: AppColor().colorBg1(),
                                            //                                   fontSize: 8.sp,
                                            //                                   fontFamily: fontMedium,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           )
                                            //                               : Container(
                                            //                             padding: EdgeInsets.all(8.0),
                                            //                             alignment: Alignment.center,
                                            //                             decoration: BoxDecoration(
                                            //                                 borderRadius: BorderRadius.circular(10.0),
                                            //                                 color: Colors.green
                                            //                             ),
                                            //                             child: Column(
                                            //                               mainAxisAlignment:
                                            //                               MainAxisAlignment
                                            //                                   .start,
                                            //                               crossAxisAlignment:
                                            //                               CrossAxisAlignment
                                            //                                   .start,
                                            //                               children: [
                                            //                                 text("PAID",
                                            //                                   textColor: AppColor().colorBg1(),
                                            //                                   fontSize: 8.sp,
                                            //                                   fontFamily: fontMedium,
                                            //                                 ),
                                            //                               ],
                                            //                             ),
                                            //                           ),
                                            //                         ],
                                            //                       ),
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //         Divider(
                                            //           height: 1.0,
                                            //           color: Color(0xff707070),
                                            //         ),
                                            //         Container(
                                            //           margin: EdgeInsets.symmetric(
                                            //               horizontal: 4.44.w,
                                            //               vertical: 2.80.h),
                                            //           child: Row(
                                            //             children: [
                                            //               Container(
                                            //                 height: 2.5.h,
                                            //                 width: 2.5.h,
                                            //                 child: Image(
                                            //                   image: AssetImage(
                                            //                       cardLocation
                                            //                   ),
                                            //                   fit: BoxFit.fill,
                                            //                 ),
                                            //               ),
                                            //               SizedBox(
                                            //                 width: 1.w,
                                            //               ),
                                            //               Container(
                                            //                 child: Column(
                                            //                   mainAxisAlignment:
                                            //                       MainAxisAlignment.start,
                                            //                   crossAxisAlignment:
                                            //                       CrossAxisAlignment
                                            //                           .start,
                                            //                   children: [
                                            //                     SizedBox(
                                            //                       width: 60.w,
                                            //                       child: Text(
                                            //                         model.data![i].createdAt
                                            //                             .toString(),
                                            //                         softWrap: true,
                                            //                         overflow: TextOverflow.clip,
                                            //                         style: TextStyle(
                                            //                           color: Color(
                                            //                               0xff191919),
                                            //                           fontSize: 8.5.sp,
                                            //                           fontFamily:
                                            //                               fontRegular,
                                            //                         ),
                                            //                       ),
                                            //                     ),
                                            //                   ],
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //         ),
                                            //         getAcceptRejectButton(
                                            //             model.data![i].status,
                                            //             model.data![i].id, i),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // );
                                          }),
                                    )
                                  : Container(
                                      height: 100,
                                      child: Center(
                                          child: Text(roles != "Food"
                                              ? "No Jobs Found!!"
                                              : "No Orders Found!!")),
                                    );
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return Container(
                                  height:
                                      MediaQuery.of(context).size.height /
                                          1.5,
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }
                          }),
              Container(
                height: MediaQuery.of(context).size.height,
              )
            ],
          ),
        )),
      )),
      // )
    );
  }

  Future getVendorBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var headers = {
      'Cookie': 'ci_session=af94a6a054dc2ff954d970c4fe45f3784ea1c80d'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Apipath.getServiceBookingUrl}'));
    request.fields.addAll({
      'roll': '$type',
      'user_id': '${uid.toString()}',
      'status': _selectedIndex == 1
          ? '3'
          : _selectedIndex == 2
          ? '4'
          : _selectedIndex == 0 ? '1' :'2'
          });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          VendorBookingModel.fromJson(json.decode(finalResponse));
      print(
          "oooooooooo ${jsonResponse} and ${jsonResponse.responseCode} and ${jsonResponse.data}");
      return VendorBookingModel.fromJson(json.decode(finalResponse));
    } else {
      print(response.reasonPhrase);
    }
  }

  // Future getDeliveryServices() async {
  //   var userId = await MyToken.getUserID();
  //   print("usre id here ${userId}");
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('${Apipath.getLabourRequest}/delivery'));
  //   request.fields.addAll({'id': '$userId'});
  //   print("this is request !! $request");
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print("this response @@ ${response.statusCode}");
  //     final str = await response.stream.bytesToString();
  //     return DeliveryListModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }

  Future getLabourServices() async {
    var userId = await MyToken.getUserID();
    print("usre id here ${uid}");
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.getVendorOrders}'));
    request.fields.addAll({
      'v_id': '${userId.toString()}',
      'status': _selectedIndex == 0
          ? '1'
          : _selectedIndex == 1
              ? '2'
              : '4'
      // '${uid.toString()}'
    });
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = GetVendorOrderModel.fromJson(json.decode(str));
      print("ssssssssssss ${datas} and ${datas.status} and ${datas.orders}");
      return GetVendorOrderModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future<RemoveServiceModel?> removeServices(id) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}delete_restaurant'));
    request.fields.addAll({'id': '$id'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return RemoveServiceModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
}
