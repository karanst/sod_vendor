/// response_code : "1"
/// message : "Register success"
/// status : "success"
/// data : {"uname":"Rohit","email":"rohit93@gmail.com","mobile":"877066991565","address":"indroe ","password":"25d55ad283aa400af464c76d713c07ad","status":0,"roll":1,"gst_no":"gdsa","store_name":"test","fssai":"d4","band_details":"\"sdf\"","adhar_card":"63ad6cb269251.png","pancard":"63ad6cb269439.png","otp":5060}

class RegistrationModel {
  RegistrationModel({
      String? responseCode, 
      String? message, 
      String? status, 
      Data? data,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
}

  RegistrationModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _responseCode;
  String? _message;
  String? _status;
  Data? _data;
RegistrationModel copyWith({  String? responseCode,
  String? message,
  String? status,
  Data? data,
}) => RegistrationModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// uname : "Rohit"
/// email : "rohit93@gmail.com"
/// mobile : "877066991565"
/// address : "indroe "
/// password : "25d55ad283aa400af464c76d713c07ad"
/// status : 0
/// roll : 1
/// gst_no : "gdsa"
/// store_name : "test"
/// fssai : "d4"
/// band_details : "\"sdf\""
/// adhar_card : "63ad6cb269251.png"
/// pancard : "63ad6cb269439.png"
/// otp : 5060

class Data {
  Data({
      String? uname, 
      String? email, 
      String? mobile, 
      String? address, 
      String? password, 
      num? status, 
      num? roll, 
      String? gstNo, 
      String? storeName, 
      String? fssai, 
      String? bandDetails, 
      String? adharCard, 
      String? pancard, 
      num? otp,}){
    _uname = uname;
    _email = email;
    _mobile = mobile;
    _address = address;
    _password = password;
    _status = status;
    _roll = roll;
    _gstNo = gstNo;
    _storeName = storeName;
    _fssai = fssai;
    _bandDetails = bandDetails;
    _adharCard = adharCard;
    _pancard = pancard;
    _otp = otp;
}

  Data.fromJson(dynamic json) {
    _uname = json['uname'];
    _email = json['email'];
    _mobile = json['mobile'];
    _address = json['address'];
    _password = json['password'];
    _status = json['status'];
    _roll = json['roll'];
    _gstNo = json['gst_no'];
    _storeName = json['store_name'];
    _fssai = json['fssai'];
    _bandDetails = json['band_details'];
    _adharCard = json['adhar_card'];
    _pancard = json['pancard'];
    _otp = json['otp'];
  }
  String? _uname;
  String? _email;
  String? _mobile;
  String? _address;
  String? _password;
  num? _status;
  num? _roll;
  String? _gstNo;
  String? _storeName;
  String? _fssai;
  String? _bandDetails;
  String? _adharCard;
  String? _pancard;
  num? _otp;
Data copyWith({  String? uname,
  String? email,
  String? mobile,
  String? address,
  String? password,
  num? status,
  num? roll,
  String? gstNo,
  String? storeName,
  String? fssai,
  String? bandDetails,
  String? adharCard,
  String? pancard,
  num? otp,
}) => Data(  uname: uname ?? _uname,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  password: password ?? _password,
  status: status ?? _status,
  roll: roll ?? _roll,
  gstNo: gstNo ?? _gstNo,
  storeName: storeName ?? _storeName,
  fssai: fssai ?? _fssai,
  bandDetails: bandDetails ?? _bandDetails,
  adharCard: adharCard ?? _adharCard,
  pancard: pancard ?? _pancard,
  otp: otp ?? _otp,
);
  String? get uname => _uname;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get password => _password;
  num? get status => _status;
  num? get roll => _roll;
  String? get gstNo => _gstNo;
  String? get storeName => _storeName;
  String? get fssai => _fssai;
  String? get bandDetails => _bandDetails;
  String? get adharCard => _adharCard;
  String? get pancard => _pancard;
  num? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uname'] = _uname;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['password'] = _password;
    map['status'] = _status;
    map['roll'] = _roll;
    map['gst_no'] = _gstNo;
    map['store_name'] = _storeName;
    map['fssai'] = _fssai;
    map['band_details'] = _bandDetails;
    map['adhar_card'] = _adharCard;
    map['pancard'] = _pancard;
    map['otp'] = _otp;
    return map;
  }

}