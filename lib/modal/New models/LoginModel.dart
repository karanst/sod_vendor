/// response_code : "1"
/// message : "OTP sent success"
/// status : "success"
/// otp : 6900
/// mobile : "1212121212"

class LoginModel {
  LoginModel({
      String? responseCode, 
      String? message, 
      String? status, 
      int? otp, 
      String? mobile,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _otp = otp;
    _mobile = mobile;
}

  LoginModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _otp = json['otp'];
    _mobile = json['mobile'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  int? _otp;
  String? _mobile;
LoginModel copyWith({  String? responseCode,
  String? message,
  String? status,
  int? otp,
  String? mobile,
}) => LoginModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  otp: otp ?? _otp,
  mobile: mobile ?? _mobile,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  int? get otp => _otp;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    map['otp'] = _otp;
    map['mobile'] = _mobile;
    return map;
  }

}