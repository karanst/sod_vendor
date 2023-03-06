/// response_code : "1"
/// message : "Status updated success"
/// status : "success"

class PostStatusModel {
  PostStatusModel({
      String? responseCode, 
      String? message, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
}

  PostStatusModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
PostStatusModel copyWith({  String? responseCode,
  String? message,
  String? status,
}) => PostStatusModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }

}