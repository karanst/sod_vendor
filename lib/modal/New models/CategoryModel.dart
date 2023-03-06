/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"13","c_name":" Photographers","c_name_a":"","icon":"6329b2c9b99bf.jpg","img":"6329b2c9b93e9.jpg","type":"","p_id":"0"},{"id":"14","c_name":"fashion designers","c_name_a":"","icon":"6329b47de7823.png","img":"6329b47de7396.png","type":"","p_id":"0"},{"id":"15","c_name":"make-up","c_name_a":"","icon":"6329b4fc96c58.jpg","img":"6329b4fc967b3.png","type":"","p_id":"0"},{"id":"18","c_name":" Hair Stylist","c_name_a":"","icon":"6329b597d62e2.jpg","img":"6329b57d83184.png","type":"","p_id":"0"},{"id":"28","c_name":"shoes designers","c_name_a":"","icon":"632ea1aa6eebb.jpeg","img":"632ea1aa6d3be.jpeg","type":"","p_id":"0"}]

class CategoryModel {
  CategoryModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CategoryModel.fromJson(dynamic json) {
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
CategoryModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => CategoryModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "13"
/// c_name : " Photographers"
/// c_name_a : ""
/// icon : "6329b2c9b99bf.jpg"
/// img : "6329b2c9b93e9.jpg"
/// type : ""
/// p_id : "0"

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