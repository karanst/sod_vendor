class UploadImageModel {
  UploadImageModel({
      this.responseCode, 
      this.message, 
      this.status, 
      this.fileName,});

  UploadImageModel.fromJson(dynamic json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    fileName = json['file_name'];
  }
  String? responseCode;
  String? message;
  String? status;
  String? fileName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = responseCode;
    map['message'] = message;
    map['status'] = status;
    map['file_name'] = fileName;
    return map;
  }

}