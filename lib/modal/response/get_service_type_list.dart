class GetServiceTypeListResponse {
  String? responseCode;
  String? message;
  String? status;
  List<Data>? data;

  GetServiceTypeListResponse(
      {this.responseCode, this.message, this.status, this.data});

  GetServiceTypeListResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? cName;
  String? id;

  Data({this.cName, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    cName = json['c_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c_name'] = this.cName;
    data['id'] = this.id;
    return data;
  }
}
