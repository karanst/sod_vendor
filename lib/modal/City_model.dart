import 'dart:convert';
/// response_code : "1"
/// msg : "City List"
/// data : [{"id":"2","name":"Indore","country_id":"5","state_id":"2","created_at":"2022-09-28 17:57:21","updated_at":"2022-09-28 17:57:21"}]

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));
String cityModelToJson(CityModel data) => json.encode(data.toJson());
class CityModel {
  CityModel({
      String? responseCode, 
      String? msg, 
      List<CityData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CityModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CityData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<CityData>? _data;
CityModel copyWith({  String? responseCode,
  String? msg,
  List<CityData>? data,
}) => CityModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<CityData>? get data => _data;

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

/// id : "2"
/// name : "Indore"
/// country_id : "5"
/// state_id : "2"
/// created_at : "2022-09-28 17:57:21"
/// updated_at : "2022-09-28 17:57:21"

CityData dataFromJson(String str) => CityData.fromJson(json.decode(str));
String dataToJson(CityData data) => json.encode(data.toJson());
class CityData {
  CityData({
      String? id, 
      String? name, 
      String? countryId, 
      String? stateId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _countryId = countryId;
    _stateId = stateId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CityData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _countryId;
  String? _stateId;
  String? _createdAt;
  String? _updatedAt;
  CityData copyWith({  String? id,
  String? name,
  String? countryId,
  String? stateId,
  String? createdAt,
  String? updatedAt,
}) => CityData(  id: id ?? _id,
  name: name ?? _name,
  countryId: countryId ?? _countryId,
  stateId: stateId ?? _stateId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get countryId => _countryId;
  String? get stateId => _stateId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}