import 'dart:convert';
/// response_code : "1"
/// msg : "Plan purchased success"
/// data : []

PurchasePlanModel purchasePlanModelFromJson(String str) => PurchasePlanModel.fromJson(json.decode(str));
String purchasePlanModelToJson(PurchasePlanModel data) => json.encode(data.toJson());
class PurchasePlanModel {
  PurchasePlanModel({
      String? responseCode, 
      String? msg, 
      List<dynamic>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  PurchasePlanModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v);
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<dynamic>? _data;
PurchasePlanModel copyWith({  String? responseCode,
  String? msg,
  List<dynamic>? data,
}) => PurchasePlanModel(  responseCode: responseCode ?? _responseCode,
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