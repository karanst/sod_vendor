import 'dart:convert';
/// response_code : "1"
/// msg : "Membership plans"
/// data : [{"id":"1","title":"Pro Membership","description":"Pro Membership","price":"1000.00","time":"28","type":"1","image":"","created_at":"2022-09-28 11:11:06","updated_at":"2022-09-28 11:11:06","time_text":"28 Days","plan_type":"Days"},{"id":"2","title":"Premium membership","description":"Premium membership","price":"10000.00","time":"3","type":"2","image":"","created_at":"2022-09-28 11:11:06","updated_at":"2022-09-28 11:11:06","time_text":"3 Months","plan_type":"Monthly"},{"id":"7","title":"gf","description":"fgj","price":"400.00","time":"2","type":"2","image":"6334028573694.jpeg","created_at":"2022-09-28 13:45:01","updated_at":"2022-09-28 13:45:01","time_text":"2 Months","plan_type":"Monthly"}]

PlansModel plansModelFromJson(String str) => PlansModel.fromJson(json.decode(str));
String plansModelToJson(PlansModel data) => json.encode(data.toJson());
class PlansModel {
  PlansModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  PlansModel.fromJson(dynamic json) {
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
PlansModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => PlansModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "1"
/// title : "Pro Membership"
/// description : "Pro Membership"
/// price : "1000.00"
/// time : "28"
/// type : "1"
/// image : ""
/// created_at : "2022-09-28 11:11:06"
/// updated_at : "2022-09-28 11:11:06"
/// time_text : "28 Days"
/// plan_type : "Days"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      int? price,
      String? time, 
      String? type, 
      String? image, 
      String? createdAt, 
      String? updatedAt, 
      String? timeText, 
      String? planType,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _time = time;
    _type = type;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _timeText = timeText;
    _planType = planType;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _time = json['time'];
    _type = json['type'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timeText = json['time_text'];
    _planType = json['plan_type'];
  }
  String? _id;
  String? _title;
  String? _description;
  int? _price;
  String? _time;
  String? _type;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _timeText;
  String? _planType;
Data copyWith({  String? id,
  String? title,
  String? description,
  int? price,
  String? time,
  String? type,
  String? image,
  String? createdAt,
  String? updatedAt,
  String? timeText,
  String? planType,
}) => Data(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  time: time ?? _time,
  type: type ?? _type,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  timeText: timeText ?? _timeText,
  planType: planType ?? _planType,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  int? get price => _price;
  String? get time => _time;
  String? get type => _type;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timeText => _timeText;
  String? get planType => _planType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['time'] = _time;
    map['type'] = _type;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['time_text'] = _timeText;
    map['plan_type'] = _planType;
    return map;
  }

}