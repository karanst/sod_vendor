class TotalPaymentResponse {
  String? responseCode;
  String? message;
  String? status;
  List<Data>? data;

  TotalPaymentResponse(
      {this.responseCode, this.message, this.status, this.data});

  TotalPaymentResponse.fromJson(Map<String, dynamic> json) {
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
  String? totalamount;

  Data({this.totalamount});

  Data.fromJson(Map<String, dynamic> json) {
    totalamount = json['totalamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalamount'] = this.totalamount;
    return data;
  }
}
