import 'dart:convert';
/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"33","c_name":"wedding photo shoot","c_name_a":"","icon":"632ecd2e7222b.jpeg","img":"632ecd2e71abf.jpeg","type":"vip","p_id":"13"},{"id":"34","c_name":"birthday photo shoot","c_name_a":"","icon":"6331835fa7710.png","img":"6331835fa6619.png","type":"vip","p_id":"13"}]

ServiceSubCategoryModel serviceSubCategoryModelFromJson(String str) => ServiceSubCategoryModel.fromJson(json.decode(str));
String serviceSubCategoryModelToJson(ServiceSubCategoryModel data) => json.encode(data.toJson());
class ServiceSubCategoryModel {
  ServiceSubCategoryModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  ServiceSubCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
ServiceSubCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => ServiceSubCategoryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

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

/// id : "33"
/// c_name : "wedding photo shoot"
/// c_name_a : ""
/// icon : "632ecd2e7222b.jpeg"
/// img : "632ecd2e71abf.jpeg"
/// type : "vip"
/// p_id : "13"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      String? img, 
      String? type, 
      String? pId,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _img = img;
    _type = type;
    _pId = pId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  String? _icon;
  String? _img;
  String? _type;
  String? _pId;
Data copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  String? img,
  String? type,
  String? pId,
}) => Data(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  String? get img => _img;
  String? get type => _type;
  String? get pId => _pId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['img'] = _img;
    map['type'] = _type;
    map['p_id'] = _pId;
    return map;
  }

}