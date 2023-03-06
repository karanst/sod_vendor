/// response_code : "1"
/// message : "Delivery found"
/// status : "success"
/// data : [{"id":"1","pickup_location":" 83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","drop_location":" 201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India","vehicle_type":"3","date":"2022-11-16","time":"03:30:00","category_id":"79","sub_category_id":"82","height":" 200","length":" 300","unit":" kg","weight":" 20","pickup_lat":" 22.7484868","pickup_lng":" 75.8977327","drop_lat":" 22.746151526100977","drop_lng":" 75.90965900570154","status":"0","driver_id":null,"user_id":"118","rejected_by":null,"created_at":"2022-11-14 13:15:32","updated_at":"2022-11-14 13:15:32","delivery_charge":"150","sub_total":"150.00","tax_amount":"27.00","total":"177.00","distance":"0.003477794975765226"},{"id":"2","pickup_location":"83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","drop_location":"201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India","vehicle_type":"3","date":"2022-11-16","time":"03:30:00","category_id":"79","sub_category_id":"82","height":"200","length":"300","unit":"kg","weight":"20","pickup_lat":"22.7484868","pickup_lng":"75.8977327","drop_lat":"22.746151526100977","drop_lng":"75.90965900570154","status":"0","driver_id":null,"user_id":"118","rejected_by":null,"created_at":"2022-11-14 13:15:50","updated_at":"2022-11-14 13:15:50","delivery_charge":"150","sub_total":"150.00","tax_amount":"27.00","total":"177.00","distance":"0.003477794975765226"}]

class NearestDeliveryModel {
  NearestDeliveryModel({
      String? responseCode, 
      String? message, 
      String? status, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
}

  NearestDeliveryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _message;
  String? _status;
  List<Data>? _data;
NearestDeliveryModel copyWith({  String? responseCode,
  String? message,
  String? status,
  List<Data>? data,
}) => NearestDeliveryModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// pickup_location : " 83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India"
/// drop_location : " 201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India"
/// vehicle_type : "3"
/// date : "2022-11-16"
/// time : "03:30:00"
/// category_id : "79"
/// sub_category_id : "82"
/// height : " 200"
/// length : " 300"
/// unit : " kg"
/// weight : " 20"
/// pickup_lat : " 22.7484868"
/// pickup_lng : " 75.8977327"
/// drop_lat : " 22.746151526100977"
/// drop_lng : " 75.90965900570154"
/// status : "0"
/// driver_id : null
/// user_id : "118"
/// rejected_by : null
/// created_at : "2022-11-14 13:15:32"
/// updated_at : "2022-11-14 13:15:32"
/// delivery_charge : "150"
/// sub_total : "150.00"
/// tax_amount : "27.00"
/// total : "177.00"
/// distance : "0.003477794975765226"

class Data {
  Data({
      String? id, 
      String? pickupLocation, 
      String? dropLocation, 
      String? vehicleType, 
      String? date, 
      String? time, 
      String? categoryId, 
      String? subCategoryId, 
      String? height, 
      String? length, 
      String? unit, 
      String? weight, 
      String? pickupLat, 
      String? pickupLng, 
      String? dropLat, 
      String? dropLng, 
      String? status, 
      dynamic driverId, 
      String? userId, 
      dynamic rejectedBy, 
      String? createdAt, 
      String? updatedAt, 
      String? deliveryCharge, 
      String? subTotal, 
      String? taxAmount, 
      String? total, 
      String? distance,}){
    _id = id;
    _pickupLocation = pickupLocation;
    _dropLocation = dropLocation;
    _vehicleType = vehicleType;
    _date = date;
    _time = time;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _height = height;
    _length = length;
    _unit = unit;
    _weight = weight;
    _pickupLat = pickupLat;
    _pickupLng = pickupLng;
    _dropLat = dropLat;
    _dropLng = dropLng;
    _status = status;
    _driverId = driverId;
    _userId = userId;
    _rejectedBy = rejectedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deliveryCharge = deliveryCharge;
    _subTotal = subTotal;
    _taxAmount = taxAmount;
    _total = total;
    _distance = distance;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _pickupLocation = json['pickup_location'];
    _dropLocation = json['drop_location'];
    _vehicleType = json['vehicle_type'];
    _date = json['date'];
    _time = json['time'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _height = json['height'];
    _length = json['length'];
    _unit = json['unit'];
    _weight = json['weight'];
    _pickupLat = json['pickup_lat'];
    _pickupLng = json['pickup_lng'];
    _dropLat = json['drop_lat'];
    _dropLng = json['drop_lng'];
    _status = json['status'];
    _driverId = json['driver_id'];
    _userId = json['user_id'];
    _rejectedBy = json['rejected_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deliveryCharge = json['delivery_charge'];
    _subTotal = json['sub_total'];
    _taxAmount = json['tax_amount'];
    _total = json['total'];
    _distance = json['distance'];
  }
  String? _id;
  String? _pickupLocation;
  String? _dropLocation;
  String? _vehicleType;
  String? _date;
  String? _time;
  String? _categoryId;
  String? _subCategoryId;
  String? _height;
  String? _length;
  String? _unit;
  String? _weight;
  String? _pickupLat;
  String? _pickupLng;
  String? _dropLat;
  String? _dropLng;
  String? _status;
  dynamic _driverId;
  String? _userId;
  dynamic _rejectedBy;
  String? _createdAt;
  String? _updatedAt;
  String? _deliveryCharge;
  String? _subTotal;
  String? _taxAmount;
  String? _total;
  String? _distance;
Data copyWith({  String? id,
  String? pickupLocation,
  String? dropLocation,
  String? vehicleType,
  String? date,
  String? time,
  String? categoryId,
  String? subCategoryId,
  String? height,
  String? length,
  String? unit,
  String? weight,
  String? pickupLat,
  String? pickupLng,
  String? dropLat,
  String? dropLng,
  String? status,
  dynamic driverId,
  String? userId,
  dynamic rejectedBy,
  String? createdAt,
  String? updatedAt,
  String? deliveryCharge,
  String? subTotal,
  String? taxAmount,
  String? total,
  String? distance,
}) => Data(  id: id ?? _id,
  pickupLocation: pickupLocation ?? _pickupLocation,
  dropLocation: dropLocation ?? _dropLocation,
  vehicleType: vehicleType ?? _vehicleType,
  date: date ?? _date,
  time: time ?? _time,
  categoryId: categoryId ?? _categoryId,
  subCategoryId: subCategoryId ?? _subCategoryId,
  height: height ?? _height,
  length: length ?? _length,
  unit: unit ?? _unit,
  weight: weight ?? _weight,
  pickupLat: pickupLat ?? _pickupLat,
  pickupLng: pickupLng ?? _pickupLng,
  dropLat: dropLat ?? _dropLat,
  dropLng: dropLng ?? _dropLng,
  status: status ?? _status,
  driverId: driverId ?? _driverId,
  userId: userId ?? _userId,
  rejectedBy: rejectedBy ?? _rejectedBy,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  subTotal: subTotal ?? _subTotal,
  taxAmount: taxAmount ?? _taxAmount,
  total: total ?? _total,
  distance: distance ?? _distance,
);
  String? get id => _id;
  String? get pickupLocation => _pickupLocation;
  String? get dropLocation => _dropLocation;
  String? get vehicleType => _vehicleType;
  String? get date => _date;
  String? get time => _time;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  String? get height => _height;
  String? get length => _length;
  String? get unit => _unit;
  String? get weight => _weight;
  String? get pickupLat => _pickupLat;
  String? get pickupLng => _pickupLng;
  String? get dropLat => _dropLat;
  String? get dropLng => _dropLng;
  String? get status => _status;
  dynamic get driverId => _driverId;
  String? get userId => _userId;
  dynamic get rejectedBy => _rejectedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deliveryCharge => _deliveryCharge;
  String? get subTotal => _subTotal;
  String? get taxAmount => _taxAmount;
  String? get total => _total;
  String? get distance => _distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pickup_location'] = _pickupLocation;
    map['drop_location'] = _dropLocation;
    map['vehicle_type'] = _vehicleType;
    map['date'] = _date;
    map['time'] = _time;
    map['category_id'] = _categoryId;
    map['sub_category_id'] = _subCategoryId;
    map['height'] = _height;
    map['length'] = _length;
    map['unit'] = _unit;
    map['weight'] = _weight;
    map['pickup_lat'] = _pickupLat;
    map['pickup_lng'] = _pickupLng;
    map['drop_lat'] = _dropLat;
    map['drop_lng'] = _dropLng;
    map['status'] = _status;
    map['driver_id'] = _driverId;
    map['user_id'] = _userId;
    map['rejected_by'] = _rejectedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['delivery_charge'] = _deliveryCharge;
    map['sub_total'] = _subTotal;
    map['tax_amount'] = _taxAmount;
    map['total'] = _total;
    map['distance'] = _distance;
    return map;
  }

}