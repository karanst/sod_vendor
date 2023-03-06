/// response_code : "1"
/// msg : "Categories Found"
/// data : [{"id":"99","c_name":"Mehndi","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Mehndi","description":"Mehndi","img":"https://developmentalphawizz.com/SOD_New//uploads/63b2e07dcb498.jpg","type":"vip","p_id":"0","service_type":"6"},{"id":"100","c_name":"Haldi","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Haldi","description":"Haldi","img":"https://developmentalphawizz.com/SOD_New//uploads/63b2e0af1233c.jpg","type":"vip","p_id":"0","service_type":"6"},{"id":"101","c_name":"Anniversary","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Anniversary","description":"Anniversary","img":"https://developmentalphawizz.com/SOD_New//uploads/63b2e105cf590.jpg","type":"vip","p_id":"0","service_type":"6"},{"id":"102","c_name":"Ring Ceremony","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Ring Ceremony","description":"Ring Ceremony","img":"https://developmentalphawizz.com/SOD_New//uploads/63b2e1724a31d.jpg","type":"vip","p_id":"0","service_type":"6"},{"id":"104","c_name":"Demo","c_name_a":"","icon":"https://developmentalphawizz.com/SOD_New//uploads/","sub_title":"Documents","description":"create-service","img":"https://developmentalphawizz.com/SOD_New//uploads/63b6de2470acc.jpg","type":"vip","p_id":"0","service_type":"6"}]

class EventCategoryModel {
  EventCategoryModel({
      String? responseCode, 
      String? msg, 
      List<Categories>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  EventCategoryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Categories.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Categories>? _data;
EventCategoryModel copyWith({  String? responseCode,
  String? msg,
  List<Categories>? data,
}) => EventCategoryModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Categories>? get data => _data;

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

/// id : "99"
/// c_name : "Mehndi"
/// c_name_a : ""
/// icon : "https://developmentalphawizz.com/SOD_New//uploads/"
/// sub_title : "Mehndi"
/// description : "Mehndi"
/// img : "https://developmentalphawizz.com/SOD_New//uploads/63b2e07dcb498.jpg"
/// type : "vip"
/// p_id : "0"
/// service_type : "6"

class Categories {
  Categories({
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

  Categories.fromJson(dynamic json) {
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
Categories copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  String? subTitle,
  String? description,
  String? img,
  String? type,
  String? pId,
  String? serviceType,
}) => Categories(  id: id ?? _id,
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