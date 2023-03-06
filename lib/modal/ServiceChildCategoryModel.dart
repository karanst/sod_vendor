import 'dart:convert';
/// response_code : "1"
/// message : "get Succesfully"
/// status : [{"id":"1","child_name":"new cat","c_name":"60","subc_name":"35","image":"6246d1e6b0b27.jpg"}]
/// img_path : "http://fixerking.com/Admin/uploads/category_sub_cat/"

ServiceChildCategoryModel serviceChildCategoryModelFromJson(String str) => ServiceChildCategoryModel.fromJson(json.decode(str));
String serviceChildCategoryModelToJson(ServiceChildCategoryModel data) => json.encode(data.toJson());
class ServiceChildCategoryModel {
  ServiceChildCategoryModel({
      String? responseCode, 
      String? message, 
      List<Status>? status, 
      String? imgPath,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _imgPath = imgPath;
}

  ServiceChildCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['status'] != null) {
      _status = [];
      json['status'].forEach((v) {
        _status?.add(Status.fromJson(v));
      });
    }
    _imgPath = json['img_path'];
  }
  String? _responseCode;
  String? _message;
  List<Status>? _status;
  String? _imgPath;
ServiceChildCategoryModel copyWith({  String? responseCode,
  String? message,
  List<Status>? status,
  String? imgPath,
}) => ServiceChildCategoryModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  imgPath: imgPath ?? _imgPath,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  List<Status>? get status => _status;
  String? get imgPath => _imgPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_status != null) {
      map['status'] = _status?.map((v) => v.toJson()).toList();
    }
    map['img_path'] = _imgPath;
    return map;
  }

}

/// id : "1"
/// child_name : "new cat"
/// c_name : "60"
/// subc_name : "35"
/// image : "6246d1e6b0b27.jpg"

Status statusFromJson(String str) => Status.fromJson(json.decode(str));
String statusToJson(Status data) => json.encode(data.toJson());
class Status {
  Status({
      String? id, 
      String? childName, 
      String? cName, 
      String? subcName, 
      String? image,}){
    _id = id;
    _childName = childName;
    _cName = cName;
    _subcName = subcName;
    _image = image;
}

  Status.fromJson(dynamic json) {
    _id = json['id'];
    _childName = json['child_name'];
    _cName = json['c_name'];
    _subcName = json['subc_name'];
    _image = json['image'];
  }
  String? _id;
  String? _childName;
  String? _cName;
  String? _subcName;
  String? _image;
Status copyWith({  String? id,
  String? childName,
  String? cName,
  String? subcName,
  String? image,
}) => Status(  id: id ?? _id,
  childName: childName ?? _childName,
  cName: cName ?? _cName,
  subcName: subcName ?? _subcName,
  image: image ?? _image,
);
  String? get id => _id;
  String? get childName => _childName;
  String? get cName => _cName;
  String? get subcName => _subcName;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['child_name'] = _childName;
    map['c_name'] = _cName;
    map['subc_name'] = _subcName;
    map['image'] = _image;
    return map;
  }

}