/// status : "0"
/// message : "Update Status Succesfully"

class OnOffModel {
  OnOffModel({
      String? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  OnOffModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  String? _status;
  String? _message;
OnOffModel copyWith({  String? status,
  String? message,
}) => OnOffModel(  status: status ?? _status,
  message: message ?? _message,
);
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}