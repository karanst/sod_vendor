import 'dart:convert';
/// response_code : "1"
/// msg : "Country List"
/// data : [{"id":"5","name":"India","created_at":"2022-09-28 17:53:21","updated_at":"2022-09-28 17:53:21"}]

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));
String countryModelToJson(CountryModel data) => json.encode(data.toJson());
class CountryModel {
  CountryModel({
      String? responseCode, 
      String? msg, 
      List<CountryData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CountryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CountryData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<CountryData>? _data;
CountryModel copyWith({  String? responseCode,
  String? msg,
  List<CountryData>? data,
}) => CountryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<CountryData>? get data => _data;

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

/// id : "5"
/// name : "India"
/// created_at : "2022-09-28 17:53:21"
/// updated_at : "2022-09-28 17:53:21"

CountryData dataFromJson(String str) => CountryData.fromJson(json.decode(str));
String dataToJson(CountryData data) => json.encode(data.toJson());
class CountryData {
  CountryData({
      String? id, 
      String? name, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  CountryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  CountryData copyWith({  String? id,
  String? name,
  String? createdAt,
  String? updatedAt,
}) => CountryData(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}