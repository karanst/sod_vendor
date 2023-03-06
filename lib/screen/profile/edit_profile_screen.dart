import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fixerking/api/api_helper/multipart_helper.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/ServiceCategoryModel.dart';
import 'package:fixerking/modal/response/get_profile_response.dart';
import 'package:fixerking/token/app_token_data.dart';
import 'package:fixerking/utility_widget/utility_widget.dart';
import 'package:fixerking/utils/images.dart';
import 'package:fixerking/utils/utility_hlepar.dart';
import 'package:fixerking/validation/form_validation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/common.dart';
import 'package:fixerking/utils/constant.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:http/http.dart' as http;
import '../../modal/City_model.dart';
import '../../modal/ServiceSubCategoryModel.dart';
import '../../modal/country_model.dart';
import '../../modal/state_model.dart';

class EditProfileScreen extends StatefulWidget {
  late GetProfileResponse response;

  EditProfileScreen({Key? key, required this.response}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController nameController = new TextEditingController();
  TextEditingController userLastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController aadharNumberController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController portfolioController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController equipmentController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController comfertableServiceController = TextEditingController();
  TextEditingController whyJoinController = TextEditingController();
  String? selectedCategory;
  String? selectedSubCategory;
  TextEditingController amountController = TextEditingController();
  List<String> cityIdList = [];
  String? SelectedSignleCity;
  String? selectedDayHour;
  String? SelectedLanguage;
  bool status = false;
  bool selected = false, enabled = false, edit1 = false;
  bool buttonLogin = false;
  var profilePic = null;
  List<CountryData> countryList = [];
  List<StateData> stateList = [];
  List<CityData> cityList = [];
  List<String> selectedCities = [];
  String? selectedCountry, selectedState;
  String? countryName, stateName,cityName;
  List _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    changePage();
    getCountries();
    setFromField();
  }
  Future<ServiceSubCategoryModel?> getServicesSubCategory(catId) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("${Apipath.BASH_URL}get_categories_list"));

    request.fields.addAll({'p_id': '$catId'});


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();

      return ServiceSubCategoryModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  changePage() async {
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      status = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showMultiSelect() async {
    // // a list of selectable items
    // // these items can be hard-coded or dynamically fetched from a database/API
    // final List _items = [
    //   {
    //     "id":"1",
    //     "name":"Flutter"
    //   },
    //   {
    //     "id":"2",
    //     "name":"Node.js"
    //   },
    //   {
    //     "id":"3",
    //     "name":"React Native"
    //   },
    // ];

    final List? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect( selectedState: selectedState.toString(),);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });

    }
  }

  var dateFormate;
  String _dateValue = '';
  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Colors.black, //Head background
                accentColor: Colors.black,
                colorScheme:
                ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);

        dateFormate =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
      });
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  List<String> timeList  = [
    "Hour",
    "Days"
  ];
  List<String> travelList = [
    "Local",
    "Nationwide",
    "Worldwide"
  ];
  List<String> languageList = [
    "English",
    "Italian",
    "Turkish",
    "Polish",
    "Indonesian",
    "Chinese/Manadarin",
    "Tagalog",
    "Japanese",
    "German",
    "Korean",
    "urdu",
    "Hindi",
    "French",
    "Portuguese",
    "Dutch",
    "Norwegian",
    "Arabic",
    "Chinese/Cantonese"
  ];
  String? selectedLanguage;
  String? selectedTravel;
  Future<ServiceCategoryModel?> getServiceCategory() async {
    // var userId = await MyToken.getUserID();
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '${Apipath.BASH_URL}get_categories_list',
        ));


    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return ServiceCategoryModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorBg1(),
      body: SafeArea(
        child: Form(
          key: _formKey,
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
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.only(top: 18.h),
                    width: 83.33.w,
                    // height: 65.05.h,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor().colorView().withOpacity(0.1),
                            blurRadius: 4,
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0)),
                    ),
                    child: firstSign(context),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(top: 115.h, bottom: 7.h),
                  //     child: InkWell(
                  //       onTap: () {
                  //         if (_formKey.currentState!.validate()) {
                  //           setState(() {
                  //             buttonLogin = true;
                  //           });
                  //           editProfile();
                  //         }
                  //       },
                  //       child: UtilityWidget.lodingButton(
                  //           buttonLogin: buttonLogin, btntext: 'Save'),
                  //     )),
                  Container(
                    height: 17.89.h,
                    width: 100.w,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 3.h),
                    decoration: BoxDecoration(
                      color: AppColor.PrimaryDark
                    ),
                    child: Row(
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
                          child: text("My Profile",
                              textColor: Color(0xffffffff),
                              fontSize: 14.sp,
                              fontFamily: fontMedium,
                              isCentered: true),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10.49.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        InkWell(
                          // onTap: () =>
                          //     getImage(context, ImgSource.Both, from: 1),
                          child: Container(
                            height: 14.66.h,
                            width: 14.66.h,
                            child: profilePic == null
                                ? ClipOval(
                                    child: UtilityHlepar.convertetIMG(
                                        // widget.response.path! +
                                            widget.response.user!.profileImage!
                                                .toString(),
                                        fit: BoxFit.cover),
                                  )
                                : ClipOval(
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.file(
                                        File(profilePic.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          height: 4.39.h,
                          width: 4.39.h,
                          margin: EdgeInsets.only(right: 2.w, bottom: 1.h),
                          decoration: boxDecoration(
                              radius: 100, bgColor: AppColor().colorPrimary()),
                          child: Center(
                            child: Image.asset(
                              edit,
                              height: 2.26.h,
                              width: 2.26.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  editProfile() async {
    var userid = await MyToken.getUserID();
    Map<String, String> tojson() => {
          "id": userid,
          // 'name': userNameController.text,
          // 'email': emailController.text,
          // 'mobile': phoneController.text,
          // "address": addressController.text,
          // 'country_id': selectedCountry.toString(),
          // 'state_id': selectedState.toString(),
          // 'city_id': selectedCities.toString(),
      "mobile": "${phoneController.text}",
      "name": "${nameController.text}",
      "email": "${emailController.text}",
      'country_id': selectedCountry.toString(),
      'state_id': selectedState.toString(),
      'city_id': SelectedSignleCity.toString(),
      "address": addressController.text,
      "can_travel": selectedTravel.toString(),
      "service_cities": cityIdList.toString(),
      "website": portfolioController.text,
      "t_link":twitterController.text,
      "i_link":instagramController.text,
      "l_link":linkedInController.text,
      "equipments":equipmentController.text,
      "birthday": dateFormate.toString(),
      "provide_services":comfertableServiceController.text,
      "join_antsnest": whyJoinController.text,
      "cat":selectedCategory.toString(),
      "sub_cat":selectedSubCategory.toString(),
      "hrs_day":selectedDayHour.toString(),
      "amount":amountController.text,
      "language":selectedLanguage.toString(),
        };
    print(tojson());
    var data = await MultipartHelper.requestOneImg(tojson(),
        url: Apipath.editProfile,
        img: profilePic != null ? profilePic.path : null);

    var Decodedata = json.decode(data);
    // print(data.toString());
    UtilityHlepar.getToast(Decodedata["message"]);
    Navigator.pop(context, "done");
    // print(decodeData["message"].toString());
  }

  void setFromField() async {
    nameController.text = widget.response.user!.uname.toString();
    // userLastNameController.text = widget.response.user!.lname.toString();
    emailController.text = widget.response.user!.email.toString();
    phoneController.text = widget.response.user!.mobile.toString();
    // aadharNumberController.text = widget.response.user!.aadharCardNo.toString();
    addressController.text = widget.response.user!.address.toString();
    // selectedCountry = widget.response.user!.countryId.toString();
    // selectedState = widget.response.user!.stateId.toString();
    // cityName = widget.response.user!.cityId.toString();
    // portfolioController.text = widget.response.user!.jsonData!.website.toString();
    // twitterController.text = widget.response.user!.jsonData!.tLink.toString();
    // instagramController.text = widget.response.user!.jsonData!.iLink.toString();
    // linkedInController.text = widget.response.user!.jsonData!.lLink.toString();
    // equipmentController.text = widget.response.user!.jsonData!.equipments.toString();
    // dateFormate = widget.response.user!.jsonData!.birthday.toString();
    // comfertableServiceController.text = widget.response.user!.jsonData!.provideServices.toString();
    // whyJoinController.text = widget.response.user!.jsonData!.joinAntsnest.toString();
    // selectedCategory = widget.response.user!.jsonData!.cat.toString();
    // selectedSubCategory = widget.response.user!.jsonData!.subCat.toString();
    // amountController.text = widget.response.user!.jsonData!.amount.toString();
    // selectedDayHour = widget.response.user!.jsonData!.hrsDay.toString();
    // selectedLanguage = widget.response.user!.jsonData!.language.toString();
    // selectedTravel = widget.response.user!.jsonData!.canTravel.toString();

    setState(() {});
   // print("checking birthday ${widget.response.user!.cityId.toString()} and ${widget.response.user!.stateId.toString()}");
  }

  Widget firstSign(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 9.92.h,
        ),
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    //validator: FormValidation.checkEmptyValidator,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                    ),
                    inputFormatters: [],
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'User Name',
                      labelStyle: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      helperText: '',
                      counterText: '',
                      fillColor: AppColor().colorEdit(),
                      enabled: true,
                      filled: true,
                      // prefixIcon: Container(
                      //   padding: EdgeInsets.all(3.5.w),
                      //   child: Image.asset(
                      //     person,
                      //     width: 1.04.w,
                      //     height: 1.04.w,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      suffixIcon: phoneController.text.length == 10
                          ? Container(
                              width: 10.w,
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.check,
                                color: AppColor().colorPrimary(),
                                size: 10.sp,
                              ))
                          : SizedBox(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(), width: 5.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 0.5.h,
                // ),
                // Container(
                //   width: 69.99.w,
                //   // height: 9.46.h,
                //   child: TextFormField(
                //     cursorColor: Colors.red,
                //     keyboardType: TextInputType.name,
                //     controller: userLastNameController,
                //     validator: FormValidation.checkEmptyValidator,
                //     style: TextStyle(
                //       color: AppColor().colorTextFour(),
                //       fontSize: 10.sp,
                //     ),
                //     inputFormatters: [],
                //     decoration: InputDecoration(
                //       focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: AppColor().colorEdit(),
                //             width: 1.0,
                //             style: BorderStyle.solid),
                //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       ),
                //       labelText: 'User Last Name',
                //       labelStyle: TextStyle(
                //         color: AppColor().colorTextFour(),
                //         fontSize: 10.sp,
                //       ),
                //       helperText: '',
                //       counterText: '',
                //       fillColor: AppColor().colorEdit(),
                //       enabled: true,
                //       filled: true,
                //       // prefixIcon: Container(
                //       //   padding: EdgeInsets.all(3.5.w),
                //       //   child: Image.asset(
                //       //     person,
                //       //     width: 1.04.w,
                //       //     height: 1.04.w,
                //       //     fit: BoxFit.fill,
                //       //   ),
                //       // ),
                //       suffixIcon: phoneController.text.length == 10
                //           ? Container(
                //           width: 10.w,
                //           alignment: Alignment.center,
                //           child: FaIcon(
                //             FontAwesomeIcons.check,
                //             color: AppColor().colorPrimary(),
                //             size: 10.sp,
                //           ))
                //           : SizedBox(),
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(
                //             color: AppColor().colorEdit(), width: 5.0),
                //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 0.5.h,
                ),
                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    cursorColor: Colors.red,
                    obscureText: false,
                    readOnly: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: FormValidation.emailVeledetion,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                    ),
                    inputFormatters: [],
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      helperText: '',
                      counterText: '',
                      fillColor: AppColor().colorEdit(),
                      enabled: true,
                      filled: true,
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.all(3.5.w),
                      //   child: Image.asset(
                      //     email,
                      //     width: 2.04.w,
                      //     height: 2.04.w,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      suffixIcon: phoneController.text.length == 10
                          ? Container(
                              width: 10.w,
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.check,
                                color: AppColor().colorPrimary(),
                                size: 10.sp,
                              ))
                          : SizedBox(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(), width: 5.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    maxLength: 10,
                    readOnly: true,
                    validator: FormValidation.validateMobile,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      helperText: '',
                      counterText: '',
                      fillColor: AppColor().colorEdit(),
                      enabled: true,
                       filled: true,
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.all(3.5.w),
                      //   child: Image.asset(
                      //     phone,
                      //     width: 2.04.w,
                      //     height: 2.04.w,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      suffixIcon: phoneController.text.length == 10
                          ? Container(
                              width: 10.w,
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.check,
                                color: AppColor().colorPrimary(),
                                size: 10.sp,
                              ))
                          : SizedBox(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(), width: 5.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Container(
                  width: 69.99.w,
                  // height: 9.46.h,
                  child: TextFormField(
                    validator: FormValidation.checkEmptyValidator,
                    cursorColor: Colors.red,
                    keyboardType: TextInputType.name,
                    controller: addressController,
                    style: TextStyle(
                      color: AppColor().colorTextFour(),
                      fontSize: 10.sp,
                    ),
                    inputFormatters: [],
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(),
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'Permanent Address',
                      labelStyle: TextStyle(
                        color: AppColor().colorTextFour(),
                        fontSize: 10.sp,
                      ),
                      helperText: '',
                      counterText: '',
                      fillColor: AppColor().colorEdit(),
                      enabled: true,
                      filled: true,
                      // prefixIcon: Padding(
                      //   padding: EdgeInsets.all(3.5.w),
                      //   child: Image.asset(
                      //     location,
                      //     width: 3.04.w,
                      //     height: 3.04.w,
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      suffixIcon: addressController.text.length == 10
                          ? Container(
                              width: 10.w,
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.check,
                                color: AppColor().colorPrimary(),
                                size: 10.sp,
                              ))
                          : SizedBox(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor().colorEdit(), width: 5.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                //COUNTRY
                Container(
                    width: 69.99.w,
                    // height: 7.46.h,
                    decoration: boxDecoration(
                      radius: 10.0,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: [
                            // Image.asset(
                            //   country,
                            //   width: 6.04.w,
                            //   height: 5.04.w,
                            //   fit: BoxFit.fill,
                            //   color: AppColor.PrimaryDark,
                            // ),
                            // SizedBox(
                            //   width: 4,
                            // ),
                            Expanded(
                              child: Text(
                               countryName == null|| countryName == 'null' ? 'Select Country' : ' $countryName',
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
                        value: selectedCountry,
                        onChanged: (value) {
                          setState(() {
                            selectedCountry = value as String;

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
                  height: 15,
                ),
                //STATE
                Container(
                    width: 69.99.w,
                    // height: 7.46.h,
                    decoration: boxDecoration(
                      radius: 10.0,
                    ),
                    child: FutureBuilder(
                        future: getState(),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    // Image.asset(
                                    //   city,
                                    //   width: 6.04.w,
                                    //   height: 5.04.w,
                                    //   fit: BoxFit.fill,
                                    //   color: AppColor.PrimaryDark,
                                    // ),
                                    // SizedBox(
                                    //   width: 4,
                                    // ),
                                    Expanded(
                                      child: Text(
                                        '$stateName',
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
                                value: selectedState,
                                onChanged: (value) {
                                  setState(() {
                                    selectedState = value as String;

                                    getCities();
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
                                  color: AppColor().colorEdit(),
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
                            );
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return Center(
                                child: CircularProgressIndicator());
                          }
                        })),
                SizedBox(
                  height: 20,
                ),
                // CITY
                // InkWell(
                //   onTap: (){
                //     _showMultiSelect();
                //   },
                //   child: Container(
                //       width: 70.99.w,
                //       height: 7.26.h,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: AppColor().colorEdit()
                //       ),
                //       // boxDecoration(
                //       //   radius: 10.0,
                //       // ),
                //       child: _selectedItems.isEmpty ?
                //       Padding(
                //         padding: const EdgeInsets.only(left: 10.0, right: 10),
                //         child: Row(
                //           children: [
                //             Image.asset(
                //               city,
                //               width: 6.04.w,
                //               height: 5.04.w,
                //               fit: BoxFit.fill,
                //               color: AppColor.PrimaryDark,
                //             ),
                //             Padding(
                //               padding: EdgeInsets.only(left: 8),
                //               child: Text(
                //                 'Select Multiple Cities',
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   color: Colors.black54,
                //                   fontWeight: FontWeight.normal,
                //                 ),
                //                 overflow: TextOverflow.ellipsis,
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //           :  Wrap(
                //         children: _selectedItems
                //             .map((item){
                //           print("okok ${item.id}");
                //           return Padding(
                //             padding: const EdgeInsets.only(left: 8.0, right: 8),
                //             child: Chip(
                //               label:
                //               Text(
                //                   "${item.name}"
                //                 //item.name
                //               ),
                //             ),
                //           );
                //         })
                //             .toList(),
                //       )
                //     // FutureBuilder(
                //     //     future: getCities(),
                //     //     builder: (BuildContext context,
                //     //         AsyncSnapshot snapshot) {
                //     //       if (snapshot.hasData) {
                //     //         return DropdownButtonHideUnderline(
                //     //           child: DropdownButton2(
                //     //             isExpanded: true,
                //     //             hint: Row(
                //     //               children: [
                //     //                 Image.asset(
                //     //                   city,
                //     //                   width: 6.04.w,
                //     //                   height: 5.04.w,
                //     //                   fit: BoxFit.fill,
                //     //                   color: AppColor.PrimaryDark,
                //     //                 ),
                //     //                 SizedBox(
                //     //                   width: 4,
                //     //                 ),
                //     //                 Expanded(
                //     //                   child: Text(
                //     //                     'Select Multiple Cities',
                //     //                     style: TextStyle(
                //     //                       fontSize: 14,
                //     //                       fontWeight: FontWeight.normal,
                //     //                     ),
                //     //                     overflow: TextOverflow.ellipsis,
                //     //                   ),
                //     //                 ),
                //     //               ],
                //     //             ),
                //     //             items: cityList.map((item) {
                //     //               return DropdownMenuItem<String>(
                //     //                 value: item.id,
                //     //                 enabled: false,
                //     //                 child: StatefulBuilder(
                //     //                   builder: (context, menuSetState) {
                //     //                     final _isSelected =
                //     //                         selectedCities
                //     //                             .contains(item);
                //     //                     print("SLECTED CITY");
                //     //                     return InkWell(
                //     //                       onTap: () {
                //     //                         _isSelected
                //     //                             ? selectedCities
                //     //                                 .remove(item.id)
                //     //                             : selectedCities
                //     //                                 .add(item.id!);
                //     //                         setState(() {});
                //     //                         menuSetState(() {});
                //     //                       },
                //     //                       child: Container(
                //     //                         height: double.infinity,
                //     //                         padding: const EdgeInsets
                //     //                                 .symmetric(
                //     //                             horizontal: 16.0),
                //     //                         child: Row(
                //     //                           children: [
                //     //                             _isSelected
                //     //                                 ? const Icon(Icons
                //     //                                     .check_box_outlined)
                //     //                                 : const Icon(Icons
                //     //                                     .check_box_outline_blank),
                //     //                             const SizedBox(
                //     //                                 width: 16),
                //     //                             Text(
                //     //                               item.name!,
                //     //                               style:
                //     //                                   const TextStyle(
                //     //                                 fontSize: 14,
                //     //                               ),
                //     //                             ),
                //     //                           ],
                //     //                         ),
                //     //                       ),
                //     //                     );
                //     //                   },
                //     //                 ),
                //     //               );
                //     //             }).toList(),
                //     //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                //     //             value: selectedCities.isEmpty
                //     //                 ? null
                //     //                 : selectedCities.last,
                //     //             onChanged: (value) {},
                //     //             buttonHeight: 50,
                //     //             buttonWidth: 160,
                //     //             buttonPadding: const EdgeInsets.only(
                //     //                 left: 14, right: 14),
                //     //             buttonDecoration: BoxDecoration(
                //     //               borderRadius:
                //     //                   BorderRadius.circular(14),
                //     //               color: Color(0xffF9F9F9),
                //     //             ),
                //     //             buttonElevation: 0,
                //     //             itemHeight: 40,
                //     //             itemPadding: const EdgeInsets.only(
                //     //                 left: 14, right: 14),
                //     //             dropdownMaxHeight: 300,
                //     //             dropdownPadding: null,
                //     //             dropdownDecoration: BoxDecoration(
                //     //               borderRadius:
                //     //                   BorderRadius.circular(14),
                //     //             ),
                //     //             dropdownElevation: 8,
                //     //             scrollbarRadius:
                //     //                 const Radius.circular(40),
                //     //             scrollbarThickness: 6,
                //     //             scrollbarAlwaysShow: true,
                //     //             selectedItemBuilder: (context) {
                //     //               return cityList.map(
                //     //                 (item) {
                //     //                   return Container(
                //     //                     // alignment: AlignmentDirectional.center,
                //     //                     padding:
                //     //                         const EdgeInsets.symmetric(
                //     //                             horizontal: 16.0),
                //     //                     child: Text(
                //     //                       selectedCities.join(','),
                //     //                       style: const TextStyle(
                //     //                         fontSize: 14,
                //     //                         overflow:
                //     //                             TextOverflow.ellipsis,
                //     //                       ),
                //     //                       maxLines: 1,
                //     //                     ),
                //     //                   );
                //     //                 },
                //     //               ).toList();
                //     //             },
                //     //           ),
                //     //         );
                //     //       } else if (snapshot.hasError) {
                //     //         return Icon(Icons.error_outline);
                //     //       } else {
                //     //         return Center(
                //     //             child: CircularProgressIndicator());
                //     //       }
                //     //     })
                //   ),
                // ),

                Container(
                  width: 80.99.w,
                  margin: EdgeInsets.symmetric(horizontal: 20),
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
                          // Image.asset(
                          //   city,
                          //   width: 6.04.w,
                          //   height: 5.04.w,
                          //   fit: BoxFit.fill,
                          //   color: AppColor.PrimaryDark,
                          // ),
                          // SizedBox(
                          //   width: 4,
                          // ),
                          Expanded(
                            child: Text(
                              cityName == null || cityName == "" ? 'Select City' :'${cityName}',
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
                      value: SelectedSignleCity,
                      onChanged: (value) {
                        setState(() {
                          SelectedSignleCity = value as String;

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
                        color: AppColor().colorEdit(),
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
                  height: 15,
                ),
                ///  portfolio / website
                Container(
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: portfolioController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Portfolio / Website",
                      label: Text(
                        "Portfolio / Website",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    // validator: (v) {
                    //   if (v!.isEmpty) {
                    //     return "Enter valid value";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                /// twitter link
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: twitterController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Twitter link",
                      label: Text(
                        "Twitter link",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    // validator: (v) {
                    //   if (v!.isEmpty) {
                    //     return "Enter valid value";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                /// instagram link
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: instagramController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Instagram link",
                      label: Text(
                        "Instagram link",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    // validator: (v) {
                    //   if (v!.isEmpty) {
                    //     return "";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: linkedInController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "LinkedIn link",
                      label: Text(
                        "LinkedIn link",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    // validator: (v) {
                    //   if (v!.isEmpty) {
                    //     return "Enter linkedIn link";
                    //   }
                    //   return null;
                    //},
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: equipmentController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Equipment used",
                      label: Text(
                        "Equipment used",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter equipment";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    _selectDate();
                  },
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                    decoration: BoxDecoration(
                        color: AppColor().colorEdit(),
                        borderRadius: BorderRadius.circular(12)),
                    child: dateFormate != null|| dateFormate != "" ? Text("${dateFormate}") : Text("Enter Birthday",style: TextStyle(color: AppColor().colorTextFour().withOpacity(0.7),fontSize: 15),),
                    // TextFormField(
                    //   controller: birthDayController,
                    //   decoration: InputDecoration(
                    //     contentPadding:
                    //     EdgeInsets.symmetric(horizontal: 10),
                    //     hintText: "dd/mm/yyyy",
                    //     label: Text(
                    //       "Enter Birthday",
                    //     ),
                    //     hintStyle: TextStyle(
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.w400),
                    //     border: InputBorder.none,
                    //   ),
                    //   validator: (v) {
                    //     if (v!.isEmpty) {
                    //       return "Enter your birthday";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.text,
                    // ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: comfertableServiceController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Enter your comfortable service",
                      label: Text(
                        "Comfortable service",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter service";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(
                    controller: whyJoinController,
                    decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Why want to join antsnest?",
                      label: Text(
                        "Why Antsnest",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter reason";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                                hint: Text(
                                  'Select Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                                    //color: Colors.grey.withOpacity(0.05)
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

                            return Icon(Icons.error_outline);
                          }
                          else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })),
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 80.99.w,
                    height: 7.46.h,
                    decoration: boxDecoration(
                      radius: 10.0,
                    ),
                    child:
                    FutureBuilder(
                        future: getServicesSubCategory(selectedCategory),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          ServiceSubCategoryModel Model = snapshot.data;
                          if (snapshot.hasData) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'Select Sub Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: Model.data!
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
                                value: selectedSubCategory,
                                onChanged: (value) {
                                  setState(() {
                                    selectedSubCategory = value as String;
                                    // // serviceName.text = serviceModel.data!
                                    //     .firstWhere((element) => element.id == value)
                                    //     .cName
                                    //     .toString();

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
                                    //color: Colors.grey.withOpacity(0.05)
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

                            return Icon(Icons.error_outline);
                          }
                          else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor().colorEdit(),
                      borderRadius: BorderRadius.circular(12)),
                  child: TextFormField(

                    controller: amountController,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Enter amount",
                      label: Text(
                        "Amount",
                      ),
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter amount";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 80.99.w,
                  height: 7.46.h,
                  decoration: boxDecoration(
                    radius: 10.0,
                  ),
                  child:DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'Select Hours / Day',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: timeList
                          .map((String? item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedDayHour,
                      onChanged: (value) {
                        setState(() {
                          selectedDayHour = value as String;
                          // // serviceName.text = serviceModel.data!
                          //     .firstWhere((element) => element.id == value)
                          //     .cName
                          //     .toString();

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
                         //color: Colors.grey.withOpacity(0.05)
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
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 80.99.w,
                  height: 7.46.h,
                  decoration: boxDecoration(
                    radius: 10.0,
                  ),
                  child:DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'Language(S) Spoken',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: languageList
                          .map((String? item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value as String;
                          // // serviceName.text = serviceModel.data!
                          //     .firstWhere((element) => element.id == value)
                          //     .cName
                          //     .toString();

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
                          // color: AppColor().colorEdit(),
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
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 80.99.w,
                  height: 7.46.h,
                  decoration: boxDecoration(
                    radius: 10.0,
                  ),
                  child:DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'Travel',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      items: travelList
                          .map((String? item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value:selectedTravel,
                      onChanged: (value) {
                        setState(() {
                          selectedTravel = value as String;
                          // // serviceName.text = serviceModel.data!
                          //     .firstWhere((element) => element.id == value)
                          //     .cName
                          //     .toString();

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
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    _showMultiSelect();
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: 80.99.w,
                      height: 7.46.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor().colorEdit(),
                      ),
                      // boxDecoration(
                      //   radius: 10.0,
                      // ),
                      child: _selectedItems.isEmpty ?
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              city,
                              width: 6.04.w,
                              height: 5.04.w,
                              fit: BoxFit.fill,
                              color: AppColor.PrimaryDark,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'Select Multiple Cities',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                          :  Wrap(
                        children: _selectedItems
                            .map((item){

                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Chip(
                              label:
                              Text(
                                  "${item.name}"
                                //item.name
                              ),
                            ),
                          );
                        })
                            .toList(),
                      )
                    // FutureBuilder(
                    //     future: getCities(),
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot snapshot) {
                    //       if (snapshot.hasData) {
                    //         return DropdownButtonHideUnderline(
                    //           child: DropdownButton2(
                    //             isExpanded: true,
                    //             hint: Row(
                    //               children: [
                    //                 Image.asset(
                    //                   city,
                    //                   width: 6.04.w,
                    //                   height: 5.04.w,
                    //                   fit: BoxFit.fill,
                    //                   color: AppColor.PrimaryDark,
                    //                 ),
                    //                 SizedBox(
                    //                   width: 4,
                    //                 ),
                    //                 Expanded(
                    //                   child: Text(
                    //                     'Select Multiple Cities',
                    //                     style: TextStyle(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.normal,
                    //                     ),
                    //                     overflow: TextOverflow.ellipsis,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             items: cityList.map((item) {
                    //               return DropdownMenuItem<String>(
                    //                 value: item.id,
                    //                 enabled: false,
                    //                 child: StatefulBuilder(
                    //                   builder: (context, menuSetState) {
                    //                     final _isSelected =
                    //                         selectedCities
                    //                             .contains(item);
                    //                     print("SLECTED CITY");
                    //                     return InkWell(
                    //                       onTap: () {
                    //                         _isSelected
                    //                             ? selectedCities
                    //                                 .remove(item.id)
                    //                             : selectedCities
                    //                                 .add(item.id!);
                    //                         setState(() {});
                    //                         menuSetState(() {});
                    //                       },
                    //                       child: Container(
                    //                         height: double.infinity,
                    //                         padding: const EdgeInsets
                    //                                 .symmetric(
                    //                             horizontal: 16.0),
                    //                         child: Row(
                    //                           children: [
                    //                             _isSelected
                    //                                 ? const Icon(Icons
                    //                                     .check_box_outlined)
                    //                                 : const Icon(Icons
                    //                                     .check_box_outline_blank),
                    //                             const SizedBox(
                    //                                 width: 16),
                    //                             Text(
                    //                               item.name!,
                    //                               style:
                    //                                   const TextStyle(
                    //                                 fontSize: 14,
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                 ),
                    //               );
                    //             }).toList(),
                    //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                    //             value: selectedCities.isEmpty
                    //                 ? null
                    //                 : selectedCities.last,
                    //             onChanged: (value) {},
                    //             buttonHeight: 50,
                    //             buttonWidth: 160,
                    //             buttonPadding: const EdgeInsets.only(
                    //                 left: 14, right: 14),
                    //             buttonDecoration: BoxDecoration(
                    //               borderRadius:
                    //                   BorderRadius.circular(14),
                    //               color: Color(0xffF9F9F9),
                    //             ),
                    //             buttonElevation: 0,
                    //             itemHeight: 40,
                    //             itemPadding: const EdgeInsets.only(
                    //                 left: 14, right: 14),
                    //             dropdownMaxHeight: 300,
                    //             dropdownPadding: null,
                    //             dropdownDecoration: BoxDecoration(
                    //               borderRadius:
                    //                   BorderRadius.circular(14),
                    //             ),
                    //             dropdownElevation: 8,
                    //             scrollbarRadius:
                    //                 const Radius.circular(40),
                    //             scrollbarThickness: 6,
                    //             scrollbarAlwaysShow: true,
                    //             selectedItemBuilder: (context) {
                    //               return cityList.map(
                    //                 (item) {
                    //                   return Container(
                    //                     // alignment: AlignmentDirectional.center,
                    //                     padding:
                    //                         const EdgeInsets.symmetric(
                    //                             horizontal: 16.0),
                    //                     child: Text(
                    //                       selectedCities.join(','),
                    //                       style: const TextStyle(
                    //                         fontSize: 14,
                    //                         overflow:
                    //                             TextOverflow.ellipsis,
                    //                       ),
                    //                       maxLines: 1,
                    //                     ),
                    //                   );
                    //                 },
                    //               ).toList();
                    //             },
                    //           ),
                    //         );
                    //       } else if (snapshot.hasError) {
                    //         return Icon(Icons.error_outline);
                    //       } else {
                    //         return Center(
                    //             child: CircularProgressIndicator());
                    //       }
                    //     })
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 7.h),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            buttonLogin = true;
                          });
                          editProfile();
                        }
                      },
                      child: UtilityWidget.lodingButton(
                          buttonLogin: buttonLogin, btntext: 'Save'),
                    )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 1.46.h,
        ),
        /*Container(
            margin: EdgeInsets.only(top: 90.h, bottom: 8.h),
            child: InkWell(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    buttonLogin = true;
                  });
                  editProfile();
                }
              },
              child: UtilityWidget.lodingButton(
                  buttonLogin: buttonLogin, btntext: 'Save'),
            )),*/
      ],
    );
  }

  // Future getImage(context, ImgSource source, {from}) async {

    // var image = await ImagePickerGC.pickImage(
    //     // enableCloseButton: true,
    //     // closeIcon: Icon(
    //     //   Icons.close,
    //     //   color: Colors.red,
    //     //   size: 12,
    //     // ),
    //     context: context,
    //     source: source,
    //     barrierDismissible: true,
    //     cameraIcon: Icon(
    //       Icons.camera_alt,
    //       color: Colors.red,
    //     ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    //     cameraText: Text(
    //       "From Camera",
    //       style: TextStyle(color: Colors.red),
    //     ),
    //     galleryText: Text(
    //       "From Gallery",
    //       style: TextStyle(color: Colors.blue),
    //     ));
  //   setState(() {
  //     profilePic = image;
  //   });
  // }

  Future getCountries() async {
    var request =
    http.Request('GET', Uri.parse('${Apipath.BASH_URL}get_countries'));
    http.StreamedResponse response = await request.send();

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

  Future getState() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_states'));
    request.fields.addAll({'country_id': '$selectedCountry'});
    http.StreamedResponse response = await request.send();

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

  Future getCities() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
    request.fields.addAll({'state_id': '$selectedState'});

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
}


class MultiSelect extends StatefulWidget {
  String selectedState;
  MultiSelect({Key? key, required this.selectedState}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();

}


class _MultiSelectState extends State<MultiSelect> {
  List <CityData>_selectedItems = [];
  // this variable holds the selected items

  List<CityData> cityList = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      }
      else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    List selectedItem = _selectedItems
        .map((item) => item.id).toList();
    // var map = {
    //   "itemIds" : selectedItem,
    //   "selectedItems" : _selectedItems
    // };
    // print("checking selected value ${_selectedItems} && ${selectedItem} && ${map}");
    Navigator.pop(context);
  }

  Future getCities() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.BASH_URL}get_cities'));
    request.fields.addAll({'state_id': '${widget.selectedState}'});

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
    getCities();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Multiple Cities'),
      content: SingleChildScrollView(
        child: ListBody(
          children: cityList
              .map((item) =>
              CheckboxListTile(
                value: _selectedItems.contains(item),
                title: Text(item.name!),
                controlAffinity: ListTileControlAffinity.leading,
                // onChanged: (isChecked) => _itemChange(item, isChecked!),
                onChanged: (isChecked){
                  setState(() {
                    if (isChecked!) {
                      setState((){
                        _selectedItems.add(item);
                      });


                    }
                    else {

                      setState((){
                        _selectedItems.remove(item);
                      });
                    }
                  });
                },
              )
          ).toList(),
        ),
      ),
      // FutureBuilder(
      //   future: getCities(),
      //   builder: (context, snapshot){
      //     if(snapshot.hasData) {
      //      return SingleChildScrollView(
      //         child: ListBody(
      //           children: cityList
      //               .map((item) =>
      //               CheckboxListTile(
      //                 value: _selectedItems.contains(item),
      //                 title: Text(item.name!),
      //                 controlAffinity: ListTileControlAffinity.leading,
      //                 onChanged: (isChecked) => _itemChange(item, isChecked!),
      //               ))
      //               .toList(),
      //         ),
      //       );
      //     }
      //     return Container(
      //       height: 30,
      //         width: 30,
      //         child: CircularProgressIndicator(
      //           color: AppColor().colorPrimary(),
      //         ));
      //   }
      // ),
      actions: [
        TextButton(
          child:  Text('Cancel',
            style: TextStyle(color: AppColor().colorPrimary()),),
          onPressed: _cancel,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: AppColor().colorPrimary()
          ),
          child:  Text('Submit'),
          onPressed: (){

            Navigator.pop(context,_selectedItems);
          }
          //     (){
          //   for(var i = 0 ; i< _selectedItems.length; i++){
          //     print(_selectedItems[i].id);
          //   }
          // }
          ,
        ),
      ],
    );
  }
}
