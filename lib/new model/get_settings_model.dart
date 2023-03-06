/// status : 1
/// msg : "Setting Found"
/// setting : {"id":"1","n_server_key":"AAAA0I6gvao:APA91bENmsxDZy6OLKvZ-lC66o2lXgNBJugEwgRs8h7YG1D-7Y0IsB5dLrhE5Q8jsbFyILKsp0v4IPKZ6D2ybIqTxesVkiVfsXgXQ8F0bh3nCvFgb1rzzMblqUddvOP78bIfc-68JJ2X","s_secret_key":"sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62","s_public_key":"pk_test_asd3w4refds4werfweasfdfwwrwdfs4343","r_secret_key":"fnwpQ69iqzV5Aq0GUiG5sC71","r_public_key":"rzp_test_dv9hJ9iSfC2Far","twitter_url":"https://twitter.com/","likend_in_url":"https://www.linkedin.com/","instaram_url":"https://www.instagram.com/","facebook_url":"https://www.facebook.com/","address":"MI road Jaipur 302002 Rajasthan India","email":"hello@sodindia.com","contact_no":"9001887487","per_km_charge":"7","gst_charge":"18","radius":"10000","advanced_amount":"","youtube_url":"https://www.youtube.com/"}

class GetSettingsModel {
  GetSettingsModel({
      num? status, 
      String? msg, 
      Setting? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  GetSettingsModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    _setting = json['setting'] != null ? Setting.fromJson(json['setting']) : null;
  }
  num? _status;
  String? _msg;
  Setting? _setting;
GetSettingsModel copyWith({  num? status,
  String? msg,
  Setting? setting,
}) => GetSettingsModel(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  num? get status => _status;
  String? get msg => _msg;
  Setting? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// n_server_key : "AAAA0I6gvao:APA91bENmsxDZy6OLKvZ-lC66o2lXgNBJugEwgRs8h7YG1D-7Y0IsB5dLrhE5Q8jsbFyILKsp0v4IPKZ6D2ybIqTxesVkiVfsXgXQ8F0bh3nCvFgb1rzzMblqUddvOP78bIfc-68JJ2X"
/// s_secret_key : "sk_test_Vcv04sLCi00ljN3C8GqrpDmw00SJk0bP62"
/// s_public_key : "pk_test_asd3w4refds4werfweasfdfwwrwdfs4343"
/// r_secret_key : "fnwpQ69iqzV5Aq0GUiG5sC71"
/// r_public_key : "rzp_test_dv9hJ9iSfC2Far"
/// twitter_url : "https://twitter.com/"
/// likend_in_url : "https://www.linkedin.com/"
/// instaram_url : "https://www.instagram.com/"
/// facebook_url : "https://www.facebook.com/"
/// address : "MI road Jaipur 302002 Rajasthan India"
/// email : "hello@sodindia.com"
/// contact_no : "9001887487"
/// per_km_charge : "7"
/// gst_charge : "18"
/// radius : "10000"
/// advanced_amount : ""
/// youtube_url : "https://www.youtube.com/"

class Setting {
  Setting({
      String? id, 
      String? nServerKey, 
      String? sSecretKey, 
      String? sPublicKey, 
      String? rSecretKey, 
      String? rPublicKey, 
      String? twitterUrl, 
      String? likendInUrl, 
      String? instaramUrl, 
      String? facebookUrl, 
      String? address, 
      String? email, 
      String? contactNo, 
      String? perKmCharge, 
      String? gstCharge, 
      String? radius, 
      String? advancedAmount, 
      String? youtubeUrl,}){
    _id = id;
    _nServerKey = nServerKey;
    _sSecretKey = sSecretKey;
    _sPublicKey = sPublicKey;
    _rSecretKey = rSecretKey;
    _rPublicKey = rPublicKey;
    _twitterUrl = twitterUrl;
    _likendInUrl = likendInUrl;
    _instaramUrl = instaramUrl;
    _facebookUrl = facebookUrl;
    _address = address;
    _email = email;
    _contactNo = contactNo;
    _perKmCharge = perKmCharge;
    _gstCharge = gstCharge;
    _radius = radius;
    _advancedAmount = advancedAmount;
    _youtubeUrl = youtubeUrl;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _nServerKey = json['n_server_key'];
    _sSecretKey = json['s_secret_key'];
    _sPublicKey = json['s_public_key'];
    _rSecretKey = json['r_secret_key'];
    _rPublicKey = json['r_public_key'];
    _twitterUrl = json['twitter_url'];
    _likendInUrl = json['likend_in_url'];
    _instaramUrl = json['instaram_url'];
    _facebookUrl = json['facebook_url'];
    _address = json['address'];
    _email = json['email'];
    _contactNo = json['contact_no'];
    _perKmCharge = json['per_km_charge'];
    _gstCharge = json['gst_charge'];
    _radius = json['radius'];
    _advancedAmount = json['advanced_amount'];
    _youtubeUrl = json['youtube_url'];
  }
  String? _id;
  String? _nServerKey;
  String? _sSecretKey;
  String? _sPublicKey;
  String? _rSecretKey;
  String? _rPublicKey;
  String? _twitterUrl;
  String? _likendInUrl;
  String? _instaramUrl;
  String? _facebookUrl;
  String? _address;
  String? _email;
  String? _contactNo;
  String? _perKmCharge;
  String? _gstCharge;
  String? _radius;
  String? _advancedAmount;
  String? _youtubeUrl;
Setting copyWith({  String? id,
  String? nServerKey,
  String? sSecretKey,
  String? sPublicKey,
  String? rSecretKey,
  String? rPublicKey,
  String? twitterUrl,
  String? likendInUrl,
  String? instaramUrl,
  String? facebookUrl,
  String? address,
  String? email,
  String? contactNo,
  String? perKmCharge,
  String? gstCharge,
  String? radius,
  String? advancedAmount,
  String? youtubeUrl,
}) => Setting(  id: id ?? _id,
  nServerKey: nServerKey ?? _nServerKey,
  sSecretKey: sSecretKey ?? _sSecretKey,
  sPublicKey: sPublicKey ?? _sPublicKey,
  rSecretKey: rSecretKey ?? _rSecretKey,
  rPublicKey: rPublicKey ?? _rPublicKey,
  twitterUrl: twitterUrl ?? _twitterUrl,
  likendInUrl: likendInUrl ?? _likendInUrl,
  instaramUrl: instaramUrl ?? _instaramUrl,
  facebookUrl: facebookUrl ?? _facebookUrl,
  address: address ?? _address,
  email: email ?? _email,
  contactNo: contactNo ?? _contactNo,
  perKmCharge: perKmCharge ?? _perKmCharge,
  gstCharge: gstCharge ?? _gstCharge,
  radius: radius ?? _radius,
  advancedAmount: advancedAmount ?? _advancedAmount,
  youtubeUrl: youtubeUrl ?? _youtubeUrl,
);
  String? get id => _id;
  String? get nServerKey => _nServerKey;
  String? get sSecretKey => _sSecretKey;
  String? get sPublicKey => _sPublicKey;
  String? get rSecretKey => _rSecretKey;
  String? get rPublicKey => _rPublicKey;
  String? get twitterUrl => _twitterUrl;
  String? get likendInUrl => _likendInUrl;
  String? get instaramUrl => _instaramUrl;
  String? get facebookUrl => _facebookUrl;
  String? get address => _address;
  String? get email => _email;
  String? get contactNo => _contactNo;
  String? get perKmCharge => _perKmCharge;
  String? get gstCharge => _gstCharge;
  String? get radius => _radius;
  String? get advancedAmount => _advancedAmount;
  String? get youtubeUrl => _youtubeUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['n_server_key'] = _nServerKey;
    map['s_secret_key'] = _sSecretKey;
    map['s_public_key'] = _sPublicKey;
    map['r_secret_key'] = _rSecretKey;
    map['r_public_key'] = _rPublicKey;
    map['twitter_url'] = _twitterUrl;
    map['likend_in_url'] = _likendInUrl;
    map['instaram_url'] = _instaramUrl;
    map['facebook_url'] = _facebookUrl;
    map['address'] = _address;
    map['email'] = _email;
    map['contact_no'] = _contactNo;
    map['per_km_charge'] = _perKmCharge;
    map['gst_charge'] = _gstCharge;
    map['radius'] = _radius;
    map['advanced_amount'] = _advancedAmount;
    map['youtube_url'] = _youtubeUrl;
    return map;
  }

}