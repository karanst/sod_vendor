import 'dart:convert';
/// response_code : "1"
/// message : "Notifications Found"
/// notifications : [{"not_id":"104","user_id":"31","data_id":"172","type":"booking","title":"New Booking Received","message":"You Received Booking Successfully","date":"2022-09-30","booking":[{"date":"2022-09-30","slot":" 05:22","size":" ","amount":"5000","service_name":"Bridal makeup ","service_id":"165","res_image":""}]},{"not_id":"103","user_id":"31","data_id":"171","type":"booking","title":"New Booking Received","message":"You Received Booking Successfully","date":"2022-09-30","booking":[{"date":"2022-09-30","slot":" 05:22","size":" ","amount":"5000","service_name":"Bridal makeup ","service_id":"165","res_image":""}]},{"not_id":"102","user_id":"31","data_id":"170","type":"booking","title":"New Booking Received","message":"You Received Booking Successfully","date":"2022-09-30","booking":[{"date":"2022-09-30","slot":" 05:22","size":" ","amount":"5000","service_name":"Bridal makeup ","service_id":"165","res_image":""}]},{"not_id":"101","user_id":"31","data_id":"169","type":"booking","title":"New Booking Received","message":"You Received Booking Successfully","date":"2022-09-30","booking":[{"date":"2022-09-30","slot":" 05:22","size":" ","amount":"5000","service_name":"Bridal makeup ","service_id":"165","res_image":""}]},{"not_id":"100","user_id":"31","data_id":"168","type":"booking","title":"New Booking Received","message":"You Received Booking Successfully","date":"2022-09-30","booking":[{"date":"2022-09-30","slot":" 05:22","size":" ","amount":"5000","service_name":"Bridal makeup ","service_id":"165","res_image":""}]}]
/// status : "success"

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));
String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());
class NotificationResponse {
  NotificationResponse({
      String? responseCode, 
      String? message, 
      List<Notifications>? notifications, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _notifications = notifications;
    _status = status;
}

  NotificationResponse.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  List<Notifications>? _notifications;
  String? _status;
NotificationResponse copyWith({  String? responseCode,
  String? message,
  List<Notifications>? notifications,
  String? status,
}) => NotificationResponse(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  notifications: notifications ?? _notifications,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  List<Notifications>? get notifications => _notifications;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }

}

/// not_id : "104"
/// user_id : "31"
/// data_id : "172"
/// type : "booking"
/// title : "New Booking Received"
/// message : "You Received Booking Successfully"
/// date : "2022-09-30"
/// booking : [{"date":"2022-09-30","slot":" 05:22","size":" ","amount":"5000","service_name":"Bridal makeup ","service_id":"165","res_image":""}]

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));
String notificationsToJson(Notifications data) => json.encode(data.toJson());
class Notifications {
  Notifications({
      String? notId, 
      String? userId, 
      String? dataId, 
      String? type, 
      String? title, 
      String? message, 
      String? date, 
      List<Booking>? booking,}){
    _notId = notId;
    _userId = userId;
    _dataId = dataId;
    _type = type;
    _title = title;
    _message = message;
    _date = date;
    _booking = booking;
}

  Notifications.fromJson(dynamic json) {
    _notId = json['not_id'];
    _userId = json['user_id'];
    _dataId = json['data_id'];
    _type = json['type'];
    _title = json['title'];
    _message = json['message'];
    _date = json['date'];
    if (json['booking'] != null) {
      _booking = [];
      json['booking'].forEach((v) {
        _booking?.add(Booking.fromJson(v));
      });
    }
  }
  String? _notId;
  String? _userId;
  String? _dataId;
  String? _type;
  String? _title;
  String? _message;
  String? _date;
  List<Booking>? _booking;
Notifications copyWith({  String? notId,
  String? userId,
  String? dataId,
  String? type,
  String? title,
  String? message,
  String? date,
  List<Booking>? booking,
}) => Notifications(  notId: notId ?? _notId,
  userId: userId ?? _userId,
  dataId: dataId ?? _dataId,
  type: type ?? _type,
  title: title ?? _title,
  message: message ?? _message,
  date: date ?? _date,
  booking: booking ?? _booking,
);
  String? get notId => _notId;
  String? get userId => _userId;
  String? get dataId => _dataId;
  String? get type => _type;
  String? get title => _title;
  String? get message => _message;
  String? get date => _date;
  List<Booking>? get booking => _booking;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['not_id'] = _notId;
    map['user_id'] = _userId;
    map['data_id'] = _dataId;
    map['type'] = _type;
    map['title'] = _title;
    map['message'] = _message;
    map['date'] = _date;
    if (_booking != null) {
      map['booking'] = _booking?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "2022-09-30"
/// slot : " 05:22"
/// size : " "
/// amount : "5000"
/// service_name : "Bridal makeup "
/// service_id : "165"
/// res_image : ""

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));
String bookingToJson(Booking data) => json.encode(data.toJson());
class Booking {
  Booking({
      String? date, 
      String? slot, 
      String? size, 
      String? amount, 
      String? serviceName, 
      String? serviceId, 
      String? resImage,}){
    _date = date;
    _slot = slot;
    _size = size;
    _amount = amount;
    _serviceName = serviceName;
    _serviceId = serviceId;
    _resImage = resImage;
}

  Booking.fromJson(dynamic json) {
    _date = json['date'];
    _slot = json['slot'];
    _size = json['size'];
    _amount = json['amount'];
    _serviceName = json['service_name'];
    _serviceId = json['service_id'];
    _resImage = json['res_image'];
  }
  String? _date;
  String? _slot;
  String? _size;
  String? _amount;
  String? _serviceName;
  String? _serviceId;
  String? _resImage;
Booking copyWith({  String? date,
  String? slot,
  String? size,
  String? amount,
  String? serviceName,
  String? serviceId,
  String? resImage,
}) => Booking(  date: date ?? _date,
  slot: slot ?? _slot,
  size: size ?? _size,
  amount: amount ?? _amount,
  serviceName: serviceName ?? _serviceName,
  serviceId: serviceId ?? _serviceId,
  resImage: resImage ?? _resImage,
);
  String? get date => _date;
  String? get slot => _slot;
  String? get size => _size;
  String? get amount => _amount;
  String? get serviceName => _serviceName;
  String? get serviceId => _serviceId;
  String? get resImage => _resImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['slot'] = _slot;
    map['size'] = _size;
    map['amount'] = _amount;
    map['service_name'] = _serviceName;
    map['service_id'] = _serviceId;
    map['res_image'] = _resImage;
    return map;
  }

}