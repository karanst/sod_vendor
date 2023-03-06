/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"88","c_name":"Indian Mehndi design","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Indian Mehndi design","description":"Indian Mehndi design","img":"https://developmentalphawizz.com/SOD_New//uploads/63ac4842241fb.jpg","type":"vip","p_id":"0","service_type":"1"},{"id":"89","c_name":"Bakery products","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Bakery products","description":"Bakery products","img":"https://developmentalphawizz.com/SOD_New//uploads/63aeb9c31ba06.jpg","type":"vip","p_id":"0","service_type":"1"},{"id":"90","c_name":"Fruits and vegetables","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Fruits and vegetables","description":"Fruits and vegetables","img":"https://developmentalphawizz.com/SOD_New//uploads/63aeba48166f0.jpg","type":"vip","p_id":"0","service_type":"1"},{"id":"91","c_name":"Meat and meat products","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Meat and meat products","description":"Meat and meat products","img":"https://developmentalphawizz.com/SOD_New//uploads/63aeba973da38.jpeg","type":"vip","p_id":"0","service_type":"1"},{"id":"92","c_name":"Fish and fish products","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Fish and fish products","description":"Fish and fish products","img":"https://developmentalphawizz.com/SOD_New//uploads/63aebaf7048d1.jpg","type":"vip","p_id":"0","service_type":"1"},{"id":"93","c_name":"Eggs and egg products","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Eggs and egg products","description":"\t\r\nEggs and egg products","img":"https://developmentalphawizz.com/SOD_New//uploads/63aebb33604ab.jpg","type":"vip","p_id":"0","service_type":"1"},{"id":"94","c_name":"Beverages","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Beverages","description":"Beverages","img":"https://developmentalphawizz.com/SOD_New//uploads/63aebb6cc2ff9.jpg","type":"vip","p_id":"0","service_type":"1"},{"id":"95","c_name":"protein products","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"protein products","description":"protein products","img":"https://developmentalphawizz.com/SOD_New//uploads/63aebbb9b4719.jpg","type":"vip","p_id":"0","service_type":"1"}]

class CategoriesModel {
  CategoriesModel({
      String? responseCode, 
      String? msg, 
      List<Category>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  CategoriesModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Category.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Category>? _data;
CategoriesModel copyWith({  String? responseCode,
  String? msg,
  List<Category>? data,
}) => CategoriesModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Category>? get data => _data;

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

/// id : "88"
/// c_name : "Indian Mehndi design"
/// c_name_a : ""
/// icon : "https://developmentalphawizz.com/SOD_New//uploads/"
/// sub_title : "Indian Mehndi design"
/// description : "Indian Mehndi design"
/// img : "https://developmentalphawizz.com/SOD_New//uploads/63ac4842241fb.jpg"
/// type : "vip"
/// p_id : "0"
/// service_type : "1"

class Category {
  Category({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      String? subTitle, 
      String? description, 
      String? img, 
      String? type, 
      String? pId, 
      String? serviceType,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _type = type;
    _pId = pId;
    _serviceType = serviceType;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
    _serviceType = json['service_type'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  String? _icon;
  String? _subTitle;
  String? _description;
  String? _img;
  String? _type;
  String? _pId;
  String? _serviceType;
Category copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  String? subTitle,
  String? description,
  String? img,
  String? type,
  String? pId,
  String? serviceType,
}) => Category(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
  serviceType: serviceType ?? _serviceType,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  String? get subTitle => _subTitle;
  String? get description => _description;
  String? get img => _img;
  String? get type => _type;
  String? get pId => _pId;
  String? get serviceType => _serviceType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['service_type'] = _serviceType;
    return map;
  }
}


/// status : "0"
/// message : "Get Data"
/// data : [{"id":"1","name":"Half Plate","status":""},{"id":"2","name":"Full Plate","status":""}]

class ProductVarientModel {
  ProductVarientModel({
    String? status,
    String? message,
    List<Varients>? data,}){
    _status = status;
    _message = message;
    _data = data;
  }

  ProductVarientModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Varients.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Varients>? _data;
  ProductVarientModel copyWith({  String? status,
    String? message,
    List<Varients>? data,
  }) => ProductVarientModel(  status: status ?? _status,
    message: message ?? _message,
    data: data ?? _data,
  );
  String? get status => _status;
  String? get message => _message;
  List<Varients>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "Half Plate"
/// status : ""

class Varients {
  Varients({
    String? id,
    String? name,
    String? status,}){
    _id = id;
    _name = name;
    _status = status;
  }

  Varients.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
  }
  String? _id;
  String? _name;
  String? _status;
  Varients copyWith({  String? id,
    String? name,
    String? status,
  }) => Varients(  id: id ?? _id,
    name: name ?? _name,
    status: status ?? _status,
  );
  String? get id => _id;
  String? get name => _name;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    return map;
  }

}

