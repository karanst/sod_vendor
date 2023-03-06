import 'dart:convert';
/// response_code : "0"
/// msg : "No plan purchased"
/// data : []

VerifyUserPlanModel verifyUserPlanModelFromJson(String str) => VerifyUserPlanModel.fromJson(json.decode(str));
String verifyUserPlanModelToJson(VerifyUserPlanModel data) => json.encode(data.toJson());
class VerifyUserPlanModel {
  VerifyUserPlanModel({
      String? responseCode, 
      String? msg, 
      List<dynamic>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  VerifyUserPlanModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<dynamic>? _data;
VerifyUserPlanModel copyWith({  String? responseCode,
  String? msg,
  List<dynamic>? data,
}) => VerifyUserPlanModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}