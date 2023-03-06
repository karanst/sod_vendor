import 'dart:async';
import 'dart:convert';
import 'package:fixerking/api/api_helper/auth_helper.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/ServiceSubCategoryModel.dart';
import 'package:fixerking/modal/request/specilization_list_request.dart';
import 'package:fixerking/modal/response/specilization_list_response.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/loding_all_page.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/toast_string.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

class SpecializationList extends StatefulWidget {
  final String serviceId;
  const SpecializationList({Key? key, required this.serviceId})
      : super(key: key);

  @override
  State<SpecializationList> createState() => _SpecializationListState();
}

class _SpecializationListState extends State<SpecializationList> {
  StreamController<SpecilizationListResponse> specilizationTypeStream =
      StreamController();

  @override
  void initState() {
    super.initState();
    // getServicesType();
  }

  @override
  void dispose() {
    super.dispose();
    specilizationTypeStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Your Specialization"),
        elevation: 0.0,
      ),
      // appBar: MyappBarView(),
      body: FutureBuilder(
            future: getServicesType(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              ServiceSubCategoryModel? serviceModel = snapshot.data;
              if (snapshot.hasData) {
                return AnimationLimiter(
                  child: ListView.builder(
                    itemCount: serviceModel!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: cord(index, serviceModel),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  InkWell cord(int i, ServiceSubCategoryModel model) {
    return InkWell(
      onTap: () {
        Navigator.pop(context, [
          model.data![i].cName.toString(),
          model.data![i].id.toString()
        ]);
      },
      child: Card(
        child: ListTile(
            leading: ClipOval(
              child: Container(
                  height: 6.h,
                  width: 10.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColor.PrimaryDark),
                  child: Text((1 + i).toString())),
            ),
            trailing: Icon(Icons.arrow_forward),
            title: Text(
              model.data![i].cName.toString(),
              style: TextStyle(fontSize: 10.0.sp),
            )),
      ),
    );
  }

  // late SpecilizationListResponse _listResponse;

  Future<ServiceSubCategoryModel?> getServicesType() async {
    var request = http.MultipartRequest('POST',
        Uri.parse("${Apipath.BASH_URL}+get_service_subCategory"));

    request.fields.addAll({
      'categoryId': '${widget.serviceId}'
    });

    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      return ServiceSubCategoryModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }
    /*try {
      SpecilizationListRequest request =
          SpecilizationListRequest(serviceId: widget.serviceId.toString());
      _listResponse = await AuthApiHelper.getSpecilizationList(request);
      if (_listResponse.status == ToastString.success) {
        specilizationTypeStream.sink.add(_listResponse);
      } else {
        specilizationTypeStream.sink.addError(_listResponse.message.toString());
      }
    } catch (e) {
      UtilityHlepar.getToast(e);
      specilizationTypeStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }*/
}
