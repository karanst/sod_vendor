import 'dart:async';

import 'package:fixerking/api/api_helper/auth_helper.dart';
import 'package:fixerking/modal/response/get_service_type_list.dart';
import 'package:fixerking/utility_widget/myappbar.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

class ServiceTypeList extends StatefulWidget {
  const ServiceTypeList({Key? key}) : super(key: key);

  @override
  State<ServiceTypeList> createState() => _ServiceTypeListState();
}

class _ServiceTypeListState extends State<ServiceTypeList> {
  StreamController<GetServiceTypeListResponse> serviceTypeStream =
      StreamController();
  late GetServiceTypeListResponse typeResponse;
  @override
  void initState() {
    super.initState();
    getServicesType();
  }

  @override
  void dispose() {
    super.dispose();
    serviceTypeStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Service type"),
        elevation: 0.0,
      ),
      // appBar: MyappBarView(),
      body: StreamBuilder<GetServiceTypeListResponse>(
          stream: serviceTypeStream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Container(
                  child: Text(snapshot.error.toString()),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return LodingAllPage();
            }
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      // verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: cord(index, snapshot),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  InkWell cord(int i, AsyncSnapshot<GetServiceTypeListResponse> snapshot) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, [
          snapshot.data!.data![i].cName.toString(),
          snapshot.data!.data![i].id.toString()
        ]);
      },
      child: Card(
        child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                  height: 10.h,
                  width: 10.w,
                  margin: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColor.PrimaryDark),
                  child: Text((1 + i).toString())),
            ),
            trailing: Icon(Icons.arrow_forward),
            title: Text(
              snapshot.data!.data![i].cName!,
              style: TextStyle(fontSize: 10.0.sp),
            )),
      ),
    );
  }

  getServicesType() async {
    try {
      var response = await AuthApiHelper.getServicesType();
      if (response.status == ToastString.success) {
        serviceTypeStream.sink.add(response);
      } else {
        serviceTypeStream.sink.addError(response.message.toString());
      }
    } catch (e) {
      UtilityHlepar.getToast(e);
      serviceTypeStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }
}
