/// response_code : "1"
/// message : "user login success"
/// status : "success"
/// user_id : {"id":"17","email":" karanevil.singhtomar@gmail.com","mobile":"8770496665","address":" Vijay Nagar Indore ","description":"","category_id":null,"per_d_charge":null,"experience":null,"vehicle_number":null,"vehicle_type":null,"rc_book":null,"per_km_charge":null,"lat":"0","lang":"0","uname":" Karan","password":"947e38602b72975fadc4f617ddb257a1","profile_image":"","device_token":"","otp":"5162","status":"0","wallet":"0.00","balance":"0.00","last_login":null,"created_at":"2022-12-30 06:21:00","updated_at":"2022-12-30 07:28:46","roll":"1","adhar_card":"63ae834caf480.png","pancard":"63ae834cafad4.png","gst_no":" 12357896544","fssai":" 123567","store_name":" Alpha","band_details":"\" UPI : 8770496665@ybl\"","city_id":"0","vehicle_no":"","registarion_card":"","driving_license":"","categories_id":"","company_name":"","role_user":""}
/// user_token : ""

class VerifyOtpModel {
  VerifyOtpModel({
      String? responseCode, 
      String? message, 
      String? status, 
      UserId? userId, 
      String? userToken,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _userId = userId;
    _userToken = userToken;
}

  VerifyOtpModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    _userToken = json['user_token'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  UserId? _userId;
  String? _userToken;
VerifyOtpModel copyWith({  String? responseCode,
  String? message,
  String? status,
  UserId? userId,
  String? userToken,
}) => VerifyOtpModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  userId: userId ?? _userId,
  userToken: userToken ?? _userToken,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  UserId? get userId => _userId;
  String? get userToken => _userToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_userId != null) {
      map['user_id'] = _userId?.toJson();
    }
    map['user_token'] = _userToken;
    return map;
  }

}

/// id : "17"
/// email : " karanevil.singhtomar@gmail.com"
/// mobile : "8770496665"
/// address : " Vijay Nagar Indore "
/// description : ""
/// category_id : null
/// per_d_charge : null
/// experience : null
/// vehicle_number : null
/// vehicle_type : null
/// rc_book : null
/// per_km_charge : null
/// lat : "0"
/// lang : "0"
/// uname : " Karan"
/// password : "947e38602b72975fadc4f617ddb257a1"
/// profile_image : ""
/// device_token : ""
/// otp : "5162"
/// status : "0"
/// wallet : "0.00"
/// balance : "0.00"
/// last_login : null
/// created_at : "2022-12-30 06:21:00"
/// updated_at : "2022-12-30 07:28:46"
/// roll : "1"
/// adhar_card : "63ae834caf480.png"
/// pancard : "63ae834cafad4.png"
/// gst_no : " 12357896544"
/// fssai : " 123567"
/// store_name : " Alpha"
/// band_details : "\" UPI : 8770496665@ybl\""
/// city_id : "0"
/// vehicle_no : ""
/// registarion_card : ""
/// driving_license : ""
/// categories_id : ""
/// company_name : ""
/// role_user : ""

class UserId {
  UserId({
      String? id, 
      String? email, 
      String? mobile, 
      String? address, 
      String? description, 
      dynamic categoryId, 
      dynamic perDCharge, 
      dynamic experience, 
      dynamic vehicleNumber, 
      dynamic vehicleType, 
      dynamic rcBook, 
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
      String? gstNo, 
      String? fssai, 
      String? storeName, 
      String? bandDetails, 
      String? cityId, 
      String? vehicleNo, 
      String? registarionCard, 
      String? drivingLicense, 
      String? categoriesId, 
      String? companyName, 
      String? roleUser,}){
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
    _gstNo = gstNo;
    _fssai = fssai;
    _storeName = storeName;
    _bandDetails = bandDetails;
    _cityId = cityId;
    _vehicleNo = vehicleNo;
    _registarionCard = registarionCard;
    _drivingLicense = drivingLicense;
    _categoriesId = categoriesId;
    _companyName = companyName;
    _roleUser = roleUser;
}

  UserId.fromJson(dynamic json) {
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
    _gstNo = json['gst_no'];
    _fssai = json['fssai'];
    _storeName = json['store_name'];
    _bandDetails = json['band_details'];
    _cityId = json['city_id'];
    _vehicleNo = json['vehicle_no'];
    _registarionCard = json['registarion_card'];
    _drivingLicense = json['driving_license'];
    _categoriesId = json['categories_id'];
    _companyName = json['company_name'];
    _roleUser = json['role_user'];
  }
  String? _id;
  String? _email;
  String? _mobile;
  String? _address;
  String? _description;
  dynamic _categoryId;
  dynamic _perDCharge;
  dynamic _experience;
  dynamic _vehicleNumber;
  dynamic _vehicleType;
  dynamic _rcBook;
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
  String? _gstNo;
  String? _fssai;
  String? _storeName;
  String? _bandDetails;
  String? _cityId;
  String? _vehicleNo;
  String? _registarionCard;
  String? _drivingLicense;
  String? _categoriesId;
  String? _companyName;
  String? _roleUser;
UserId copyWith({  String? id,
  String? email,
  String? mobile,
  String? address,
  String? description,
  dynamic categoryId,
  dynamic perDCharge,
  dynamic experience,
  dynamic vehicleNumber,
  dynamic vehicleType,
  dynamic rcBook,
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
  String? gstNo,
  String? fssai,
  String? storeName,
  String? bandDetails,
  String? cityId,
  String? vehicleNo,
  String? registarionCard,
  String? drivingLicense,
  String? categoriesId,
  String? companyName,
  String? roleUser,
}) => UserId(  id: id ?? _id,
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
  gstNo: gstNo ?? _gstNo,
  fssai: fssai ?? _fssai,
  storeName: storeName ?? _storeName,
  bandDetails: bandDetails ?? _bandDetails,
  cityId: cityId ?? _cityId,
  vehicleNo: vehicleNo ?? _vehicleNo,
  registarionCard: registarionCard ?? _registarionCard,
  drivingLicense: drivingLicense ?? _drivingLicense,
  categoriesId: categoriesId ?? _categoriesId,
  companyName: companyName ?? _companyName,
  roleUser: roleUser ?? _roleUser,
);
  String? get id => _id;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get description => _description;
  dynamic get categoryId => _categoryId;
  dynamic get perDCharge => _perDCharge;
  dynamic get experience => _experience;
  dynamic get vehicleNumber => _vehicleNumber;
  dynamic get vehicleType => _vehicleType;
  dynamic get rcBook => _rcBook;
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
  String? get gstNo => _gstNo;
  String? get fssai => _fssai;
  String? get storeName => _storeName;
  String? get bandDetails => _bandDetails;
  String? get cityId => _cityId;
  String? get vehicleNo => _vehicleNo;
  String? get registarionCard => _registarionCard;
  String? get drivingLicense => _drivingLicense;
  String? get categoriesId => _categoriesId;
  String? get companyName => _companyName;
  String? get roleUser => _roleUser;

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
    map['gst_no'] = _gstNo;
    map['fssai'] = _fssai;
    map['store_name'] = _storeName;
    map['band_details'] = _bandDetails;
    map['city_id'] = _cityId;
    map['vehicle_no'] = _vehicleNo;
    map['registarion_card'] = _registarionCard;
    map['driving_license'] = _drivingLicense;
    map['categories_id'] = _categoriesId;
    map['company_name'] = _companyName;
    map['role_user'] = _roleUser;
    return map;
  }

}