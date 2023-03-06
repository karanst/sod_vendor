import 'dart:convert';
/// response_code : "1"
/// message : "get Succesfully"
/// status : [{"model_id":"1","cat_id":"2","sub_cat_id":"2","child_Id":"2","model_name":"33 w ac"}]
/// img_path : "http://fixerking.com/Admin/uploads/category_sub_cat/"

ModelCategoryModel modelCategoryModelFromJson(String str) => ModelCategoryModel.fromJson(json.decode(str));
String modelCategoryModelToJson(ModelCategoryModel data) => json.encode(data.toJson());
class ModelCategoryModel {
  ModelCategoryModel({
      String? responseCode, 
      String? message, 
      List<Status>? status, 
      String? imgPath,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _imgPath = imgPath;
}

  ModelCategoryModel.fromJson(dynamic json) {
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
ModelCategoryModel copyWith({  String? responseCode,
  String? message,
  List<Status>? status,
  String? imgPath,
}) => ModelCategoryModel(  responseCode: responseCode ?? _responseCode,
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

/// model_id : "1"
/// cat_id : "2"
/// sub_cat_id : "2"
/// child_Id : "2"
/// model_name : "33 w ac"

Status statusFromJson(String str) => Status.fromJson(json.decode(str));
String statusToJson(Status data) => json.encode(data.toJson());
class Status {
  Status({
      String? modelId, 
      String? catId, 
      String? subCatId, 
      String? childId, 
      String? modelName,}){
    _modelId = modelId;
    _catId = catId;
    _subCatId = subCatId;
    _childId = childId;
    _modelName = modelName;
}

  Status.fromJson(dynamic json) {
    _modelId = json['model_id'];
    _catId = json['cat_id'];
    _subCatId = json['sub_cat_id'];
    _childId = json['child_Id'];
    _modelName = json['model_name'];
  }
  String? _modelId;
  String? _catId;
  String? _subCatId;
  String? _childId;
  String? _modelName;
Status copyWith({  String? modelId,
  String? catId,
  String? subCatId,
  String? childId,
  String? modelName,
}) => Status(  modelId: modelId ?? _modelId,
  catId: catId ?? _catId,
  subCatId: subCatId ?? _subCatId,
  childId: childId ?? _childId,
  modelName: modelName ?? _modelName,
);
  String? get modelId => _modelId;
  String? get catId => _catId;
  String? get subCatId => _subCatId;
  String? get childId => _childId;
  String? get modelName => _modelName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model_id'] = _modelId;
    map['cat_id'] = _catId;
    map['sub_cat_id'] = _subCatId;
    map['child_Id'] = _childId;
    map['model_name'] = _modelName;
    return map;
  }

}