/// response_code : "1"
/// message : "Vendor Found"
/// user : {"id":"86","email":"sawan@mailinator.com","mobile":"9877897899","address":"Indore, Madhya Pradesh","description":"","category_id":"74","per_d_charge":"100","experience":"5+ Years","vehicle_number":null,"vehicle_type":null,"rc_book":"","per_km_charge":null,"lat":"0","lang":"0","uname":"Sawan Shakya","password":"","profile_image":"","device_token":"","otp":"5031","status":"1","wallet":"0.00","balance":"0.00","last_login":null,"created_at":"2022-11-04 00:57:45","updated_at":"2022-11-04 00:57:56","roll":"1","adhar_card":"https://developmentalphawizz.com/new_ondemand/uploads/documents/6364c5f92cdb1.png","pancard":"https://developmentalphawizz.com/new_ondemand/uploads/documents/6364c5f92cf9b.jpg","role_name":"Labour"}
/// status : "success"

class GetProfileResponse {
  GetProfileResponse({
      String? responseCode, 
      String? message, 
      User? user, 
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _user = user;
    _status = status;
}

  GetProfileResponse.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  User? _user;
  String? _status;
GetProfileResponse copyWith({  String? responseCode,
  String? message,
  User? user,
  String? status,
}) => GetProfileResponse(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  user: user ?? _user,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  User? get user => _user;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

/// id : "86"
/// email : "sawan@mailinator.com"
/// mobile : "9877897899"
/// address : "Indore, Madhya Pradesh"
/// description : ""
/// category_id : "74"
/// per_d_charge : "100"
/// experience : "5+ Years"
/// vehicle_number : null
/// vehicle_type : null
/// rc_book : ""
/// per_km_charge : null
/// lat : "0"
/// lang : "0"
/// uname : "Sawan Shakya"
/// password : ""
/// profile_image : ""
/// device_token : ""
/// otp : "5031"
/// status : "1"
/// wallet : "0.00"
/// balance : "0.00"
/// last_login : null
/// created_at : "2022-11-04 00:57:45"
/// updated_at : "2022-11-04 00:57:56"
/// roll : "1"
/// adhar_card : "https://developmentalphawizz.com/new_ondemand/uploads/documents/6364c5f92cdb1.png"
/// pancard : "https://developmentalphawizz.com/new_ondemand/uploads/documents/6364c5f92cf9b.jpg"
/// role_name : "Labour"

class User {
  User({
      String? id, 
      String? email, 
      String? mobile, 
      String? address, 
      String? description, 
      String? categoryId, 
      String? perDCharge, 
      String? experience, 
      dynamic vehicleNumber, 
      dynamic vehicleType, 
      String? rcBook, 
      dynamic perKmCharge, 
      String? lat, 
      String? lang, 
      String? uname, 
      String? password, 
      String? profileImage, 
      String? deviceToken, 
      String? otp, 
      String? status, 
      String? wallet, 
      String? balance, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt, 
      String? roll, 
      String? adharCard, 
      String? pancard, 
      String? roleName,}){
    _id = id;
    _email = email;
    _mobile = mobile;
    _address = address;
    _description = description;
    _categoryId = categoryId;
    _perDCharge = perDCharge;
    _experience = experience;
    _vehicleNumber = vehicleNumber;
    _vehicleType = vehicleType;
    _rcBook = rcBook;
    _perKmCharge = perKmCharge;
    _lat = lat;
    _lang = lang;
    _uname = uname;
    _password = password;
    _profileImage = profileImage;
    _deviceToken = deviceToken;
    _otp = otp;
    _status = status;
    _wallet = wallet;
    _balance = balance;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _roll = roll;
    _adharCard = adharCard;
    _pancard = pancard;
    _roleName = roleName;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _mobile = json['mobile'];
    _address = json['address'];
    _description = json['description'];
    _categoryId = json['category_id'];
    _perDCharge = json['per_d_charge'];
    _experience = json['experience'];
    _vehicleNumber = json['vehicle_number'];
    _vehicleType = json['vehicle_type'];
    _rcBook = json['rc_book'];
    _perKmCharge = json['per_km_charge'];
    _lat = json['lat'];
    _lang = json['lang'];
    _uname = json['uname'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _deviceToken = json['device_token'];
    _otp = json['otp'];
    _status = json['status'];
    _wallet = json['wallet'];
    _balance = json['balance'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _roll = json['roll'];
    _adharCard = json['adhar_card'];
    _pancard = json['pancard'];
    _roleName = json['role_name'];
  }
  String? _id;
  String? _email;
  String? _mobile;
  String? _address;
  String? _description;
  String? _categoryId;
  String? _perDCharge;
  String? _experience;
  dynamic _vehicleNumber;
  dynamic _vehicleType;
  String? _rcBook;
  dynamic _perKmCharge;
  String? _lat;
  String? _lang;
  String? _uname;
  String? _password;
  String? _profileImage;
  String? _deviceToken;
  String? _otp;
  String? _status;
  String? _wallet;
  String? _balance;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  String? _roll;
  String? _adharCard;
  String? _pancard;
  String? _roleName;
User copyWith({  String? id,
  String? email,
  String? mobile,
  String? address,
  String? description,
  String? categoryId,
  String? perDCharge,
  String? experience,
  dynamic vehicleNumber,
  dynamic vehicleType,
  String? rcBook,
  dynamic perKmCharge,
  String? lat,
  String? lang,
  String? uname,
  String? password,
  String? profileImage,
  String? deviceToken,
  String? otp,
  String? status,
  String? wallet,
  String? balance,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
  String? roll,
  String? adharCard,
  String? pancard,
  String? roleName,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  description: description ?? _description,
  categoryId: categoryId ?? _categoryId,
  perDCharge: perDCharge ?? _perDCharge,
  experience: experience ?? _experience,
  vehicleNumber: vehicleNumber ?? _vehicleNumber,
  vehicleType: vehicleType ?? _vehicleType,
  rcBook: rcBook ?? _rcBook,
  perKmCharge: perKmCharge ?? _perKmCharge,
  lat: lat ?? _lat,
  lang: lang ?? _lang,
  uname: uname ?? _uname,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  deviceToken: deviceToken ?? _deviceToken,
  otp: otp ?? _otp,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  balance: balance ?? _balance,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  roll: roll ?? _roll,
  adharCard: adharCard ?? _adharCard,
  pancard: pancard ?? _pancard,
  roleName: roleName ?? _roleName,
);
  String? get id => _id;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get description => _description;
  String? get categoryId => _categoryId;
  String? get perDCharge => _perDCharge;
  String? get experience => _experience;
  dynamic get vehicleNumber => _vehicleNumber;
  dynamic get vehicleType => _vehicleType;
  String? get rcBook => _rcBook;
  dynamic get perKmCharge => _perKmCharge;
  String? get lat => _lat;
  String? get lang => _lang;
  String? get uname => _uname;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get deviceToken => _deviceToken;
  String? get otp => _otp;
  String? get status => _status;
  String? get wallet => _wallet;
  String? get balance => _balance;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get roll => _roll;
  String? get adharCard => _adharCard;
  String? get pancard => _pancard;
  String? get roleName => _roleName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['description'] = _description;
    map['category_id'] = _categoryId;
    map['per_d_charge'] = _perDCharge;
    map['experience'] = _experience;
    map['vehicle_number'] = _vehicleNumber;
    map['vehicle_type'] = _vehicleType;
    map['rc_book'] = _rcBook;
    map['per_km_charge'] = _perKmCharge;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['uname'] = _uname;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['device_token'] = _deviceToken;
    map['otp'] = _otp;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['roll'] = _roll;
    map['adhar_card'] = _adharCard;
    map['pancard'] = _pancard;
    map['role_name'] = _roleName;
    return map;
  }

}