import 'dart:async';

import 'package:fixerking/api/api_helper/home_api_helper.dart';
import 'package:fixerking/modal/request/get_new_order_request.dart';
import 'package:fixerking/modal/response/get_new_order_response.dart';
import 'package:fixerking/screen/service_details_screen.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utility_widget/myappbar.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/loding_home_page.dart';
import 'package:fixerking/utils/app_strings.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainServiceHistory extends StatefulWidget {
  const MainServiceHistory({Key? key}) : super(key: key);

  @override
  State<MainServiceHistory> createState() => _MainServiceHistoryState();
}

class _MainServiceHistoryState extends State<MainServiceHistory> {
  StreamController<GetNewOrderResponse> geOrderHistoryStream =
      StreamController();
  late GetNewOrderResponse orderResponse;

  @override
  void initState() {
    super.initState();
    getOderHistory();
  }

  @override
  void dispose() {
    super.dispose();
    geOrderHistoryStream.close();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Service History"),
      ),
      body: SafeArea(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          width: 100.w,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.0, -0.5),
              colors: [
                AppColor().colorBg1(),
                AppColor().colorBg2(),
              ],
              radius: 0.8,
            ),
          ),
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // MyappBarView(
                //   mytitle: "Service History",
                // ),
                SizedBox(
                  height: 15,
                ),
                StreamBuilder<GetNewOrderResponse>(
                    stream: geOrderHistoryStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: text(snapshot.error.toString()),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return LodingHomePage();
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data!.booking!.length,
                          itemBuilder: (context, int i) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             ServiceScreenDetails(
                                //                 orderResponse: snapshot.data!,
                                //                 i: i)));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Spacer(),
                                            ClipOval(
                                              child: UtilityHlepar.convertetIMG(
                                                  snapshot.data!.booking![i]
                                                      .service!.serviceImage
                                                      .toString(),
                                                  height: 8.h,
                                                  fit: BoxFit.cover),
                                            ),
                                            Spacer(),
                                            cardRightSection(mysize,
                                                i: i, response: snapshot.data!),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );

                            //           ],
                            //         ),
                            //         // After line
                            //         Divider(),
                            //         Container(
                            //           margin:
                            //               EdgeInsets.symmetric(vertical: 10),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.center,
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.center,
                            //             children: [
                            //               Text(
                            //                 AppStrings.currencySymbols +
                            //                     UtilityHlepar.convertNA(snapshot
                            //                         .data!
                            //                         .booking![i]
                            //                         .service!
                            //                         .servicePrice!),
                            //                 style: TextStyle(
                            //                   fontSize: 20.0,
                            //                   fontWeight: FontWeight.w400,
                            //                   color: AppColor.PrimaryDark,
                            //                 ),
                            //               ),
                            //               Text(
                            //                 " ( Service Price )",
                            //                 style: TextStyle(
                            //                     fontWeight: FontWeight.w500,
                            //                     color: Colors.grey),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  getOderHistory() async {
    try {
      var userid = await MyToken.getUserID();
      // var userid = "1";
      GetNewOrderRequest request = GetNewOrderRequest(userId: userid);
      // orderResponse = await HomeApiHelper.getNewOrder(request);
      if (orderResponse.responseCode == ToastString.responseCode) {
        geOrderHistoryStream.sink.add(orderResponse);
      } else {
        geOrderHistoryStream.sink.addError(orderResponse.message.toString());
      }
    } catch (e) {
      geOrderHistoryStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }

  Column cardRightSection(Size mysize, {required GetNewOrderResponse response, i}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Service User : ",
                  style: TextStyle(color: Color(0xff929292)),
                ),
              ),
              Container(
                width: 40.w,
                child: Text(
                  UtilityHlepar.convertNA(response.booking![i].username!),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Color(0xff929292)),
                ),
              ),
              // text("text"),
              // SizedBox(
              //   width: 5.w,
              //   child: Text.rich(TextSpan(children: [
              //     TextSpan(
              //         text: ,
              //         ),
              //         style: TextStyle(fontSize: 10.sp))
              //   ])),
              // )
              // Spacer(),
              // Icon(Icons.done)

              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              // Image.asset(
              //   i == 2
              //       ? "images/icons/service_padding.png"
              //       : "images/icons/service_done.png",
              //   height: 12.sp,
              // ),
              //     Text(
              //       UtilityHlepar.convertNA(response.booking![i].status!),
              //       // i == 2 ? "Pending" : 'Completed',
              //       style: TextStyle(fontSize: 8.sp),
              //     )
              //   ],
              // ),
              // )
            ],
          ),
        ),
        // Data & Time
        SizedBox(
          width: 60.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Image.asset(
                  'images/icons/calendar_img.png',
                  height: 10,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  UtilityHlepar.convertNA(response.booking![i].date!),
                  style: TextStyle(color: Color(0xff929292)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Image.asset(
                  'images/icons/time_img.png',
                  height: 10,
                ),
              ),
              response.booking![i].service!.serviceTime != null
                  ? Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  UtilityHlepar.convertNA(response.booking![i].service!.serviceTime),
                  style: TextStyle(color: Color(0xff929292)),
                ),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        // My Address
        Container(
          width: 63.w,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Image.asset(
                  'images/icons/location_img.png',
                  height: 10,
                ),
              ),
              Container(
                width: 45.w,
                // width: mysize.width * 0.5,
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  UtilityHlepar.convertNA(response.booking![i].address!),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xff929292)),
                ),
              ),
            ],
          ),
        ),
        //Category name
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Image.asset(
                  'images/icons/category_img.png',
                  height: 10,
                ),
              ),
              Container(
                width: 60.w,
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  UtilityHlepar.convertNA(
                      response.booking![i].service!.serviceName!),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xff929292)),
                ),
              ),
            ],
          ),
        ),

        //description name
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Image.asset(
                  'images/icons/description_img.png',
                  height: 10,
                ),
              ),
              SizedBox(
                width: 60.w,
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    UtilityHlepar.convertNA(response.booking![i].notes!),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xff929292)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Text.rich(TextSpan(children: [
          // WidgetSpan(
          //   child: Image.asset(
          //     i == 2
          //         ? "images/icons/service_padding.png"
          //         : "images/icons/service_done.png",
          //     height: 12.sp,
          //   ),
          // ),
          TextSpan(
              text: " " + UtilityHlepar.convertNA(response.booking![i].status!),
              style: TextStyle(fontSize: 8.sp)),
        ]))
      ],
    );
  }
}
