import 'dart:convert';
/// response_code : "1"
/// message : "get Succesfully"
/// status : {"id":"48","cat_id":"10","subcat_id":"4","childcat_id":"3","res_id":"35","v_id":"147","service_name":"tap","service_price":"100","service_description":"Good service ","service_image":"63230606b9ea6.jpg","price_unit":"","duration":"","service_ratings":"0.0","created_date":"2022-09-15 04:06:51","service_fees":"1360","service_time":"01:30 ","per_minite_price":"14","final_charge":"0","model":"8","issue":"Leakage","convenience_fee":"0"}

VisitChargeModel visitChargeModelFromJson(String str) => VisitChargeModel.fromJson(json.decode(str));
String visitChargeModelToJson(VisitChargeModel data) => json.encode(data.toJson());
class VisitChargeModel {
  VisitChargeModel({
      String? responseCode, 
      String? message, 
      Status? status,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
}

  VisitChargeModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }
  String? _responseCode;
  String? _message;
  Status? _status;
VisitChargeModel copyWith({  String? responseCode,
  String? message,
  Status? status,
}) => VisitChargeModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  Status? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    return map;
  }

}

/// id : "48"
/// cat_id : "10"
/// subcat_id : "4"
/// childcat_id : "3"
/// res_id : "35"
/// v_id : "147"
/// service_name : "tap"
/// service_price : "100"
/// service_description : "Good service "
/// service_image : "63230606b9ea6.jpg"
/// price_unit : ""
/// duration : ""
/// service_ratings : "0.0"
/// created_date : "2022-09-15 04:06:51"
/// service_fees : "1360"
/// service_time : "01:30 "
/// per_minite_price : "14"
/// final_charge : "0"
/// model : "8"
/// issue : "Leakage"
/// convenience_fee : "0"

Status statusFromJson(String str) => Status.fromJson(json.decode(str));
String statusToJson(Status data) => json.encode(data.toJson());
class Status {
  Status({
      String? id, 
      String? catId, 
      String? subcatId, 
      String? childcatId, 
      String? resId, 
      String? vId, 
      String? serviceName, 
      String? servicePrice, 
      String? serviceDescription, 
      String? serviceImage, 
      String? priceUnit, 
      String? duration, 
      String? serviceRatings, 
      String? createdDate, 
      String? serviceFees, 
      String? serviceTime, 
      String? perMinitePrice, 
      String? finalCharge, 
      String? model, 
      String? issue, 
      String? convenienceFee,}){
    _id = id;
    _catId = catId;
    _subcatId = subcatId;
    _childcatId = childcatId;
    _resId = resId;
    _vId = vId;
    _serviceName = serviceName;
    _servicePrice = servicePrice;
    _serviceDescription = serviceDescription;
    _serviceImage = serviceImage;
    _priceUnit = priceUnit;
    _duration = duration;
    _serviceRatings = serviceRatings;
    _createdDate = createdDate;
    _serviceFees = serviceFees;
    _serviceTime = serviceTime;
    _perMinitePrice = perMinitePrice;
    _finalCharge = finalCharge;
    _model = model;
    _issue = issue;
    _convenienceFee = convenienceFee;
}

  Status.fromJson(dynamic json) {
    _id = json['id'];
    _catId = json['cat_id'];
    _subcatId = json['subcat_id'];
    _childcatId = json['childcat_id'];
    _resId = json['res_id'];
    _vId = json['v_id'];
    _serviceName = json['service_name'];
    _servicePrice = json['service_price'];
    _serviceDescription = json['service_description'];
    _serviceImage = json['service_image'];
    _priceUnit = json['price_unit'];
    _duration = json['duration'];
    _serviceRatings = json['service_ratings'];
    _createdDate = json['created_date'];
    _serviceFees = json['service_fees'];
    _serviceTime = json['service_time'];
    _perMinitePrice = json['per_minite_price'];
    _finalCharge = json['final_charge'];
    _model = json['model'];
    _issue = json['issue'];
    _convenienceFee = json['convenience_fee'];
  }
  String? _id;
  String? _catId;
  String? _subcatId;
  String? _childcatId;
  String? _resId;
  String? _vId;
  String? _serviceName;
  String? _servicePrice;
  String? _serviceDescription;
  String? _serviceImage;
  String? _priceUnit;
  String? _duration;
  String? _serviceRatings;
  String? _createdDate;
  String? _serviceFees;
  String? _serviceTime;
  String? _perMinitePrice;
  String? _finalCharge;
  String? _model;
  String? _issue;
  String? _convenienceFee;
Status copyWith({  String? id,
  String? catId,
  String? subcatId,
  String? childcatId,
  String? resId,
  String? vId,
  String? serviceName,
  String? servicePrice,
  String? serviceDescription,
  String? serviceImage,
  String? priceUnit,
  String? duration,
  String? serviceRatings,
  String? createdDate,
  String? serviceFees,
  String? serviceTime,
  String? perMinitePrice,
  String? finalCharge,
  String? model,
  String? issue,
  String? convenienceFee,
}) => Status(  id: id ?? _id,
  catId: catId ?? _catId,
  subcatId: subcatId ?? _subcatId,
  childcatId: childcatId ?? _childcatId,
  resId: resId ?? _resId,
  vId: vId ?? _vId,
  serviceName: serviceName ?? _serviceName,
  servicePrice: servicePrice ?? _servicePrice,
  serviceDescription: serviceDescription ?? _serviceDescription,
  serviceImage: serviceImage ?? _serviceImage,
  priceUnit: priceUnit ?? _priceUnit,
  duration: duration ?? _duration,
  serviceRatings: serviceRatings ?? _serviceRatings,
  createdDate: createdDate ?? _createdDate,
  serviceFees: serviceFees ?? _serviceFees,
  serviceTime: serviceTime ?? _serviceTime,
  perMinitePrice: perMinitePrice ?? _perMinitePrice,
  finalCharge: finalCharge ?? _finalCharge,
  model: model ?? _model,
  issue: issue ?? _issue,
  convenienceFee: convenienceFee ?? _convenienceFee,
);
  String? get id => _id;
  String? get catId => _catId;
  String? get subcatId => _subcatId;
  String? get childcatId => _childcatId;
  String? get resId => _resId;
  String? get vId => _vId;
  String? get serviceName => _serviceName;
  String? get servicePrice => _servicePrice;
  String? get serviceDescription => _serviceDescription;
  String? get serviceImage => _serviceImage;
  String? get priceUnit => _priceUnit;
  String? get duration => _duration;
  String? get serviceRatings => _serviceRatings;
  String? get createdDate => _createdDate;
  String? get serviceFees => _serviceFees;
  String? get serviceTime => _serviceTime;
  String? get perMinitePrice => _perMinitePrice;
  String? get finalCharge => _finalCharge;
  String? get model => _model;
  String? get issue => _issue;
  String? get convenienceFee => _convenienceFee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cat_id'] = _catId;
    map['subcat_id'] = _subcatId;
    map['childcat_id'] = _childcatId;
    map['res_id'] = _resId;
    map['v_id'] = _vId;
    map['service_name'] = _serviceName;
    map['service_price'] = _servicePrice;
    map['service_description'] = _serviceDescription;
    map['service_image'] = _serviceImage;
    map['price_unit'] = _priceUnit;
    map['duration'] = _duration;
    map['service_ratings'] = _serviceRatings;
    map['created_date'] = _createdDate;
    map['service_fees'] = _serviceFees;
    map['service_time'] = _serviceTime;
    map['per_minite_price'] = _perMinitePrice;
    map['final_charge'] = _finalCharge;
    map['model'] = _model;
    map['issue'] = _issue;
    map['convenience_fee'] = _convenienceFee;
    return map;
  }

}