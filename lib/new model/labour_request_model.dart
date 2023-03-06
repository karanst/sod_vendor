/// response_code : "1"
/// message : "Labour requests"
/// status : "success"
/// data : [{"username":"yogesh ","email":"yogeshalphawizz45@gmail.com","mobile":"8519099940","labour_name":"Sawan Shakya","labour_email":"sawan@mailinator.com","labour_mobile":"9877897899","id":"4","user_id":"115","labour_id":"86","date":"0000-00-00","time":"06:15:00","quantity":"5","amount":"400.00","tax_amount":"0.00","payment_status":"0","payment_type":"","requirement":"Construction site ","status":"0","comment":"I will do my work with 400 / person","created_at":"2022-11-03 06:33:39","updated_at":"2022-11-04 07:01:51","status_name":"Pending"},{"username":"yogesh ","email":"yogeshalphawizz45@gmail.com","mobile":"8519099940","labour_name":"Sawan Shakya","labour_email":"sawan@mailinator.com","labour_mobile":"9877897899","id":"5","user_id":"115","labour_id":"86","date":"0000-00-00","time":"02:00:00","quantity":"3","amount":"200.00","tax_amount":"0.00","payment_status":"0","payment_type":"","requirement":"demo","status":"0","comment":null,"created_at":"2022-11-03 23:43:47","updated_at":"2022-11-04 07:03:35","status_name":"Pending"},{"username":"yogesh ","email":"yogeshalphawizz45@gmail.com","mobile":"8519099940","labour_name":"Sawan Shakya","labour_email":"sawan@mailinator.com","labour_mobile":"9877897899","id":"6","user_id":"115","labour_id":"86","date":"0000-00-00","time":"01:24:00","quantity":"4","amount":"400.00","tax_amount":"0.00","payment_status":"0","payment_type":"","requirement":"construction ","status":"0","comment":null,"created_at":"2022-11-04 00:55:45","updated_at":"2022-11-04 07:03:29","status_name":"Pending"},{"username":"yogesh ","email":"yogeshalphawizz45@gmail.com","mobile":"8519099940","labour_name":"Sawan Shakya","labour_email":"sawan@mailinator.com","labour_mobile":"9877897899","id":"7","user_id":"115","labour_id":"86","date":"0000-00-00","time":"01:24:00","quantity":"4","amount":"400.00","tax_amount":"0.00","payment_status":"0","payment_type":"","requirement":"construction ","status":"0","comment":null,"created_at":"2022-11-04 00:55:49","updated_at":"2022-11-04 06:52:06","status_name":"Pending"},{"username":"yogesh ","email":"yogeshalphawizz45@gmail.com","mobile":"8519099940","labour_name":"Sawan Shakya","labour_email":"sawan@mailinator.com","labour_mobile":"9877897899","id":"8","user_id":"115","labour_id":"86","date":"0000-00-00","time":"02:26:00","quantity":"5","amount":"400.00","tax_amount":"0.00","payment_status":"0","payment_type":"","requirement":"construction ","status":"0","comment":null,"created_at":"2022-11-04 00:56:34","updated_at":"2022-11-04 06:52:06","status_name":"Pending"}]

class LabourRequestModel {
  LabourRequestModel({
      String? responseCode, 
      String? message, 
      String? status, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
}

  LabourRequestModel.fromJson(dynamic json) {
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
LabourRequestModel copyWith({  String? responseCode,
  String? message,
  String? status,
  List<Data>? data,
}) => LabourRequestModel(  responseCode: responseCode ?? _responseCode,
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

/// username : "yogesh "
/// email : "yogeshalphawizz45@gmail.com"
/// mobile : "8519099940"
/// labour_name : "Sawan Shakya"
/// labour_email : "sawan@mailinator.com"
/// labour_mobile : "9877897899"
/// id : "4"
/// user_id : "115"
/// labour_id : "86"
/// date : "0000-00-00"
/// time : "06:15:00"
/// quantity : "5"
/// amount : "400.00"
/// tax_amount : "0.00"
/// payment_status : "0"
/// payment_type : ""
/// requirement : "Construction site "
/// status : "0"
/// comment : "I will do my work with 400 / person"
/// created_at : "2022-11-03 06:33:39"
/// updated_at : "2022-11-04 07:01:51"
/// status_name : "Pending"

class Data {
  Data({
      String? username, 
      String? email, 
      String? mobile, 
      String? labourName, 
      String? labourEmail, 
      String? labourMobile, 
      String? id, 
      String? userId, 
      String? labourId, 
      String? date, 
      String? time, 
      String? quantity, 
      String? amount, 
      String? taxAmount, 
      String? paymentStatus, 
      String? paymentType, 
      String? requirement, 
      String? status, 
      String? comment, 
      String? createdAt, 
      String? updatedAt, 
      String? statusName,}){
    _username = username;
    _email = email;
    _mobile = mobile;
    _labourName = labourName;
    _labourEmail = labourEmail;
    _labourMobile = labourMobile;
    _id = id;
    _userId = userId;
    _labourId = labourId;
    _date = date;
    _time = time;
    _quantity = quantity;
    _amount = amount;
    _taxAmount = taxAmount;
    _paymentStatus = paymentStatus;
    _paymentType = paymentType;
    _requirement = requirement;
    _status = status;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _statusName = statusName;
}

  Data.fromJson(dynamic json) {
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _labourName = json['labour_name'];
    _labourEmail = json['labour_email'];
    _labourMobile = json['labour_mobile'];
    _id = json['id'];
    _userId = json['user_id'];
    _labourId = json['labour_id'];
    _date = json['date'];
    _time = json['time'];
    _quantity = json['quantity'];
    _amount = json['amount'];
    _taxAmount = json['tax_amount'];
    _paymentStatus = json['payment_status'];
    _paymentType = json['payment_type'];
    _requirement = json['requirement'];
    _status = json['status'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _statusName = json['status_name'];
  }
  String? _username;
  String? _email;
  String? _mobile;
  String? _labourName;
  String? _labourEmail;
  String? _labourMobile;
  String? _id;
  String? _userId;
  String? _labourId;
  String? _date;
  String? _time;
  String? _quantity;
  String? _amount;
  String? _taxAmount;
  String? _paymentStatus;
  String? _paymentType;
  String? _requirement;
  String? _status;
  String? _comment;
  String? _createdAt;
  String? _updatedAt;
  String? _statusName;
Data copyWith({  String? username,
  String? email,
  String? mobile,
  String? labourName,
  String? labourEmail,
  String? labourMobile,
  String? id,
  String? userId,
  String? labourId,
  String? date,
  String? time,
  String? quantity,
  String? amount,
  String? taxAmount,
  String? paymentStatus,
  String? paymentType,
  String? requirement,
  String? status,
  String? comment,
  String? createdAt,
  String? updatedAt,
  String? statusName,
}) => Data(  username: username ?? _username,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  labourName: labourName ?? _labourName,
  labourEmail: labourEmail ?? _labourEmail,
  labourMobile: labourMobile ?? _labourMobile,
  id: id ?? _id,
  userId: userId ?? _userId,
  labourId: labourId ?? _labourId,
  date: date ?? _date,
  time: time ?? _time,
  quantity: quantity ?? _quantity,
  amount: amount ?? _amount,
  taxAmount: taxAmount ?? _taxAmount,
  paymentStatus: paymentStatus ?? _paymentStatus,
  paymentType: paymentType ?? _paymentType,
  requirement: requirement ?? _requirement,
  status: status ?? _status,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  statusName: statusName ?? _statusName,
);
  String? get username => _username;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get labourName => _labourName;
  String? get labourEmail => _labourEmail;
  String? get labourMobile => _labourMobile;
  String? get id => _id;
  String? get userId => _userId;
  String? get labourId => _labourId;
  String? get date => _date;
  String? get time => _time;
  String? get quantity => _quantity;
  String? get amount => _amount;
  String? get taxAmount => _taxAmount;
  String? get paymentStatus => _paymentStatus;
  String? get paymentType => _paymentType;
  String? get requirement => _requirement;
  String? get status => _status;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get statusName => _statusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['labour_name'] = _labourName;
    map['labour_email'] = _labourEmail;
    map['labour_mobile'] = _labourMobile;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['labour_id'] = _labourId;
    map['date'] = _date;
    map['time'] = _time;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    map['tax_amount'] = _taxAmount;
    map['payment_status'] = _paymentStatus;
    map['payment_type'] = _paymentType;
    map['requirement'] = _requirement;
    map['status'] = _status;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['status_name'] = _statusName;
    return map;
  }

}