import 'dart:convert';

import 'package:fixerking/new%20model/customer_reviews.dart';
import 'package:fixerking/new%20model/getProductsModel.dart';
import 'package:fixerking/new%20model/vendor_services_model.dart';
import 'package:fixerking/screen/Add%20Services%20Products/add_products.dart';
import 'package:fixerking/screen/Add%20Services%20Products/add_services.dart';
import 'package:fixerking/screen/Add%20Services%20Products/edit_products.dart';
import 'package:fixerking/screen/Add%20Services%20Products/edit_services.dart';
import 'package:fixerking/screen/newScreens/AddService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api_path.dart';
import '../../../utils/colors.dart';
import '../../../utils/widget.dart';
import 'package:http/http.dart' as http;

import '../../token/token_string.dart';

class CustomerReviews extends StatefulWidget {
  final String? uid;
  const CustomerReviews({Key? key, this.uid}) : super(key: key);

  @override
  State<CustomerReviews> createState() => _CustomerReviewsState();
}

class _CustomerReviewsState extends State<CustomerReviews> {
  var data;

  Future getCustomerReviews() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
     String? userId = prefs.getString(TokenString.userid);

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.getFoodReviewUrl}'));
    request.fields.addAll({'v_id': '${widget.uid.toString()}'
    // '${userId.toString()}'
    });
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = CustomerReviewsModel.fromJson(json.decode(str));
      print("ssssssssssss ${datas} and ${datas.status} and ${datas.products}");
      return CustomerReviewsModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  // Future getServices() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? vid = prefs.getString(TokenString.userid);
  //
  //   var request =
  //   http.MultipartRequest('POST', Uri.parse('${Apipath.getServicesUrl}'));
  //   request.fields.addAll({'v_id': '${vid.toString()}'});
  //   print("this is request !! ${request.fields}");
  //
  //   http.StreamedResponse response = await request.send();
  //   print("this response @@ ${response.statusCode}");
  //
  //   if (response.statusCode == 200) {
  //     final str = await response.stream.bytesToString();
  //     var datas = VendorServicesModel.fromJson(json.decode(str));
  //     print("ssssssssssss ${datas} and ${datas.status} and ${datas.products}");
  //     return VendorServicesModel.fromJson(json.decode(str));
  //   } else {
  //     return null;
  //   }
  // }

  String? uid;
  String? type;

  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
   // Future.delayed(Duration(
   //   seconds: 1
   // ), (){
   //   getCustomerReviews();
   // });

    // getCustomerReviews();

  }

  deleteProduct(String id) async {
    var headers = {
      'Cookie': 'ci_session=bf4991e8d971b0be9cdd7dea6588e6723884b0d7'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${Apipath.deleteProductUrl}'));
    request.fields.addAll({'product_id': '$id'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      final finalResult = json.decode(jsonResponse);
      print("final result here ${finalResult}");
      setState(() {
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  deleteServices(String id) async {
    var headers = {
      'Cookie': 'ci_session=bf4991e8d971b0be9cdd7dea6588e6723884b0d7'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.deleteServicesUrl}'));
    request.fields.addAll({'id': '$id'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = await response.stream.bytesToString();
      final finalResult = json.decode(jsonResponse);
      print("final result here ${finalResult}");
      setState(() {
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    checkingLogin();
    // getProducts();
    // getServices();
    // Future.delayed(Duration(milliseconds: 500),(){
    //   return

    // });
    // getLabourServices();
    // addProducts();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorBg2());
    return Scaffold(
        backgroundColor: AppColor().colorPrimary(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     if (type == "1") {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => AddProducts()));
        //     } else {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => AddServices()));
        //     }
        //   },
        //   child: Icon(
        //     Icons.add,
        //     color: AppColor.PrimaryDark,
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor().colorPrimary(),
          title: Text(
            "Customer Reviews",
            style: TextStyle(
              color: AppColor().colorBg1(),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColor().colorSecondary(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              )),
          child: Container(
              padding: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColor().colorBg1(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child:
              // type == "1" ?
              FutureBuilder(
                  future: getCustomerReviews(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    CustomerReviewsModel? model = snapshot.data;
                    // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                    if (snapshot.hasData) {
                      return model!.status == "0"
                          ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: model.products!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    bottom: 10.0),
                                child: Stack(
                                  children: [
                                    Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              15)),
                                      child: Container(
                                        padding:
                                        const EdgeInsets.all(10),
                                        // only(left: 85, right: 20),
                                        height: 90,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColor().colorPrimary()),
                                            borderRadius:
                                            BorderRadius.circular(
                                                15)),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          10),
                                                      child: Image
                                                          .network(
                                                        "${model.products![index].profileImage.toString()}",
                                                        fit: BoxFit
                                                            .fill,
                                                      ),
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
                                                        "${model.products![index].username.toString()}",
                                                        style:
                                                        TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize:
                                                          14,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 140,
                                                        child: Text(
                                                          "${model.products![index].productName.toString()}",
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColor.PrimaryDark,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: 5),
                                                      Container(
                                                        width: 140,
                                                        child: Text(
                                                            "${model.products![index].revText.toString()}",
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("${model.products![index].revStars.toString()}",),
                                                      const SizedBox(width: 5,),
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index){
                                                          return Icon(Icons.star,
                                                            color: AppColor().colorSecondary(),
                                                            size: 16,);
                                                        },
                                                        itemCount:
                                                        model.products![index].revStars.toString() == "1.0"?
                                                        1 :
                                                        model.products![index].revStars.toString() == "2.0"?
                                                        2 :
                                                        model.products![index].revStars.toString() == "3.0"?
                                                        3 :
                                                        model.products![index].revStars.toString() == "4.0"?
                                                        4 : 5
                                                        ,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),

                                            // Row(
                                            //   children: [
                                            //     Card(
                                            //       elevation: 2,
                                            //       child: InkWell(
                                            //           onTap: () {
                                            //             // Navigator.push(
                                            //             //     context,
                                            //             //     MaterialPageRoute(
                                            //             //         builder: (context) => EditProducts(
                                            //             //           productsModel: model.products![index],
                                            //             //         )));
                                            //           },
                                            //           child: Icon(
                                            //             Icons.edit,
                                            //             color: AppColor
                                            //                 .PrimaryDark,
                                            //           )),
                                            //     ),
                                            //     SizedBox(
                                            //       width: 6,
                                            //     ),
                                            //     InkWell(
                                            //       onTap: () {
                                            //         deleteProduct(model
                                            //             .products![
                                            //         index]
                                            //             .productId
                                            //             .toString());
                                            //       },
                                            //       child: Card(
                                            //         elevation: 2,
                                            //         child: Icon(
                                            //           Icons
                                            //               .delete_forever_rounded,
                                            //           color:
                                            //           Colors.red,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),

                                            // Container(
                                            //   height: 25,
                                            //   width: 80,
                                            //   decoration: BoxDecoration(
                                            //       color: AppColor.PrimaryDark,
                                            //       borderRadius: BorderRadius.circular(30)),
                                            //   child: const Center(
                                            //     child: Text(
                                            //       "View",
                                            //       style: TextStyle(color: Colors.white),
                                            //     ),
                                            //   ),
                                            // )
                                            // AppBtn(
                                            //   title: "View",
                                            //   onPress: (){
                                            //
                                            //   },
                                            //   height: 15,
                                            //   width: 70,
                                            //   fSize: 14,
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   radius: 37,
                                    //   child: ClipRRect(
                                    //     child: Image.network("${model.products![index].productImage!.toString()}",
                                    //     fit: BoxFit.fill,),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              );
                              //cardWidget(model, i
                            }),
                      )
                          : Container(
                        height:
                        MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                            child: Text("No Reviews Found!!")),
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Container(
                          height: 30,
                          width: 30,
                          // MediaQuery.of(context).size.height / 1.5,
                          child: Center(
                              child: CircularProgressIndicator(
                                color: AppColor.PrimaryDark,
                              )));
                    }
                  })
                  // : FutureBuilder(
                  // future: getServices(),
                  // builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //   VendorServicesModel? model = snapshot.data;
                  //   // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                  //   if (snapshot.hasData) {
                  //     return model!.status == "1"
                  //         ? Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(20)),
                  //       child: ListView.builder(
                  //           shrinkWrap: true,
                  //           physics: AlwaysScrollableScrollPhysics(),
                  //           itemCount: model.products!.length,
                  //           itemBuilder: (context, index) {
                  //             return Padding(
                  //               padding: const EdgeInsets.only(
                  //                   left: 15,
                  //                   right: 15,
                  //                   bottom: 10.0),
                  //               child: Stack(
                  //                 children: [
                  //                   Card(
                  //                     elevation: 0,
                  //                     shape: RoundedRectangleBorder(
                  //                         borderRadius:
                  //                         BorderRadius.circular(
                  //                             15)),
                  //                     child: Container(
                  //                       padding:
                  //                       const EdgeInsets.all(10),
                  //                       // only(left: 85, right: 20),
                  //                       height: 90,
                  //                       width: MediaQuery.of(context)
                  //                           .size
                  //                           .width,
                  //                       decoration: BoxDecoration(
                  //                           border: Border.all(color: AppColor().colorPrimary()),
                  //                           borderRadius:
                  //                           BorderRadius.circular(
                  //                               15)),
                  //                       child: Row(
                  //                         mainAxisAlignment:
                  //                         MainAxisAlignment
                  //                             .spaceBetween,
                  //                         children: [
                  //                           Container(
                  //                             child: Row(
                  //                               mainAxisAlignment:
                  //                               MainAxisAlignment
                  //                                   .spaceBetween,
                  //                               children: [
                  //                                 Container(
                  //                                   height: 60,
                  //                                   width: 60,
                  //                                   decoration:
                  //                                   BoxDecoration(
                  //                                     borderRadius:
                  //                                     BorderRadius
                  //                                         .circular(
                  //                                         10),
                  //                                   ),
                  //                                   child: ClipRRect(
                  //                                     borderRadius:
                  //                                     BorderRadius
                  //                                         .circular(
                  //                                         6),
                  //                                     child: Image
                  //                                         .network(
                  //                                       "${model.products![index].servicesImage![0].toString()}",
                  //                                       fit: BoxFit
                  //                                           .fill,
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                                 SizedBox(
                  //                                   width: 10,
                  //                                 ),
                  //                                 Column(
                  //                                   crossAxisAlignment:
                  //                                   CrossAxisAlignment
                  //                                       .start,
                  //                                   mainAxisAlignment:
                  //                                   MainAxisAlignment
                  //                                       .center,
                  //                                   children: [
                  //                                     Text(
                  //                                       "${model.products![index].artistName}",
                  //                                       style:
                  //                                       TextStyle(
                  //                                         color: Colors
                  //                                             .black,
                  //                                         fontSize:
                  //                                         14,
                  //                                         fontWeight:
                  //                                         FontWeight
                  //                                             .bold,
                  //                                       ),
                  //                                     ),
                  //                                     SizedBox(
                  //                                         height: 5),
                  //                                     Text(
                  //                                         "\u{20B9} ${model.products![index].specialPrice}"),
                  //                                     // Text("\u{20B9}" + serviceList[i]['price'],
                  //                                     //   style: TextStyle(
                  //                                     //     fontSize: 12,
                  //                                     //     color: Colors.black,
                  //                                     //   ),
                  //                                     // ),
                  //                                   ],
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //
                  //                           Row(
                  //                             children: [
                  //                               Card(
                  //                                 elevation: 2,
                  //                                 child: InkWell(
                  //                                     onTap: () {
                  //                                       Navigator.push(
                  //                                           context,
                  //                                           MaterialPageRoute(
                  //                                               builder: (context) => EditServices(
                  //                                                 productsModel: model.products![index],
                  //                                               )));
                  //                                     },
                  //                                     child: Icon(
                  //                                       Icons.edit,
                  //                                       color: AppColor
                  //                                           .PrimaryDark,
                  //                                     )),
                  //                               ),
                  //                               SizedBox(
                  //                                 width: 6,
                  //                               ),
                  //                               InkWell(
                  //                                 onTap: () {
                  //                                   deleteServices(model
                  //                                       .products![
                  //                                   index]
                  //                                       .id
                  //                                       .toString());
                  //                                 },
                  //                                 child: Card(
                  //                                   elevation: 2,
                  //                                   child: Icon(
                  //                                     Icons
                  //                                         .delete_forever_rounded,
                  //                                     color:
                  //                                     Colors.red,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //
                  //                           // Container(
                  //                           //   height: 25,
                  //                           //   width: 80,
                  //                           //   decoration: BoxDecoration(
                  //                           //       color: AppColor.PrimaryDark,
                  //                           //       borderRadius: BorderRadius.circular(30)),
                  //                           //   child: const Center(
                  //                           //     child: Text(
                  //                           //       "View",
                  //                           //       style: TextStyle(color: Colors.white),
                  //                           //     ),
                  //                           //   ),
                  //                           // )
                  //                           // AppBtn(
                  //                           //   title: "View",
                  //                           //   onPress: (){
                  //                           //
                  //                           //   },
                  //                           //   height: 15,
                  //                           //   width: 70,
                  //                           //   fSize: 14,
                  //                           // )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   // CircleAvatar(
                  //                   //   radius: 37,
                  //                   //   child: ClipRRect(
                  //                   //     child: Image.network("${model.products![index].productImage!.toString()}",
                  //                   //     fit: BoxFit.fill,),
                  //                   //   ),
                  //                   // ),
                  //                 ],
                  //               ),
                  //             );
                  //             //cardWidget(model, i
                  //           }),
                  //     )
                  //         : Container(
                  //       height:
                  //       MediaQuery.of(context).size.height / 1.5,
                  //       child: Center(
                  //           child: Text("No Services Found!!")),
                  //     );
                  //   } else if (snapshot.hasError) {
                  //     return Icon(Icons.error_outline);
                  //   } else {
                  //     return Container(
                  //         height: 30,
                  //         width: 30,
                  //         // MediaQuery.of(context).size.height / 1.5,
                  //         child: Center(
                  //             child: CircularProgressIndicator(
                  //               color: AppColor.PrimaryDark,
                  //             )));
                  //   }
                  // })
            ///

          ),
        ));
  }
}
