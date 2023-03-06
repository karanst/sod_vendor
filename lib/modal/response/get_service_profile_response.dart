class ServiceProfileResponse {
  String? responseCode;
  String? message;
  String? status;
  List<Data>? data;

  ServiceProfileResponse(
      {this.responseCode, this.message, this.status, this.data});

  ServiceProfileResponse.fromJson(Map<String, dynamic> json) {
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
  String? time;
  String? cName;
  String? serviceName;

  Data({this.time, this.cName, this.serviceName});

  Data.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    cName = json['c_name'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['c_name'] = this.cName;
    data['service_name'] = this.serviceName;
    return data;
  }
}
