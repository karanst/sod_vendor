/// status : "0"
/// message : "Ticket types fetched successfully"
/// data : [{"id":"1","title":"\tProducts Quality","created_at":"0000-00-00 00:00:00"},{"id":"2","title":"product range","created_at":"0000-00-00 00:00:00"}]

class TicketTypeModel {
  TicketTypeModel({
      String? status, 
      String? message, 
      List<TicketType>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  TicketTypeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TicketType.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<TicketType>? _data;
TicketTypeModel copyWith({  String? status,
  String? message,
  List<TicketType>? data,
}) => TicketTypeModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get status => _status;
  String? get message => _message;
  List<TicketType>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// title : "\tProducts Quality"
/// created_at : "0000-00-00 00:00:00"

class TicketType {
  TicketType({
      String? id, 
      String? title, 
      String? createdAt,}){
    _id = id;
    _title = title;
    _createdAt = createdAt;
}

  TicketType.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _title;
  String? _createdAt;
TicketType copyWith({  String? id,
  String? title,
  String? createdAt,
}) => TicketType(  id: id ?? _id,
  title: title ?? _title,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get title => _title;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['created_at'] = _createdAt;
    return map;
  }

}