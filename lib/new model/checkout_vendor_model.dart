/// response_code : "1"
/// message : "Order Placed"
/// order_id : "51"
/// status : "success"

class CheckoutVendorModel {
  CheckoutVendorModel({
      String? responseCode, 
      String? message, 
      String? orderId, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _orderId = orderId;
    _status = status;
}

  CheckoutVendorModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _orderId = json['order_id'];
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  String? _orderId;
  String? _status;
CheckoutVendorModel copyWith({  String? responseCode,
  String? message,
  String? orderId,
  String? status,
}) => CheckoutVendorModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  orderId: orderId ?? _orderId,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get orderId => _orderId;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['order_id'] = _orderId;
    map['status'] = _status;
    return map;
  }

}