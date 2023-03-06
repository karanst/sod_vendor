import 'package:dotted_line/dotted_line.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../new model/buy_vendor_product.dart';
import '../../../../utils/colors.dart';
import '../../Payment.dart';

class OfferDetails extends StatefulWidget {
  final Products? model;
  const OfferDetails({Key? key, this.model}) : super(key: key);

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  BuyVendorProduct? productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddService()));
      // },
      // // Icon(Icons.add,color: AppColor.PrimaryDark,),
      // //   backgroundColor: Colors.white,
      // ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor().colorPrimary(),
        title: Text(
          "Offer Details",
          style: TextStyle(
            color: AppColor().colorBg1(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        Container(
        padding: EdgeInsets.only(top: 5),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColor().colorSecondary(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            )),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColor().colorBg1(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              )),
          child: Padding(
                padding: const EdgeInsets.only(top: 30,left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        // only(left: 85, right: 20),
                        height: 190,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: Container(
                          // height: 80,
                          // width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                            "${widget.model!.productImage![0].toString()}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "${widget.model!.productName.toString()}",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("₹ ${widget.model!.productPrice}",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough
                    ),),
                    Text("₹ ${widget.model!.sellingPrice}",
                    style: TextStyle(
                      color: AppColor.PrimaryDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                    ),),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Descriptions",
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),),
                    SizedBox(
                      height: 8,
                    ),
                    Text("${widget.model!.productDescription!.toString()}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: AppBtn(
                          onPress: (){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 120.0, bottom: 120),
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    title: Center(child: Text(' Summary',
                                      style: TextStyle(
                                          fontSize: 14
                                      ),)),
                                    content: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Product',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor().colorTextPrimary()
                                                ),),
                                              Text(
                                                "${widget.model!.productName.toString()}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: AppColor().colorTextSecondary()
                                                ),),
                                            ],
                                          ),
                                        ),
                                        DottedLine(),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Rate",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColor().colorTextPrimary()
                                                ),),
                                              Text("₹ ${widget.model!.sellingPrice}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: AppColor().colorTextSecondary()
                                                ),),
                                            ],
                                          ),
                                        ),
                                        DottedLine(),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total Amount",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: AppColor().colorTextPrimary()
                                                ),),
                                              Text("₹ ${widget.model!.sellingPrice}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: AppColor().colorTextSecondary()
                                                ),),
                                            ],
                                          ),
                                        ),
                                        DottedLine(),
                                      ],
                                    ),
                                    actions: [
                                      Column(
                                        children: [
                                          AppBtn(
                                            onPress: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          Payment(
                                                            productId: widget.model!.productId.toString(),
                                                            total: widget.model!.sellingPrice.toString(),
                                                          )));
                                            },
                                            label: "Pay",
                                          ),
                                          // Container(
                                          //   height: 40,
                                          //   width: MediaQuery.of(context)
                                          //       .size
                                          //       .width /
                                          //       1.2,
                                          //   decoration: BoxDecoration(
                                          //       borderRadius:
                                          //       BorderRadius.circular(15),
                                          //       color: AppColor.PrimaryDark),
                                          //   child: InkWell(
                                          //       onTap: () {
                                          //         Navigator.push(
                                          //             context,
                                          //             MaterialPageRoute(
                                          //                 builder:
                                          //                     (context) =>
                                          //                     Payment()));
                                          //       },
                                          //       child: Center(
                                          //           child: Text('Pay Now',
                                          //               style: TextStyle(
                                          //                   fontSize: 15,
                                          //                   color: AppColor()
                                          //                       .colorBg1())))),
                                          // ),
                                          SizedBox(
                                            height: 9,
                                          ),
                                          Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                1.2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                border: Border.all(color: AppColor().colorPrimary()),
                                                color: AppColor().colorBg1()),
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Center(
                                                    child: Text('Cancel',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: AppColor()
                                                                .colorPrimary())))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          label: "Pay",
                        ),
                      ),
                    )
                  ],
                ),
              )
        ),

              // Stack(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 20, right: 10),
              //       child: Card(
              //         elevation: 3,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(25)),
              //         child: Container(
              //           padding: const EdgeInsets.all(10),
              //           // only(left: 85, right: 20),
              //           height: 190,
              //           width: MediaQuery.of(context).size.width,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(25)),
              //           child: Container(
              //             // height: 80,
              //             // width: 120,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(20),
              //             ),
              //             child: Image.network(
              //               "${widget.model!.productImage![0].toString()}",
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //
              //     // SizedBox(height: 50,),
              //     // Padding(
              //     //   padding: const EdgeInsets.only(top: 450, left: 30),
              //     //   child: InkWell(
              //     //     onTap: (){
              //     //       showDialog(
              //     //         context: context,
              //     //         builder: (BuildContext context) {
              //     //           return Padding(
              //     //             padding: const EdgeInsets.only(top: 120.0, bottom: 120),
              //     //             child: AlertDialog(
              //     //               shape: RoundedRectangleBorder(
              //     //                 borderRadius: BorderRadius.all(Radius.circular(20))
              //     //               ),
              //     //               title: Center(child: Text('Summary',
              //     //               style: TextStyle(
              //     //                 fontSize: 14
              //     //               ),)),
              //     //               content: Column(
              //     //                 children: [
              //     //                   Padding(
              //     //                     padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              //     //                     child: Row(
              //     //                       mainAxisAlignment:
              //     //                       MainAxisAlignment.spaceBetween,
              //     //                       children: [
              //     //                         Text('Product',
              //     //                           style: TextStyle(
              //     //                               fontWeight: FontWeight.w400,
              //     //                               color: AppColor().colorTextPrimary()
              //     //                           ),),
              //     //                         Text(
              //     //                             "${widget.model!.productName.toString()}",
              //     //                           style: TextStyle(
              //     //                               fontWeight: FontWeight.w400,
              //     //                               fontSize: 14,
              //     //                               color: AppColor().colorTextSecondary()
              //     //                           ),),
              //     //                       ],
              //     //                     ),
              //     //                   ),
              //     //                   DottedLine(),
              //     //                   Padding(
              //     //                     padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              //     //                     child: Row(
              //     //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //                       children: [
              //     //                         Text(
              //     //                           "Rate",
              //     //                           style: TextStyle(
              //     //                             fontWeight: FontWeight.w400,
              //     //                             color: AppColor().colorTextPrimary()
              //     //                         ),),
              //     //                         Text("₹ ${widget.model!.productPrice}",
              //     //                         style: TextStyle(
              //     //                           fontWeight: FontWeight.w400,
              //     //                           fontSize: 14,
              //     //                           color: AppColor().colorTextSecondary()
              //     //                         ),),
              //     //                       ],
              //     //                     ),
              //     //                   ),
              //     //                   DottedLine(),
              //     //                   Padding(
              //     //                     padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              //     //                     child: Row(
              //     //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     //                       children: [
              //     //                         Text(
              //     //                           "Total Amount",
              //     //                           style: TextStyle(
              //     //                               fontWeight: FontWeight.w400,
              //     //                               fontSize: 16,
              //     //                               color: AppColor().colorTextPrimary()
              //     //                           ),),
              //     //                         Text("₹ ${widget.model!.productPrice}",
              //     //                           style: TextStyle(
              //     //                               fontWeight: FontWeight.w400,
              //     //                               fontSize: 14,
              //     //                               color: AppColor().colorTextSecondary()
              //     //                           ),),
              //     //                       ],
              //     //                     ),
              //     //                   ),
              //     //                   DottedLine(),
              //     //                 ],
              //     //               ),
              //     //               actions: [
              //     //                 Column(
              //     //                   children: [
              //     //                     AppBtn(
              //     //                       onPress: (){
              //     //                         Navigator.push(
              //     //                             context,
              //     //                             MaterialPageRoute(
              //     //                                 builder:
              //     //                                     (context) =>
              //     //                                     Payment()));
              //     //                       },
              //     //                       label: "Pay",
              //     //                     ),
              //     //                     // Container(
              //     //                     //   height: 40,
              //     //                     //   width: MediaQuery.of(context)
              //     //                     //       .size
              //     //                     //       .width /
              //     //                     //       1.2,
              //     //                     //   decoration: BoxDecoration(
              //     //                     //       borderRadius:
              //     //                     //       BorderRadius.circular(15),
              //     //                     //       color: AppColor.PrimaryDark),
              //     //                     //   child: InkWell(
              //     //                     //       onTap: () {
              //     //                     //         Navigator.push(
              //     //                     //             context,
              //     //                     //             MaterialPageRoute(
              //     //                     //                 builder:
              //     //                     //                     (context) =>
              //     //                     //                     Payment()));
              //     //                     //       },
              //     //                     //       child: Center(
              //     //                     //           child: Text('Pay Now',
              //     //                     //               style: TextStyle(
              //     //                     //                   fontSize: 15,
              //     //                     //                   color: AppColor()
              //     //                     //                       .colorBg1())))),
              //     //                     // ),
              //     //                     SizedBox(
              //     //                       height: 9,
              //     //                     ),
              //     //                     Container(
              //     //                       height: 40,
              //     //                       width: MediaQuery.of(context)
              //     //                           .size
              //     //                           .width /
              //     //                           1.2,
              //     //                       decoration: BoxDecoration(
              //     //                           borderRadius:
              //     //                           BorderRadius.circular(15),
              //     //                           border: Border.all(color: AppColor().colorPrimary()),
              //     //                           color: AppColor().colorBg1()),
              //     //                       child: InkWell(
              //     //                           onTap: () {
              //     //                             Navigator.pop(context);
              //     //                           },
              //     //                           child: Center(
              //     //                               child: Text('Cancel',
              //     //                                   style: TextStyle(
              //     //                                       fontSize: 15,
              //     //                                       color: AppColor()
              //     //                                           .colorPrimary())))),
              //     //                     ),
              //     //                   ],
              //     //                 ),
              //     //               ],
              //     //             ),
              //     //           );
              //     //         },
              //     //       );
              //     //     },
              //     //     child: Container(
              //     //       height: 50,
              //     //       width: MediaQuery.of(context).size.width / 1.2,
              //     //       decoration: BoxDecoration(
              //     //           borderRadius: BorderRadius.circular(20),
              //     //           color: AppColor.PrimaryDark),
              //     //       child: Center(
              //     //         child: Text(
              //     //           "Pay",
              //     //           style: TextStyle(
              //     //               fontSize: 20, color: AppColor().colorBg1()),
              //     //         ),
              //     //       ),
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
      // child: Card(
      //       elevation: 2,
      //       shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(20)
      //       ),
      //       child: Container(
      //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      //         // height: 80,
      //         width: MediaQuery.of(context).size.width/ 1.2,
      //         child: Padding(
      //           padding: const EdgeInsets.only(left: 15),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //           Image.
      //           network(widget.model!.productImage![0].toString(), height: 60, width: 90,
      //           ),
      //               Column(
      //                 children: [
      //                   Text(widget.model!.productName![0].toString()),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       )
      //     ),
      //   ),
    );
  }
}
