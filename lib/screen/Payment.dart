import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/new%20model/checkout_vendor_model.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'PaymentSuccess.dart';

class Payment extends StatefulWidget {
  final String? productId, total;
  const Payment({Key? key, this.productId, this.total}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  Future checkOutVendorOrder(String paymentMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.checkOutVendorApi}'));
    request.fields.addAll({
      'payment_mode':'COD',
      'total':'${widget.total.toString()}',
      'product_id':'${widget.productId.toString()}',
      'quantity':'1',
      'user_id': '$uid',
      'address': '',
    });
    print('request here ====>>>>> ${request.fields}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = CheckoutVendorModel.fromJson(json.decode(str));
      Fluttertoast.showToast(msg: '${datas.message.toString()}');

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentSuccess()));

      return CheckoutVendorModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor().colorPrimary(),
        title: Text("Payment", style: TextStyle(
          color: AppColor().colorBg1(),
        ),
        ),
      ),
      body: Column(
        children: [
          Container(
          padding: EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColor().colorSecondary(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              )),
          child: Container(
            padding: EdgeInsets.only(top:30, left: 20, right: 20),
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColor().colorBg1(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                )),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    checkOutVendorOrder("COD");
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentSuccess()));
                  },
                  child: Card(
                    // elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor().colorPrimary()),
                        borderRadius: BorderRadius.circular(13)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                Image.asset("images/cash.png",
                                height: 35,
                                width: 35,),
                                  SizedBox(width: 10,),
                                  Text('Cash payment',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
                                ],
                              )
                          ),

                          Icon(Icons.chevron_right_outlined,color: AppColor.PrimaryDark,size: 30,),
                        ],
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 10,),
                // InkWell(
                //   onTap: (){
                //     checkOutVendorOrder("Online");
                //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentSuccess()));
                //   },
                //   child: Card(
                //     // elevation: 4,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(13.0)),
                //     child: Container(
                //       height: 80,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: AppColor().colorPrimary()),
                //           borderRadius: BorderRadius.circular(13)
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Image.asset("images/online.png",
                //                     height: 35,
                //                     width: 35,),
                //                   SizedBox(width: 10,),
                //                   Text('Online Payment',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
                //                 ],
                //               )
                //           ),
                //
                //           Icon(Icons.chevron_right_outlined,color: AppColor.PrimaryDark,size: 30,),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10,),
                // InkWell(
                //   onTap: (){
                //     checkOutVendorOrder("Wallet");
                //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentSuccess()));
                //   },
                //   child: Card(
                //     // elevation: 4,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(13.0)),
                //     child: Container(
                //       height: 80,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: AppColor().colorPrimary()),
                //           borderRadius: BorderRadius.circular(13)
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Image.asset("images/wallet.png",
                //                     height: 35,
                //                     width: 35,),
                //                   SizedBox(width: 10,),
                //                   Text('Wallet',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
                //                 ],
                //               )
                //           ),
                //
                //           Icon(Icons.chevron_right_outlined,color: AppColor.PrimaryDark,size: 30,),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //       height: 560,
              //       child: Expanded(child: ListView.builder(
              //           itemCount: 3,
              //           itemBuilder: (context, index){
              //             return SizedBox(height: 90,
              //               child: InkWell(
              //                 onTap: (){
              //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentSuccess()));
              //               },
              //                 child: Card(
              //                   elevation: 4,
              //                   shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(13.0)),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Padding(
              //                         padding: const EdgeInsets.all(8.0),
              //                         child: Row(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           children: [
              //                             Icon(Icons.payment, color: AppColor.PrimaryDark,),
              //                             SizedBox(width: 10,),
              //                             Text('Cash payment',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
              //                           ],
              //                         )
              //                       ),
              //
              //                       Icon(Icons.chevron_right_outlined,color: AppColor.PrimaryDark,size: 40,),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             );
              //           }))
              //   ),
              // ),
          )
          ),
        ],
      ),
    );
  }
}
