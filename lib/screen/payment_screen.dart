import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fixerking/api/api_helper/home_api_helper.dart';
import 'package:fixerking/modal/request/payment_history_request.dart';
import 'package:fixerking/modal/request/request_for_payment_request.dart';
import 'package:fixerking/modal/response/payment_history_response.dart';
import 'package:fixerking/modal/response/request_for_payment_response.dart';
import 'package:fixerking/modal/response/total_payment_response.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utility_widget/myappbar.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/loding_slider.dart';
import 'package:fixerking/utils/app_strings.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/showDialog.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:fixerking/validation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool selected = false, enabled = false, edit = false;

  StreamController<PaymentHistoryResponse> paymentHistoryStream =
      StreamController();
  StreamController<TotalPaymentResponse> totalPaymentStream =
      StreamController();
  TextEditingController withdrawMoneyContoroll = TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey();
  var totalMoney = 0;

  @override
  void initState() {
    super.initState();
    getTotalPayment();
    getPaymentHistory();
  }

  @override
  void dispose() {
    super.dispose();
    paymentHistoryStream.close();
    totalPaymentStream.close();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorPrimary());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        centerTitle: true,
        title: Text("Payment"),
      ),
      backgroundColor: AppColor().colorBg1(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            width: 100.w,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.5),
                colors: [
                  AppColor().colorBg1(),
                  AppColor().colorBg1(),
                ],
                radius: 0.8,
              ),
            ),
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                // MyappBarView(
                //   mytitle: "Payment",
                // ),
                // Container(
                //   height: 9.92.h,
                //   width: 100.w,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //         image: AssetImage(profileBg),
                //         fit: BoxFit.fill,
                //       )),
                //   child: Center(
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Container(
                //             width: 6.38.w,
                //             height: 6.38.w,
                //             alignment: Alignment.centerLeft,
                //             margin: EdgeInsets.only(left: 7.91.w),
                //             child: InkWell(
                //                 onTap: () {
                //                   Navigator.pop(context);
                //                 },
                //                 child: Image.asset(
                //                   back,
                //                   height: 4.0.h,
                //                   width: 8.w,
                //                 ))),
                //         SizedBox(
                //           width: 2.08.h,
                //         ),Container(
                //           width: 65.w,
                //           child: text(
                //             "Payment",
                //             textColor: Color(0xffffffff),
                //             fontSize: 14.sp,
                //             fontFamily: fontMedium,
                //             isCentered: true,
                //           ),
                //         ),

                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 1.52.h,
                ),
                StreamBuilder<TotalPaymentResponse>(
                    stream: totalPaymentStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox(
                            height: 20.h, child: LodingSliderView());
                      }
                      return Container(
                        margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w),
                        padding: EdgeInsets.only(
                            left: 2.91.w, right: 2.91.w, top: 2.67.h),
                        height: 22.26.h,
                        decoration: boxDecoration(
                          showShadow: true,
                          radius: 20.0,
                          bgColor: AppColor().colorBg1(),
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              filter,
                              height: 2.26.h,
                              width: 2.26.h,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Center(
                                    child: Image.asset(
                                      paymentIcon,
                                      height: 8.75.h,
                                      width: 21.94.w,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.12.h,
                                  ),
                                  text(
                                    "Your Total Earning",
                                    textColor: Color(0xff707070),
                                    fontSize: 14.sp,
                                    fontFamily: fontBold,
                                  ),
                                  SizedBox(
                                    height: 1.02.h,
                                  ),
                                  text(
                                    AppStrings.currencySymbols +
                                        " " +
                                        totalMoney
                                            // snapshot.data!.data![0].totalamount
                                            .toString(),
                                    textColor: Color(0xff000000),
                                    fontSize: 14.sp,
                                    fontFamily: fontBold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 1.52.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w),
                  width: 100.w,
                  child: text(
                    "Request For Money",
                    textColor: Color(0xff202442),
                    fontSize: 14.sp,
                    fontFamily: fontBold,
                  ),
                ),
                SizedBox(
                  height: 1.52.h,
                ),
                Form(
                  key: _fromKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 8.33.w, right: 8.33.w),
                    padding: EdgeInsets.only(left: 2.91.w, right: 2.91.w),
                    height: 8.21.h,
                    decoration: boxDecoration(
                      showShadow: true,
                      radius: 20.0,
                      bgColor: AppColor().colorBg1(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 26.52.w,
                          // height: 5.23.h,
                          child: TextFormField(
                            cursorColor: Colors.red,
                            keyboardType: TextInputType.number,
                            validator: FormValidation.checkEmptyValidator,
                            controller: withdrawMoneyContoroll,
                            style: TextStyle(
                              color: AppColor().colorTextFour(),
                              fontSize: 10.sp,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                              // totalMoney
                            ],
                            decoration: InputDecoration(
                              labelText: '',
                              labelStyle: TextStyle(
                                color: AppColor().colorTextFour(),
                                fontSize: 10.sp,
                              ),
                              fillColor: AppColor().colorEdit(),
                              enabled: true,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor().colorBg1(), width: 5.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_fromKey.currentState!.validate()) {
                              int intputValeu =
                                  int.parse(withdrawMoneyContoroll.text);
                              int money = totalMoney;
                              if (intputValeu <= money) {
                                print("object");
                                requestForMoney();
                              } else {
                                UtilityHlepar.getToast(
                                    ToastString.yourEarninglow);
                              }
                            }
                            // setState(() {
                            //   enabled = true;
                            // });
                            // await Future.delayed(Duration(milliseconds: 200));
                            // setState(() {
                            //   enabled = false;
                            // });
                            //    Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500),));
                          },
                          child: ScaleAnimatedWidget.tween(
                            enabled: enabled,
                            duration: Duration(milliseconds: 200),
                            scaleDisabled: 1.0,
                            scaleEnabled: 0.9,
                            child: Container(
                              width: 26.52.w,
                              height: 5.23.h,
                              decoration: boxDecoration(
                                  radius: 15.0,
                                  bgColor: AppColor().colorPrimaryDark()),
                              child: Center(
                                child: text(
                                  "Request",
                                  textColor: Color(0xffffffff),
                                  fontSize: 10.sp,
                                  fontFamily: fontRegular,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.52.h,
                ),

                StreamBuilder<PaymentHistoryResponse>(
                    stream: paymentHistoryStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return LodingAllPage();
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 1.87.h),
                        child: Column(
                          children: [
                            // Container(
                            //   margin:
                            //       EdgeInsets.only(left: 8.33.w, right: 8.33.w),
                            //   width: 100.w,
                            //   child: text(
                            //     "Payment History",
                            //     textColor: Color(0xff202442),
                            //     fontSize: 14.sp,
                            //     fontFamily: fontBold,
                            //   ),
                            // ),
                            SizedBox(
                              height: 1.52.h,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      height: 11.25.h,
                                      width: 82.91.w,
                                      decoration: boxDecoration(
                                        showShadow: true,
                                        radius: 20.0,
                                        bgColor: AppColor().colorBg1(),
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 8.33.w,
                                          right: 8.33.w,
                                          bottom: 1.87.h),
                                      padding: EdgeInsets.only(
                                          left: 3.05.w, right: 3.05.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 7.81.h,
                                            width: 7.81.h,
                                            child: Image(
                                              image: AssetImage(package),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 1.6.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: text(
                                                      "Invoice ID : #INV-" +
                                                          UtilityHlepar
                                                              .convertNA(
                                                                  snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .orderId),
                                                      textColor:
                                                          Color(0xff191919),
                                                      fontSize: 10.5.sp,
                                                      fontFamily: fontBold,
                                                      overFlow: true),
                                                ),
                                                SizedBox(
                                                  height: 1.9.h,
                                                ),
                                                Container(
                                                  child: text(
                                                      "Payment Mode: " +
                                                          UtilityHlepar
                                                              .convertNA(snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .paymentMode),
                                                      textColor:
                                                          Color(0xff191919),
                                                      fontSize: 7.5.sp,
                                                      fontFamily: fontBold,
                                                      overFlow: true),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      text(
                                                        "Amount Paid : ",
                                                        textColor:
                                                            Color(0xff000000),
                                                        fontSize: 7.5.sp,
                                                        fontFamily: fontBold,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      text(
                                                        AppStrings
                                                                .currencySymbols +
                                                            " " +
                                                            UtilityHlepar
                                                                .convertNA(
                                                                    snapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .price),
                                                        textColor:
                                                            Color(0xffF4B71E),
                                                        fontSize: 7.5.sp,
                                                        fontFamily: fontBold,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.05.w,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 1.9.h),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Image(
                                                    image: AssetImage(snapshot
                                                                .data!
                                                                .data![index]
                                                                .pStatus
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "success"
                                                        ? greenIcon
                                                        : redIcon),
                                                    fit: BoxFit.fill,
                                                    height: 3.20.h,
                                                    width: 3.20.h,
                                                  ),
                                                  text(
                                                    UtilityHlepar.convertNA(
                                                        snapshot
                                                            .data!
                                                            .data![index]
                                                            .pStatus),
                                                    // index == 1
                                                    //     ? "Pending"
                                                    //     : "Received",
                                                    textColor: snapshot
                                                                .data!
                                                                .data![index]
                                                                .pStatus
                                                                .toString()
                                                                .toLowerCase() ==
                                                            "success"
                                                        ? Color(0xff79A11D)
                                                        : AppColor()
                                                            .colorPrimaryDark(),
                                                    fontSize: 7.5.sp,
                                                    fontFamily: fontRegular,
                                                  ),
                                                  SizedBox(
                                                    height: 0.7.h,
                                                  ),
                                                  text(
                                                    UtilityHlepar.convertNA(
                                                        snapshot
                                                            .data!
                                                            .data![index]
                                                            .datea),
                                                    textColor:
                                                        Color(0xff000000),
                                                    fontSize: 7.5.sp,
                                                    fontFamily: fontSemibold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ));
                                }),
                          ],
                        ),
                      );
                    }),

                SizedBox(
                  height: 3.02.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        enabled = true;
                      });
                      await Future.delayed(Duration(milliseconds: 200));
                      setState(() {
                        enabled = false;
                      });
                      //    Navigator.push(context, PageTransition(child: LoginScreen(), type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500),));
                    },
                    child: ScaleAnimatedWidget.tween(
                      enabled: enabled,
                      duration: Duration(milliseconds: 200),
                      scaleDisabled: 1.0,
                      scaleEnabled: 0.9,
                      child: Container(
                        width: 69.99.w,
                        height: 6.46.h,
                        decoration: boxDecoration(
                            radius: 15.0,
                            bgColor: AppColor().colorPrimaryDark()),
                        child: Center(
                          child: text(
                            "Update",
                            textColor: Color(0xffffffff),
                            fontSize: 14.5.sp,
                            fontFamily: fontRegular,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.02.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  late TotalPaymentResponse totalPaymentResponse;
  getTotalPayment() async {
    try {
      // String userId = "396";
      String userId = await MyToken.getUserID();
      PaymentHistoryRequest request = PaymentHistoryRequest(userId: userId);
      totalPaymentResponse = await HomeApiHelper.gettotalPayment(request);
      if (totalPaymentResponse.responseCode == ToastString.responseCode) {
        totalPaymentStream.sink.add(totalPaymentResponse);
        try {
          totalMoney = int.parse(totalPaymentResponse.data![0].totalamount!);
        } catch (e) {
          totalMoney = 0;
        }
        if (totalMoney == null) {
          totalMoney = 0;
        }
      } else {
        totalPaymentStream.sink
            .addError(totalPaymentResponse.message.toString());
      }
    } catch (e) {
      UtilityHlepar.getToast(e.toString());
      totalPaymentStream.sink.addError(ToastString.msgSomeWentWrong);
    }
    setState(() {});
    // gettotalPayment
  }

  late PaymentHistoryResponse historyResponse;
  getPaymentHistory() async {
    try {
      // String userId = "396";
      String userId = await MyToken.getUserID();
      PaymentHistoryRequest request = PaymentHistoryRequest(userId: userId);
      historyResponse = await HomeApiHelper.getPaymentHistory(request);
      if (historyResponse.responseCode == ToastString.responseCode) {
        paymentHistoryStream.sink.add(historyResponse);
      } else {
        paymentHistoryStream.sink.addError(historyResponse.message.toString());
      }
    } catch (e) {
      UtilityHlepar.getToast(e.toString());
      paymentHistoryStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }

  late RequestForPaymentResponse forPaymentResponse;
  void requestForMoney() async {
    MYDialog.loadingDialog(context);
    // String userId = "396";
    String userId = await MyToken.getUserID();
    RequestForPaymentRequest request = RequestForPaymentRequest(
        userId: userId, amount: withdrawMoneyContoroll.text);
    forPaymentResponse = await HomeApiHelper.requestForPayment(request);
    UtilityHlepar.getToast(forPaymentResponse.message.toString());
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
