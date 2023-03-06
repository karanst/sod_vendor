class ForgotPassResponse {
  int? status;
  String? msg;
  int? newPass;

  ForgotPassResponse({this.status, this.msg, this.newPass});

  ForgotPassResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    newPass = json['new_pass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['new_pass'] = this.newPass;
    return data;
  }
}
