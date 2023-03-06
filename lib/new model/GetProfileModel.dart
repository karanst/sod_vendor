/// response_code : "1"
/// message : "Get Successfully"
/// status : "success"
/// data : [{"id":"29","email":"Karanevil.singhtomar@gmail.com","mobile":"8770496665","address":"Pithampur Industrial Area, Pithampur, Madhya Pradesh, India","description":"","category_id":null,"per_d_charge":null,"per_h_charge":null,"experience":null,"vehicle_number":null,"vehicle_type":null,"rc_book":null,"per_km_charge":null,"lat":"22.7469113","lang":"75.8980757","uname":"Karan","password":"d41d8cd98f00b204e9800998ecf8427e","profile_image":"https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c5424ca9d7e.jpg","device_token":"eEM-xhudR828rnus_Agqqs:APA91bFYYw7IZtFhXC_PVz7x11P8vvrrqoqgkLU5NK9Y6OWW2VPP4rz8dRB7bH70l-UYoAH7CKgF0_SS55WiQyOnwZGVkFQRkhBwQFxGLbrMphs_AcaE2JDdbIueYKAg7BrNf5eUbM7o","otp":"5045","status":"0","wallet":"10.00","balance":"0.00","last_login":null,"created_at":"2023-01-13 13:30:36","updated_at":"2023-01-19 13:54:19","roll":"1","adhar_card":"https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c15cfca4bb8.jpg","pancard":"https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c15cfca50b9.jpg","gst_no":"GST1655","fssai":"474737262","store_name":"Shruti Stores","band_details":{"UPI":"86643156@ybl"},"city_id":"0","vehicle_no":"","registarion_card":"","driving_license":"","categories_id":"","company_name":"","role_user":"","event":"","latitude":"null","longitude":"null","delivery_type":"","refferal_code":"9281","friend_code":"","online_status":"0","store_description":""}]
/// image_path : "https://developmentalphawizz.com/SOD_New//uploads/profile_pics/"

class GetProfileModel {
  GetProfileModel({
      String? responseCode, 
      String? message, 
      String? status, 
      List<Data>? data, 
      String? imagePath,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
    _imagePath = imagePath;
}

  GetProfileModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _imagePath = json['image_path'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  List<Data>? _data;
  String? _imagePath;
GetProfileModel copyWith({  String? responseCode,
  String? message,
  String? status,
  List<Data>? data,
  String? imagePath,
}) => GetProfileModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
  imagePath: imagePath ?? _imagePath,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  List<Data>? get data => _data;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['image_path'] = _imagePath;
    return map;
  }

}

/// id : "29"
/// email : "Karanevil.singhtomar@gmail.com"
/// mobile : "8770496665"
/// address : "Pithampur Industrial Area, Pithampur, Madhya Pradesh, India"
/// description : ""
/// category_id : null
/// per_d_charge : null
/// per_h_charge : null
/// experience : null
/// vehicle_number : null
/// vehicle_type : null
/// rc_book : null
/// per_km_charge : null
/// lat : "22.7469113"
/// lang : "75.8980757"
/// uname : "Karan"
/// password : "d41d8cd98f00b204e9800998ecf8427e"
/// profile_image : "https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c5424ca9d7e.jpg"
/// device_token : "eEM-xhudR828rnus_Agqqs:APA91bFYYw7IZtFhXC_PVz7x11P8vvrrqoqgkLU5NK9Y6OWW2VPP4rz8dRB7bH70l-UYoAH7CKgF0_SS55WiQyOnwZGVkFQRkhBwQFxGLbrMphs_AcaE2JDdbIueYKAg7BrNf5eUbM7o"
/// otp : "5045"
/// status : "0"
/// wallet : "10.00"
/// balance : "0.00"
/// last_login : null
/// created_at : "2023-01-13 13:30:36"
/// updated_at : "2023-01-19 13:54:19"
/// roll : "1"
/// adhar_card : "https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c15cfca4bb8.jpg"
/// pancard : "https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c15cfca50b9.jpg"
/// gst_no : "GST1655"
/// fssai : "474737262"
/// store_name : "Shruti Stores"
/// band_details : {"UPI":"86643156@ybl"}
/// city_id : "0"
/// vehicle_no : ""
/// registarion_card : ""
/// driving_license : ""
/// categories_id : ""
/// company_name : ""
/// role_user : ""
/// event : ""
/// latitude : "null"
/// longitude : "null"
/// delivery_type : ""
/// refferal_code : "9281"
/// friend_code : ""
/// online_status : "0"
/// store_description : ""

class Data {
  Data({
      String? id, 
      String? email, 
      String? mobile, 
      String? address, 
      String? description, 
      dynamic categoryId, 
      dynamic perDCharge, 
      dynamic perHCharge, 
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
      BandDetails? bandDetails, 
      String? cityId, 
      String? vehicleNo, 
      String? registarionCard, 
      String? drivingLicense, 
      String? categoriesId, 
      String? companyName, 
      String? roleUser, 
      String? event, 
      String? latitude, 
      String? longitude, 
      String? deliveryType, 
      String? refferalCode, 
      String? friendCode, 
      String? onlineStatus, 
      String? storeDescription,}){
    _id = id;
    _email = email;
    _mobile = mobile;
    _address = address;
    _description = description;
    _categoryId = categoryId;
    _perDCharge = perDCharge;
    _perHCharge = perHCharge;
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
    _event = event;
    _latitude = latitude;
    _longitude = longitude;
    _deliveryType = deliveryType;
    _refferalCode = refferalCode;
    _friendCode = friendCode;
    _onlineStatus = onlineStatus;
    _storeDescription = storeDescription;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _mobile = json['mobile'];
    _address = json['address'];
    _description = json['description'];
    _categoryId = json['category_id'];
    _perDCharge = json['per_d_charge'];
    _perHCharge = json['per_h_charge'];
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
    _bandDetails = json['band_details'] != null ? BandDetails.fromJson(json['band_details']) : null;
    _cityId = json['city_id'];
    _vehicleNo = json['vehicle_no'];
    _registarionCard = json['registarion_card'];
    _drivingLicense = json['driving_license'];
    _categoriesId = json['categories_id'];
    _companyName = json['company_name'];
    _roleUser = json['role_user'];
    _event = json['event'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _deliveryType = json['delivery_type'];
    _refferalCode = json['refferal_code'];
    _friendCode = json['friend_code'];
    _onlineStatus = json['online_status'];
    _storeDescription = json['store_description'];
  }
  String? _id;
  String? _email;
  String? _mobile;
  String? _address;
  String? _description;
  dynamic _categoryId;
  dynamic _perDCharge;
  dynamic _perHCharge;
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
  BandDetails? _bandDetails;
  String? _cityId;
  String? _vehicleNo;
  String? _registarionCard;
  String? _drivingLicense;
  String? _categoriesId;
  String? _companyName;
  String? _roleUser;
  String? _event;
  String? _latitude;
  String? _longitude;
  String? _deliveryType;
  String? _refferalCode;
  String? _friendCode;
  String? _onlineStatus;
  String? _storeDescription;
Data copyWith({  String? id,
  String? email,
  String? mobile,
  String? address,
  String? description,
  dynamic categoryId,
  dynamic perDCharge,
  dynamic perHCharge,
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
  BandDetails? bandDetails,
  String? cityId,
  String? vehicleNo,
  String? registarionCard,
  String? drivingLicense,
  String? categoriesId,
  String? companyName,
  String? roleUser,
  String? event,
  String? latitude,
  String? longitude,
  String? deliveryType,
  String? refferalCode,
  String? friendCode,
  String? onlineStatus,
  String? storeDescription,
}) => Data(  id: id ?? _id,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  description: description ?? _description,
  categoryId: categoryId ?? _categoryId,
  perDCharge: perDCharge ?? _perDCharge,
  perHCharge: perHCharge ?? _perHCharge,
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
  event: event ?? _event,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  deliveryType: deliveryType ?? _deliveryType,
  refferalCode: refferalCode ?? _refferalCode,
  friendCode: friendCode ?? _friendCode,
  onlineStatus: onlineStatus ?? _onlineStatus,
  storeDescription: storeDescription ?? _storeDescription,
);
  String? get id => _id;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get description => _description;
  dynamic get categoryId => _categoryId;
  dynamic get perDCharge => _perDCharge;
  dynamic get perHCharge => _perHCharge;
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
  BandDetails? get bandDetails => _bandDetails;
  String? get cityId => _cityId;
  String? get vehicleNo => _vehicleNo;
  String? get registarionCard => _registarionCard;
  String? get drivingLicense => _drivingLicense;
  String? get categoriesId => _categoriesId;
  String? get companyName => _companyName;
  String? get roleUser => _roleUser;
  String? get event => _event;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get deliveryType => _deliveryType;
  String? get refferalCode => _refferalCode;
  String? get friendCode => _friendCode;
  String? get onlineStatus => _onlineStatus;
  String? get storeDescription => _storeDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['description'] = _description;
    map['category_id'] = _categoryId;
    map['per_d_charge'] = _perDCharge;
    map['per_h_charge'] = _perHCharge;
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
    if (_bandDetails != null) {
      map['band_details'] = _bandDetails?.toJson();
    }
    map['city_id'] = _cityId;
    map['vehicle_no'] = _vehicleNo;
    map['registarion_card'] = _registarionCard;
    map['driving_license'] = _drivingLicense;
    map['categories_id'] = _categoriesId;
    map['company_name'] = _companyName;
    map['role_user'] = _roleUser;
    map['event'] = _event;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['delivery_type'] = _deliveryType;
    map['refferal_code'] = _refferalCode;
    map['friend_code'] = _friendCode;
    map['online_status'] = _onlineStatus;
    map['store_description'] = _storeDescription;
    return map;
  }

}

/// UPI : "86643156@ybl"

class BandDetails {
  BandDetails({
      String? upi,}){
    _upi = upi;
}

  BandDetails.fromJson(dynamic json) {
    _upi = json['UPI'];
  }
  String? _upi;
BandDetails copyWith({  String? upi,
}) => BandDetails(  upi: upi ?? _upi,
);
  String? get upi => _upi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UPI'] = _upi;
    return map;
  }

}