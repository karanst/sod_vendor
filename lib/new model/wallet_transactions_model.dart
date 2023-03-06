/// response_code : "1"
/// message : "Request sent success"
/// status : "success"
/// data : [{"id":"8","user_id":"29","bank_details":"{\"upi_id\": \"8770496665@ybl\"}","amount":"5.00","status":"0","created_at":"2023-01-24 08:18:24","updated_at":"2023-01-24 08:18:24"}]

class WalletTransactionsModel {
  WalletTransactionsModel({
      String? responseCode, 
      String? message, 
      String? status, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
}

  WalletTransactionsModel.fromJson(dynamic json) {
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
WalletTransactionsModel copyWith({  String? responseCode,
  String? message,
  String? status,
  List<Data>? data,
}) => WalletTransactionsModel(  responseCode: responseCode ?? _responseCode,
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

/// id : "8"
/// user_id : "29"
/// bank_details : "{\"upi_id\": \"8770496665@ybl\"}"
/// amount : "5.00"
/// status : "0"
/// created_at : "2023-01-24 08:18:24"
/// updated_at : "2023-01-24 08:18:24"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? bankDetails, 
      String? amount, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _bankDetails = bankDetails;
    _amount = amount;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bankDetails = json['bank_details'];
    _amount = json['amount'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _bankDetails;
  String? _amount;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? userId,
  String? bankDetails,
  String? amount,
  String? status,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  bankDetails: bankDetails ?? _bankDetails,
  amount: amount ?? _amount,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get bankDetails => _bankDetails;
  String? get amount => _amount;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['bank_details'] = _bankDetails;
    map['amount'] = _amount;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}