import 'dart:convert';
/// response_code : "1"
/// msg : "Latest posts"
/// data : [{"id":"6","user_id":"31","cat_id":"42","sub_cat_id":"58","note":"video editing","location":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101","date":"2022-10-15","budget":"865.00","status":"0","created_at":"2022-10-15 18:33:24","updated_at":"2022-10-15 18:33:24","rejected_by":null,"accepted_by":null},{"id":"4","user_id":"31","cat_id":"44","sub_cat_id":"62","note":"test service ","location":"G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101","date":"2022-10-15","budget":"440.00","status":"1","created_at":"2022-10-15 17:40:41","updated_at":"2022-10-15 18:43:58","rejected_by":null,"accepted_by":null},{"id":"3","user_id":"4","cat_id":"42","sub_cat_id":"58","note":"This is service request","location":"Indore, Madhya Pradesh, India, 452003","date":"2022-10-15","budget":"20000.00","status":"0","created_at":"2022-10-15 17:33:21","updated_at":"2022-10-15 17:33:21","rejected_by":null,"accepted_by":null},{"id":"2","user_id":"4","cat_id":"42","sub_cat_id":"58","note":"This is service request","location":"Indore, Madhya Pradesh, India, 452003","date":"2022-10-15","budget":"20000.00","status":"0","created_at":"2022-10-15 17:03:54","updated_at":"2022-10-15 17:03:54","rejected_by":null,"accepted_by":null},{"id":"1","user_id":"4","cat_id":"42","sub_cat_id":"58","note":"This is service request","location":"Indore, Madhya Pradesh, India, 452003","date":"2022-10-15","budget":"20000.00","status":"0","created_at":"2022-10-15 16:58:35","updated_at":"2022-10-15 16:58:35","rejected_by":null,"accepted_by":null}]

LatestPostModel latestPostModelFromJson(String str) => LatestPostModel.fromJson(json.decode(str));
String latestPostModelToJson(LatestPostModel data) => json.encode(data.toJson());
class LatestPostModel {
  LatestPostModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  LatestPostModel.fromJson(dynamic json) {
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
LatestPostModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => LatestPostModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "6"
/// user_id : "31"
/// cat_id : "42"
/// sub_cat_id : "58"
/// note : "video editing"
/// location : "G2, Plot No 83, Scheme No 53, near Medanta Hospital, Vijay Nagar, Indore, Madhya Pradesh 452010, India, 101"
/// date : "2022-10-15"
/// budget : "865.00"
/// status : "0"
/// created_at : "2022-10-15 18:33:24"
/// updated_at : "2022-10-15 18:33:24"
/// rejected_by : null
/// accepted_by : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      String? catId, 
      String? subCatId, 
      String? note, 
      String? location, 
      String? date, 
      String? budget, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      dynamic rejectedBy, 
      dynamic acceptedBy,}){
    _id = id;
    _userId = userId;
    _catId = catId;
    _subCatId = subCatId;
    _note = note;
    _location = location;
    _date = date;
    _budget = budget;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _rejectedBy = rejectedBy;
    _acceptedBy = acceptedBy;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _catId = json['cat_id'];
    _subCatId = json['sub_cat_id'];
    _note = json['note'];
    _location = json['location'];
    _date = json['date'];
    _budget = json['budget'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _rejectedBy = json['rejected_by'];
    _acceptedBy = json['accepted_by'];
  }
  String? _id;
  String? _userId;
  String? _catId;
  String? _subCatId;
  String? _note;
  String? _location;
  String? _date;
  String? _budget;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  dynamic _rejectedBy;
  dynamic _acceptedBy;
Data copyWith({  String? id,
  String? userId,
  String? catId,
  String? subCatId,
  String? note,
  String? location,
  String? date,
  String? budget,
  String? status,
  String? createdAt,
  String? updatedAt,
  dynamic rejectedBy,
  dynamic acceptedBy,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  catId: catId ?? _catId,
  subCatId: subCatId ?? _subCatId,
  note: note ?? _note,
  location: location ?? _location,
  date: date ?? _date,
  budget: budget ?? _budget,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  rejectedBy: rejectedBy ?? _rejectedBy,
  acceptedBy: acceptedBy ?? _acceptedBy,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get catId => _catId;
  String? get subCatId => _subCatId;
  String? get note => _note;
  String? get location => _location;
  String? get date => _date;
  String? get budget => _budget;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get rejectedBy => _rejectedBy;
  dynamic get acceptedBy => _acceptedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['cat_id'] = _catId;
    map['sub_cat_id'] = _subCatId;
    map['note'] = _note;
    map['location'] = _location;
    map['date'] = _date;
    map['budget'] = _budget;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['rejected_by'] = _rejectedBy;
    map['accepted_by'] = _acceptedBy;
    return map;
  }

}