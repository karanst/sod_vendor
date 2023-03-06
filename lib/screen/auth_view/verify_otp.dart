import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/LoginWithOtpModel.dart';
import 'package:fixerking/modal/verifyOtpModel.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar_delivery.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VerifyOtp extends StatefulWidget {
  String? otp;
  String? mobile;
  VerifyOtp({this.otp, this.mobile});

  // final otp, email;
  //  final bool signUp;
  //  VerifyOtp({Key? key, this.otp, this.email, required this.signUp}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  var apiOtp;
  var inputOtp;
  // ProgressDialog? pr;

  final pinController = TextEditingController();
  final focusNode = FocusNode();

  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  String? resendOtp;
  String? userRole;
  bool isLoading = false;

  Future<LoginWithOtpModel?> loginWithOtp() async {

    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.sendOtpUrl}'));
    request.fields.addAll({
      'mobile': '${widget.mobile}',
      // 'device_token': ''
    });

    http.StreamedResponse response = await request.send();

    print(request);
    print(request.fields);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      var results = LoginWithOtpModel.fromJson(json.decode(str));
      print("checking result here ${results.message} and ${results.otp} and  ${results}");
      if(results.responseCode =="1"){
        Fluttertoast.showToast(msg: "${results.message}");
        setState(() {
          resendOtp = results.otp.toString();
        });
      }else{
        Fluttertoast.showToast(msg: "${results.message}");
      }

      return LoginWithOtpModel.fromJson(json.decode(str));
    }
    else {
      print("checking fail response ${response.statusCode}");

    }
  }

  @override
  Widget build(BuildContext context) {
    var focusedBorderColor = AppColor().colorBg1();
    var fillColor = AppColor().colorPrimary();
    var borderColor = AppColor().colorBg1();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.PrimaryDark,
        leading:   InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 15),
              child: Icon(Icons.arrow_back_ios,color: AppColor().colorBg1(),),
            )),
          title: Text("Verification"),
        centerTitle: true,
      ),
      // appBar: AppBar(
      //   backgroundColor: AppColor().colorBg1(),
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: Text("Verification",style: TextStyle(color: AppColor().colorPrimary()),),
      //   leading: InkWell(
      //     onTap: (){
      //       Navigator.of(context).pop();
      //     },
      //     child: Container(
      //       child: Icon(Icons.arrow_back_ios,color: AppColor().colorPrimary(),),
      //     ),
      //   ),
      // ),
      backgroundColor: AppColor().colorPrimary(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'images/welcome_icon.png'
              ),
              fit: BoxFit.contain
          ),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 80,
            ),
            Text(
              "Code has sent to",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor().colorBg1(),
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),

            SizedBox(height: 9,),
            Text(
              "+91${widget.mobile}",
              style: TextStyle(
                  color: AppColor().colorBg1(),
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller: pinController,
                focusNode: focusNode,
                androidSmsAutofillMethod:
                AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                // validator: (value) {
                //   return value == '' ? null : 'Please Enter Pin';
                // },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            SizedBox(height: 20,),

            Text(
              resendOtp == null || resendOtp == ""?
              "${widget.otp.toString()}"
              : "${resendOtp.toString()}",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColor().colorBg1()
            ),),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text(
                  "Haven't received the verification code? ",
                  style: TextStyle(
                      color: AppColor().colorBg1(),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                  // textAlign: TextAlign.center,
                ),
                // Text("${widget.otp}")
                TextButton(
                  onPressed: (){
                    loginWithOtp();
                  },
                  child: Text(
                    "Resend",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                        color: AppColor().colorBg1(),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                ),],
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child:
              InkWell(
                onTap: (){
                  setState((){
                    isLoading = true;
                  });
                  verifyOTP();
                },
                child: Container(
                    height: 43,
                    width:  MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
                    child: isLoading ?
                        loadingWidget()
                  :  Center(child: Text("Verify Authentication Code", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
                ),
              )

              // AppBtn(
              //   label: "Verify Authentication Code",
              //   onPress: (){
              //     verifyOTP();
              //   },
              // )

            ),
          ],
        ),
      ),
    );
  }

  Future verifyOTP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // showDialog(context: context, builder: (context){
    //   return CustomLoader(text: "Verifying user, please wait...",);
    // });
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.verifyOtpUrl}'));
    request.fields.addAll({
      'mobile': '${widget.mobile}',
      'otp': '${pinController.text.toString()}',
      'fcm_id': '${token.toString()}'
    });
    print("this is @@@@@ ${request.fields.toString()}");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = VerifyOtpModel.fromJson(json.decode(str));
      print("sdssssdd ${jsonResponse}");
      if(jsonResponse.responseCode == "1"){

        String userId = jsonResponse.userId!.id.toString();
        String type = jsonResponse.userId!.roll.toString();
        String role = jsonResponse.userId!.rollName.toString();
        String userPic = jsonResponse.userId!.profileImage.toString();
        String userName = jsonResponse.userId!.uname.toString();
        String walletBalance = jsonResponse.userId!.wallet.toString();
        String referralCode = jsonResponse.userId!.refferalCode.toString();
        String onOffStatus = jsonResponse.userId!.onlineStatus.toString();

        await prefs.setString(TokenString.userid, userId);
        await prefs.setString(TokenString.type, type);
        await prefs.setString(TokenString.roles, role);
        await prefs.setString(TokenString.userPic, userPic);
        await prefs.setString(TokenString.userName, userName);
        await prefs.setString(TokenString.walletBalance, walletBalance);
        await prefs.setString(TokenString.referralCode, referralCode);
        await prefs.setString(TokenString.onOffStatus, onOffStatus);

        setState((){
          isLoading = false;
        });
        Fluttertoast.showToast(msg: '${jsonResponse.message.toString()}');

        if(type == "2" || type == "3" || type =="4"){
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomBarDelivery(),
            ),
                (Route<dynamic> route) => false,
          );
        }else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomBar(),
            ),
                (Route<dynamic> route) => false);
        }
        // }
      }else{
        setState((){
          isLoading = false;
        });
        Fluttertoast.showToast(msg: '${jsonResponse.message.toString()}');
      }
      return VerifyOtpModel.fromJson(json.decode(str));
    }
    else {
    print(response.reasonPhrase);
    }

  }
}

//   String? userid;
//   verifyUser()async{
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     showDialog(context: context, builder: (context){
//       return CustomLoader(text: "Verifying user, please wait...",);
//     });
//     var response = await http.post(Uri.parse('${Apipath.verifyOtpUrl}'),
//         body: {"mobile":"${widget.email}","otp": widget.otp});
//     print("response of verify user ${response.body}");
//     var finalStr = VerifyUserModel.fromJson(json.decode(response.body));
//     String? msg = VerifyUserModel.fromJson(json.decode(response.body)).message;
//     if(finalStr.status == "success"){
//       setState(() {
//         userid = finalStr.userId;
//       });
//       // SharedPreferences prefs = await SharedPreferences.getInstance();
//       // await prefs.setString(TokenString.userid, userid!);
//       // prefs.setString("vendorId", "${userid}");
//       // String? uid = prefs.getString("vendorId");
//       // print("checking vendor id here ${uid}");
//       Navigator.of(context).pop();
//       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomBar()), (route) => false);
//     }
//     else{
//       Navigator.of(context).pop();
//       const snackBar = SnackBar(
//         backgroundColor: colors.green,
//         content: Text('Invalid otp') ,
//       );
// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }


class SharedPreferencesKey {
  static const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";
  static const String LOGGED_IN_USERRDATA = "LOGGED_IN_USERRDATA";
}