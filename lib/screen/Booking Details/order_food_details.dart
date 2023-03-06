
import 'dart:convert';
import 'dart:io';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/New%20models/PostStatusModel.dart';
import 'package:fixerking/new%20model/Get_vendor_order_Model.dart';
import 'package:fixerking/new%20model/update_order.dart';
import 'package:fixerking/screen/notification_screen.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class OrderFoodDetails extends StatefulWidget {
  Orders data;
  final String? type;
  final String? uid;

  OrderFoodDetails({Key? key, required this.data, this.type, this.uid}) : super(key: key);

  @override
  State<OrderFoodDetails> createState() => _OrderFoodDetailsState();
}

class _OrderFoodDetailsState extends State<OrderFoodDetails> {
  var profilePic = null;
  bool cnfrmDelivery = false;
  TextEditingController otpController = TextEditingController();

  String? dropdownvalue ;

  var items = [
    'Preparing',
    'Ready',
    'Picked up',
    'Delivered',
    'Cancel',
  ];
  Future updateFoodOrderStatus(String id, status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            // widget.type =="1" ?
            '${Apipath.acceptRejectFoodStatus}'
            //     :
            // widget.type =="2" || widget.type =="3" || widget.type =="4"  ?
            // '${Apipath.acceptRejectDeliveryStatus}'
            //     : '${Apipath.acceptRejectServiceStatus}'
        ));
    // if(widget.type == "1"){
      request.fields.addAll({'order_id': '$id', 'status': '$status', 'roll': '1'});
    // }else if(widget.type =="2" || widget.type =="3" || widget.type =="4" ){
    //   request.fields.addAll({
    //     'booking_id': '${id.toString()}',
    //     'accept_reject': '${status.toString()}',
    //     'driver_id': '${widget.uid.toString()}'
    //     // 'otp': "${otpController.text.toString()}",
    //   });
    // } else{
    //   request.fields.addAll({'booking_id': '$id', 'status': '$status'});
    // }

    print("request of status ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var data = UpdateOrder.fromJson(json.decode(str));
      Fluttertoast.showToast(msg: data.message.toString());
      Navigator.pop(context, true);
      return UpdateOrder.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Widget customerDetails() {
    // print(" checking date ${widget.data.date}");
    // var dateFormate =
    //     DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.data.date ?? ""));
    // var bookingTime = TimeOfDay(hour: DateTime.parse(widget.data.createDate!).hour , minute: DateTime.parse(widget.data.createDate!).minute) ;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Customer Details",
              //   style: TextStyle(
              //       color: AppColor().colorTextPrimary(),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 16),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Name",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("${widget.data.username}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mobile No.",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("${widget.data.mobile}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ))
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Address",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Container(
                    width: 220,
                    child: Text("${widget.data.address}",
                        maxLines: 2,
                        style: TextStyle(
                          color: AppColor().colorPrimary(),
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis

                        )),
                  )
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget bookCard() {
    // var dateFormate =
    //     DateFormat("dd, MMMM yyyy").format(DateTime.parse(widget.data.date!));
    //     DateFormat("dd, MMMM yyyy").format(DateTime.parse(widget.data.date!));
    // var bookingTime = TimeOfDay(
    //     hour: DateTime.parse(widget.data.date!).hour,
    //     minute: DateTime.parse(widget.data.date!).minute);
    // var timeString =
    //     "${bookingTime.hour} : ${bookingTime.minute} ${bookingTime.period.name}";
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Order Status",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  widget.data.orderStatus == "0" ?
                      SizedBox.shrink():
                  widget.data.orderStatus == "3" ?
                      Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          color: Colors.green
                        ),
                        child: Center(child: Text("Completed",
                        style: TextStyle(
                          color: Colors.white
                        ),)),
                      ) :
                  widget.data.orderStatus == "4" ?
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                        color: Colors.red
                    ),
                    child: Center(child: Text("Cancelled",
                      style: TextStyle(
                          color: Colors.white
                      ),)),
                  )
                  :
                  Padding(
                    padding: const EdgeInsets.only(  ),
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.PrimaryDark),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            // hint: Text("Status Update"),
                            value: dropdownvalue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 24,
                              color: AppColor.PrimaryDark,
                            ),
                            elevation: 10,
                            // underline: Container(
                            //   height: 3,
                            //   color: colors.whit,
                            // ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownvalue = value!;
                              });
                              updateDeliveryStatus(widget.data.orderId.toString(), dropdownvalue.toString());
                            },
                            items: items.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: AppColor.PrimaryDark),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  )
                  // Container(
                  //   padding: EdgeInsets.all(12),
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: widget.data.orderStatus == "0" ||
                  //               widget.data.orderStatus == "1" ||
                  //               widget.data.orderStatus == "2"
                  //           ? colors.yellow
                  //           : widget.data.orderStatus == "3"
                  //               ? colors.green
                  //               : colors.red),
                  //   child: Text(
                  //     widget.data.orderStatus == "0"
                  //         ? "Pending"
                  //         : widget.data.orderStatus == "1"
                  //             ? "Processed"
                  //             : widget.data.orderStatus == "2"
                  //                 ? "Shipped"
                  //                 : widget.data.orderStatus == "3"
                  //                     ? "Delivered"
                  //                     : "Cancelled",
                  //     style: TextStyle(color:
                  //     colors.whit),
                  //   ),
                  // ),


                ],
              ),
              SizedBox(height: 5),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Id",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("${widget.data.orderId}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      ))
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Order Id',
              //     ),
              //     Container(
              //         alignment: Alignment.centerRight,
              //         child: widget.data.pStatus == "0"
              //             ? Text(
              //                 "In Progress",
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: AppColor().colorPrimary()),
              //               )
              //             : widget.data.pStatus == "1"
              //                 ? Text(
              //                     "Accepted by Delivery Services",
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         color: AppColor().colorPrimary()),
              //                   )
              //                 : widget.data.pStatus == "2"
              //                     ? Text(
              //                         "Cancelled by User",
              //                         textAlign: TextAlign.center,
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             color: AppColor().colorPrimary()),
              //                       )
              //                     : widget.data.pStatus == "3"
              //                         ? Text(
              //                             "Shipped",
              //                             textAlign: TextAlign.center,
              //                             style: TextStyle(
              //                                 fontWeight: FontWeight.bold,
              //                                 color:
              //                                     AppColor().colorPrimary()),
              //                           )
              //                         : widget.data.pStatus == "4"
              //                             ? Text(
              //                                 "On the way",
              //                                 textAlign: TextAlign.center,
              //                                 style: TextStyle(
              //                                     fontWeight: FontWeight.bold,
              //                                     color: AppColor()
              //                                         .colorPrimary()),
              //                               )
              //                             : widget.data.pStatus == "5"
              //                                 ? Text(
              //                                     "Delivered",
              //                                     textAlign: TextAlign.center,
              //                                     style: TextStyle(
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         color: AppColor()
              //                                             .colorPrimary()),
              //                                   )
              //                                 : Text(
              //                                     "",
              //                                     textAlign: TextAlign.center,
              //                                     style: TextStyle(
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         color: AppColor()
              //                                             .colorPrimary()),
              //                                   )
              //         // decoration: BoxDecoration(
              //         //     color: Colors.grey.shade100,
              //         //     borderRadius: BorderRadius.circular(5)),
              //         ),
              //   ],
              // ),

              Divider(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date & Time',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text('${widget.data.date}',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),

              Divider(),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Mode',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("${widget.data.paymentMode}",
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),

              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget productsDetailCard() {
    return  ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        itemCount: widget.data.products!.length,
        itemBuilder: (context, index){
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.PrimaryDark),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 60,
                            height:60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Image.network('${widget.data.products![index].productImage}',
                              fit: BoxFit.contain,)),
                        Text('${widget.data.products![index].productName}' ?? "",
                            style: TextStyle(
                              color: AppColor().colorPrimary(),
                              fontWeight: FontWeight.normal,
                            )),
                        Text(
                            "${widget.data.products![index].quantity} X ₹${widget.data.products![index].sellingPrice}",
                            style: TextStyle(
                              color: AppColor().colorPrimary(),
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget pricingCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.PrimaryDark),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Text(
              //       'Payment Details',
              //       style:
              //           TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              // Divider(
              //   height: 20,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sub Total',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("₹ " + widget.data.total!,
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )
                      //   style: TextStyle(
                      //       fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Platform Chaarges',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("-₹ " + widget.data.vendorPaymentAdmin.toString(),
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )
                    // style: TextStyle(
                    //     fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text('GST & Service Charge',
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         )),
              //     Text("-₹ " + widget.data.gstCharge!,
              //         style: TextStyle(
              //           color: AppColor().colorPrimary(),
              //           fontWeight: FontWeight.normal,
              //         )
              //         // style: TextStyle(
              //         //     fontSize: 15.0, fontWeight: FontWeight.bold),
              //         ),
              //   ],
              // ),
              Divider(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount',
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )),
                  Text("₹ " + widget.data.finalVendorTotal!,
                      style: TextStyle(
                        color: AppColor().colorPrimary(),
                        fontWeight: FontWeight.normal,
                      )
                    // style: TextStyle(
                    //     fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget confirmButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            cnfrmDelivery = true;
            // cnfrmDelivery =!cnfrmDelivery;
          });
        },
        style: ElevatedButton.styleFrom(
            primary: AppColor().colorPrimary(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            fixedSize: Size(MediaQuery.of(context).size.width - 40, 45)),
        child: Text("Confirm Delivery"));
  }

  // Future getImage(context, ImgSource source, {from}) async {
  //   var image = await ImagePickerGC.pickImage(
  //       // enableCloseButton: true,
  //       // closeIcon: Icon(
  //       //   Icons.close,
  //       //   color: Colors.red,
  //       //   size: 12,
  //       // ),
  //       context: context,
  //       source: source,
  //       barrierDismissible: true,
  //       cameraIcon: Icon(
  //         Icons.camera_alt,
  //         color: Colors.red,
  //       ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //       cameraText: Text(
  //         "From Camera",
  //         style: TextStyle(color: Colors.red),
  //       ),
  //       galleryText: Text(
  //         "From Gallery",
  //         style: TextStyle(color: Colors.blue),
  //       ));
  //   setState(() {
  //     profilePic = image;
  //   });
  // }

  // Widget dropDwon() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 25.0,  ),
  //     child: Card(
  //         elevation: 3,
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //         child: Container(
  //           decoration: BoxDecoration(
  //               border: Border.all(color: AppColor.PrimaryDark),
  //               borderRadius: BorderRadius.circular(15)),
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: DropdownButtonHideUnderline(
  //               child: DropdownButton<String>(
  //                 isExpanded: true,
  //                 hint: Text("Status Update"),
  //                 value: dropdownvalue,
  //                 icon: const Icon(
  //                   Icons.keyboard_arrow_down,
  //                   size: 24,
  //                   color: AppColor.PrimaryDark,
  //                 ),
  //                 elevation: 10,
  //                 // underline: Container(
  //                 //   height: 3,
  //                 //   color: colors.whit,
  //                 // ),
  //                 onChanged: (String? value) {
  //                   // This is called when the user selects an item.
  //                   setState(() {
  //                     dropdownvalue = value!;
  //                   });
  //                 },
  //                 items: items.map<DropdownMenuItem<String>>((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(
  //                       value,
  //                       style: TextStyle(color: AppColor.PrimaryDark),
  //                     ),
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //           ),
  //         )),
  //   );
  // }

  Widget updateDelivery() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 260,
        padding: EdgeInsets.all(10),
        child: Column(children: [
          InkWell(
            // onTap: () => getImage(context, ImgSource.Both, from: 1),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: Container(
                height: 14.66.h,
                width: 14.66.h,
                child: profilePic == null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Icon(
                          Icons.upload_file_rounded,
                          size: 50,
                        )))
                    : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Image.file(
                          File(profilePic.path),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: otpController,
              maxLength: 6,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "OTP",
                  border: InputBorder.none,
                  counterText: ""),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                // updateDeliveryStatus(widget.data.orderId.toString(), widget.data.pStatus.toString());
              },
              style: ElevatedButton.styleFrom(
                  primary: AppColor().colorPrimary(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(MediaQuery.of(context).size.width - 100, 45)),
              child: Text("Submit"))
        ]),
      ),
    );
  }

  updateDeliveryStatus(String id, String status) async {
    String stats;
    if(status == "Delivered"){
      stats = "3";
    }else if(status == "Cancel"){
      stats = "4";
    }else{
      stats = "2";
    }
    var vendorId = await MyToken.getUserID();
    var headers = {
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjU3NDI0MjgsImlhdCI6MTY2NTc0MjEyOCwiaXNzIjoiZXNob3AifQ.W1CPYxzUdedOnqF_9RCnXzxfXsrgXjD6afFscII8Ijc',
      'Cookie': 'ci_session=pkgacirfg4clhtgbfsecc4g4sg48jfnk'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(Apipath.acceptRejectFoodStatus));
    request.fields.addAll({
      'order_id': '${id.toString()}',
      'status': '${stats.toString()}',
      'roll': '1'
      // 'otp': "${otpController.text.toString()}",
    });

    print("this is request ====>>>> $status ${request.fields.toString()}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("this is response @@ ${response.statusCode}");

      var finalResult = await response.stream.bytesToString();
      final jsonResponse = PostStatusModel.fromJson(json.decode(finalResult));
      print("final result here ${jsonResponse.message}");
      if (jsonResponse.responseCode == "1") {
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        // isStatus = true;
        // updateRequestFunction('${id}', '${value}');
      } else {
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data.orderStatus == "0"){
      dropdownvalue = 'Preparing';
    }else if(widget.data.orderStatus == "1"){
      dropdownvalue = 'Ready';
    }
    else if(widget.data.orderStatus == "2"){
      dropdownvalue = 'Picked up';
    }
    else if(widget.data.orderStatus == "3"){
      dropdownvalue = 'Delivered';
    }else{
      dropdownvalue = 'Cancel';
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor().colorPrimary(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
                Icons.arrow_back_ios
            ),
          ),
          backgroundColor: AppColor().colorPrimary(),
          title: Text(
            "Order Details",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 12.0, right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.data.pStatus == "3"
                                ? Text(
                                    "Booking Cancelled",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20),
                                  )
                                : SizedBox.shrink(),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 5),
                              child: Text(
                                "Customer Details",
                                style: TextStyle(
                                    color: AppColor().colorTextPrimary(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            customerDetails(),
                            // bookDetailCard(),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 25, bottom: 5),
                              child: Text(
                                "Order Details",
                                style: TextStyle(
                                    color: AppColor().colorTextPrimary(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                            bookCard(),
                            const SizedBox(height: 15,),
                            productsDetailCard(),
                            // newsev(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 25, bottom: 5),
                                  child: Text(
                                    'Payment Details',
                                    style:
                                    TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 20,
                            ),
                            pricingCard(),
                            const SizedBox(height: 15,),
                            widget.data.orderStatus == "0"?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      updateFoodOrderStatus(
                                          "${widget.data.orderId.toString()}",
                                          "1");

                                        // getFoodOrders();

                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green,
                                        fixedSize: Size(140, 35),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                    child: Text(
                                      "Accept",
                                      style:
                                      TextStyle(fontWeight: FontWeight.w400),
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      updateFoodOrderStatus(
                                          "${widget.data.orderId.toString()}",
                                          "4");
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
                                      style:
                                      TextStyle(fontWeight: FontWeight.w400),
                                    ))
                              ],
                            )
                            : SizedBox.shrink(),
                            // dropDwon(),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // cnfrmDelivery ? SizedBox.shrink() :
                            // Center(
                            //   child: AppBtn(
                            //     onPress: (){
                            //       updateDeliveryStatus(widget.data.orderId.toString(), dropdownvalue.toString());
                            //     },
                            //     label: "Submit",
                            //   ),
                            // ),
                            // confirmButton(),

                            SizedBox(
                              height: 20,
                            ),
                            // cnfrmDelivery ? updateDelivery() : SizedBox.shrink()
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
