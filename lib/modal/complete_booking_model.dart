import 'dart:convert';
/// response_code : "1"
/// msg : "Booking completed success"

CompleteBookingModel completeBookingModelFromJson(String str) => CompleteBookingModel.fromJson(json.decode(str));
String completeBookingModelToJson(CompleteBookingModel data) => json.encode(data.toJson());
class CompleteBookingModel {
  CompleteBookingModel({
      String? responseCode, 
      String? msg,}){
    _responseCode = responseCode;
    _msg = msg;
}

  CompleteBookingModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
  }
  String? _responseCode;
  String? _msg;
CompleteBookingModel copyWith({  String? responseCode,
  String? msg,
}) => CompleteBookingModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    return map;
  }

}