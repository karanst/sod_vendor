import 'dart:convert';

import 'package:fixerking/new%20model/getProductsModel.dart';
import 'package:fixerking/new%20model/vendor_services_model.dart';
import 'package:fixerking/screen/Add%20Services%20Products/DetailScreens/product_details.dart';
import 'package:fixerking/screen/Add%20Services%20Products/DetailScreens/service_details.dart';
import 'package:fixerking/screen/Add%20Services%20Products/add_products.dart';
import 'package:fixerking/screen/Add%20Services%20Products/add_services.dart';
import 'package:fixerking/screen/Add%20Services%20Products/edit_products.dart';
import 'package:fixerking/screen/Add%20Services%20Products/edit_services.dart';
import 'package:fixerking/screen/auth_view/login.dart';
import 'package:fixerking/screen/newScreens/AddService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api_path.dart';
import '../../../utils/colors.dart';
import '../../../utils/widget.dart';
import 'package:http/http.dart' as http;

import '../../token/token_string.dart';

class ProductsServicesScreen extends StatefulWidget {
  const ProductsServicesScreen({Key? key}) : super(key: key);

  @override
  State<ProductsServicesScreen> createState() => _ProductsServicesScreenState();
}

class _ProductsServicesScreenState extends State<ProductsServicesScreen> {
  var data;
  Future getProducts() async {
    // var userId = await MyToken.getUserID();
    // print("usre id here ${userId}");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.getVendorProducts}'));
    request.fields.addAll({'vid': '${uid}'});
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = GetProductsModel.fromJson(json.decode(str));
      print("ssssssssssss ${datas} and ${datas.status} and ${datas.products}");
      return GetProductsModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future getServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? vid = prefs.getString(TokenString.userid);

    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.getServicesUrl}'));
    request.fields.addAll({'v_id': '${vid.toString()}'});
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this response @@ ${response.statusCode}");

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      var datas = VendorServicesModel.fromJson(json.decode(str));
      print("ssssssssssss ${datas} and ${datas.status} and ${datas.products}");
      return VendorServicesModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  String? uid;
  String? type;
  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
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
      if(finalResult['status'] == "0") {
        Fluttertoast.showToast(msg: "${finalResult['message']}");
        Navigator.pop(context, true);
        Future.delayed(Duration(seconds: 1), (){
          setState((){
            getProducts();
          });
        });
      }else{
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      }
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
    request.fields.addAll({'service_id': '$id'});
    print("this is delete service request ${request.fields.toString()}");
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

  Widget productCardWidget(model , int index){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            ProductDetails(model: model.products![index],)));
      },
      child: Padding(
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
                                  6),
                              child: Image
                                  .network(
                                "${model.products![index].otherImage![0].toString()}",
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
                                "${model.products![index].productName}",
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
                              SizedBox(
                                  height: 5),
                              Row(
                                children: [
                                  Text("\u{20B9}" + " ${model.products![index].productPrice}",
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "\u{20B9} ${model.products![index].sellingPrice}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.PrimaryDark,
                                    ),),
                                ],
                              ),
                              Text(model.products![index].productStatus.toString() == "0"?
                              "Pending"
                                  : model.products![index].productStatus.toString() == "1"?
                              "Approved"
                                  : "Disapproved",
                                style: TextStyle(
                                    color: model.products![index].productStatus.toString() == "0"?
                                    Colors.yellow
                                        : model.products![index].productStatus.toString() == "1"?
                                    Colors.green
                                        : Colors.red
                                ),)
                            ],
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Card(
                          elevation: 2,
                          child: InkWell(
                              onTap: () async{
                                var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProducts(
                                          productsModel: model.products![index],
                                        )));
                                if(result = true){
                                  setState((){
                                    getProducts();
                                  });

                                }

                              },
                              child: Icon(
                                Icons.edit,
                                color: AppColor
                                    .PrimaryDark,
                              )),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () async{
                            var newResult = await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete Product?"),
                                    content: Text("Are you sure you want to delete this product?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor().colorPrimary()
                                        ),
                                        child: Text("YES"),
                                        onPressed: () async{
                                          await deleteProduct(model
                                              .products![
                                          index]
                                              .productId
                                              .toString());
                                          Future.delayed(Duration(milliseconds: 500), (){
                                            Navigator.pop(context, true);
                                          });
                                          // Navigator.pop(context);
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor().colorPrimary()
                                        ),
                                        child: Text("NO"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                }
                            );
                            print("this is result ====> ${newResult}");

                            if(newResult == true){
                              await getProducts();
                            }

                          },
                          child: Card(
                            elevation: 2,
                            child: Icon(
                              Icons
                                  .delete_forever_rounded,
                              color:
                              Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),

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
      ),
    );
  }

  Widget serviceCardWidget(model, index){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ServiceDetails(
          model: model.products![index],
        )));
      },
      child: Padding(
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
                          model.products![index].serviceImg == null ||
                              model.products![index].serviceImg == ""?
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
                                  6),
                              child:
                              Icon(
                                Icons.image,
                                size: 50,
                              ),
                            ),
                          )
                              : Container(
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
                                  6),
                              child:
                              Image
                                  .network(
                                "${model.products![index].serviceImg.toString()}",
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
                              Container(
                                width: 150,
                                child: Text(
                                  "${model.products![index].artistName}",
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
                              ),
                              SizedBox(
                                  height: 5),
                              Text(
                                  "\u{20B9} ${model.products![index].specialPrice}"),
                              SizedBox(
                                  height: 5),
                              Text(model.products![index].serviceStatus.toString() == "0"?
                              "Pending"
                                  : model.products![index].serviceStatus.toString() == "1"?
                              "Approved"
                                  : "Disapproved",
                                style: TextStyle(
                                    color: model.products![index].serviceStatus.toString() == "0"?
                                    Colors.yellow
                                        : model.products![index].serviceStatus.toString() == "1"?
                                    Colors.green
                                        : Colors.red
                                ),)
                              // Text("\u{20B9}" + serviceList[i]['price'],
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     color: Colors.black,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Card(
                          elevation: 2,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditServices(
                                          productsModel: model.products![index],
                                        )));
                              },
                              child: Icon(
                                Icons.edit,
                                color: AppColor
                                    .PrimaryDark,
                              )),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        InkWell(
                          onTap: () async{
                            var newResult = await showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete Services?"),
                                    content: Text("Are you sure you want to delete this service?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor().colorPrimary()
                                        ),
                                        child: Text("YES"),
                                        onPressed: () async{
                                          await deleteServices(model
                                              .products![index].serviceId.toString());
                                          Future.delayed(Duration(milliseconds: 500), (){
                                            Navigator.pop(context, true);
                                          });
                                          // Navigator.pop(context);
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor().colorPrimary()
                                        ),
                                        child: Text("NO"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                }
                            );
                            print("this is result ====> ${newResult}");

                            if(newResult == true){
                              await getServices();
                            }


                          },
                          child: Card(
                            elevation: 2,
                            child: Icon(
                              Icons
                                  .delete_forever_rounded,
                              color:
                              Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),

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
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorBg2());
    return Scaffold(
        backgroundColor: AppColor().colorPrimary(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            // if (type == "1") {
             var isSuccess = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                  type == "1" ?
                      AddProducts()
                  : AddServices()
                  ));
             print("this is success result $isSuccess");
             if(isSuccess = true){
             setState((){
                getProducts();
                getServices();
             });
             }
            // } else {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => AddServices()));
            // }
          },
          child: Icon(
            Icons.add,
            color: AppColor.PrimaryDark,
          ),
          backgroundColor: Colors.white,
        ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor().colorPrimary(),
          title: Text(
            type == "1" ?
            "Products"
            : "Services",
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
            padding: EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColor().colorBg2(),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),

              ),
              // decoration: BoxDecoration(
              //     color: AppColor().colorBg1(),
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(45),
              //       topRight: Radius.circular(45),
              //     )),
              child: type == "1"
                  ? FutureBuilder(
                      future: getProducts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        GetProductsModel? model = snapshot.data;
                        // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                        if (snapshot.hasData) {
                          return model!.status == "1"
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: model.products!.length,
                                  itemBuilder: (context, index) {
                                    return productCardWidget(model, index);
                                    //cardWidget(model, i
                                  })
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  child: Center(
                                      child: Text("No Products Found!!")),
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
                  : FutureBuilder(
                      future: getServices(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        VendorServicesModel? model = snapshot.data;
                        // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                        if (snapshot.hasData) {
                          return
                            // model!.status == "1"
                            //   ?
                          Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: model!.products!.length,
                                      itemBuilder: (context, index) {
                                        return serviceCardWidget(model, index);
                                        //cardWidget(model, i
                                      }),
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
              // ListView.builder(
              //     padding: EdgeInsets.symmetric(horizontal: 12),
              //     shrinkWrap: true,
              //     physics: ScrollPhysics(),
              //     itemCount: products!.length,
              //     itemBuilder: (context,index){
              //       return Padding(
              //         padding: const EdgeInsets.only(bottom: 10.0),
              //         child: Stack(
              //           children: [
              //             Card(
              //               elevation: 3,
              //               shape: const StadiumBorder(),
              //               child: Container(
              //                 padding: const EdgeInsets.only(left: 85, right: 20),
              //                 height: 60,
              //                 width: MediaQuery.of(context).size.width,
              //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         Text(
              //                           "${products![index].productName}",
              //                           style: TextStyle(
              //                             color: Colors.black,
              //                             fontSize: 14, fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                         SizedBox(height: 5),
              //                         Text("${products![index].productPrice}"),
              //                         // Text("\u{20B9}" + serviceList[i]['price'],
              //                         //   style: TextStyle(
              //                         //     fontSize: 12,
              //                         //     color: Colors.black,
              //                         //   ),
              //                         // ),
              //                       ],
              //                     ),
              //                     Row(
              //                       children: [
              //                         Card(
              //                           elevation:2,
              //                           child: InkWell(
              //                               onTap: () {
              //                                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditProducts()));
              //                               },
              //                               child: Icon(Icons.edit,color: AppColor.PrimaryDark,)),
              //                         ),
              //                         SizedBox(width: 6,),
              //                         Card(
              //                           elevation:2,
              //                           child: Icon(Icons.delete_forever_rounded,color: Colors.red,),
              //                         ),
              //                       ],
              //                     ),
              //                     // Container(
              //                     //   height: 25,
              //                     //   width: 80,
              //                     //   decoration: BoxDecoration(
              //                     //       color: AppColor.PrimaryDark,
              //                     //       borderRadius: BorderRadius.circular(30)),
              //                     //   child: const Center(
              //                     //     child: Text(
              //                     //       "View",
              //                     //       style: TextStyle(color: Colors.white),
              //                     //     ),
              //                     //   ),
              //                     // )
              //                     // AppBtn(
              //                     //   title: "View",
              //                     //   onPress: (){
              //                     //
              //                     //   },
              //                     //   height: 15,
              //                     //   width: 70,
              //                     //   fSize: 14,
              //                     // )
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             // CircleAvatar(
              //             //   radius: 37,
              //             //   child: Image.asset("${products[index]!.otherImage}",fit: BoxFit.fill,),
              //             // ),
              //           ],
              //         ),
              //       );// availabilityCard(context, GetProductsModel, index, true);
              //     })
              ),
        ));
  }
}
