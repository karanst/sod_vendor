import 'dart:async';
import 'package:fixerking/api/api_helper/home_api_helper.dart';
import 'package:fixerking/modal/request/notification_request.dart';
import 'package:fixerking/modal/response/notification_response.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  StreamController<NotificationResponse> responseSteam = StreamController();

  @override
  void initState() {
    super.initState();
    getNotification();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    responseSteam.close();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorPrimary());
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text("Notification",),
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
      ),
      body: SafeArea(
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColor().colorBg1(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    StreamBuilder<NotificationResponse>(
                        stream: responseSteam.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: Center(
                                  child: Text(snapshot.error.toString())),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // return LodingAllPage();
                            return Center(
                              child: Container(
                                height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColor().colorPrimary(),
                                    ),
                                  ),
                            );
                          }
                          return Container(
                            height: MediaQuery.of(context).size.height- 125,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data!.notifications!.length,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context,
                                          snapshot.data!.notifications![i]);
                                    },
                                    child: Container(
                                        // height: 11.40.h,
                                        width: 82.91.w,
                                        decoration: BoxDecoration(
                                          // showShadow: true,
                                          border: Border.all(
                                              color: AppColor.PrimaryDark),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColor().colorBg1(),
                                        ),
                                        // boxDecoration(
                                        //
                                        // ),
                                        margin: EdgeInsets.only(
                                            left: 8.33.w,
                                            right: 8.33.w,
                                            bottom: 1.87.h),
                                        padding: EdgeInsets.only(
                                            left: 3.05.w, right: 2.05.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 6.32.h,
                                              width: 6.32.h,
                                              child: Image(
                                                image: AssetImage(
                                                    notificationIcon),
                                                fit: BoxFit.fill,
                                                color: AppColor.PrimaryDark,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.05.w,
                                            ),
                                            Container(
                                              width: 57.5.w,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: text(
                                                        snapshot
                                                            .data!
                                                            .notifications![i]
                                                            .title!,
                                                        textColor:
                                                            Color(0xff191919),
                                                        fontSize: 13.5.sp,
                                                        fontFamily: fontBold,
                                                        overFlow: true),
                                                  ),
                                                  SizedBox(
                                                    height: 0.5.h,
                                                  ),
                                                  Container(
                                                    child: text(
                                                      snapshot
                                                          .data!
                                                          .notifications![i]
                                                          .message!,
                                                      textColor:
                                                          Color(0xff2a2a2a),
                                                      fontSize: 10.sp,
                                                      overFlow: true,
                                                      fontFamily: fontRegular,
                                                      maxLine: 3,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                }),
                          );
                        }),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  late NotificationResponse response;
  getNotification() async {
    try {
      String userid = await MyToken.getUserID();
      NotificationRequest request = NotificationRequest(userid: userid);
      response = await HomeApiHelper.getNotification(request);
      if (response.responseCode == ToastString.responseCode) {
        responseSteam.sink.add(response);
      } else {
        responseSteam.sink.addError(response.message!);
      }
    } catch (e) {
      UtilityHlepar.getToast(e.toString());
      responseSteam.sink.addError(ToastString.msgSomeWentWrong);
    }
  }
}
