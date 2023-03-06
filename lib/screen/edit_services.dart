import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

// import 'package:time_picker_sheet/widget/sheet.dart';
// import 'package:time_picker_sheet/widget/time_picker.dart';
import '../api/api_path.dart';
import '../modal/AddServicesModel.dart';
import '../modal/City_model.dart';
import '../modal/ModelCategoryModel.dart';
import '../modal/ServiceCategoryModel.dart';
import '../modal/ServiceChildCategoryModel.dart';
import '../modal/ServiceSubCategoryModel.dart';
import '../modal/VisitChargeModel.dart';
import '../modal/country_model.dart';
import '../modal/state_model.dart';
import '../token/app_token_data.dart';
import '../utility_widget/utility_widget.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import '../utils/toast_string.dart';
import '../utils/utility_hlepar.dart';
import '../utils/widget.dart';
import 'BottomBars/bottom_bar.dart';

class EditServices extends StatefulWidget {
  final serviceName,
      serviceTime,
      serviceCharge,
      catId,
      subCatId,
      serviceId,
      serviceImage,
      subName,
      childName,
      experts,
      city,
      country,
      state,
  logo,
      serviceDescription;


  const EditServices(
      {Key? key,
      this.serviceName,
      this.serviceTime,
        this.logo,
        this.city,
        this.country,
        this.state,
      this.serviceCharge,
      this.serviceId,
      this.catId,
      this.subCatId,
      this.serviceImage,
      this.subName,
      this.childName,
        this.experts,
      this.serviceDescription})
      : super(key: key);

  @override
  State<EditServices> createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {
  // late TextEditingController onpenTime;
  late TextEditingController serviceCharge;
  late TextEditingController serviceName;
  late TextEditingController descriptionController;
  late TextEditingController expertsC;
  var fileResult;
  String service_name = "";
  String issue = "";
  GlobalKey<FormState> _formKey = GlobalKey();
  String? selectedCategory, selectSubCategory, selectChildCategory, selectModel;
  double perMinServiceCharge = 0.0;
  String? visitingCharge;
  bool buttonLogin = false;
  String finalCharges = "0";
  var servicePic;
  var imageList;
  var imagePathList;
  var storeId;
  DateTime dateTimeSelected = DateTime.now();
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  List<CityData> cityList = [];
  List<CountryData> countryList = [];
  List<StateData> stateList = [];
  Future getState() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
    request.fields.addAll({'country_id': '$selectedCountry'});
    http.StreamedResponse response = await request.send();
    print(request);
    print(request.fields);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = StateModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          stateList = jsonResponse.data!;
        });
      }
      return StateModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
  Future getCountries() async {
    var request =
    http.Request('GET', Uri.parse('${Apipath.BASH_URL}get_countries'));
    http.StreamedResponse response = await request.send();
    print(request);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = CountryModel.fromJson(json.decode(str));

      if (jsonResponse.responseCode == "1") {
        setState(() {
          countryList = jsonResponse.data!;
        });
      }
      return CountryModel.fromJson(json.decode(str));
    } else {
      print(response.reasonPhrase);
    }
  }
  Future getCities() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
    request.fields.addAll({'state_id': '$selectedState'});
    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      /*var fullResponse = json.decode(str);
      serviceList = fullResponse["data"];
      print(serviceList.length);
      setState(() {});
      boolList = serviceList.map((element) {
        return false;
      }).toList();
      serviceList.forEach((element) {
        boolServiceMapList[element["id"]] = false;
      });
      print(boolServiceMapList.length);
      print(boolList.length);*/
      final jsonResponse = CityModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          cityList = jsonResponse.data!;
        });
      }
      return CityModel.fromJson(json.decode(str));
    } else {
      print(response.reasonPhrase);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // onpenTime = new TextEditingController(text: widget.serviceTime);
    serviceCharge = new TextEditingController(text: widget.serviceCharge);
    serviceName = new TextEditingController(text: widget.serviceName);
    descriptionController = new TextEditingController(text: widget.serviceDescription);
    // expertsC = new TextEditingController(text: widget.experts);
    servicePic = widget.serviceImage;
    selectedCategory = widget.catId;
    selectSubCategory = widget.subCatId;
    getCountries();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor().colorBg1(),
        body: SingleChildScrollView(
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
                Container(
                  height: 9.92.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(profileBg),
                    fit: BoxFit.fill,
                  )),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 6.38.w,
                            height: 6.38.w,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 7.91.w),
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  back,
                                  height: 4.0.h,
                                  width: 8.w,
                                ))),
                        SizedBox(
                          width: 2.08.h,
                        ),
                        Container(
                          width: 65.w,
                          child: text(
                            "Edit Service Profile",
                            textColor: Color(0xffffffff),
                            fontSize: 14.sp,
                            fontFamily: fontMedium,
                            isCentered: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.02.h,
                ),
                secondSign(context),
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

  Widget secondSign(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 2.62.h,
          ),
          text(
            "Service Offered",
            textColor: AppColor().colorPrimary(),
            fontSize: 14.sp,
            fontFamily: fontBold,
          ),
          SizedBox(
            height: 2.96.h,
          ),

          // SERVICE NAME
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            color: AppColor().colorEdit(),
            child: Container(
                width: 80.99.w,
                height: 7.46.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  controller: serviceName,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Service Name",
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                    prefixIcon: Icon(
                      Icons.miscellaneous_services,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Container(
              width: 80.99.w,
              height: 7.46.h,
              decoration: boxDecoration(
                radius: 10.0,
                color:  AppColor().colorEdit(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Image.asset(
                        country,
                        width: 6.04.w,
                        height: 5.04.w,
                        fit: BoxFit.fill,
                        color: AppColor.PrimaryDark,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          'Select Country',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: countryList
                      .map((item) => DropdownMenuItem<String>(
                    value: item.id,
                    child: Text(
                      item.name!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  value: selectedCountry == null ? widget.country : selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value as String;
                      print("selectedCategory=>" +
                          selectedCountry.toString());
                      getState();
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColor.PrimaryDark,
                  ),
                  iconSize: 14,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding:
                  const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor().colorEdit(),
                  ),
                  buttonElevation: 0,
                  itemHeight: 40,
                  itemPadding:
                  const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 300,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                ),
              )),
          SizedBox(
            height: 2.5.h,
          ),
          Container(
            width: 80.99.w,
            height: 7.46.h,
            decoration: boxDecoration(
              radius: 10.0,
              color:AppColor().colorEdit(),
            ),
            child:DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: [
                    Image.asset(
                      city,
                      width: 6.04.w,
                      height: 5.04.w,
                      fit: BoxFit.fill,
                      color: AppColor.PrimaryDark,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select State',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: stateList
                    .map((item) =>
                    DropdownMenuItem<String>(
                      value: item.id,
                      child: Text(
                        item.name!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow:
                        TextOverflow.ellipsis,
                      ),
                    ))
                    .toList(),
                value: selectedState == null ? widget.state : selectedState,
                onChanged: (value) {
                  setState(() {
                    selectedState = value as String;
                    print("selected State===>" +
                        selectedState.toString());
                  });
                  getCities();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColor.PrimaryDark,
                ),
                iconSize: 14,
                buttonHeight: 50,
                buttonWidth: 160,
                buttonPadding: const EdgeInsets.only(
                    left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(14),
                  color:AppColor().colorEdit(),
                ),
                buttonElevation: 0,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(
                    left: 14, right: 14),
                dropdownMaxHeight: 300,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                dropdownElevation: 8,
                scrollbarRadius:
                const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Container(
            width: 80.99.w,
            height: 7.46.h,
            decoration: boxDecoration(
              radius: 10.0,
              color:AppColor().colorEdit(),
            ),
            child:DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: [
                    Image.asset(
                      city,
                      width: 6.04.w,
                      height: 5.04.w,
                      fit: BoxFit.fill,
                      color: AppColor.PrimaryDark,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select City',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: cityList
                    .map((item) =>
                    DropdownMenuItem<String>(
                      value: item.id,
                      child: Text(
                        item.name!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow:
                        TextOverflow.ellipsis,
                      ),
                    ))
                    .toList(),
                value: selectedCity == null ? widget.city : selectedCity,
                onChanged: (value) {
                  setState(() {
                    selectedCity = value as String;
                    print("selected State===>" +
                        selectedCity.toString());
                  });
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColor.PrimaryDark,
                ),
                iconSize: 14,
                buttonHeight: 50,
                buttonWidth: 160,
                buttonPadding: const EdgeInsets.only(
                    left: 14, right: 14),
                buttonDecoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(14),
                  color:AppColor().colorEdit(),
                ),
                buttonElevation: 0,
                itemHeight: 40,
                itemPadding: const EdgeInsets.only(
                    left: 14, right: 14),
                dropdownMaxHeight: 300,
                dropdownPadding: null,
                dropdownDecoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                dropdownElevation: 8,
                scrollbarRadius:
                const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          SizedBox(
            height: 2.5.h,
          ),

          // SERVICE CATEGORY
          Container(
              width: 80.99.w,
              height: 7.46.h,
              decoration: boxDecoration(
                radius: 10.0,
              ),
              child: FutureBuilder(
                  future: getServiceCategory(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    ServiceCategoryModel serviceModel = snapshot.data;
                    if (snapshot.hasData) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Image.asset(
                                service,
                                width: 6.04.w,
                                height: 5.04.w,
                                fit: BoxFit.fill,
                                color: AppColor.PrimaryDark,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Select Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: serviceModel.data!
                              .map((item) => DropdownMenuItem<String>(
                            value: item.id,
                            child: Text(
                              item.cName!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value as String;
                              // // serviceName.text = serviceModel.data!
                              //     .firstWhere((element) => element.id == value)
                              //     .cName
                              //     .toString();
                              print("selectedCategory=>" +
                                  selectedCategory.toString() +
                                  "serviceName" +
                                  serviceName.text);
                            });
                            print("CATEGORY ID== $selectedCategory");
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColor.PrimaryDark,
                          ),
                          iconSize: 14,
                          buttonHeight: 50,
                          buttonWidth: 160,
                          buttonPadding:
                          const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColor().colorEdit(),
                          ),
                          buttonElevation: 0,
                          itemHeight: 40,
                          itemPadding:
                          const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 300,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                        ),
                      );
                    }
                    else if (snapshot.hasError) {
                      print("ERROR===" + snapshot.error.toString());
                      return Icon(Icons.error_outline);
                    }
                    else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
          SizedBox(
            height: 2.5.h,
          ),

          // SERVICE SUBCATEGORY
          Container(
              width: 80.99.w,
              height: 7.46.h,
              decoration: boxDecoration(
                radius: 10.0,
                // bgColor: AppColor().colorEdit(),
              ),
              child: FutureBuilder(
                  future: getServicesSubCategory(selectedCategory),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    ServiceSubCategoryModel subCatModel = snapshot.data;
                    print("SUB CAT DATA=== $subCatModel");
                    if (snapshot.hasData) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Image.asset(
                                special,
                                width: 6.04.w,
                                height: 5.04.w,
                                fit: BoxFit.fill,
                                color: AppColor.PrimaryDark,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  'Select Sub Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: subCatModel.data!
                              .map((item) => DropdownMenuItem<String>(
                            value: item.id,
                            child: Text(
                              item.cName!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: selectSubCategory,
                          onChanged: (value) {
                            setState(() {
                              selectSubCategory = value as String;
                            });
                            print("SUB CATEGORY ID== $selectSubCategory");
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColor.PrimaryDark,
                          ),
                          iconSize: 14,
                          buttonHeight: 50,
                          buttonWidth: 160,
                          buttonPadding:
                          const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: AppColor().colorEdit(),
                          ),
                          buttonElevation: 0,
                          itemHeight: 40,
                          itemPadding:
                          const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 300,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          dropdownElevation: 8,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 6,
                          scrollbarAlwaysShow: true,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  })),
          SizedBox(
            height: 2.62.h,
          ),

          //service Description
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            color: AppColor().colorEdit(),
            child: Container(
                width: 80.99.w,
                height: 7.46.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  controller: descriptionController,
                  // maxLines: 2,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Service Description",
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                    prefixIcon: Icon(
                      Icons.description,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),

         /* //SERVICE EXPERTS
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            color: AppColor().colorEdit(),
            child: Container(
                width: 80.99.w,
                height: 7.46.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: expertsC,
                  inputFormatters: [LengthLimitingTextInputFormatter(5)],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Service Experts",
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                    prefixIcon: Icon(
                      Icons.credit_card_outlined,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),*/

          //SERVICE PRICE
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            color: AppColor().colorEdit(),
            child: Container(
                width: 80.99.w,
                height: 7.46.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: serviceCharge,
                  inputFormatters: [LengthLimitingTextInputFormatter(5)],
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Service Charges",
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15.0, vertical: 16),
                    prefixIcon: Icon(
                      Icons.credit_card_outlined,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                ),),
          ),
          SizedBox(
            height: 2.5.h,
          ),

         /* // Service TIME
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0)),
            color: AppColor().colorEdit(),
            child: Container(
                width: 80.99.w,
                height: 7.46.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child: TextFormField(
                  controller: onpenTime,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Service Time (in Hrs.)",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                    prefixIcon: Icon(
                      Icons.watch,
                      color: AppColor.PrimaryDark,
                    ),
                  ),
                  onTap: () async {
                    _openTimePickerSheet(context);
                  },
                )),
          ),
          SizedBox(
            height: 2.5.h,
          ),
*/
          // SERVICE IMAGE
          GestureDetector(
            onTap: () {
              // getImagePicker();
              getFromGallery();
            },
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0)),
              color: AppColor().colorEdit(),
              child: Container(
                width: 80.99.w,
                height: 10.46.h,
                decoration: boxDecoration(
                  radius: 14.0,
                  bgColor: AppColor().colorEdit(),
                ),
                child:
                servicePic != null

                    ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.image,
                        color: AppColor.PrimaryDark,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ListView.builder(
                            shrinkWrap:  true,
                            itemCount: widget.logo.length,
                            itemBuilder: (c,i){
                          return Text(
                            "${widget.logo[i]}",
                            overflow: TextOverflow.ellipsis,
                          );
                        })
                      )
                    ],
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: AppColor.PrimaryDark,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text("Upload service image"),
                    ],
                  ),
                ),
              ),
            ),
          ),
       widget.logo == null || widget.logo == "" ? SizedBox.shrink() : Container(
            height: 90,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.logo.length,
                itemBuilder: (c,i){
              return Container(
                height: 90,
                width: 100,
                margin: EdgeInsets.only(left: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network("${widget.logo[i]}",fit: BoxFit.fill,),
                ),
              );
            }),
          ),
          SizedBox(
            height: 2.5.h,
          ),

          Center(
            child: InkWell(
              onTap: () async {
                var userId = await MyToken.getUserID();
                if (_formKey.currentState!.validate()) {
                  if (selectedCategory!.isNotEmpty &&
                      selectSubCategory!.isNotEmpty &&
                      serviceCharge.text.isNotEmpty ) {
                    setState(() {
                      buttonLogin = true;
                    });
                    Map<String, String> param = {
                      'name': '${serviceName.text.toString()}',
                      'description': '${descriptionController.text}',
                      'cat_id': '$selectedCategory',
                      'scat_id': '$selectSubCategory',
                      'vid': '$userId',
                      'price': '${serviceCharge.text.toString()}',
                      // 'hours': '${onpenTime.text.toString()}',
                      // 'experts': '${expertsC.text}',
                      'id': widget.serviceId,
                      'country_id': "${selectedCountry.toString()}",
                      "state_id":"${selectedCity.toString()}",
                      "city_id":"${selectedCity.toString()}",
                    };
                    print("ADD SERVICE PARAM=====" + param.toString());
                    AddServicesModel addModel = await editServices(param);
                    if (addModel.responseCode == "1") {
                      Navigator.pop(context, true);
                      UtilityHlepar.getToast("Service Edit Successfully");
                    } else {
                      UtilityHlepar.getToast(addModel.message);
                    }
                  }
                  else if (selectedCategory!.isEmpty) {
                    UtilityHlepar.getToast(ToastString.msgSelectServiceType);
                  }
                  else if (selectSubCategory!.isEmpty) {
                    UtilityHlepar.getToast(ToastString.msgSelectServiceSubType);
                  }
                  // else if (onpenTime.text.isEmpty) {
                  //   UtilityHlepar.getToast(ToastString.msgServiceTime);
                  // }
                  else if (serviceCharge.text.isEmpty) {
                    UtilityHlepar.getToast(ToastString.msgServiceCharge);
                  } else if(servicePic == null){
                    UtilityHlepar.getToast("Service Image Required");
                  }
                }
              },
              child: UtilityWidget.lodingButton(
                  buttonLogin: buttonLogin, btntext: 'Submit'),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
        ],
      ),
    );
  }

  Future<ServiceCategoryModel?> getServiceCategory() async {
    // var userId = await MyToken.getUserID();
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${Apipath.BASH_URL}get_categories_list',
        ));
    print(request);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return ServiceCategoryModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future<ServiceSubCategoryModel?> getServicesSubCategory(catId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));

    request.fields.addAll({'p_id': '$catId'});

    print(request);
    print(request.fields);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      return ServiceSubCategoryModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future<void> getFromGallery() async {

    fileResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,

    );
    if (fileResult != null) {
      setState(() {
        // servicePic = File(result.files.single.path!);
        servicePic = fileResult.paths.toList();
      });
      print("SERVICE PIC === $servicePic");
    } else {
      // User canceled the picker
    }
  }

  // Future<void> getFromGallery() async {
  //   var result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //     allowMultiple: true,
  //   );
  //   if (result != null) {
  //     setState(() {
  //       // servicePic = File(result.files.single.path.toString());
  //     });
  //     imagePathList = result.paths.toList();
  //     // imagePathList.add(result.paths.toString()).toList();
  //     print("SERVICE PIC === ${imagePathList.length}");
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  Future editServices(param) async {
    print("servicePic list here ${servicePic}");
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}edit_restaurant'));
     for(var i=0;i<servicePic.length;i++){
      fileResult == null ? "" :
        request.files.add(
          await http.MultipartFile.fromPath('res_image[]', servicePic[i].toString()));
    }
    // if(widget.serviceImage == null){
    //   request.files.add(await http.MultipartFile.fromPath(
    //       'logo', servicePic!.path));
    // } else {
    //   request.files.add(http.MultipartFile.fromString(
    //       'logo', widget.serviceImage));
    // }

    request.fields.addAll(param);

    http.StreamedResponse response = await request.send();
    print(request.toString());
    print(request.fields.toString());
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str.toString());
      return AddServicesModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: 'Select Service Time',
        minuteTitle: 'Minute',
        hourTitle: 'Hour',
        saveButtonText: 'Save',
      ),
    );

    if (result != null) {
      print("--22222------$result");
      setState(() {
        dateTimeSelected = result;
        // onpenTime.text = "0${dateTimeSelected.hour}:${dateTimeSelected.minute == 0 ? "0${dateTimeSelected.minute}" : dateTimeSelected.minute} ";
      });
    }
  }
  bool isChange = false;
}
