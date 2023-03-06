import 'dart:convert';
/// response_code : "1"
/// message : "Remove Successfully"
/// status : "success"

RemoveServiceModel removeServiceModelFromJson(String str) => RemoveServiceModel.fromJson(json.decode(str));
String removeServiceModelToJson(RemoveServiceModel data) => json.encode(data.toJson());
class RemoveServiceModel {
  RemoveServiceModel({
      String? responseCode, 
      String? message, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
}

  RemoveServiceModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
RemoveServiceModel copyWith({  String? responseCode,
  String? message,
  String? status,
}) => RemoveServiceModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }

}