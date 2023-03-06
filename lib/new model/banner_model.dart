/// status : 1
/// msg : "Banners Found"
/// Banners : ["https://developmentalphawizz.com/SOD_New//uploads/63ad79f67962c.png"]

class BannerModel {
  BannerModel({
      num? status, 
      String? msg, 
      List<String>? banners,}){
    _status = status;
    _msg = msg;
    _banners = banners;
}

  BannerModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _banners = json['Banners'] != null ? json['Banners'].cast<String>() : [];
  }
  num? _status;
  String? _msg;
  List<String>? _banners;
BannerModel copyWith({  num? status,
  String? msg,
  List<String>? banners,
}) => BannerModel(  status: status ?? _status,
  msg: msg ?? _msg,
  banners: banners ?? _banners,
);
  num? get status => _status;
  String? get msg => _msg;
  List<String>? get banners => _banners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    map['Banners'] = _banners;
    return map;
  }

}