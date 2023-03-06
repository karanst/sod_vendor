/// status : "0"
/// message : "Get Review Data"
/// products : [{"rev_id":"1","rev_user":"1","rev_pro":"9","rev_stars":"2.0","rev_text":"Test review","rev_date":"2023-01-13 11:27:23","id":"1","username":"devesh","email":"Devesh@gmail.com","countrycode":"91","mobile":"9993224906","password":"d41d8cd98f00b204e9800998ecf8427e","profile_pic":"","facebook_id":"","type":"","isGold":"0","address":"151, Ward 35, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","city":"","country":"","device_token":"cKXjOdiPQ8GGhZ49DmCvn1:APA91bHVJHQxgzQK6fsEaY7q5bR4A8XXabTlHDMMc10rCUy9yU9PH97wjWUYeKupB1xUS-LLD9Be8ps9bxmsCAtU23xqcebWBFxtofRgpfpsdEzkbPmkG_dThYnn4NHP6C0G2H_zdaSb","agreecheck":"0","otp":"4772","status":"1","wallet":"6000.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-01-13 05:42:52","updated_at":"2023-01-13 11:12:19","description":"","category_id":null,"per_d_charge":null,"per_h_charge":null,"experience":null,"vehicle_number":null,"vehicle_type":null,"rc_book":null,"per_km_charge":null,"lat":"22.7469071","lang":"75.8980732","uname":"Devesh","profile_image":"https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c0f7fbbf011.png","balance":"0.00","roll":"1","adhar_card":"63c0ef5cd6817.jpg","pancard":"63c0ef5cd795f.jpg","gst_no":"636373773363","fssai":"73636522525","store_name":"Devesh Stores","band_details":"{\"UPI\":\"8770496665@ybl\"}","city_id":"0","vehicle_no":"","registarion_card":"","driving_license":"","categories_id":"","company_name":"","role_user":"","event":"","latitude":"22.7195687","longitude":"75.8577258","delivery_type":"","product_id":"9","cat_id":"1","subcat_id":"7","product_name":"Pizza","product_description":"Junk food is used to describe food and drinks low in nutrients (e.g. vitamins, minerals and fibre) and high in kilojoules, saturated fat, added sugar and/or added salt. ","product_price":"500","product_image":"63c0fa65889ae.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"399","product_create_date":"2023-01-13 06:29:57","vendor_id":"1","other_image":""}]

class CustomerReviewsModel {
  CustomerReviewsModel({
      String? status, 
      String? message, 
      List<Products>? products,}){
    _status = status;
    _message = message;
    _products = products;
}

  CustomerReviewsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Products>? _products;
CustomerReviewsModel copyWith({  String? status,
  String? message,
  List<Products>? products,
}) => CustomerReviewsModel(  status: status ?? _status,
  message: message ?? _message,
  products: products ?? _products,
);
  String? get status => _status;
  String? get message => _message;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// rev_id : "1"
/// rev_user : "1"
/// rev_pro : "9"
/// rev_stars : "2.0"
/// rev_text : "Test review"
/// rev_date : "2023-01-13 11:27:23"
/// id : "1"
/// username : "devesh"
/// email : "Devesh@gmail.com"
/// countrycode : "91"
/// mobile : "9993224906"
/// password : "d41d8cd98f00b204e9800998ecf8427e"
/// profile_pic : ""
/// facebook_id : ""
/// type : ""
/// isGold : "0"
/// address : "151, Ward 35, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India"
/// city : ""
/// country : ""
/// device_token : "cKXjOdiPQ8GGhZ49DmCvn1:APA91bHVJHQxgzQK6fsEaY7q5bR4A8XXabTlHDMMc10rCUy9yU9PH97wjWUYeKupB1xUS-LLD9Be8ps9bxmsCAtU23xqcebWBFxtofRgpfpsdEzkbPmkG_dThYnn4NHP6C0G2H_zdaSb"
/// agreecheck : "0"
/// otp : "4772"
/// status : "1"
/// wallet : "6000.00"
/// oauth_provider : null
/// oauth_uid : null
/// last_login : null
/// created_at : "2023-01-13 05:42:52"
/// updated_at : "2023-01-13 11:12:19"
/// description : ""
/// category_id : null
/// per_d_charge : null
/// per_h_charge : null
/// experience : null
/// vehicle_number : null
/// vehicle_type : null
/// rc_book : null
/// per_km_charge : null
/// lat : "22.7469071"
/// lang : "75.8980732"
/// uname : "Devesh"
/// profile_image : "https://developmentalphawizz.com/SOD_New//uploads/profile_pics/63c0f7fbbf011.png"
/// balance : "0.00"
/// roll : "1"
/// adhar_card : "63c0ef5cd6817.jpg"
/// pancard : "63c0ef5cd795f.jpg"
/// gst_no : "636373773363"
/// fssai : "73636522525"
/// store_name : "Devesh Stores"
/// band_details : "{\"UPI\":\"8770496665@ybl\"}"
/// city_id : "0"
/// vehicle_no : ""
/// registarion_card : ""
/// driving_license : ""
/// categories_id : ""
/// company_name : ""
/// role_user : ""
/// event : ""
/// latitude : "22.7195687"
/// longitude : "75.8577258"
/// delivery_type : ""
/// product_id : "9"
/// cat_id : "1"
/// subcat_id : "7"
/// product_name : "Pizza"
/// product_description : "Junk food is used to describe food and drinks low in nutrients (e.g. vitamins, minerals and fibre) and high in kilojoules, saturated fat, added sugar and/or added salt. "
/// product_price : "500"
/// product_image : "63c0fa65889ae.jpg"
/// pro_ratings : "0.0"
/// role_id : "0"
/// selling_price : "399"
/// product_create_date : "2023-01-13 06:29:57"
/// vendor_id : "1"
/// other_image : ""

class Products {
  Products({
      String? revId, 
      String? revUser, 
      String? revPro, 
      String? revStars, 
      String? revText, 
      String? revDate, 
      String? id, 
      String? username, 
      String? email, 
      String? countrycode, 
      String? mobile, 
      String? password, 
      String? profilePic, 
      String? facebookId, 
      String? type, 
      String? isGold, 
      String? address, 
      String? city, 
      String? country, 
      String? deviceToken, 
      String? agreecheck, 
      String? otp, 
      String? status, 
      String? wallet, 
      dynamic oauthProvider, 
      dynamic oauthUid, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt, 
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
      String? profileImage, 
      String? balance, 
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
      String? event, 
      String? latitude, 
      String? longitude, 
      String? deliveryType, 
      String? productId, 
      String? catId, 
      String? subcatId, 
      String? productName, 
      String? productDescription, 
      String? productPrice, 
      String? productImage, 
      String? proRatings, 
      String? roleId, 
      String? sellingPrice, 
      String? productCreateDate, 
      String? vendorId, 
      String? otherImage,}){
    _revId = revId;
    _revUser = revUser;
    _revPro = revPro;
    _revStars = revStars;
    _revText = revText;
    _revDate = revDate;
    _id = id;
    _username = username;
    _email = email;
    _countrycode = countrycode;
    _mobile = mobile;
    _password = password;
    _profilePic = profilePic;
    _facebookId = facebookId;
    _type = type;
    _isGold = isGold;
    _address = address;
    _city = city;
    _country = country;
    _deviceToken = deviceToken;
    _agreecheck = agreecheck;
    _otp = otp;
    _status = status;
    _wallet = wallet;
    _oauthProvider = oauthProvider;
    _oauthUid = oauthUid;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
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
    _profileImage = profileImage;
    _balance = balance;
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
    _productId = productId;
    _catId = catId;
    _subcatId = subcatId;
    _productName = productName;
    _productDescription = productDescription;
    _productPrice = productPrice;
    _productImage = productImage;
    _proRatings = proRatings;
    _roleId = roleId;
    _sellingPrice = sellingPrice;
    _productCreateDate = productCreateDate;
    _vendorId = vendorId;
    _otherImage = otherImage;
}

  Products.fromJson(dynamic json) {
    _revId = json['rev_id'];
    _revUser = json['rev_user'];
    _revPro = json['rev_pro'];
    _revStars = json['rev_stars'];
    _revText = json['rev_text'];
    _revDate = json['rev_date'];
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _countrycode = json['countrycode'];
    _mobile = json['mobile'];
    _password = json['password'];
    _profilePic = json['profile_pic'];
    _facebookId = json['facebook_id'];
    _type = json['type'];
    _isGold = json['isGold'];
    _address = json['address'];
    _city = json['city'];
    _country = json['country'];
    _deviceToken = json['device_token'];
    _agreecheck = json['agreecheck'];
    _otp = json['otp'];
    _status = json['status'];
    _wallet = json['wallet'];
    _oauthProvider = json['oauth_provider'];
    _oauthUid = json['oauth_uid'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
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
    _profileImage = json['profile_image'];
    _balance = json['balance'];
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
    _event = json['event'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _deliveryType = json['delivery_type'];
    _productId = json['product_id'];
    _catId = json['cat_id'];
    _subcatId = json['subcat_id'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _productPrice = json['product_price'];
    _productImage = json['product_image'];
    _proRatings = json['pro_ratings'];
    _roleId = json['role_id'];
    _sellingPrice = json['selling_price'];
    _productCreateDate = json['product_create_date'];
    _vendorId = json['vendor_id'];
    _otherImage = json['other_image'];
  }
  String? _revId;
  String? _revUser;
  String? _revPro;
  String? _revStars;
  String? _revText;
  String? _revDate;
  String? _id;
  String? _username;
  String? _email;
  String? _countrycode;
  String? _mobile;
  String? _password;
  String? _profilePic;
  String? _facebookId;
  String? _type;
  String? _isGold;
  String? _address;
  String? _city;
  String? _country;
  String? _deviceToken;
  String? _agreecheck;
  String? _otp;
  String? _status;
  String? _wallet;
  dynamic _oauthProvider;
  dynamic _oauthUid;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
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
  String? _profileImage;
  String? _balance;
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
  String? _event;
  String? _latitude;
  String? _longitude;
  String? _deliveryType;
  String? _productId;
  String? _catId;
  String? _subcatId;
  String? _productName;
  String? _productDescription;
  String? _productPrice;
  String? _productImage;
  String? _proRatings;
  String? _roleId;
  String? _sellingPrice;
  String? _productCreateDate;
  String? _vendorId;
  String? _otherImage;
Products copyWith({  String? revId,
  String? revUser,
  String? revPro,
  String? revStars,
  String? revText,
  String? revDate,
  String? id,
  String? username,
  String? email,
  String? countrycode,
  String? mobile,
  String? password,
  String? profilePic,
  String? facebookId,
  String? type,
  String? isGold,
  String? address,
  String? city,
  String? country,
  String? deviceToken,
  String? agreecheck,
  String? otp,
  String? status,
  String? wallet,
  dynamic oauthProvider,
  dynamic oauthUid,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
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
  String? profileImage,
  String? balance,
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
  String? event,
  String? latitude,
  String? longitude,
  String? deliveryType,
  String? productId,
  String? catId,
  String? subcatId,
  String? productName,
  String? productDescription,
  String? productPrice,
  String? productImage,
  String? proRatings,
  String? roleId,
  String? sellingPrice,
  String? productCreateDate,
  String? vendorId,
  String? otherImage,
}) => Products(  revId: revId ?? _revId,
  revUser: revUser ?? _revUser,
  revPro: revPro ?? _revPro,
  revStars: revStars ?? _revStars,
  revText: revText ?? _revText,
  revDate: revDate ?? _revDate,
  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
  countrycode: countrycode ?? _countrycode,
  mobile: mobile ?? _mobile,
  password: password ?? _password,
  profilePic: profilePic ?? _profilePic,
  facebookId: facebookId ?? _facebookId,
  type: type ?? _type,
  isGold: isGold ?? _isGold,
  address: address ?? _address,
  city: city ?? _city,
  country: country ?? _country,
  deviceToken: deviceToken ?? _deviceToken,
  agreecheck: agreecheck ?? _agreecheck,
  otp: otp ?? _otp,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  oauthProvider: oauthProvider ?? _oauthProvider,
  oauthUid: oauthUid ?? _oauthUid,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
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
  profileImage: profileImage ?? _profileImage,
  balance: balance ?? _balance,
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
  productId: productId ?? _productId,
  catId: catId ?? _catId,
  subcatId: subcatId ?? _subcatId,
  productName: productName ?? _productName,
  productDescription: productDescription ?? _productDescription,
  productPrice: productPrice ?? _productPrice,
  productImage: productImage ?? _productImage,
  proRatings: proRatings ?? _proRatings,
  roleId: roleId ?? _roleId,
  sellingPrice: sellingPrice ?? _sellingPrice,
  productCreateDate: productCreateDate ?? _productCreateDate,
  vendorId: vendorId ?? _vendorId,
  otherImage: otherImage ?? _otherImage,
);
  String? get revId => _revId;
  String? get revUser => _revUser;
  String? get revPro => _revPro;
  String? get revStars => _revStars;
  String? get revText => _revText;
  String? get revDate => _revDate;
  String? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get countrycode => _countrycode;
  String? get mobile => _mobile;
  String? get password => _password;
  String? get profilePic => _profilePic;
  String? get facebookId => _facebookId;
  String? get type => _type;
  String? get isGold => _isGold;
  String? get address => _address;
  String? get city => _city;
  String? get country => _country;
  String? get deviceToken => _deviceToken;
  String? get agreecheck => _agreecheck;
  String? get otp => _otp;
  String? get status => _status;
  String? get wallet => _wallet;
  dynamic get oauthProvider => _oauthProvider;
  dynamic get oauthUid => _oauthUid;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
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
  String? get profileImage => _profileImage;
  String? get balance => _balance;
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
  String? get event => _event;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get deliveryType => _deliveryType;
  String? get productId => _productId;
  String? get catId => _catId;
  String? get subcatId => _subcatId;
  String? get productName => _productName;
  String? get productDescription => _productDescription;
  String? get productPrice => _productPrice;
  String? get productImage => _productImage;
  String? get proRatings => _proRatings;
  String? get roleId => _roleId;
  String? get sellingPrice => _sellingPrice;
  String? get productCreateDate => _productCreateDate;
  String? get vendorId => _vendorId;
  String? get otherImage => _otherImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rev_id'] = _revId;
    map['rev_user'] = _revUser;
    map['rev_pro'] = _revPro;
    map['rev_stars'] = _revStars;
    map['rev_text'] = _revText;
    map['rev_date'] = _revDate;
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['countrycode'] = _countrycode;
    map['mobile'] = _mobile;
    map['password'] = _password;
    map['profile_pic'] = _profilePic;
    map['facebook_id'] = _facebookId;
    map['type'] = _type;
    map['isGold'] = _isGold;
    map['address'] = _address;
    map['city'] = _city;
    map['country'] = _country;
    map['device_token'] = _deviceToken;
    map['agreecheck'] = _agreecheck;
    map['otp'] = _otp;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['oauth_provider'] = _oauthProvider;
    map['oauth_uid'] = _oauthUid;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
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
    map['profile_image'] = _profileImage;
    map['balance'] = _balance;
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
    map['event'] = _event;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['delivery_type'] = _deliveryType;
    map['product_id'] = _productId;
    map['cat_id'] = _catId;
    map['subcat_id'] = _subcatId;
    map['product_name'] = _productName;
    map['product_description'] = _productDescription;
    map['product_price'] = _productPrice;
    map['product_image'] = _productImage;
    map['pro_ratings'] = _proRatings;
    map['role_id'] = _roleId;
    map['selling_price'] = _sellingPrice;
    map['product_create_date'] = _productCreateDate;
    map['vendor_id'] = _vendorId;
    map['other_image'] = _otherImage;
    return map;
  }

}