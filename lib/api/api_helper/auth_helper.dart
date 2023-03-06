import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/api/api_services.dart';
import 'package:fixerking/modal/request/change_password_request.dart';
import 'package:fixerking/modal/request/forgot_password.dart';
import 'package:fixerking/modal/request/get_profile_request.dart';
import 'package:fixerking/modal/request/login_with_email.dart';
import 'package:fixerking/modal/request/login_with_phone.dart';
import 'package:fixerking/modal/request/sign_up_request.dart';
import 'package:fixerking/modal/request/specilization_list_request.dart';
import 'package:fixerking/modal/response/change_password_response.dart';
import 'package:fixerking/modal/response/forgot_password_response.dart';
import 'package:fixerking/modal/response/get_profile_response.dart';
import 'package:fixerking/modal/response/get_service_type_list.dart';
import 'package:fixerking/modal/response/login_email_response.dart';
import 'package:fixerking/modal/response/login_phone_response.dart';
import 'package:fixerking/modal/response/sign_up_response.dart';
import 'package:fixerking/modal/response/specilization_list_response.dart';
import 'package:fixerking/utils/utility_hlepar.dart';

class AuthApiHelper {
  // login with Email
  static Future<LoginEmailResponse> loginEmail(
      EmailLoginRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.email_login, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data['message']);
    return LoginEmailResponse.fromJson(data);
  }

  // login with Phone
  static Future<LoginPhoneResponse> loginPhone(
      PhoneLoginRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.phone_login, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data['message']);
    return LoginPhoneResponse.fromJson(data);
  }

  // forgot password
  static Future<ForgotPassResponse> forgotPassword(
      ForgotPasswordRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.forgot_password, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    UtilityHlepar.getToast(data['msg']);
    UtilityHlepar.getToast(data['new_pass']);
    return ForgotPassResponse.fromJson(data);
  }

  // Get Profile
  static Future<GetProfileResponse> getProfile(
      GetProfileRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.get_vebdor_profile, parameters: request.tojson());
    print(Apipath.get_vebdor_profile.toString());
    var data = jsonDecode(responsData.body);
    return GetProfileResponse.fromJson(data);
  }

  //get_services_type
  static Future<GetServiceTypeListResponse> getServicesType() async {
    var responsData = await ApiService.getAPI(path: Apipath.get_services_type);
    var data = jsonDecode(responsData.body);
    return GetServiceTypeListResponse.fromJson(data);
  }

  // Get Specilization List
  static Future<SpecilizationListResponse> getSpecilizationList(
      SpecilizationListRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.specilization_list, parameters: request.tojson());
    print("Request========= ${Apipath.specilization_list}");
    print("Parameter=== ${request.toString()}");
    var data = jsonDecode(responsData.body);
    return SpecilizationListResponse.fromJson(data);
  }

  //  Sign Up now
  static Future<SignUpResponse> signUpNow(SignUpRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.sign_up, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return SignUpResponse.fromJson(data);
  }

  //  Change Password
  static Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.changePassword, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return ChangePasswordResponse.fromJson(data);
  }
}
