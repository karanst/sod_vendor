import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/response/notification_response.dart';
import 'package:fixerking/new%20model/GetProfileModel.dart';
import 'package:fixerking/new%20model/Get_vendor_order_Model.dart';
import 'package:fixerking/new%20model/VendorBookingModel.dart';
import 'package:fixerking/new%20model/banner_model.dart';
import 'package:fixerking/new%20model/buy_vendor_product.dart';
import 'package:fixerking/new%20model/delivery_booking_model.dart';
import 'package:fixerking/new%20model/food_delivery_model.dart';
// import 'package:fixerking/new%20model/delivery_booking_model.dart';
import 'package:fixerking/new%20model/get_settings_model.dart';
import 'package:fixerking/new%20model/ride_booking_model.dart';
import 'package:fixerking/screen/Add%20Services%20Products/add_products.dart';
import 'package:fixerking/screen/Add%20Services%20Products/add_services.dart';
import 'package:fixerking/screen/Booking%20Details/delivery_service_details.dart';
import 'package:fixerking/screen/Booking%20Details/event_services_details.dart';
import 'package:fixerking/screen/Booking%20Details/order_food_delivery.dart';
import 'package:fixerking/screen/Booking%20Details/order_food_details.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar_delivery.dart';
import 'package:fixerking/screen/Add%20Services%20Products/DetailScreens/OfferDetails.dart';
import 'package:fixerking/screen/Add%20Services%20Products/products_services_screen.dart';
import 'package:fixerking/screen/ReferEarnWallet/refer_n_earn.dart';
import 'package:fixerking/screen/ReferEarnWallet/wallet.dart';
import 'package:fixerking/screen/auth_view/login.dart';
import 'package:fixerking/screen/customer_reviews.dart';
import 'package:fixerking/screen/customer_support_faq.dart';
import 'package:fixerking/screen/manage_Service.dart';
import 'package:fixerking/screen/notification_screen.dart';
import 'package:fixerking/screen/push_notification_service.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../new model/update_order.dart';
import '../utils/Widgets.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  final String? bookingId;
  const HomeScreen({Key? key, this.bookingId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? name;
  BannerModel? bannerModal;
  Setting? settings;
  BuyVendorProduct? productModel;
  bool isProduct = false;
  Position? currentLocation;
  var homelat;
  var homeLong;
  final Geolocator geolocator = Geolocator();
  String? _currentAddress;

  int _selectedIndex = 0;
  int currentindex = 0;
  bool statusOn = false;
  bool onOff = false;
  bool changeOnTap = true;
  bool acceptStatus = false;

  Future getVendorBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var headers = {
      'Cookie': 'ci_session=af94a6a054dc2ff954d970c4fe45f3784ea1c80d'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.getServiceBookingUrl}'));
    request.fields
        .addAll({'roll': '${type.toString()}', 'user_id': '${uid.toString()}'});
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

  Future getFoodOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.getVendorOrders}'));
    request.fields.addAll({'v_id': '$uid'});
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

  // Future getDeliveryBooking() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? uid = prefs.getString(TokenString.userid);
  //
  //   var request =
  //       http.MultipartRequest('POST', Uri.parse('${Apipath.getDeliveryBooking}'));
  //   request.fields.addAll({
  //     'driver_id':'${uid.toString()}',
  //     'type': '$type',
  //     'status': '0',
  //
  //   });
  //   print('request =====?????>>> ${Apipath.getDeliveryBooking} &&&&&& ${request.fields}');
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print("this response @@ ${response.statusCode}");
  //     final str = await response.stream.bytesToString();
  //     var datas = DeliveryBookingModel.fromJson(json.decode(str));
  //     deliveryModel = datas.rides!;
  //     print("ssssssssssss ${datas} and ${datas.msg} and ${datas.totalAmount}");
  //     return DeliveryBookingModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }

  Future updateFoodOrderStatus(String id, status) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(type == "1"
            ? '${Apipath.acceptRejectFoodStatus}'
            : type == "2" || type == "3" || type == "4"
                ? '${Apipath.acceptRejectDeliveryStatus}'
                : '${Apipath.acceptRejectServiceStatus}'));
    if (type == "1") {
      request.fields
          .addAll({'order_id': '$id', 'status': '$status', 'roll': '1'});
    } else if (type == "2" || type == "3" || type == "4") {
      request.fields.addAll({
        'booking_id': '${id.toString()}',
        'accept_reject': '${status.toString()}',
        'driver_id': '${uid.toString()}'
        // 'otp': "${otpController.text.toString()}",
      });
    } else {
      request.fields.addAll({'booking_id': '$id', 'status': '$status'});
    }

    print(
        "request of status ===>>> ${Apipath.acceptRejectDeliveryStatus} ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var data = UpdateOrder.fromJson(json.decode(str));
      _refresh();
      // await getDeliverRideBooking(deliveryModel!.id);
      Fluttertoast.showToast(msg: data.message.toString());
      return UpdateOrder.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future updateFoodDeliveryStatus(String id, status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            // type =="1" ?
            // '${Apipath.acceptRejectFoodStatus}'
            //     :
            // type =="2" || type =="3" || type =="4"  ?
            '${Apipath.accRejFoodDeliveryUrl}'
            // : '${Apipath.acceptRejectServiceStatus}'
            ));
    request.fields.addAll({
      'order_id': '${id.toString()}',
      'status': '${status.toString()}',
      'driver_id': '${uid.toString()}'
      // 'otp': "${otpController.text.toString()}",
    });
    print("request of status ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var data = UpdateOrder.fromJson(json.decode(str));
      // if(data.status == "0"){}
      await getFoodDeliveryBooking(foodDeliveryModel!.orderId);
      // getFoodDeliveryBooking("");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderFoodDelivery(
                    data: foodDeliveryModel,
                  )));
      Fluttertoast.showToast(msg: data.message.toString());
      return UpdateOrder.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  // Future getVendorProduct() async {
  //   // var userId = await MyToken.getUserID();
  //   // print("usre id here ${userId}");
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'https://developmentalphawizz.com/SOD_New/api/get_all_products_vendor'));
  //   request.fields.addAll({'v_id': '2'});
  //   print("this is request !! ${request.fields}");
  //
  //   http.StreamedResponse response = await request.send();
  //   print("this is request !! 11111${response}");
  //   if (response.statusCode == 200) {
  //     print("this response @@ ${response.statusCode}");
  //     final str = await response.stream.bytesToString();
  //     var datas = GetVendorOrderModel.fromJson(json.decode(str));
  //     print("ssssssssssss ${datas} and ${datas.status} and ${datas.orders}");
  //     return GetVendorOrderModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }

  _getBanners() async {
    var uri = Uri.parse('${Apipath.getBanners}');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    // request.fields['type_id'] = type.toString();
    print("this is request banner ====>>> ${request.fields.toString()}");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        bannerModal = BannerModel.fromJson(userData);
      });
    }
    print(responseData);
  }

  Future<void> _launchUrl(url) async {
    final Uri _url = Uri.parse(url);
    await launchUrl(_url);
    // if (await launchUrl(_url)) {
    //   throw 'Could not launch $_url';
    // }
  }

  _getSettings() async {
    var uri = Uri.parse('${Apipath.getSettings}');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    // request.fields['type_id'] = type.toString();
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    // if (mounted) {
    //   setState(() {
    var data = GetSettingsModel.fromJson(userData);

    settings = data.setting;

    // });
    // }
    // print(responseData);
  }

  _buyVendorProduct() async {
    var uri = Uri.parse('${Apipath.buyVendorProductUrl}');
    var request = new http.MultipartRequest("POST", uri);
    // Map<String, String> headers = {
    //   "Accept": "application/json",
    // };
    request.headers.addAll({'type': "$type"});
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    productModel = BuyVendorProduct.fromJson(userData);
    if (productModel!.status == "1") {
      setState(() {
        isProduct = true;
      });
    } else {}

    print(responseData);
  }

  Future updateOnOffStatus(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var headers = {
    //   'Cookie': 'ci_session=fb513962ef255c62e54f293c4d1d74aa992ab405'
    // };
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.onOffUrl}'));
    request.fields.addAll({
      'id': '${uid.toString()}',
      'status': '${status.toString()}'
      //onOff == true ? "1": "0"
    });
    print("OnandOff status ${request.fields}");
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    // if(onOff = true) {
    //   setState((){
    //     onOfStatus = "1";
    //   });
    // }else{
    //   setState((){
    //     onOfStatus = "0";
    //   });
    // }

    if (response.statusCode == 200) {
      await prefs.setString(TokenString.onOffStatus, onOfStatus.toString());
      print("response**** ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var data = jsonDecode(str);
      String msg = data['message'];
      // var data = Onoffmodel.fromJson(json.decode(str));
      Fluttertoast.showToast(msg: msg.toString());
      // return Onoffmodel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Widget cardWidget(GetVendorOrderModel model, int i) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderFoodDetails(
                      data: model.orders![i],
                      type: type.toString(),
                      uid: uid.toString(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.orders![i].orderStatus == "1"
                          ? Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        fixedSize: Size(140, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    child: Text(
                                      "Accepted",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                            )
                          : model.orders![i].orderStatus == "5"
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            fixedSize: Size(140, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                        child: Text(
                                          "Accepted",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        )),
                                  ),
                                )
                              : model.orders![i].orderStatus == "2"
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                fixedSize: Size(140, 35),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                            child: Text(
                                              "Accepted",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ),
                                    )
                                  : model.orders![i].orderStatus == "3"
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7.0),
                                          child: Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    fixedSize: Size(140, 35),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    )),
                                                child: Text(
                                                  "Completed",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                          ),
                                        )
                                      : model.orders![i].orderStatus == "4"
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 7.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    updateFoodOrderStatus(
                                                        "${model.orders![i].orderId.toString()}",
                                                        "4");

                                                    // if(type =="1"){
                                                    //   getFoodOrders();
                                                    // }else{
                                                    //   getVendorBooking();
                                                    // }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.red,
                                                          fixedSize:
                                                              Size(140, 35),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          )),
                                                  child: Text(
                                                    "Declined",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      updateFoodOrderStatus(
                                                          "${model.orders![i].orderId.toString()}",
                                                          "1");
                                                      // _refresh();
                                                      // if(type =="1"){
                                                      //   getFoodOrders();
                                                      // }else{
                                                      //   getVendorBooking();
                                                      // }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary:
                                                                Colors.green,
                                                            fixedSize:
                                                                Size(140, 35),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            )),
                                                    child: Text(
                                                      "Accept",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      updateFoodOrderStatus(
                                                          "${model.orders![i].orderId.toString()}",
                                                          "4");
                                                      // if(type =="1"){
                                                      //   getFoodOrders();
                                                      // }else{
                                                      //   getVendorBooking();
                                                      // }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors.red,
                                                            fixedSize:
                                                                Size(140, 35),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            )),
                                                    child: Text(
                                                      "Decline",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ))
                                              ],
                                            ),
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
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 8, left: 15, right: 15),
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
                        "${model.data![i].username}",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),

                // ListView.builder(
                //   itemCount: model.data![i].products!.length,
                //     itemBuilder: (context, index){
                //   return
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
                // ;
                //            }),

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.data![i].status == "1"
                          ? Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        fixedSize: Size(140, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    child: Text(
                                      "Accepted",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                            )
                          : model.data![i].status == "2"
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: Center(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            fixedSize: Size(140, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                        child: Text(
                                          "On the way",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        )),
                                  ),
                                )
                              : model.data![i].status == "3"
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 7.0),
                                      child: Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green,
                                                fixedSize: Size(140, 35),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                            child: Text(
                                              "Completed",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400),
                                            )),
                                      ),
                                    )
                                  : model.data![i].status == "4"
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7.0),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                updateFoodOrderStatus(
                                                    "${model.data![i].bookingId.toString()}",
                                                    "4");
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  fixedSize: Size(140, 35),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )),
                                              child: Text(
                                                "Declined",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  updateFoodOrderStatus(
                                                      "${model.data![i].bookingId.toString()}",
                                                      "1");
                                                  if (type == "1") {
                                                    getFoodOrders();
                                                  } else {
                                                    getVendorBooking();
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.green,
                                                    fixedSize: Size(140, 35),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    )),
                                                child: Text(
                                                  "Accept",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  updateFoodOrderStatus(
                                                      "${model.data![i].bookingId.toString()}",
                                                      "4");
                                                  if (type == "1") {
                                                    getFoodOrders();
                                                  } else {
                                                    getVendorBooking();
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                    fixedSize: Size(140, 35),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    )),
                                                child: Text(
                                                  "Decline",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ))
                                          ],
                                        ),
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

  cardWidgetDelivery(ParcelModel model) {
    return InkWell(
      onTap: () {
        // model.rides![i].type
        // if(model.order![i].bookingsType == "ride_booking") {
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  OfflinePage("")));
        // } else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DeliveryDetails(
                      data: model,
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
                        "${model.username}",
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
                        "${model.dateAdded}",
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
                        "Pick Up Location",
                        style: TextStyle(
                            color: AppColor().colorPrimary(),
                            fontWeight: FontWeight.normal),
                      ),
                      Container(
                        width: 180,
                        child: Text(
                          "${model.pickupAddress}",
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
                        child: Text(
                          "${model.dropAddress}",
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
                        "₹ ${model.amount}",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      model.status == "1"
                          ? Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        fixedSize: Size(140, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    child: Text(
                                      "Accepted",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                            )
                          : model.status == "4"
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        updateFoodOrderStatus(
                                            "${model.status}", "4");
                                        if (type == "1") {
                                          getFoodOrders();
                                        } else {
                                          getVendorBooking();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red,
                                          fixedSize: Size(140, 35),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      child: Text(
                                        "Declined",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      )),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          updateFoodOrderStatus(
                                              "${model.id}", "1");
                                          Future.delayed(Duration(seconds: 4),
                                              () {
                                            if (type == "3" || type == "4") {
                                              // getDeliverRideBooking();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DeliveryDetails(
                                                              data: model)));
                                            }
                                            if (type == "1") {
                                              getFoodOrders();
                                            } else {
                                              getVendorBooking();
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green,
                                            fixedSize: Size(140, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        )),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          updateFoodOrderStatus(
                                              "${model.id}", "4");
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            if (type == "3" || type == "4") {
                                              // getDeliverRideBooking();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DeliveryDetails(
                                                              data: model)));
                                            }
                                            if (type == "1") {
                                              getFoodOrders();
                                            } else {
                                              getVendorBooking();
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            fixedSize: Size(140, 35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                        child: Text(
                                          "Decline",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400),
                                        ))
                                  ],
                                ),
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

  // deliveryWidget(){
  //  if( deliveryType == "Food") {
  //    foodDeliveryModel != null ?
  //    cardWidgetDelivery(foodDeliveryModel!, 0)
  //        : Container(
  //      height: MediaQuery.of(context).size.height/3,
  //      child: Center(child: Text("No Bookings found!!")),
  //    );
  //   }else{
  //    model != null ? Stack(
  //      alignment: Alignment.bottomCenter,
  //      children: [
  //        SingleChildScrollView(
  //          child: Padding(
  //            padding: const EdgeInsets.only(left: 15.0, right: 15),
  //            child: Container(
  //              height: MediaQuery
  //                  .of(context)
  //                  .size
  //                  .width / 2,
  //              padding: EdgeInsets.only(top: 15),
  //              decoration: BoxDecoration(
  //                  color: AppColor().colorBg1(),
  //                  border: Border.all(
  //                      color: AppColor().colorPrimary()
  //                  ),
  //                  borderRadius: BorderRadius.circular(15)
  //              ),
  //              // padding: EdgeInsets.all(15),
  //              child: Column(
  //                children: [
  //                  Padding(
  //                    padding: const EdgeInsets.only(left: 15.0, right: 15),
  //                    child: Column(
  //                      mainAxisSize: MainAxisSize.min,
  //                      children: [
  //                        text("Ride Info",
  //                            fontSize: 12,
  //                            // fontFamily: fontMedium,
  //                            textColor: Colors.black),
  //                        Divider(),
  //                        boxHeight(5),
  //                        Row(
  //                          children: [
  //                            Container(
  //                              height: 10,
  //                              width: 10,
  //                              decoration: boxDecoration(
  //                                  radius: 100,
  //                                  bgColor: Colors.green),
  //                            ),
  //                            boxWidth(10),
  //                            Expanded(
  //                                child: text(
  //                                    model!.pickupAddress.toString(),
  //                                    fontSize: 12,
  //                                    fontFamily: fontRegular,
  //                                    textColor: Colors.black)),
  //                          ],
  //                        ),
  //                        boxHeight(5),
  //                        model!.dropAddress != null ? Row(
  //                          children: [
  //                            Container(
  //                              height: 10,
  //                              width: 10,
  //                              decoration: boxDecoration(
  //                                  radius: 100, bgColor: Colors.red),
  //                            ),
  //                            boxWidth(10),
  //                            Expanded(
  //                                child: text(
  //                                    model!.dropAddress.toString(),
  //                                    fontSize: 12,
  //                                    fontFamily: fontRegular,
  //                                    textColor: Colors.black)),
  //                          ],
  //                        ) : SizedBox(),
  //                        boxHeight(5),
  //                        Divider(),
  //                        boxHeight(5),
  //                        Row(
  //                          mainAxisAlignment:
  //                          MainAxisAlignment.spaceBetween,
  //                          children: [
  //                            text("Payment Mode : ",
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                            text(model!.transaction.toString(),
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                          ],
  //                        ),
  //                        boxHeight(5),
  //                        // !model!.bookingType
  //                        //     .toString()
  //                        //     .contains("Point")
  //                        //     ? AnimatedTextKit(
  //                        //   animatedTexts: [
  //                        //     ColorizeAnimatedText(
  //                        //       model!.bookingType
  //                        //           .toString()
  //                        //           .contains("Rental Booking")?"Rental Booking - ${model!.start_time} - ${model!.end_time}":"Schedule - ${model!.pickupDate} ${model!.pickupTime}",
  //                        //       textStyle: colorizeTextStyle,
  //                        //       colors: colorizeColors,
  //                        //     ),
  //                        //   ],
  //                        //   pause: Duration(milliseconds: 100),
  //                        //   isRepeatingAnimation: true,
  //                        //   totalRepeatCount: 100,
  //                        //   onTap: () {
  //                        //     print("Tap Event");
  //                        //   },
  //                        // )
  //                        //     : SizedBox(),
  //                        boxHeight(5),
  //                        Row(
  //                          mainAxisAlignment:
  //                          MainAxisAlignment.spaceBetween,
  //                          children: [
  //                            text("Ride Type : ",
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                            text(model!.bookingType.toString(),
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                          ],
  //                        ),
  //                        boxHeight(5),
  //                        Row(
  //                          mainAxisAlignment:
  //                          MainAxisAlignment.spaceBetween,
  //                          children: [
  //                            text("Earning Amount : ",
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                            text("₹" + model!.paidAmount.toString(),
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                          ],
  //                        ),
  //                        boxHeight(5),
  //                        Row(
  //                          mainAxisAlignment:
  //                          MainAxisAlignment.spaceBetween,
  //                          children: [
  //                            text(model!.bookingType
  //                                .toString()
  //                                .contains("Rental Booking")
  //                                ? "Hours : "
  //                                : "Distance : ",
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                            text(model!.bookingType
  //                                .toString()
  //                                .contains("Rental Booking") ? model!.hours
  //                                .toString() + " hrs" : model!.km.toString() +
  //                                " km",
  //                                fontSize: 12,
  //                                fontFamily: fontMedium,
  //                                textColor: Colors.black),
  //                          ],
  //                        ),
  //                        boxHeight(5),
  //                        /*Row(
  //                         mainAxisAlignment:
  //                         MainAxisAlignment.spaceBetween,
  //                         crossAxisAlignment:
  //                         CrossAxisAlignment.start,
  //                         children: [
  //                             text("Earning Amount ",
  //                                       fontSize: 10.sp,
  //                                       fontFamily: fontMedium,
  //                                       textColor: Colors.black),
  //                             text("₹" + model!.paidAmount.toString(),
  //                                       fontSize: 10.sp,
  //                                       fontFamily: fontMedium,
  //                                       textColor: Colors.black),
  //                             text("|",
  //                                       fontSize: 10.sp,
  //                                       fontFamily: fontMedium,
  //                                       textColor: Colors.black),
  //                             text("Distance ",
  //                                       fontSize: 10.sp,
  //                                       fontFamily: fontMedium,
  //                                       textColor: Colors.black),
  //                             text(model!.km.toString() + " km",
  //                                       fontSize: 10.sp,
  //                                       fontFamily: fontMedium,
  //                                       textColor: Colors.black),
  //                         ],
  //                         ),*/
  //                        Container(
  //                          child: Column(
  //                            children: [
  //                              double.parse(model!.gstAmount
  //                                  .toString()) >
  //                                  0
  //                                  ? Row(
  //                                mainAxisAlignment:
  //                                MainAxisAlignment
  //                                    .spaceBetween,
  //                                children: [
  //                                  text("Sub Total : ",
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor:
  //                                      Colors.black),
  //                                  text(
  //                                      "₹" +
  //                                          (double.parse(model!
  //                                              .amount
  //                                              .toString()) -
  //                                              double.parse(model!
  //                                                  .gstAmount
  //                                                  .toString()) -
  //                                              double.parse(model!
  //                                                  .surgeAmount
  //                                                  .toString()))
  //                                              .toStringAsFixed(
  //                                              2),
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor:
  //                                      Colors.black),
  //                                ],
  //                              )
  //                                  : SizedBox(),
  //                              model!.baseFare != null &&
  //                                  model!.baseFare! is double &&
  //                                  double.parse(model!.baseFare
  //                                      .toString()) >
  //                                      0
  //                                  ? Row(
  //                                mainAxisAlignment:
  //                                MainAxisAlignment
  //                                    .spaceBetween,
  //                                children: [
  //                                  text("Base fare : ",
  //                                      fontSize: 12,
  //                                      fontFamily: fontRegular,
  //                                      textColor:
  //                                      Colors.black),
  //                                  text(
  //                                      "₹" +
  //                                          model!.baseFare
  //                                              .toString(),
  //                                      fontSize: 12,
  //                                      fontFamily: fontRegular,
  //                                      textColor:
  //                                      Colors.black),
  //                                ],
  //                              )
  //                                  : SizedBox(),
  //                              model!.ratePerKm != null &&
  //                                  model!.ratePerKm! is double &&
  //                                  double.parse(model!.km.toString()) >=
  //                                      2 &&
  //                                  double.parse(model!.ratePerKm
  //                                      .toString()
  //                                      .replaceAll(
  //                                      ",", "")) >
  //                                      0
  //                                  ? Row(
  //                                mainAxisAlignment:
  //                                MainAxisAlignment
  //                                    .spaceBetween,
  //                                children: [
  //                                  text(
  //                                      "${model!.km.toString()} Kilometers : ",
  //                                      fontSize: 12,
  //                                      fontFamily: fontRegular,
  //                                      textColor:
  //                                      Colors.black),
  //                                  text(
  //                                      "₹" +
  //                                          model!.ratePerKm
  //                                              .toString()
  //                                              .replaceAll(
  //                                              ",", ""),
  //                                      fontSize: 12,
  //                                      fontFamily: fontRegular,
  //                                      textColor:
  //                                      Colors.black),
  //                                ],
  //                              )
  //                                  : SizedBox(),
  //                              model!.timeAmount != null &&
  //                                  model!.timeAmount! is double &&
  //                                  double.parse(model!.timeAmount
  //                                      .toString()) >
  //                                      0
  //                                  ? Row(
  //                                mainAxisAlignment:
  //                                MainAxisAlignment
  //                                    .spaceBetween,
  //                                children: [
  //                                  text(
  //                                      "${model!.totalTime
  //                                          .toString()} Minutes : ",
  //                                      fontSize: 12,
  //                                      fontFamily: fontRegular,
  //                                      textColor:
  //                                      Colors.black),
  //                                  text(
  //                                      "₹" +
  //                                          model!.timeAmount
  //                                              .toString(),
  //                                      fontSize: 12,
  //                                      fontFamily: fontRegular,
  //                                      textColor:
  //                                      Colors.black),
  //                                ],
  //                              )
  //                                  : SizedBox(),
  //                              double.parse(model!.gstAmount
  //                                  .toString()) >
  //                                  0
  //                                  ? Row(
  //                                mainAxisAlignment:
  //                                MainAxisAlignment
  //                                    .spaceBetween,
  //                                children: [
  //                                  text("Taxes : ",
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor:
  //                                      Colors.black),
  //                                  text(
  //                                      "₹" +
  //                                          model!.gstAmount
  //                                              .toString(),
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor:
  //                                      Colors.black),
  //                                ],
  //                              )
  //                                  : SizedBox(),
  //                              double.parse(model!.surgeAmount
  //                                  .toString()) >
  //                                  0
  //                                  ? Row(
  //                                mainAxisAlignment:
  //                                MainAxisAlignment
  //                                    .spaceBetween,
  //                                children: [
  //                                  text("Surge Amount : ",
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor:
  //                                      Colors.black),
  //                                  text(
  //                                      "₹" +
  //                                          model!.surgeAmount
  //                                              .toString(),
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor:
  //                                      Colors.black),
  //                                ],
  //                              )
  //                                  : SizedBox(),
  //                              Divider(),
  //                              Row(
  //                                mainAxisAlignment:
  //                                MainAxisAlignment.spaceBetween,
  //                                children: [
  //                                  text("Total : ",
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor: Colors.black),
  //                                  text("₹" + "${model!.amount}",
  //                                      fontSize: 12,
  //                                      fontFamily: fontMedium,
  //                                      textColor: Colors.black),
  //                                ],
  //                              ),
  //                              boxHeight(5),
  //                            ],
  //                          ),
  //                        ),
  //                        boxHeight(5),
  //
  //                        // !acceptStatus
  //                        //     ? Row(
  //                        //   mainAxisAlignment:
  //                        //   MainAxisAlignment.spaceBetween,
  //                        //   children: [
  //                        //     InkWell(
  //                        //       onTap: () {
  //                        //         // setState(() {
  //                        //         //   acceptStatus = true;
  //                        //         // });
  //                        //         // bookingStatus(
  //                        //         //     model!.id.toString(),
  //                        //         //     "2");
  //                        //
  //                        //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>FindingRidePage()));
  //                        //       },
  //                        //       child: Container(
  //                        //         width: 100,
  //                        //         height: 35,
  //                        //         decoration: boxDecoration(
  //                        //             radius: 5,
  //                        //             bgColor: Colors.grey),
  //                        //         child: Center(
  //                        //             child: text("Reject",
  //                        //                 fontFamily:
  //                        //                 fontMedium,
  //                        //                 fontSize: 12,
  //                        //                 isCentered: true,
  //                        //                 textColor:
  //                        //                 Colors.white)),
  //                        //       ),
  //                        //     ),
  //                        //     InkWell(
  //                        //       onTap: () async {
  //                        //         ///
  //                        //         // if (currentBookingStatus == true) {
  //                        //         //   setState(() {
  //                        //         //     acceptStatus = true;
  //                        //         //     condition = true;
  //                        //         //   });
  //                        //         //   bookingStatus(
  //                        //         //       model!.id.toString(),
  //                        //         //       "1");
  //                        //         // } else {
  //                        //         //   setState(() {
  //                        //         //     condition = true;
  //                        //         //     model = null;
  //                        //         //   });
  //                        //         //   setSnackbar(
  //                        //         //       "Ride is Cancelled by User",
  //                        //         //       context);
  //                        //         //   print("CANCELLED");
  //                        //         // }
  //                        //         ///
  //                        //       },
  //                        //       child: Container(
  //                        //         width: 100,
  //                        //         height: 35,
  //                        //         decoration: boxDecoration(
  //                        //             radius: 5,
  //                        //             bgColor: Theme.of(context)
  //                        //                 .primaryColor),
  //                        //         child: Center(
  //                        //             child: text("Accept",
  //                        //                 fontFamily:
  //                        //                 fontMedium,
  //                        //                 fontSize: 12,
  //                        //                 isCentered: true,
  //                        //                 textColor:
  //                        //                 Colors.white)),
  //                        //       ),
  //                        //     ),
  //                        //   ],
  //                        // )
  //                        //     : Center(
  //                        //   child: CircularProgressIndicator(),
  //                        // ),
  //                      ],
  //                    ),
  //                  ),
  //                  Container(
  //                    height: 60,
  //                    width: MediaQuery
  //                        .of(context)
  //                        .size
  //                        .width,
  //                    decoration: BoxDecoration(
  //                        color: AppColor().colorPrimary(),
  //                        borderRadius: BorderRadius.only(
  //                            bottomLeft: Radius.circular(12),
  //                            bottomRight: Radius.circular(12))
  //                    ),
  //                    child: Column(
  //                      crossAxisAlignment: CrossAxisAlignment.center,
  //                      children: [
  //                        model!.status == "1"
  //                            ? Padding(
  //                          padding: const EdgeInsets.only(top: 7.0),
  //                          child: Center(
  //                            child: ElevatedButton(
  //                                onPressed: () {
  //                                  //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
  //                                },
  //                                style: ElevatedButton.styleFrom(
  //                                    primary: Colors.green,
  //                                    fixedSize: Size(140, 35),
  //                                    shape: RoundedRectangleBorder(
  //                                      borderRadius: BorderRadius.circular(10),
  //                                    )),
  //                                child: Text(
  //                                  "Accepted",
  //                                  style: TextStyle(
  //                                      fontWeight: FontWeight.w400),
  //                                )),
  //                          ),
  //                        )
  //                            : model!.status == "6"
  //                            ? Padding(
  //                          padding: const EdgeInsets.only(top: 7.0),
  //                          child: ElevatedButton(
  //                              onPressed: () {
  //                                updateFoodOrderStatus(
  //                                    "${model!.id.toString()}", "4");
  //                                if (type == "1") {
  //                                  getFoodOrders();
  //                                } else {
  //                                  getVendorBooking();
  //                                }
  //                              },
  //                              style: ElevatedButton.styleFrom(
  //                                  primary: Colors.red,
  //                                  fixedSize: Size(140, 35),
  //                                  shape: RoundedRectangleBorder(
  //                                    borderRadius: BorderRadius.circular(10),
  //                                  )),
  //                              child: Text(
  //                                "Declined",
  //                                style: TextStyle(fontWeight: FontWeight.w400),
  //                              )),
  //                        )
  //                            : Row(
  //                          mainAxisAlignment: MainAxisAlignment.center,
  //                          crossAxisAlignment: CrossAxisAlignment.center,
  //                          children: [
  //                            ElevatedButton(
  //                                onPressed: () {
  //                                  updateFoodDeliveryStatus(
  //                                      "${model!.id.toString()}",
  //                                      "5");
  //                                  if (type == "1") {
  //                                    getFoodOrders();
  //                                  } else {
  //                                    getVendorBooking();
  //                                  }
  //                                },
  //                                style: ElevatedButton.styleFrom(
  //                                    primary: Colors.green,
  //                                    fixedSize: Size(140, 35),
  //                                    shape: RoundedRectangleBorder(
  //                                      borderRadius: BorderRadius.circular(10),
  //                                    )),
  //                                child: Text(
  //                                  "Accept",
  //                                  style:
  //                                  TextStyle(fontWeight: FontWeight.w400),
  //                                )),
  //                            const SizedBox(
  //                              width: 15,
  //                            ),
  //                            ElevatedButton(
  //                                onPressed: () {
  //                                  updateFoodOrderStatus(
  //                                      "${model!.id.toString()}",
  //                                      "6");
  //                                  if (type == "1") {
  //                                    getFoodOrders();
  //                                  } else {
  //                                    getVendorBooking();
  //                                  }
  //                                },
  //                                style: ElevatedButton.styleFrom(
  //                                    primary: Colors.red,
  //                                    fixedSize: Size(140, 35),
  //                                    shape: RoundedRectangleBorder(
  //                                      borderRadius: BorderRadius.circular(10),
  //                                    )),
  //                                child: Text(
  //                                  "Decline",
  //                                  style:
  //                                  TextStyle(fontWeight: FontWeight.w400),
  //                                ))
  //                          ],
  //                        ),
  //                      ],
  //                    ),
  //                  ),
  //                ],
  //              ),
  //            ),
  //          ),
  //        )
  //      ],
  //    )
  //        : Container(
  //      height: MediaQuery.of(context).size.height/3,
  //      child: Center(child: Text("No Bookings found!!")),
  //    );
  //   }
  // }

  bool isSwitched = false;
  bool newSwitch = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    // if(approvalStatus =="0") {
    //  Fluttertoast.showToast(msg: "Vendor not approved from admin");
    // }else{
    if (isSwitched == false) {
      setState(() {
        updateOnOffStatus("1");
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        updateOnOffStatus("0");
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
      // }
    }
  }

  void showToast() {
    Fluttertoast.showToast(msg: "Vendor can't be online until approved!");
  }

  getDrawer() {
    // print("checking user pic ${userPic}");
    return ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(35)),
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(35)),
            // circular(20)
          ),
          width: 290,
          backgroundColor: AppColor.PrimaryDark,
          child: ListView(
            // padding: EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.PrimaryDark,
                ), //BoxDecoration
                child: Row(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    userImage == null || userImage == ""
                        ? CircleAvatar(
                            backgroundColor: AppColor().colorBg1(),
                            radius: 40,
                            child: Icon(
                              Icons.person,
                              size: 44,
                            )
                            //Image.network(userPic.toString()),
                            )
                        : CircleAvatar(
                            backgroundColor: AppColor().colorBg1(),
                            radius: 40,
                            backgroundImage:
                                NetworkImage('${userImage.toString()}'),
                            // child: Image.network("${userPic.toString()}",
                            // fit: BoxFit.contain,
                            // ),
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hello!",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              uName == null || uName == ""
                                  ? "Guest"
                                  : "${uName.toString()}",
                              style: TextStyle(
                                  color: AppColor().colorBg1(), fontSize: 17),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wallet()));
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    wallet == null || wallet == ""
                                        ? " ₹ 0"
                                        : "₹ ${wallet.toString()}",

                                    /*textScaleFactor: 1.3,*/
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    approvalStatus == "0"
                        ? Padding(
                            padding: EdgeInsets.only(top: 15, right: 15),
                            child: InkWell(
                              onTap: () async {
                                showToast();
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Container(
                                      height: 15,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0, top: 0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.white,
                            inactiveThumbColor: Colors.redAccent,
                            inactiveTrackColor: Colors.white,
                          )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Divider(
                  thickness: 1,
                  color: AppColor().colorBg1(),
                ),
              ), //DrawerHeader
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColor().colorSecondary(),
                ),
                child: Center(
                  child: ListTile(
                    leading: Image.asset(
                      "images/icons/home_fill.png",
                      color: AppColor().colorPrimary(),
                      height: 25,
                      width: 25,
                    ),
                    // leading: const ImageIcon(AssetImage("images/icons/Home.png", )),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          color: AppColor().colorPrimary(),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      if (type == "2" || type == "3" || type == "4") {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BottomBarDelivery(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => BottomBar(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                  ),
                ),
              ),

              type == "2" || type == "3" || type == "4"
                  ? SizedBox.shrink()
                  : ListTile(
                      // leading: Icon(Icons.list),
                      leading: Image.asset(
                        "images/icons/booking.png",
                        color: Colors.white,
                        height: 25,
                        width: 25,
                      ),
                      // leading: const ImageIcon(AssetImage("images/icons/booking.png")),
                      title: Text(type == "1" ? 'My Products' : 'My Services',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      // selected: index == _selectedIndex,
                      onTap: () {
                        // if(type =="1" ){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductsServicesScreen()));
                        // } else{
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBarDelivery()));
                        // }
                      },
                    ),
              type == "2" || type == "3" || type == "4"
                  ? SizedBox.shrink()
                  : ListTile(
                      // leading: Icon(Icons.bookmark_border),
                      leading: Image.asset(
                        "images/icons/addnew.png",
                        color: Colors.white,
                        height: 25,
                        width: 25,
                      ),
                      // leading: const ImageIcon(AssetImage("assets/Icons/Wallet1.png")),
                      title: const Text(
                        'Add New',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        if (type == "1") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProducts()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddServices()));
                        }
                      },
                    ),
              ListTile(
                // leading: Icon(Icons.my_library_add),
                leading: Image.asset(
                  "images/icons/completejobs.png",
                  color: Colors.white,
                  height: 25,
                  width: 25,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/Wallet1.png")),
                title: Text(type == "1" ? 'Completed Orders' : 'Completed Jobs',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ManageService(isIcon: true, index: 1)));
                },
              ),
              ListTile(
                // leading: Icon(Icons.bookmark_border),
                leading: Image.asset(
                  "images/icons/rating.png",
                  height: 25,
                  width: 25,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/Events.png")),
                title: const Text('My Rating',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                  //   MaterialPageRoute(builder: (context)=> MyRequestPage()),
                  // );
                },
              ),
              ListTile(
                // leading: Icon(Icons.list),
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: AppColor().colorBg1(),
                  size: 24,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/About us.png")),
                title: const Text('Wallet',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                    MaterialPageRoute(builder: (context) => Wallet()),
                  );
                },
              ),
              ListTile(
                // leading: Icon(Icons.list),
                leading: Image.asset(
                  "images/icons/refer.png",
                  height: 25,
                  width: 25,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/About us.png")),
                title: const Text('Referral',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                    MaterialPageRoute(builder: (context) => ReferAndEarn()),
                  );
                },
              ),
              ListTile(
                leading: Image.asset(
                  "images/icons/review.png",
                  height: 25,
                  width: 25,
                ),
                title: const Text('Customers Review',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CustomerReviews(uid: uid.toString())),
                  );
                },
              ),
              ListTile(
                // leading: Icon(Icons.list),
                leading: Icon(
                  Icons.delete_forever,
                  color: AppColor().colorBg1(),
                  size: 24,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/About us.png")),
                title: const Text('Delete Account',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Account"),
                          content: Text("Are you sure you want to delete your account?"),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor().colorPrimary()),
                              child: Text("YES"),
                              onPressed: () async {
                                accountDelete();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor().colorPrimary()),
                              child: Text("NO"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });

                },
              ),
              ListTile(
                // leading: Icon(Icons.security),
                leading: Image.asset(
                  "images/icons/security.png",
                  height: 25,
                  width: 25,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/Refferal.png")),
                title: const Text('Security',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                  //   MaterialPageRoute(builder: (context)=> refferral()),
                  // );
                },
              ),
              ListTile(
                // leading: Icon(Icons.report),
                leading: Image.asset(
                  "images/icons/report.png",
                  height: 25,
                  width: 25,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/Emergancy contect.png")),
                title: const Text('Report',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                  //   MaterialPageRoute(builder: (context)=> ArtistDetails()),
                  // );
                },
              ),
              ListTile(
                // leading: Icon(Icons.support),
                leading: Image.asset(
                  "images/icons/support.png",
                  height: 25,
                  width: 25,
                ),
                // leading: const ImageIcon(AssetImage("assets/Icons/FAQ.png")),
                title: const Text('Support',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerSupport()),
                  );
                },
              ),
              // ListTile(
              //   leading: const ImageIcon(AssetImage("assets/Icons/Privacy Policy.png")),
              //   title: const Text('Privacy Policy'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => PrivacyPolicy()),
              //     );
              //   },
              // ),
              // ListTile(
              //   leading: const ImageIcon(AssetImage("assets/Icons/Support.png")),
              //   title: const Text(' Support '),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => TermsConditionScreen()),
              //     );
              //   },
              // ),
              // ListTile(
              //   leading: const ImageIcon(AssetImage("assets/Icons/Claim.png")),
              //   title: const Text(' Claim'),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => TermsConditionScreen()),
              //     );
              //   },
              // ),
              /// Only for Testing
              // ListTile(
              //   leading: const Icon(Icons.list_alt, color: backgroundblack,),
              //   title: const Text(' Testing '),
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => HomePage()),
              //     );
              //   },
              // ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm Logout"),
                          content: Text("Are you sure you want to Logout?"),
                          actions: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor().colorPrimary()),
                              child: Text("YES"),
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(TokenString.userid, "");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor().colorPrimary()),
                              child: Text("NO"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                },
                // leading: Icon(Icons.logout_outlined),
                leading: Image.asset(
                  "images/icons/logout.png",
                  height: 25,
                  width: 25,
                ),
                title: Text('Log Out',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("Follow Us",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchUrl('${settings!.youtubeUrl.toString()}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "images/icons/youtube.png",
                          height: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('${settings!.facebookUrl.toString()}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "images/icons/facebook.png",
                          height: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('${settings!.instaramUrl.toString()}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset(
                          "images/icons/insta.png",
                          height: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('${settings!.twitterUrl.toString()}');
                      },
                      child: Image.asset(
                        "images/icons/twitter.png",
                        height: 30,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('${settings!.likendInUrl.toString()}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.asset(
                          'images/icons/linkedin.png',
                          height: 30,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl('https://www.google.co.in/');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.asset(
                          'images/icons/google.png',
                          height: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }

  Widget _banner(BuildContext context) {
    return bannerModal == null
        ? Center(
            child: Container(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: colors.primary,
            ),
          ))
        : ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 1200),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      height: 120,
                      onPageChanged: (position, reason) {
                        setState(() {
                          currentindex = position;
                        });
                        print(reason);
                        print(CarouselPageChangedReason.controller);
                      },
                    ),
                    items: bannerModal!.banners!.map((val) {
                      return InkWell(
                        onTap: () {
                          // if (homeSliderList[currentindex].type ==
                          //     "restaurants") {
                          //   print(homeSliderList[currentindex].list);
                          //   if (homeSliderList[currentindex].list!=null) {
                          //     var item =
                          //         homeSliderList[currentindex].list;
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => SellerProfile(
                          //               title: item.store_name.toString(),
                          //               sellerID: item.seller_id.toString(),
                          //               sellerId: item.seller_id.toString(),
                          //               sellerData: item,
                          //               userLocation: currentAddress.text,
                          //               // catId: widget.catId,
                          //               shop: false,
                          //             )));
                          //     /*Navigator.push(
                          //                 context,
                          //                 PageRouteBuilder(
                          //                     pageBuilder: (_, __, ___) =>
                          //                         ProductDetail(
                          //                             model: item,
                          //                             secPos: 0,
                          //                             index: 0,
                          //                             list: true)),
                          //               );*/
                          //   }
                          // } else if (homeSliderList[currentindex].type ==
                          //     "categories") {
                          //   var item = homeSliderList[currentindex].list;
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => SellerList(
                          //             catId: item.categoryId,
                          //             catName: item.name,
                          //             userLocation:
                          //             currentAddress.text,
                          //             getByLocation: true,
                          //           )));
                          // }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "${val.toString()}",
                                fit: BoxFit.fill,
                              )),
                        ),
                      );
                    }).toList(),
                  ),
                  // margin: EdgeInsetsDirectional.only(top: 10),
                  // child: PageView.builder(
                  //   itemCount: homeSliderList.length,
                  //   scrollDirection: Axis.horizontal,
                  //   controller: _controller,
                  //   pageSnapping: true,
                  //   physics: AlwaysScrollableScrollPhysics(),
                  //   onPageChanged: (index) {
                  //     context.read<HomeProvider>().setCurSlider(index);
                  //   },
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return pages[index];
                  //   },
                  // ),
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: bannerModal!.banners!.map((e) {
                      int index = bannerModal!.banners!.indexOf(e);
                      return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentindex == index
                                ? Theme.of(context).colorScheme.fontColor
                                : Theme.of(context).colorScheme.lightBlack,
                          ));
                    }).toList()),
              ],
            ),
          );
  }

  // Widget _banner(BuildContext context) {
  //   return bannerModal == null
  //       ? Center(
  //           child: Container(
  //           height: 30,
  //           width: 30,
  //           child: CircularProgressIndicator(
  //             color: colors.primary,
  //           ),
  //         ))
  //       : Padding(
  //           padding: const EdgeInsets.only(),
  //           child: ImageSlideshow(
  //             width: double.infinity,
  //             height: 120,
  //             initialPage: 0,
  //             indicatorColor: Colors.black,
  //             indicatorBackgroundColor: Colors.grey,
  //             children: bannerModal!.banners!
  //                 .map(
  //                   (item) => Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 10),
  //                     child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(20),
  //                         child: CachedNetworkImage(
  //                           imageUrl: item,
  //                           fit: BoxFit.fill,
  //                           placeholder: (context, url) => Center(
  //           child: Container(
  //           height: 20,
  //           width: 20,
  //           child: CircularProgressIndicator(
  //             color: colors.primary,
  //           ),
  //         )),
  //                           errorWidget: (context, url, error) => Container(
  //                             height: 5,
  //                             width: 5,
  //                             child: Icon(
  //                               Icons.error,
  //                               color: AppColor.PrimaryDark,
  //                             ),
  //                           ),
  //                         )),
  //                   ),
  //                 )
  //                 .toList(),
  //             onPageChanged: (value) {
  //               print('Page changed: $value');
  //             },
  //           ),
  //         );
  // }

  String? roles;
  String? uid;
  String? type;
  String? deliveryType;
  String? bookingID;
  String? userName;
  String? userPic;
  String? wallet;
  String? mobileNo;
  String? onOfStatus;
  String? approvalStatus;
  String? userImage;
  String? uName;

  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString(TokenString.userid);
    type = prefs.getString(TokenString.type);
    roles = prefs.getString(TokenString.roles);
    userName = prefs.getString(TokenString.userName);
    userPic = prefs.getString(TokenString.userPic);
    // wallet = prefs.getString(TokenString.walletBalance);
    currentAddress = prefs.getString(TokenString.deviceToken);
    onOfStatus = prefs.getString(TokenString.onOffStatus);
    // approvalStatus = prefs.getString(TokenString.approvalStatus);

    // if(onOfStatus == "1"){
    //   setState((){
    //     onOff = true;
    //   });
    // }else{
    //   setState((){
    //     onOff = false;
    //   });
    // }
    _getBanners();
    print(
        "roles here ${roles.toString()} aaand ${type.toString()} &&& ${uid.toString()}");
  }

  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  Future updateFcmToken() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.updateFcmTokenUrl}'));
    request.fields.addAll({
      'fcm_id': '${token.toString()}',
      'id': '${uid.toString()}'
      // 'device_token': ''
    });
    print("this is vendor ====>>>>   ${request.fields.toString()}");

    http.StreamedResponse response = await request.send();

    print(request);
    print(request.fields);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      // var results = LoginWithOtpModel.fromJson(json.decode(str));
      // print("checking result here ${results.message} and ${results.otp} and  ${results}");

      // setState(() {
      //   resendOtp = results.otp.toString();
      // });
      // return LoginWithOtpModel.fromJson(json.decode(str));
    } else {
      print("checking fail response ${response.statusCode}");
    }
  }

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
      approvalStatus = result.data![0].status;
      uName = result.data![0].uname;
      userImage = result.data![0].profileImage;
      wallet = result.data![0].wallet.toString();
      mobileNo = result.data![0].mobile.toString();
      prefs.setString(TokenString.walletBalance, wallet.toString());
      print("this is approval status ====>>> ${approvalStatus.toString()}");
      if (approvalStatus == "0") {
        setState(() {
          isSwitched = false;
        });
      } else {
        setState(() {
          isSwitched = true;
        });
      }
      // prefs.setString(TokenString.approvalStatus, approvalStatus!);
      print("this is approval status ====>>> ${approvalStatus.toString()}");

      return GetProfileModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  accountDelete() async {
    var headers = {
      'Cookie': 'ci_session=3ab2e0bfe4c2535c351d13c7ca58f780dce6aa8f'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${Apipath.accountDelete}'));
    request.fields.addAll({
      'mobile': '${mobileNo.toString()}'
    });
    print("this is request =====>>>>> ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var result= json.decode(str);
      if(result['response_code'] == "1"){
        setSnackBar("${result['msg']}");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Login()));
      }else{
        setSnackBar("${result['msg']}");
      }
      // var result = GetProfileModel.fromJson(json.decode(str));
      // approvalStatus = result.data![0].status;
      // uName = result.data![0].uname;
      // userImage = result.data![0].profileImage;
      // wallet = result.data![0].wallet.toString();
      // prefs.setString(TokenString.walletBalance, wallet.toString());
      // print("this is approval status ====>>> ${approvalStatus.toString()}");
      // if (approvalStatus == "0") {
      //   setState(() {
      //     isSwitched = false;
      //   });
      // } else {
      //   setState(() {
      //     isSwitched = true;
      //   });
      // }
      // // prefs.setString(TokenString.approvalStatus, approvalStatus!);
      // print("this is approval status ====>>> ${approvalStatus.toString()}");
      //
      // return GetProfileModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  // Bookings? model;
  FoodOrder? foodDeliveryModel;
  ParcelModel? deliveryModel;
  bool isRide = false;

  getDeliverRideBooking(String? id) async {
    print("this is initiated $id");
    var headers = {
      'Cookie': 'ci_session=3ab2e0bfe4c2535c351d13c7ca58f780dce6aa8f'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.getRideDeliveryBooking}'));
    request.fields.addAll({
      'booking_id': '${id.toString()}',
      // 'type': '${type.toString()}'

      //'$uid'
    });
    print("this is request =====>>>>> ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var result = RideBookingModel.fromJson(json.decode(str));

      setState(() {
        deliveryModel = result.rides;
        isRide = true;
      });
    } else {
      return null;
    }
  }

  getFoodDeliveryBooking(String? id) async {
    var headers = {
      'Cookie': 'ci_session=3ab2e0bfe4c2535c351d13c7ca58f780dce6aa8f'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.getFoodDeliveryBooking}'));
    request.fields.addAll({
      'booking_id': '${id.toString()}',
    });
    print(
        "this is our food delivery request =====>>>>> ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("this food delivery response @@ ${response.statusCode}");
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      var result = FoodDeliveryModel.fromJson(json.decode(str));
      foodDeliveryModel = result.orders;
    } else {
      return null;
    }
  }

  String? currentAddress;
  Future _refresh() async {
    return callApi();
  }

  Future<Null> callApi() async {
    await getProfile();
    await _getSettings();
    await getSharedData();
    await getUserCurrentLocation();
    await _getAddressFromLatLng();
    await _buyVendorProduct();
    // getFoodDeliveryBooking(foodDeliveryModel!.orderId);
    await getFoodOrders();
    await getVendorBooking();
    await _getBanners();

    return null;
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationService notificationService = new PushNotificationService(
      context: context,
      onResult: (result) async {
        print("boook " + result.toString());
        if (result != null) {
          var id = result;
          // deliveryType = result.type;
          await getFoodDeliveryBooking(id);
          await getDeliverRideBooking(id);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          });
          // if(type =="Food"){
          //   setState((){

          // Future.delayed(Duration(
          //   seconds: 2
          // ),(){
          //   _refresh();
          // });
          // });
          // }
          // else {
          //   // getDeliverRideBooking(id, type);
          // }
          // if(result != null){
          //   if (result == "yes") {
          //     // registerToken();
          //   }
          //   else {
          //     // getDeliverRideBooking(result);
          //   }
        }
      },
      // type: type
    );
    notificationService.initialise();
    _getSettings();
    callApi();
    getUserCurrentLocation();
    _getAddressFromLatLng();
    _buyVendorProduct();

    // _refresh();

    // Future.delayed(Duration(seconds: 1), () {
    //   return _refresh();
    // });
  }

  LocationPermission? permission;

  Future getUserCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation!.latitude;
          homeLong = currentLocation!.longitude;
        });
    });
    print("LOCATION===" + currentLocation.toString());
  }

  _getAddressFromLatLng() async {
    getUserCurrentLocation().then((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);

        Placemark place = p[0];

        setState(() {
          _currentAddress =
              "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
          prefs.setString(
              TokenString.currentAddress, _currentAddress.toString());

          //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
          print("this is current location ==========>>>>>  ${_currentAddress}");
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: AppColor().colorPrimary(),
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Scaffold(
          backgroundColor: colors.primary,
          key: _scaffoldKey,
          drawer: getDrawer(),
          // bottomSheet:  model != null
          //     ? Stack(
          //   alignment: Alignment.bottomCenter,
          //   children: [
          //     Card(
          //       margin: EdgeInsets.all(8.0),
          //       child: SingleChildScrollView(
          //         child: Container(
          //           padding: EdgeInsets.all(15),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               text("Ride Info",
          //                   fontSize: 12,
          //                   // fontFamily: fontMedium,
          //                   textColor: Colors.black),
          //               Divider(),
          //               boxHeight(5),
          //               Row(
          //                 children: [
          //                   Container(
          //                     height: 10,
          //                     width: 10,
          //                     decoration: boxDecoration(
          //                         radius: 100,
          //                         bgColor: Colors.green),
          //                   ),
          //                   boxWidth(10),
          //                   Expanded(
          //                       child: text(
          //                           model!.pickupAddress.toString(),
          //                           fontSize: 12,
          //                           fontFamily: fontRegular,
          //                           textColor: Colors.black)),
          //                 ],
          //               ),
          //               boxHeight(5),
          //               model!.dropAddress!=null?Row(
          //                 children: [
          //                   Container(
          //                     height: 10,
          //                     width: 10,
          //                     decoration: boxDecoration(
          //                         radius: 100, bgColor: Colors.red),
          //                   ),
          //                   boxWidth(10),
          //                   Expanded(
          //                       child: text(
          //                           model!.dropAddress.toString(),
          //                           fontSize: 12,
          //                           fontFamily: fontRegular,
          //                           textColor: Colors.black)),
          //                 ],
          //               ):SizedBox(),
          //               boxHeight(5),
          //               Divider(),
          //               boxHeight(5),
          //               Row(
          //                 mainAxisAlignment:
          //                 MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   text("Payment Mode : ",
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                   text(model!.transaction.toString(),
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                 ],
          //               ),
          //               boxHeight(5),
          //               // !model!.bookingType
          //               //     .toString()
          //               //     .contains("Point")
          //               //     ? AnimatedTextKit(
          //               //   animatedTexts: [
          //               //     ColorizeAnimatedText(
          //               //       model!.bookingType
          //               //           .toString()
          //               //           .contains("Rental Booking")?"Rental Booking - ${model!.start_time} - ${model!.end_time}":"Schedule - ${model!.pickupDate} ${model!.pickupTime}",
          //               //       textStyle: colorizeTextStyle,
          //               //       colors: colorizeColors,
          //               //     ),
          //               //   ],
          //               //   pause: Duration(milliseconds: 100),
          //               //   isRepeatingAnimation: true,
          //               //   totalRepeatCount: 100,
          //               //   onTap: () {
          //               //     print("Tap Event");
          //               //   },
          //               // )
          //               //     : SizedBox(),
          //               boxHeight(5),
          //               Row(
          //                 mainAxisAlignment:
          //                 MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   text("Ride Type : ",
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                   text(model!.bookingType.toString(),
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                 ],
          //               ),
          //               boxHeight(5),
          //               Row(
          //                 mainAxisAlignment:
          //                 MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   text("Earning Amount : ",
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                   text("₹" + model!.paidAmount.toString(),
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                 ],
          //               ),
          //               boxHeight(5),
          //               Row(
          //                 mainAxisAlignment:
          //                 MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   text(model!.bookingType
          //                       .toString()
          //                       .contains("Rental Booking")?"Hours : ":"Distance : ",
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                   text(model!.bookingType
          //                       .toString()
          //                       .contains("Rental Booking")?model!.hours.toString() + " hrs":model!.km.toString() + " km",
          //                       fontSize: 12,
          //                       fontFamily: fontMedium,
          //                       textColor: Colors.black),
          //                 ],
          //               ),
          //               boxHeight(5),
          //               /*Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       crossAxisAlignment:
          //                       CrossAxisAlignment.start,
          //                       children: [
          //                         text("Earning Amount ",
          //                             fontSize: 10.sp,
          //                             fontFamily: fontMedium,
          //                             textColor: Colors.black),
          //                         text("₹" + model!.paidAmount.toString(),
          //                             fontSize: 10.sp,
          //                             fontFamily: fontMedium,
          //                             textColor: Colors.black),
          //                         text("|",
          //                             fontSize: 10.sp,
          //                             fontFamily: fontMedium,
          //                             textColor: Colors.black),
          //                         text("Distance ",
          //                             fontSize: 10.sp,
          //                             fontFamily: fontMedium,
          //                             textColor: Colors.black),
          //                         text(model!.km.toString() + " km",
          //                             fontSize: 10.sp,
          //                             fontFamily: fontMedium,
          //                             textColor: Colors.black),
          //                       ],
          //                     ),*/
          //               Container(
          //                 child: Column(
          //                   children: [
          //                     double.parse(model!.gstAmount
          //                         .toString()) >
          //                         0
          //                         ? Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment
          //                           .spaceBetween,
          //                       children: [
          //                         text("Sub Total : ",
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor:
          //                             Colors.black),
          //                         text(
          //                             "₹" +
          //                                 (double.parse(model!
          //                                     .amount
          //                                     .toString()) -
          //                                     double.parse(model!
          //                                         .gstAmount
          //                                         .toString()) -
          //                                     double.parse(model!
          //                                         .surgeAmount
          //                                         .toString()))
          //                                     .toStringAsFixed(
          //                                     2),
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor:
          //                             Colors.black),
          //                       ],
          //                     )
          //                         : SizedBox(),
          //                     model!.baseFare!=null&&model!.baseFare! is double&&double.parse(model!.baseFare
          //                         .toString()) >
          //                         0
          //                         ? Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment
          //                           .spaceBetween,
          //                       children: [
          //                         text("Base fare : ",
          //                             fontSize: 12,
          //                             fontFamily: fontRegular,
          //                             textColor:
          //                             Colors.black),
          //                         text(
          //                             "₹" +
          //                                 model!.baseFare
          //                                     .toString(),
          //                             fontSize: 12,
          //                             fontFamily: fontRegular,
          //                             textColor:
          //                             Colors.black),
          //                       ],
          //                     )
          //                         : SizedBox(),
          //                     model!.ratePerKm!=null&&model!.ratePerKm! is double&&double.parse(model!.km.toString()) >=
          //                         2 &&
          //                         double.parse(model!.ratePerKm
          //                             .toString()
          //                             .replaceAll(
          //                             ",", "")) >
          //                             0
          //                         ? Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment
          //                           .spaceBetween,
          //                       children: [
          //                         text(
          //                             "${model!.km.toString()} Kilometers : ",
          //                             fontSize: 12,
          //                             fontFamily: fontRegular,
          //                             textColor:
          //                             Colors.black),
          //                         text(
          //                             "₹" +
          //                                 model!.ratePerKm
          //                                     .toString()
          //                                     .replaceAll(
          //                                     ",", ""),
          //                             fontSize: 12,
          //                             fontFamily: fontRegular,
          //                             textColor:
          //                             Colors.black),
          //                       ],
          //                     )
          //                         : SizedBox(),
          //                     model!.timeAmount!=null&&model!.timeAmount! is double&&double.parse(model!.timeAmount
          //                         .toString()) >
          //                         0
          //                         ? Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment
          //                           .spaceBetween,
          //                       children: [
          //                         text(
          //                             "${model!.totalTime.toString()} Minutes : ",
          //                             fontSize: 12,
          //                             fontFamily: fontRegular,
          //                             textColor:
          //                             Colors.black),
          //                         text(
          //                             "₹" +
          //                                 model!.timeAmount
          //                                     .toString(),
          //                             fontSize: 12,
          //                             fontFamily: fontRegular,
          //                             textColor:
          //                             Colors.black),
          //                       ],
          //                     )
          //                         : SizedBox(),
          //                     double.parse(model!.gstAmount
          //                         .toString()) >
          //                         0
          //                         ? Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment
          //                           .spaceBetween,
          //                       children: [
          //                         text("Taxes : ",
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor:
          //                             Colors.black),
          //                         text(
          //                             "₹" +
          //                                 model!.gstAmount
          //                                     .toString(),
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor:
          //                             Colors.black),
          //                       ],
          //                     )
          //                         : SizedBox(),
          //                     double.parse(model!.surgeAmount
          //                         .toString()) >
          //                         0
          //                         ? Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment
          //                           .spaceBetween,
          //                       children: [
          //                         text("Surge Amount : ",
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor:
          //                             Colors.black),
          //                         text(
          //                             "₹" +
          //                                 model!.surgeAmount
          //                                     .toString(),
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor:
          //                             Colors.black),
          //                       ],
          //                     )
          //                         : SizedBox(),
          //                     Divider(),
          //                     Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         text("Total : ",
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor: Colors.black),
          //                         text("₹" + "${model!.amount}",
          //                             fontSize: 12,
          //                             fontFamily: fontMedium,
          //                             textColor: Colors.black),
          //                       ],
          //                     ),
          //                     boxHeight(5),
          //                   ],
          //                 ),
          //               ),
          //               boxHeight(5),
          //               !acceptStatus
          //                   ? Row(
          //                 mainAxisAlignment:
          //                 MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   InkWell(
          //                     onTap: () {
          //                       // setState(() {
          //                       //   acceptStatus = true;
          //                       // });
          //                       // bookingStatus(
          //                       //     model!.id.toString(),
          //                       //     "2");
          //
          //                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>FindingRidePage()));
          //                     },
          //                     child: Container(
          //                       width: 100,
          //                       height: 35,
          //                       decoration: boxDecoration(
          //                           radius: 5,
          //                           bgColor: Colors.grey),
          //                       child: Center(
          //                           child: text("Reject",
          //                               fontFamily:
          //                               fontMedium,
          //                               fontSize: 12,
          //                               isCentered: true,
          //                               textColor:
          //                               Colors.white)),
          //                     ),
          //                   ),
          //                   InkWell(
          //                     onTap: () async {
          //                       ///
          //                       // if (currentBookingStatus == true) {
          //                       //   setState(() {
          //                       //     acceptStatus = true;
          //                       //     condition = true;
          //                       //   });
          //                       //   bookingStatus(
          //                       //       model!.id.toString(),
          //                       //       "1");
          //                       // } else {
          //                       //   setState(() {
          //                       //     condition = true;
          //                       //     model = null;
          //                       //   });
          //                       //   setSnackbar(
          //                       //       "Ride is Cancelled by User",
          //                       //       context);
          //                       //   print("CANCELLED");
          //                       // }
          //                       ///
          //                     },
          //                     child: Container(
          //                       width: 100,
          //                       height: 35,
          //                       decoration: boxDecoration(
          //                           radius: 5,
          //                           bgColor: Theme.of(context)
          //                               .primaryColor),
          //                       child: Center(
          //                           child: text("Accept",
          //                               fontFamily:
          //                               fontMedium,
          //                               fontSize: 12,
          //                               isCentered: true,
          //                               textColor:
          //                               Colors.white)),
          //                     ),
          //                   ),
          //                 ],
          //               )
          //                   : Center(
          //                 child: CircularProgressIndicator(),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // )
          //     : SizedBox(),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              backgroundColor: colors.primary,
              leading: InkWell(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 8, bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: colors.primary),
                    //     color: colors.primary),
                    child: const ImageIcon(
                        AssetImage(
                          'images/drawericon.png',
                        ),
                        color: colors.whit),
                  ),
                ),
              ),
              elevation: 0,
              title: Container(
                  child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.location_on,
                      color: colors.whit,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 170,
                    child: Text(
                      _currentAddress == "" || _currentAddress == null
                          ? ""
                          : "${_currentAddress.toString()}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          color: colors.whit,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              )),
              actions: [
                InkWell(
                  onTap: () async {
                    Notifications result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                    if (result != null) {
                      setState(() {
                        bookingID = result.dataId;
                        deliveryType = result.type;
                      });
                      print(
                          "this is delivery type ---->> =====>>> ${bookingID.toString()}");
                      // if (type == "1") {
                      //   await getFoodDeliveryBooking(bookingID);
                      // } else if (type == "2") {
                      await getFoodDeliveryBooking(bookingID);

                      await getDeliverRideBooking(bookingID);
                      // }
                      // Future.delayed(Duration(seconds: 2), () {
                      //   _refresh();
                      // });
                    }
                    // Navigator.push(context, MaterialPageRoute(builder:(context)=>NotificationScreen()));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 4.0, top: 1, bottom: 8),
                    child: const Icon(Icons.notifications, color: colors.whit),
                  ),
                ),
                Container(width: 10),
              ],
            ),
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
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(builder: (context) => SearchProduct()),
                          //     // );
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //         top: 30.0, left: 15, right: 15),
                          //     child: Card(
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10)),
                          //       elevation: 4,
                          //       child: TextFormField(
                          //         decoration: InputDecoration(
                          //           fillColor: Colors.white,
                          //           // filled: true,
                          //
                          //           border: UnderlineInputBorder(
                          //               borderSide: BorderSide.none,
                          //               borderRadius:
                          //                   BorderRadius.circular(10)),
                          //           hintText: "Search ",
                          //           hintStyle: TextStyle(
                          //               color: AppColor().colorPrimary()),
                          //           prefixIcon: Icon(
                          //             Icons.search,
                          //             color: AppColor().colorPrimary(),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Container(
                              decoration: BoxDecoration(),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 8.0, right: 8),
                          //   child: CarouselSlider(
                          //     options: CarouselOptions(
                          //       height: 200
                          //     ),
                          //     items: bannerModal!.banners!.map((i) {
                          //       return Builder(
                          //         builder: (BuildContext context) {
                          //           return Container(
                          //             width: MediaQuery.of(context).size.width,
                          //             height: 180,
                          //             padding: const EdgeInsets.only(left: 8.0, right: 8),
                          //             child: Image.network(i,
                          //             height: ,),
                          //           );
                          //         },
                          //       );
                          //     }).toList(),
                          //   ),
                          // ),
                          _banner(context),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, bottom: 8, top: 8),
                                    child: Text('Today offer',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: AppColor().colorPrimary(),
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                  isProduct
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OfferDetails(
                                                            model: productModel!
                                                                .products![0],
                                                          )));
                                            },
                                            child: Card(
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                      colors: [
                                                        AppColor().colorGrad1(),
                                                        AppColor().colorGrad2(),
                                                      ],
                                                    )),
                                                padding:
                                                    const EdgeInsets.all(15),
                                                // only(left: 85, right: 20),
                                                height: 120,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.1,
                                                // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Image.
                                                              // asset("images/delivery.png"),
                                                              network(
                                                            productModel!
                                                                .products![0]
                                                                .productImage![
                                                                    0]
                                                                .toString(),
                                                            width: 80,
                                                            height: 80,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              productModel!
                                                                  .products![0]
                                                                  .productName
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(height: 5),

                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "\u{20B9} ${productModel!.products![0].productPrice.toString()}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "\u{20B9} ${productModel!.products![0].sellingPrice.toString()}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColor()
                                                                        .colorPrimary(),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5),
                                                            // Text("${ProductModel!.products![index].productPrice}"),
                                                            Container(
                                                              width: 200,
                                                              child: Text(
                                                                productModel!
                                                                    .products![
                                                                        0]
                                                                    .productDescription
                                                                    .toString(),
                                                                maxLines: 3,
                                                                style:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_right,
                                                      color:
                                                          AppColor.PrimaryDark,
                                                      size: 40,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: colors.primary,
                                          ),
                                        )),
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(15.0),
                                  //   child: Image.asset(
                                  //     "assets/images/home2.png", height:140,width: 300,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, bottom: 8, top: 8),
                            child: Text(
                                roles != "Food" ? "Today Jobs" : 'New Order',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor().colorPrimary(),
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          type == "1"
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: FutureBuilder(
                                      future: getFoodOrders(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          GetVendorOrderModel? model =
                                              snapshot.data;
                                          return model!.responseCode == "1"
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount:
                                                      model.orders!.length,
                                                  itemBuilder: (context, i) {
                                                    return cardWidget(model, i);
                                                  })
                                              : Container(
                                                  height: 100,
                                                  child: Center(
                                                      child: Text(roles !=
                                                              "Food"
                                                          ? "No Jobs Found!!"
                                                          : "No Orders Found!!")),
                                                );
                                        } else if (snapshot.hasError) {
                                          return Icon(Icons.error_outline);
                                        } else {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.5,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color:
                                                    AppColor().colorPrimary(),
                                              )));
                                        }
                                      }),
                                )
                              : type == "5" || type == "6" || type == "7"
                                  ? FutureBuilder(
                                      future: getVendorBooking(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          VendorBookingModel model =
                                              snapshot.data;
                                          return model.responseCode == "1"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          model.data!.length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return cardWidget1(
                                                            model, i);
                                                      }),
                                                )
                                              : Container(
                                                  height: 100,
                                                  child: Center(
                                                      child: Text(roles !=
                                                              "Food"
                                                          ? "No Jobs Found!!"
                                                          : "No Orders Found!!")),
                                                );
                                        } else if (snapshot.hasError) {
                                          return Icon(Icons.error_outline);
                                        } else {
                                          return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  1.5,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color:
                                                    AppColor().colorPrimary(),
                                              )));
                                        }
                                      })
                                  : type == "2" || type == "3" || type == "4"
                                      ? deliveryType == "Food"
                                          ? foodDeliveryModel != null
                                              ? InkWell(
                                                  onTap: () {
                                                    // model.rides![i].type
                                                    // if(model.order![i].bookingsType == "ride_booking") {
                                                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  OfflinePage("")));
                                                    // } else{
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OrderFoodDelivery(
                                                                  data:
                                                                      foodDeliveryModel,
                                                                )));
                                                    // }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      child: Container(
                                                        // padding: EdgeInsets.all(12),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .PrimaryDark),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 12.0,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Name",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Text(
                                                                    "${foodDeliveryModel!.username}",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      bottom: 4,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Date & Time",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Text(
                                                                    "${foodDeliveryModel!.date}",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      bottom: 4,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Address",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Container(
                                                                    width: 180,
                                                                    child: Text(
                                                                      "${foodDeliveryModel!.deliveryAddress}",
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          color: AppColor()
                                                                              .colorPrimary(),
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          overflow:
                                                                              TextOverflow.ellipsis),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      bottom: 4,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Amount",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Text(
                                                                    "₹ ${foodDeliveryModel!.total}",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.w600),
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
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor()
                                                                      .colorPrimary(),
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              12),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              12))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  foodDeliveryModel!
                                                                              .orderStatus ==
                                                                          "3"
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 7.0),
                                                                          child:
                                                                              Center(
                                                                            child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                    primary: Colors.green,
                                                                                    fixedSize: Size(140, 35),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    )),
                                                                                child: Text(
                                                                                  "Delivered",
                                                                                  style: TextStyle(fontWeight: FontWeight.w400),
                                                                                )),
                                                                          ),
                                                                        )
                                                                      : foodDeliveryModel!.orderStatus ==
                                                                              "5"
                                                                          ? Padding(
                                                                              padding: const EdgeInsets.only(top: 7.0),
                                                                              child: Center(
                                                                                child: ElevatedButton(
                                                                                    onPressed: () {
                                                                                      //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(
                                                                                        primary: Colors.green,
                                                                                        fixedSize: Size(140, 35),
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        )),
                                                                                    child: Text(
                                                                                      "Accepted",
                                                                                      style: TextStyle(fontWeight: FontWeight.w400),
                                                                                    )),
                                                                              ),
                                                                            )
                                                                          : foodDeliveryModel!.orderStatus == "6"
                                                                              ? Padding(
                                                                                  padding: const EdgeInsets.only(top: 7.0),
                                                                                  child: ElevatedButton(
                                                                                      onPressed: () {
                                                                                        // updateFoodOrderStatus(
                                                                                        //     "${foodDeliveryModel!.orderId}", "4");
                                                                                        // if(type =="1"){
                                                                                        //   getFoodOrders();
                                                                                        // }else{
                                                                                        //   getVendorBooking();
                                                                                        // }
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                          primary: Colors.red,
                                                                                          fixedSize: Size(140, 35),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          )),
                                                                                      child: Text(
                                                                                        "Declined",
                                                                                        style: TextStyle(fontWeight: FontWeight.w400),
                                                                                      )),
                                                                                )
                                                                              : Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    ElevatedButton(
                                                                                        onPressed: () {
                                                                                          updateFoodDeliveryStatus("${foodDeliveryModel!.orderId}", "5");

                                                                                          // if(type =="1"){
                                                                                          //   getFoodOrders();
                                                                                          // }else{
                                                                                          //   getVendorBooking();
                                                                                          // }
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(
                                                                                            primary: Colors.green,
                                                                                            fixedSize: Size(140, 35),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                            )),
                                                                                        child: Text(
                                                                                          "Accept",
                                                                                          style: TextStyle(fontWeight: FontWeight.w400),
                                                                                        )),
                                                                                    const SizedBox(
                                                                                      width: 15,
                                                                                    ),
                                                                                    ElevatedButton(
                                                                                        onPressed: () {
                                                                                          updateFoodDeliveryStatus("${foodDeliveryModel!.orderId}", "6");
                                                                                          // Future.delayed(Duration(seconds: 1), (){
                                                                                          //   getFoodDeliveryBooking("");
                                                                                          // });
                                                                                          // if(type =="1"){
                                                                                          //   getFoodOrders();
                                                                                          // }else{
                                                                                          //   getVendorBooking();
                                                                                          // }
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(
                                                                                            primary: Colors.red,
                                                                                            fixedSize: Size(140, 35),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                            )),
                                                                                        child: Text(
                                                                                          "Decline",
                                                                                          style: TextStyle(fontWeight: FontWeight.w400),
                                                                                        ))
                                                                                  ],
                                                                                ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      3,
                                                  child: Center(
                                                      child: Text(
                                                          "No Bookings found!")),
                                                )
                                          : deliveryModel == null
                                              ? Container(
                                                  height: 100,
                                                  child: Center(
                                                      child: Text(roles !=
                                                              "Food"
                                                          ? "No Jobs Found!!"
                                                          : "No Orders Found!!")),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration(seconds: 4),
                                                        () {
                                                      if (type == "3" ||
                                                          type == "4") {
                                                        // getDeliverRideBooking();
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DeliveryDetails(
                                                                        data:
                                                                            deliveryModel!)));
                                                      }
                                                    });
                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(builder: (context) => BottomBarDelivery(
                                                    //       index: 1,
                                                    //     )));
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             DeliveryDetails(
                                                    //               data:
                                                    //                   deliveryModel!,
                                                    //             )));
                                                    // }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Card(
                                                      elevation: 5,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      child: Container(
                                                        // padding: EdgeInsets.all(12),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .PrimaryDark),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 12.0,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Name",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Text(
                                                                    "${deliveryModel!.username}",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      bottom: 4,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Date & Time",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Text(
                                                                    "${deliveryModel!.dateAdded}",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      bottom: 4,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Pick Up Location",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Container(
                                                                    width: 180,
                                                                    child: Text(
                                                                      "${deliveryModel!.pickupAddress}",
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          color: AppColor()
                                                                              .colorPrimary(),
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          overflow:
                                                                              TextOverflow.ellipsis),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      bottom: 4,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Drop Location",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Container(
                                                                    width: 180,
                                                                    child: Text(
                                                                      "${deliveryModel!.dropAddress}",
                                                                      maxLines:
                                                                          2,
                                                                      style: TextStyle(
                                                                          color: AppColor()
                                                                              .colorPrimary(),
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          overflow:
                                                                              TextOverflow.ellipsis),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 4.0,
                                                                      bottom: 4,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Amount",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                  Text(
                                                                    "₹ ${deliveryModel!.amount}",
                                                                    style: TextStyle(
                                                                        color: AppColor()
                                                                            .colorPrimary(),
                                                                        fontWeight:
                                                                            FontWeight.w600),
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
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor()
                                                                      .colorPrimary(),
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              12),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              12))),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  deliveryModel!
                                                                              .status ==
                                                                          "0"
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 7.0),
                                                                          child:
                                                                              Center(
                                                                            child: ElevatedButton(
                                                                                onPressed: () {
                                                                                  //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                    primary: Colors.green,
                                                                                    fixedSize: Size(140, 35),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    )),
                                                                                child: Text(
                                                                                  "Accepted",
                                                                                  style: TextStyle(fontWeight: FontWeight.w400),
                                                                                )),
                                                                          ),
                                                                        )
                                                                      : deliveryModel!.status ==
                                                                              "4"
                                                                          ? Padding(
                                                                              padding: const EdgeInsets.only(top: 7.0),
                                                                              child: ElevatedButton(
                                                                                  onPressed: () {
                                                                                    updateFoodOrderStatus("${deliveryModel!.status}", "4");
                                                                                    if (type == "1") {
                                                                                      getFoodOrders();
                                                                                    } else {
                                                                                      getVendorBooking();
                                                                                    }
                                                                                  },
                                                                                  style: ElevatedButton.styleFrom(
                                                                                      primary: Colors.red,
                                                                                      fixedSize: Size(140, 35),
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      )),
                                                                                  child: Text(
                                                                                    "Declined",
                                                                                    style: TextStyle(fontWeight: FontWeight.w400),
                                                                                  )),
                                                                            )
                                                                          : Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                ElevatedButton(
                                                                                    onPressed: () {
                                                                                      updateFoodOrderStatus("$bookingID", "1");
                                                                                      Future.delayed(Duration(seconds: 4), () {
                                                                                        if (type == "3" || type == "4") {
                                                                                          // getDeliverRideBooking();
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDetails(data: deliveryModel!)));
                                                                                        }
                                                                                        if (type == "1") {
                                                                                          getFoodOrders();
                                                                                        } else {
                                                                                          getVendorBooking();
                                                                                        }
                                                                                      });
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(
                                                                                        primary: Colors.green,
                                                                                        fixedSize: Size(140, 35),
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        )),
                                                                                    child: Text(
                                                                                      "Accept",
                                                                                      style: TextStyle(fontWeight: FontWeight.w400),
                                                                                    )),
                                                                                const SizedBox(
                                                                                  width: 15,
                                                                                ),
                                                                                ElevatedButton(
                                                                                    onPressed: () {
                                                                                      updateFoodOrderStatus("$bookingID", "4");
                                                                                      Future.delayed(Duration(seconds: 1), () {
                                                                                        if (type == "3" || type == "4") {
                                                                                          // getDeliverRideBooking();
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryDetails(data: deliveryModel!)));
                                                                                        }
                                                                                        if (type == "1") {
                                                                                          getFoodOrders();
                                                                                        } else {
                                                                                          getVendorBooking();
                                                                                        }
                                                                                      });
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(
                                                                                        primary: Colors.red,
                                                                                        fixedSize: Size(140, 35),
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        )),
                                                                                    child: Text(
                                                                                      "Decline",
                                                                                      style: TextStyle(fontWeight: FontWeight.w400),
                                                                                    ))
                                                                              ],
                                                                            ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                      // : type == "2"
                                      //     ? // ?  deliveryType == "food" ?
                                      //     foodDeliveryModel != null
                                      //         ? InkWell(
                                      //             onTap: () {
                                      //               // model.rides![i].type
                                      //               // if(model.order![i].bookingsType == "ride_booking") {
                                      //               //   Navigator.push(context, MaterialPageRoute(builder: (context)=>  OfflinePage("")));
                                      //               // } else{
                                      //               Navigator.push(
                                      //                   context,
                                      //                   MaterialPageRoute(
                                      //                       builder: (context) =>
                                      //                           OrderFoodDelivery(
                                      //                             data:
                                      //                                 foodDeliveryModel,
                                      //                           )));
                                      //               // }
                                      //             },
                                      //             child: Padding(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       4.0),
                                      //               child: Card(
                                      //                 elevation: 5,
                                      //                 shape:
                                      //                     RoundedRectangleBorder(
                                      //                         borderRadius:
                                      //                             BorderRadius
                                      //                                 .circular(
                                      //                                     15)),
                                      //                 child: Container(
                                      //                   // padding: EdgeInsets.all(12),
                                      //                   decoration:
                                      //                       BoxDecoration(
                                      //                     border: Border.all(
                                      //                         color: AppColor
                                      //                             .PrimaryDark),
                                      //                     borderRadius:
                                      //                         BorderRadius
                                      //                             .circular(15),
                                      //                   ),
                                      //                   child: Column(
                                      //                     children: [
                                      //                       Padding(
                                      //                         padding:
                                      //                             const EdgeInsets
                                      //                                     .only(
                                      //                                 top: 12.0,
                                      //                                 left: 15,
                                      //                                 right:
                                      //                                     15),
                                      //                         child: Row(
                                      //                           mainAxisAlignment:
                                      //                               MainAxisAlignment
                                      //                                   .spaceBetween,
                                      //                           children: [
                                      //                             Text(
                                      //                               "Name",
                                      //                               style: TextStyle(
                                      //                                   color: AppColor()
                                      //                                       .colorPrimary(),
                                      //                                   fontWeight:
                                      //                                       FontWeight.normal),
                                      //                             ),
                                      //                             Text(
                                      //                               "${foodDeliveryModel!.username}",
                                      //                               style: TextStyle(
                                      //                                   color: AppColor()
                                      //                                       .colorPrimary(),
                                      //                                   fontWeight:
                                      //                                       FontWeight.w600),
                                      //                             )
                                      //                           ],
                                      //                         ),
                                      //                       ),
                                      //                       Padding(
                                      //                         padding:
                                      //                             const EdgeInsets
                                      //                                     .only(
                                      //                                 top: 4.0,
                                      //                                 bottom: 4,
                                      //                                 left: 15,
                                      //                                 right:
                                      //                                     15),
                                      //                         child: Row(
                                      //                           mainAxisAlignment:
                                      //                               MainAxisAlignment
                                      //                                   .spaceBetween,
                                      //                           children: [
                                      //                             Text(
                                      //                               "Date & Time",
                                      //                               style: TextStyle(
                                      //                                   color: AppColor()
                                      //                                       .colorPrimary(),
                                      //                                   fontWeight:
                                      //                                       FontWeight.normal),
                                      //                             ),
                                      //                             Text(
                                      //                               "${foodDeliveryModel!.date}",
                                      //                               style: TextStyle(
                                      //                                   color: AppColor()
                                      //                                       .colorPrimary(),
                                      //                                   fontWeight:
                                      //                                       FontWeight.w600),
                                      //                             )
                                      //                           ],
                                      //                         ),
                                      //                       ),
                                      //                       Padding(
                                      //                         padding:
                                      //                             const EdgeInsets
                                      //                                     .only(
                                      //                                 top: 4.0,
                                      //                                 bottom: 4,
                                      //                                 left: 15,
                                      //                                 right:
                                      //                                     15),
                                      //                         child: Row(
                                      //                           mainAxisAlignment:
                                      //                               MainAxisAlignment
                                      //                                   .spaceBetween,
                                      //                           crossAxisAlignment:
                                      //                               CrossAxisAlignment
                                      //                                   .start,
                                      //                           children: [
                                      //                             Text(
                                      //                               "Address",
                                      //                               style: TextStyle(
                                      //                                   color: AppColor()
                                      //                                       .colorPrimary(),
                                      //                                   fontWeight:
                                      //                                       FontWeight.normal),
                                      //                             ),
                                      //                             Container(
                                      //                               width: 180,
                                      //                               child: Text(
                                      //                                 // "",
                                      //                                 "${foodDeliveryModel!.deliveryAddress}",
                                      //                                 maxLines:
                                      //                                     2,
                                      //                                 style: TextStyle(
                                      //                                     color: AppColor()
                                      //                                         .colorPrimary(),
                                      //                                     fontWeight: FontWeight
                                      //                                         .w600,
                                      //                                     overflow:
                                      //                                         TextOverflow.ellipsis),
                                      //                               ),
                                      //                             )
                                      //                           ],
                                      //                         ),
                                      //                       ),
                                      //                       Padding(
                                      //                         padding:
                                      //                             const EdgeInsets
                                      //                                     .only(
                                      //                                 top: 4.0,
                                      //                                 bottom: 4,
                                      //                                 left: 15,
                                      //                                 right:
                                      //                                     15),
                                      //                         child: Row(
                                      //                           mainAxisAlignment:
                                      //                               MainAxisAlignment
                                      //                                   .spaceBetween,
                                      //                           children: [
                                      //                             Text(
                                      //                               "Amount",
                                      //                               style: TextStyle(
                                      //                                   color: AppColor()
                                      //                                       .colorPrimary(),
                                      //                                   fontWeight:
                                      //                                       FontWeight.normal),
                                      //                             ),
                                      //                             Text(
                                      //                               "₹ ${foodDeliveryModel!.total}",
                                      //                               style: TextStyle(
                                      //                                   color: AppColor()
                                      //                                       .colorPrimary(),
                                      //                                   fontWeight:
                                      //                                       FontWeight.w600),
                                      //                             )
                                      //                           ],
                                      //                         ),
                                      //                       ),
                                      //                       SizedBox(
                                      //                         height: 10,
                                      //                       ),
                                      //                       // Padding(
                                      //                       //   padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                      //                       //   child: DottedLine(
                                      //                       //     // direction: Axis.horizontal,
                                      //                       //     lineLength: 320,
                                      //                       //     lineThickness: 1.0,
                                      //                       //     dashLength: 4.0,
                                      //                       //     dashColor: AppColor().colorPrimary(),
                                      //                       //     // dashGradient: [Colors.red, Colors.blue],
                                      //                       //     dashRadius: 0.0,
                                      //                       //     dashGapLength: 4.0,
                                      //                       //     dashGapColor: Colors.transparent,
                                      //                       //     // dashGapGradient: [Colors.red, Colors.blue],
                                      //                       //     dashGapRadius: 0.0,
                                      //                       //   ),
                                      //                       // ),
                                      //                       Container(
                                      //                         height: 60,
                                      //                         width:
                                      //                             MediaQuery.of(
                                      //                                     context)
                                      //                                 .size
                                      //                                 .width,
                                      //                         decoration: BoxDecoration(
                                      //                             color: AppColor()
                                      //                                 .colorPrimary(),
                                      //                             borderRadius: BorderRadius.only(
                                      //                                 bottomLeft:
                                      //                                     Radius.circular(
                                      //                                         12),
                                      //                                 bottomRight:
                                      //                                     Radius.circular(
                                      //                                         12))),
                                      //                         child: Column(
                                      //                           crossAxisAlignment:
                                      //                               CrossAxisAlignment
                                      //                                   .center,
                                      //                           children: [
                                      //                             foodDeliveryModel!
                                      //                                         .orderStatus ==
                                      //                                     "3"
                                      //                                 ? Padding(
                                      //                                     padding:
                                      //                                         const EdgeInsets.only(top: 7.0),
                                      //                                     child:
                                      //                                         Center(
                                      //                                       child: ElevatedButton(
                                      //                                           onPressed: () {
                                      //                                             //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                      //                                           },
                                      //                                           style: ElevatedButton.styleFrom(
                                      //                                               primary: Colors.green,
                                      //                                               fixedSize: Size(140, 35),
                                      //                                               shape: RoundedRectangleBorder(
                                      //                                                 borderRadius: BorderRadius.circular(10),
                                      //                                               )),
                                      //                                           child: Text(
                                      //                                             "Delivered",
                                      //                                             style: TextStyle(fontWeight: FontWeight.w400),
                                      //                                           )),
                                      //                                     ),
                                      //                                   )
                                      //                                 : foodDeliveryModel!.orderStatus ==
                                      //                                         "5"
                                      //                                     ? Padding(
                                      //                                         padding: const EdgeInsets.only(top: 7.0),
                                      //                                         child: Center(
                                      //                                           child: ElevatedButton(
                                      //                                               onPressed: () {
                                      //                                                 //updateFoodOrderStatus("${model.orders![i].orderId.toString()}","1" );
                                      //                                               },
                                      //                                               style: ElevatedButton.styleFrom(
                                      //                                                   primary: Colors.green,
                                      //                                                   fixedSize: Size(140, 35),
                                      //                                                   shape: RoundedRectangleBorder(
                                      //                                                     borderRadius: BorderRadius.circular(10),
                                      //                                                   )),
                                      //                                               child: Text(
                                      //                                                 "Accepted",
                                      //                                                 style: TextStyle(fontWeight: FontWeight.w400),
                                      //                                               )),
                                      //                                         ),
                                      //                                       )
                                      //                                     : foodDeliveryModel!.orderStatus == "6"
                                      //                                         ? Padding(
                                      //                                             padding: const EdgeInsets.only(top: 7.0),
                                      //                                             child: ElevatedButton(
                                      //                                                 onPressed: () {
                                      //                                                   // updateFoodOrderStatus(
                                      //                                                   //     "${foodDeliveryModel!.orderId}", "4");
                                      //                                                   // if(type =="1"){
                                      //                                                   //   getFoodOrders();
                                      //                                                   // }else{
                                      //                                                   //   getVendorBooking();
                                      //                                                   // }
                                      //                                                 },
                                      //                                                 style: ElevatedButton.styleFrom(
                                      //                                                     primary: Colors.red,
                                      //                                                     fixedSize: Size(140, 35),
                                      //                                                     shape: RoundedRectangleBorder(
                                      //                                                       borderRadius: BorderRadius.circular(10),
                                      //                                                     )),
                                      //                                                 child: Text(
                                      //                                                   "Declined",
                                      //                                                   style: TextStyle(fontWeight: FontWeight.w400),
                                      //                                                 )),
                                      //                                           )
                                      //                                         : Row(
                                      //                                             mainAxisAlignment: MainAxisAlignment.center,
                                      //                                             crossAxisAlignment: CrossAxisAlignment.center,
                                      //                                             children: [
                                      //                                               ElevatedButton(
                                      //                                                   onPressed: () {
                                      //                                                     updateFoodDeliveryStatus("${foodDeliveryModel!.orderId}", "5");
                                      //
                                      //                                                     // if(type =="1"){
                                      //                                                     //   getFoodOrders();
                                      //                                                     // }else{
                                      //                                                     //   getVendorBooking();
                                      //                                                     // }
                                      //                                                   },
                                      //                                                   style: ElevatedButton.styleFrom(
                                      //                                                       primary: Colors.green,
                                      //                                                       fixedSize: Size(140, 35),
                                      //                                                       shape: RoundedRectangleBorder(
                                      //                                                         borderRadius: BorderRadius.circular(10),
                                      //                                                       )),
                                      //                                                   child: Text(
                                      //                                                     "Accept",
                                      //                                                     style: TextStyle(fontWeight: FontWeight.w400),
                                      //                                                   )),
                                      //                                               const SizedBox(
                                      //                                                 width: 15,
                                      //                                               ),
                                      //                                               ElevatedButton(
                                      //                                                   onPressed: () {
                                      //                                                     updateFoodDeliveryStatus("${foodDeliveryModel!.orderId}", "6");
                                      //                                                     // if(type =="1"){
                                      //                                                     //   getFoodOrders();
                                      //                                                     // }else{
                                      //                                                     //   getVendorBooking();
                                      //                                                     // }
                                      //                                                   },
                                      //                                                   style: ElevatedButton.styleFrom(
                                      //                                                       primary: Colors.red,
                                      //                                                       fixedSize: Size(140, 35),
                                      //                                                       shape: RoundedRectangleBorder(
                                      //                                                         borderRadius: BorderRadius.circular(10),
                                      //                                                       )),
                                      //                                                   child: Text(
                                      //                                                     "Decline",
                                      //                                                     style: TextStyle(fontWeight: FontWeight.w400),
                                      //                                                   ))
                                      //                                             ],
                                      //                                           ),
                                      //                           ],
                                      //                         ),
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )
                                      //         : Container(
                                      //             height: MediaQuery.of(context)
                                      //                     .size
                                      //                     .height /
                                      //                 3,
                                      //             child: Center(
                                      //                 child: Text(
                                      //                     "No Bookings found!")),
                                      //           )
                                      : Center(
                                          child: CircularProgressIndicator(
                                          color: AppColor().colorPrimary(),
                                        )),

                          const SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ))), //
        ));
  }
}
