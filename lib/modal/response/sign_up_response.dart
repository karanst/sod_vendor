class SignUpResponse {
  String? responseCode;
  String? message;
  String? status;
  String? user;

  SignUpResponse({this.responseCode, this.message, this.status, this.user});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    data['user'] = this.user;
    return data;
  }
}
