import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/api/api_helper/ApiList.dart';
import 'package:fixerking/new%20model/LoginEmailModel.dart';
import 'package:fixerking/new%20model/SendOtpModel.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar_delivery.dart';
import 'package:fixerking/screen/auth_view/forget_screen.dart';

import 'package:fixerking/screen/auth_view/registration.dart';
import 'package:fixerking/screen/auth_view/verify_otp.dart';
import 'package:fixerking/screen/auth_view/signup.dart';
import 'package:fixerking/screen/verify_otp.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:fixerking/utils/widget.dart';
import 'package:fixerking/validation/form_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_path.dart';
import '../../utils/images.dart';
import 'package:http/http.dart' as http;

import '../BottomBars/bottom_bar.dart';
import '../home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // final mobileController = TextEditingController();
  final codeController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? password, email, userid, message, userTocken, responseCode;
  // late int? otp;

  bool _isNetworkAvail = true;
  // Animation? buttonSqueezeanimation;
  // AnimationController? buttonController;

  int _value = 1;
  bool isMobile = false;
  bool isSendOtp = false;
  num? otp;
  bool isLoading = false;

  // Future<void> loginEmail() async {
  //   var headers = {
  //     'Cookie': 'ci_session=96413abf8905d3f80caa6dbe3e99b2426582bdb9'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('vendor_login'));
  //   request.fields.addAll({
  //     'email': 'rohit3@gmail.com',
  //     'password': '12345678'
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  void initState() {
    super.initState();
    getToken();
  }

  Future<LoginEmailModel?> loginEmail() async {
    // showDialog(context: context, builder: (context){
    //   return CustomLoader(text: "Verifying user, please wait...",);
    // });
    print("Api Working");
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.email_login}'));
    request.fields.addAll({
      'email': '${emailController.text}',
      'password': '${passwordController.text}',
      'fcm_id': '${token.toString()}'
    });
    print(request);
    print("this is new request =====>>> ${request.fields}");

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Working*******");
      final str = await response.stream.bytesToString();
      var results = LoginEmailModel.fromJson(json.decode(str));

      if (results.responseCode == "1") {
        setState((){
          isLoading = false;
        });
        print("vendor.....");
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String userId = results.userId!.id.toString();
        String type = results.userId!.roll.toString();
        String role = results.userId!.rollName.toString();
        String userPic = results.userId!.profileImage.toString();
        String userName = results.userId!.uname.toString();
        String walletBalance = results.userId!.wallet.toString();
        String referralCode = results.userId!.refferalCode.toString();
        String onOffStatus = results.userId!.onlineStatus.toString();
        String approvalStatus = results.userId!.status.toString();

        await prefs.setString(TokenString.userid, userId);
        await prefs.setString(TokenString.type, type);
        await prefs.setString(TokenString.roles, role);
        await prefs.setString(TokenString.userPic, userPic);
        await prefs.setString(TokenString.userName, userName);
        await prefs.setString(TokenString.walletBalance, walletBalance);
        await prefs.setString(TokenString.referralCode, referralCode);
        await prefs.setString(TokenString.onOffStatus, onOffStatus);
        await prefs.setString(TokenString.approvalStatus, approvalStatus);

        Fluttertoast.showToast(msg: "${results.message.toString()}");
        if (type == "2" || type == "3" || type == "4") {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomBarDelivery(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          setState((){
            isLoading = false;
          });
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomBar(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        setState((){
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${results.message.toString()}");
        // Fluttertoast.showToast(msg: "Wrong Email Password");
        // Fluttertoast.showToast(msg: "${otp.toString()}");
      }
      return LoginEmailModel.fromJson(json.decode(str));
    }
  }

  // Future<LoginMobileModel?> sendOtp () async {
  //   var headers = {
  //     'Cookie': 'ci_session=05ac37f409d655c30c1ca411738f61e5dad712f0'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${Apipath.v_send_otp}'));
  //   request.fields.addAll({
  //     'mobile': '${mobileController.text}'
  //   });
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     final str = await response.stream.bytesToString();
  //     var results = LoginEmailModel.fromJson(json.decode(str));
  //     // print("checking Result here ${otp.message}");
  //     String otp1 = results.otp.toString();
  //     print("OTP ${otp1.toString()}");
  //     // Fluttertoast.showToast("Otp Sent Successfully");
  //     // Navigator.push(
  //     //     context, MaterialPageRoute(builder: (context) => VerifyOtp()));
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  bool? Error;
  String? msg;

  sendOtp() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return CustomLoader(
    //         text: "Verifying user, please wait...",
    //       );
    //     });print(toMap());
    var response = await http.post(
        Uri.parse('${Apipath.sendOtpUrl}',),
        body: {"mobile": mobileController.text});
    print('resp=========>>>>>  ${Apipath.sendOtpUrl}');
    var result = SendOtpModel.fromJson(json.decode(response.body));

    msg = result.message;
    otp = result.otp;

    // otp = SendOtpModel.fromJson(json.decode(response.body)).otp;
    print("vvvvvvvOtp $otp");
    var snackBar = setSnackBar('${msg.toString()}');
    if(response.statusCode == 200) {
      if (result.responseCode == "1") {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    VerifyOtp(
                      otp: otp.toString(),
                      mobile: mobileController.text.toString(),
                    )));
        var snackBar = SnackBar(
          backgroundColor: AppColor().colorPrimary(),
          content: Text(
            '$msg',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return SendOtpModel.fromJson(json.decode(response.body));
  }

  Map toMap() {
    var map = <String, dynamic>{};
    map["mobile"] = mobileController.text.toString();
    return map;
  }

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
      return true;
    },
    child:
      SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColor.PrimaryDark,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'images/splash_bg.png',
                  // 'assets/images/login_logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/Splashscreen.png'))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 33,
                        color: AppColor().colorBg1(),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 1,
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          activeColor: AppColor().colorBg1(),
                          groupValue: _value,
                          onChanged: (int? value) {
                            setState(() {
                              _value = value!;
                              isMobile = false;
                            });
                          },
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                              color: AppColor().colorBg1(), fontSize: 18),
                        ),
                        Radio(
                            value: 2,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            activeColor: AppColor().colorBg1(),
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                isMobile = true;
                              });
                            }),
                        // SizedBox(width: 10.0,),
                        Text(
                          "Mobile No.",
                          style: TextStyle(
                              color: AppColor().colorBg1(), fontSize: 18),
                        ),
                      ],
                    ),
                    isMobile == false
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 20, left: 20, right: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: colors.whit,
                                      //Theme.of(context).colorScheme.gray,
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: emailController,
                                        validator:
                                            FormValidation.emailVeledetion,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Enter Email",
                                          // labelText: "Enter Email id",
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: AppColor.PrimaryDark,
                                            size: 24,
                                          ),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColor().colorBg1()),
                                    child: Center(
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: _isHidden ? true : false,
                                        keyboardType: TextInputType.text,
                                        validator: (msg) {
                                          if (msg!.isEmpty) {
                                            return "Please Enter Valid Password!";
                                          }
                                        },
                                        // maxLength: 10,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          counterText: "",
                                          contentPadding: EdgeInsets.only(
                                              left: 15, top: 15),
                                          hintText: "Password",
                                          // labelText: "Pass",
                                          prefixIcon: InkWell(
                                            onTap: _togglePasswordView,
                                            child: Icon(
                                              _isHidden
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: _isHidden
                                                  ? AppColor().colorPrimary()
                                                  : AppColor().colorSecondary(),
                                            ),
                                          ),
                                          // prefixIcon: Icon(Icons.lock),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgetScreen()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                color: AppColor().colorBg1(),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState((){
                                        isLoading = true;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        loginEmail();
                                      } else {
                                        setState((){
                                          isLoading =false;
                                        });
                                        Fluttertoast.showToast(
                                            msg:
                                            "Please Enter Correct Credentials!!");
                                      }
                                    },
                                    child: Container(
                                        height: 43,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
                                        child: isLoading ?
                                        loadingWidget():
                                        Center(child: Text("Sign In", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
                                    ),
                                  )
                                  // AppBtn(
                                  //   label: "Sign In",
                                  //   onPress: () {
                                  //     setState((){
                                  //       isLoading = true;
                                  //     });
                                  //     if (_formKey.currentState!.validate()) {
                                  //       loginEmail();
                                  //     } else {
                                  //       setState((){
                                  //         isLoading =false;
                                  //       });
                                  //       Fluttertoast.showToast(
                                  //           msg:
                                  //               "Please Enter Correct Credentials!!");
                                  //     }
                                  //   },
                                  // )
                                ],
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    isMobile == true
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: colors.whit,
                                //Theme.of(context).colorScheme.gray,
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: mobileController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    contentPadding:
                                        EdgeInsets.only(left: 15, top: 15),
                                    hintText: "Mobile Number",
                                    prefixIcon: Icon(
                                      Icons.call,
                                      color: AppColor().colorPrimary(),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                    isMobile == true
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 80, left: 20, right: 20),
                            child:

                            InkWell(
                              onTap: (){
                                setState((){
                                  isLoading = true;
                                });
                                if(mobileController.text.isNotEmpty && mobileController.text.length == 10){
                                  sendOtp();
                                }else{
                                  setState((){
                                    isLoading = false;
                                  });
                                  Fluttertoast.showToast(msg: "Please enter valid mobile number!");
                                }
                              },
                              child: Container(
                                  height: 43,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
                                  child: isLoading ?
                                      loadingWidget():
                                  Center(child: Text("Send OTP", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
                              ),
                            )

                            // AppBtn(
                            //   label: "Send OTP",
                            //   onPress: () {
                            //     setState((){
                            //       isLoading = true;
                            //     });
                            //     if(mobileController.text.isNotEmpty && mobileController.text.length == 10){
                            //     sendOtp();
                            //     }else{
                            //       Fluttertoast.showToast(msg: "Please enter valid mobile number!");
                            //     }
                            //   },
                            // )
                            // InkWell(
                            //   onTap: (){
                            //     sendOtp();
                            //   },
                            //   child: Container(
                            //       height: 48,
                            //       width:  MediaQuery.of(context).size.width/ 1.2,
                            //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor().colorBg1()),
                            //       child: Center(child: Text("Send OTP", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))),
                            // ),
                            )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColor().colorBg1(),
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          //   onTap: (){},
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: AppColor().colorBg1(),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()
                                  //     VendorRegisteration(
                                  //   role: "0",
                                  // ),
                                  ),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )
      );
  }
}
