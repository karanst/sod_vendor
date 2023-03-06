import 'dart:convert';
/// response_code : "1"
/// msg : "State List"
/// data : [{"id":"2","name":"Madhya Pardesh","country_id":"5","created_at":"2022-09-28 17:53:49","updated_at":"2022-09-28 18:15:40"},{"id":"3","name":"Maharastra","country_id":"5","created_at":"2022-09-28 18:49:51","updated_at":"2022-09-28 18:49:51"}]

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));
String stateModelToJson(StateModel data) => json.encode(data.toJson());
class StateModel {
  StateModel({
      String? responseCode, 
      String? msg, 
      List<StateData>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  StateModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(StateData.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<StateData>? _data;
StateModel copyWith({  String? responseCode,
  String? msg,
  List<StateData>? data,
}) => StateModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<StateData>? get data => _data;

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
/// name : "Madhya Pardesh"
/// country_id : "5"
/// created_at : "2022-09-28 17:53:49"
/// updated_at : "2022-09-28 18:15:40"

StateData dataFromJson(String str) => StateData.fromJson(json.decode(str));
String dataToJson(StateData data) => json.encode(data.toJson());
class StateData {
  StateData({
      String? id, 
      String? name, 
      String? countryId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _countryId = countryId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  StateData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _name;
  String? _countryId;
  String? _createdAt;
  String? _updatedAt;
  StateData copyWith({  String? id,
  String? name,
  String? countryId,
  String? createdAt,
  String? updatedAt,
}) => StateData(  id: id ?? _id,
  name: name ?? _name,
  countryId: countryId ?? _countryId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get countryId => _countryId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}