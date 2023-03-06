import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/api/api_services.dart';
import 'package:fixerking/modal/request/accept_reject_request.dart';
import 'package:fixerking/modal/request/customer_support_request.dart';
import 'package:fixerking/modal/request/get_new_order_request.dart';
import 'package:fixerking/modal/request/get_service_profile_request.dart';
import 'package:fixerking/modal/request/i_am_online_request.dart';
import 'package:fixerking/modal/request/notification_request.dart';
import 'package:fixerking/modal/request/order_status_request.dart';
import 'package:fixerking/modal/request/payment_history_request.dart';
import 'package:fixerking/modal/request/request_for_payment_request.dart';
import 'package:fixerking/modal/request/update_service_request.dart';
import 'package:fixerking/modal/request/work_complete_request.dart';
import 'package:fixerking/modal/response/accept_reject_response.dart';
import 'package:fixerking/modal/response/customer_support_response.dart';
import 'package:fixerking/modal/response/get_faq_response.dart';
import 'package:fixerking/modal/response/get_new_order_response.dart';
import 'package:fixerking/modal/response/get_service_profile_response.dart';
import 'package:fixerking/modal/response/i_am_online_response.dart';
import 'package:fixerking/modal/response/notification_response.dart';
import 'package:fixerking/modal/response/payment_history_response.dart';
import 'package:fixerking/modal/response/request_for_payment_response.dart';
import 'package:fixerking/modal/response/total_payment_response.dart';
import 'package:fixerking/modal/response/update_order_status_response.dart';
import 'package:fixerking/modal/response/update_service_profile_response.dart';
import 'package:fixerking/modal/response/work_done_response.dart';

import '../../modal/VendorOrderModel.dart';

class HomeApiHelper {
//  Get Home New orders
  static Future<VendorOrderModel> getNewOrder(
      GetNewOrderRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.get_new_order, parameters: request.tojson());
    print("djkfvkjfv======== ${responsData}");
    var data = jsonDecode(responsData.body);
    return VendorOrderModel.fromJson(data);
  }

  // Accept Reject Booking Status
  static Future<AcceptRejectResponse> acceptReject(
      AcceptRejectRequest request) async {
    print("ACCEPT PARAM====== ${request.toString()}");
    var responsData = await ApiService.postAPI(
        path: Apipath.accept_reject_booking_status,
        parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return AcceptRejectResponse.fromJson(data);
  }

  // update new order Status
  // static Future<UpdateStatusResponse> updateOrderStatus(
  //     OrderStatusRequest request) async {
  //   var responsData = await ApiService.postAPI(
  //       path: Apipath.booking_status_change_by_vendor,
  //       parameters: request.tojson());
  //   var data = jsonDecode(responsData.body);
  //   return UpdateStatusResponse.fromJson(data);
  // }

  // Work Completed Status
  static Future<WorkDoneResponse> workCompletedStatus(
      WorkDoneRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.completed_Work, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return WorkDoneResponse.fromJson(data);
  }

  //  Get Notification
  static Future<NotificationResponse> getNotification(
      NotificationRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.notification, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return NotificationResponse.fromJson(data);
  }

  //  customer support
  static Future<CustomerSupportResponse> customerSupport(
      CustomerSupportRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.customer_support, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return CustomerSupportResponse.fromJson(data);
  }

  //  Get Faq
  static Future<GetFaqResponse> getFaq() async {
    var responsData = await ApiService.getAPI(path: Apipath.get_faq);
    var data = jsonDecode(responsData.body);
    return GetFaqResponse.fromJson(data);
  }

  //  Payment History
  static Future<PaymentHistoryResponse> getPaymentHistory(
      PaymentHistoryRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.payment_history, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return PaymentHistoryResponse.fromJson(data);
  }

  //  Get total payment
  static Future<TotalPaymentResponse> gettotalPayment(
      PaymentHistoryRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.get_payment_total, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return TotalPaymentResponse.fromJson(data);
  }

  //  Request For Payment
  static Future<RequestForPaymentResponse> requestForPayment(
      RequestForPaymentRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.request_for_payment, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return RequestForPaymentResponse.fromJson(data);
  }

  //  I am online
  static Future<IamOnlineResponse> iamOnline(IamOnlineRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.i_am_online, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return IamOnlineResponse.fromJson(data);
  }

  //  Get Service Profile
  static Future<ServiceProfileResponse> getServiceProfile(
      ServiceProfileRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.get_service_profile, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return ServiceProfileResponse.fromJson(data);
  }

  //  update service profile
  static Future<UpdateServiceProfileResponse> updateServiceProfile(
      UpdateServiceRequest request) async {
    var responsData = await ApiService.postAPI(
        path: Apipath.update_service_profile, parameters: request.tojson());
    var data = jsonDecode(responsData.body);
    return UpdateServiceProfileResponse.fromJson(data);
  }
}
