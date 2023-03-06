/// error : false
/// message : "Ticket types fetched successfully"
/// total : "1"
/// data : {"id":"1","ticket_type_id":"1","user_id":"29","subject":"Product quality is different","email":"null","description":"Product quality is different","status":"OPENED","last_updated":"2023-01-16 06:40:26","date_created":"2023-01-16 06:35:17","name":"Karan","ticket_type":"\tProducts Quality"}
/// status : "0"

class TicketModel {
  TicketModel({
      bool? error, 
      String? message, 
      String? total, 
      Tickets? data,
      String? status,}){
    _error = error;
    _message = message;
    _total = total;
    _data = data;
    _status = status;
}

  TicketModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _total = json['total'];
    _data = json['data'] != null ? Tickets.fromJson(json['data']) : null;
    _status = json['status'];
  }
  bool? _error;
  String? _message;
  String? _total;
  Tickets? _data;
  String? _status;
TicketModel copyWith({  bool? error,
  String? message,
  String? total,
  Tickets? data,
  String? status,
}) => TicketModel(  error: error ?? _error,
  message: message ?? _message,
  total: total ?? _total,
  data: data ?? _data,
  status: status ?? _status,
);
  bool? get error => _error;
  String? get message => _message;
  String? get total => _total;
  Tickets? get data => _data;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

/// id : "1"
/// ticket_type_id : "1"
/// user_id : "29"
/// subject : "Product quality is different"
/// email : "null"
/// description : "Product quality is different"
/// status : "OPENED"
/// last_updated : "2023-01-16 06:40:26"
/// date_created : "2023-01-16 06:35:17"
/// name : "Karan"
/// ticket_type : "\tProducts Quality"

class Tickets {
  Tickets({
      String? id, 
      String? ticketTypeId, 
      String? userId, 
      String? subject, 
      String? email, 
      String? description, 
      String? status, 
      String? lastUpdated, 
      String? dateCreated, 
      String? name, 
      String? ticketType,}){
    _id = id;
    _ticketTypeId = ticketTypeId;
    _userId = userId;
    _subject = subject;
    _email = email;
    _description = description;
    _status = status;
    _lastUpdated = lastUpdated;
    _dateCreated = dateCreated;
    _name = name;
    _ticketType = ticketType;
}

  Tickets.fromJson(dynamic json) {
    _id = json['id'];
    _ticketTypeId = json['ticket_type_id'];
    _userId = json['user_id'];
    _subject = json['subject'];
    _email = json['email'];
    _description = json['description'];
    _status = json['status'];
    _lastUpdated = json['last_updated'];
    _dateCreated = json['date_created'];
    _name = json['name'];
    _ticketType = json['ticket_type'];
  }
  String? _id;
  String? _ticketTypeId;
  String? _userId;
  String? _subject;
  String? _email;
  String? _description;
  String? _status;
  String? _lastUpdated;
  String? _dateCreated;
  String? _name;
  String? _ticketType;
Tickets copyWith({  String? id,
  String? ticketTypeId,
  String? userId,
  String? subject,
  String? email,
  String? description,
  String? status,
  String? lastUpdated,
  String? dateCreated,
  String? name,
  String? ticketType,
}) => Tickets(  id: id ?? _id,
  ticketTypeId: ticketTypeId ?? _ticketTypeId,
  userId: userId ?? _userId,
  subject: subject ?? _subject,
  email: email ?? _email,
  description: description ?? _description,
  status: status ?? _status,
  lastUpdated: lastUpdated ?? _lastUpdated,
  dateCreated: dateCreated ?? _dateCreated,
  name: name ?? _name,
  ticketType: ticketType ?? _ticketType,
);
  String? get id => _id;
  String? get ticketTypeId => _ticketTypeId;
  String? get userId => _userId;
  String? get subject => _subject;
  String? get email => _email;
  String? get description => _description;
  String? get status => _status;
  String? get lastUpdated => _lastUpdated;
  String? get dateCreated => _dateCreated;
  String? get name => _name;
  String? get ticketType => _ticketType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ticket_type_id'] = _ticketTypeId;
    map['user_id'] = _userId;
    map['subject'] = _subject;
    map['email'] = _email;
    map['description'] = _description;
    map['status'] = _status;
    map['last_updated'] = _lastUpdated;
    map['date_created'] = _dateCreated;
    map['name'] = _name;
    map['ticket_type'] = _ticketType;
    return map;
  }

}