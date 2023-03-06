/// response_code : "1"
/// message : "Orders Found"
/// orders : {"order_id":"243","user_id":"66","total":"984.20","items":"[{\"product_id\":\"222\",\"quantity\":\"3\"},{\"product_id\":\"221\",\"quantity\":\"3\"}]","payment_mode":"wallet","address":"","date":"2023-02-09","datea":"2023-02-09","txn_id":"","p_status":"success","p_date":"","order_status":"3","mobile_no":"9876543210","vendor_id":"107","subtotal":"900","vendor_payment_admin":"20","gst_charge":"2.4","delivery_charge":"35","user_gst":"4.2","assign_id":"108","online_status":"0","otp":"3836","username":"Shivansh","address_id":"115","user_pay_gst":"45","id":"66","email":"shivansh@gmail.com","countrycode":"91","mobile":"9179374172","password":"25d55ad283aa400af464c76d713c07ad","profile_pic":"","facebook_id":"","type":"","isGold":"0","city":"","country":"","device_token":"","agreecheck":"0","status":"1","wallet":"2015.80","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-09 11:48:44","updated_at":"2023-02-09 12:26:00","refferal_code":"SOD692544","friend_code":"","addresses_id":"115","delivery_address":"New Palasia Rd, Harijan Colony, Indore, Madhya Pradesh 452001, India","driver_pay_amount":"32","products":[{"product_id":"222","cat_id":"4","subcat_id":"10","product_name":"fry","product_description":"tasty","product_price":"150","product_image":"https://developmentalphawizz.com/SOD_New/uploads/product_images/63e4dac967b9a.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"100","product_create_date":"2023-02-09 11:36:41","vendor_id":"107","other_image":"63e4dac96773d.jpg","product_status":"1","variant_name":"Full Plate","product_type":"Veg","tax":"0","quantity":"3"},{"product_id":"221","cat_id":"41","subcat_id":"42","product_name":"Paneer","product_description":"tasty","product_price":"300","product_image":"https://developmentalphawizz.com/SOD_New/uploads/product_images/63e4dab188f52.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"200","product_create_date":"2023-02-09 11:36:17","vendor_id":"107","other_image":"63e4dab1880b1.jpg","product_status":"1","variant_name":"Full Plate","product_type":"Veg","tax":"0","quantity":"3"}]}
/// status : "success"

class FoodDeliveryModel {
  FoodDeliveryModel({
      String? responseCode, 
      String? message, 
      FoodOrder? orders,
      String? status,}){
    _responseCode = responseCode;
    _message = message;
    _orders = orders;
    _status = status;
}

  FoodDeliveryModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _orders = json['orders'] != null ? FoodOrder.fromJson(json['orders']) : null;
    _status = json['status'];
  }
  String? _responseCode;
  String? _message;
  FoodOrder? _orders;
  String? _status;
FoodDeliveryModel copyWith({  String? responseCode,
  String? message,
  FoodOrder? orders,
  String? status,
}) => FoodDeliveryModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  orders: orders ?? _orders,
  status: status ?? _status,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  FoodOrder? get orders => _orders;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_orders != null) {
      map['orders'] = _orders?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

/// order_id : "243"
/// user_id : "66"
/// total : "984.20"
/// items : "[{\"product_id\":\"222\",\"quantity\":\"3\"},{\"product_id\":\"221\",\"quantity\":\"3\"}]"
/// payment_mode : "wallet"
/// address : ""
/// date : "2023-02-09"
/// datea : "2023-02-09"
/// txn_id : ""
/// p_status : "success"
/// p_date : ""
/// order_status : "3"
/// mobile_no : "9876543210"
/// vendor_id : "107"
/// subtotal : "900"
/// vendor_payment_admin : "20"
/// gst_charge : "2.4"
/// delivery_charge : "35"
/// user_gst : "4.2"
/// assign_id : "108"
/// online_status : "0"
/// otp : "3836"
/// username : "Shivansh"
/// address_id : "115"
/// user_pay_gst : "45"
/// id : "66"
/// email : "shivansh@gmail.com"
/// countrycode : "91"
/// mobile : "9179374172"
/// password : "25d55ad283aa400af464c76d713c07ad"
/// profile_pic : ""
/// facebook_id : ""
/// type : ""
/// isGold : "0"
/// city : ""
/// country : ""
/// device_token : ""
/// agreecheck : "0"
/// status : "1"
/// wallet : "2015.80"
/// oauth_provider : null
/// oauth_uid : null
/// last_login : null
/// created_at : "2023-02-09 11:48:44"
/// updated_at : "2023-02-09 12:26:00"
/// refferal_code : "SOD692544"
/// friend_code : ""
/// addresses_id : "115"
/// delivery_address : "New Palasia Rd, Harijan Colony, Indore, Madhya Pradesh 452001, India"
/// driver_pay_amount : "32"
/// products : [{"product_id":"222","cat_id":"4","subcat_id":"10","product_name":"fry","product_description":"tasty","product_price":"150","product_image":"https://developmentalphawizz.com/SOD_New/uploads/product_images/63e4dac967b9a.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"100","product_create_date":"2023-02-09 11:36:41","vendor_id":"107","other_image":"63e4dac96773d.jpg","product_status":"1","variant_name":"Full Plate","product_type":"Veg","tax":"0","quantity":"3"},{"product_id":"221","cat_id":"41","subcat_id":"42","product_name":"Paneer","product_description":"tasty","product_price":"300","product_image":"https://developmentalphawizz.com/SOD_New/uploads/product_images/63e4dab188f52.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"200","product_create_date":"2023-02-09 11:36:17","vendor_id":"107","other_image":"63e4dab1880b1.jpg","product_status":"1","variant_name":"Full Plate","product_type":"Veg","tax":"0","quantity":"3"}]

class FoodOrder {
  FoodOrder({
      String? orderId, 
      String? userId, 
      String? total, 
      String? items, 
      String? paymentMode, 
      String? address, 
      String? date, 
      String? datea, 
      String? txnId, 
      String? pStatus, 
      String? pDate, 
      String? orderStatus, 
      String? mobileNo, 
      String? vendorId, 
      String? subtotal, 
      String? vendorPaymentAdmin, 
      String? gstCharge, 
      String? deliveryCharge, 
      String? userGst, 
      String? assignId, 
      String? onlineStatus, 
      String? otp, 
      String? username, 
      String? addressId, 
      String? userPayGst, 
      String? id, 
      String? email, 
      String? countrycode, 
      String? mobile, 
      String? password, 
      String? profilePic, 
      String? facebookId, 
      String? type, 
      String? isGold, 
      String? city, 
      String? country, 
      String? deviceToken, 
      String? agreecheck, 
      String? status, 
      String? wallet, 
      dynamic oauthProvider, 
      dynamic oauthUid, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt, 
      String? refferalCode, 
      String? friendCode, 
      String? addressesId, 
      String? deliveryAddress, 
      String? driverPayAmount, 
      List<Products>? products,}){
    _orderId = orderId;
    _userId = userId;
    _total = total;
    _items = items;
    _paymentMode = paymentMode;
    _address = address;
    _date = date;
    _datea = datea;
    _txnId = txnId;
    _pStatus = pStatus;
    _pDate = pDate;
    _orderStatus = orderStatus;
    _mobileNo = mobileNo;
    _vendorId = vendorId;
    _subtotal = subtotal;
    _vendorPaymentAdmin = vendorPaymentAdmin;
    _gstCharge = gstCharge;
    _deliveryCharge = deliveryCharge;
    _userGst = userGst;
    _assignId = assignId;
    _onlineStatus = onlineStatus;
    _otp = otp;
    _username = username;
    _addressId = addressId;
    _userPayGst = userPayGst;
    _id = id;
    _email = email;
    _countrycode = countrycode;
    _mobile = mobile;
    _password = password;
    _profilePic = profilePic;
    _facebookId = facebookId;
    _type = type;
    _isGold = isGold;
    _city = city;
    _country = country;
    _deviceToken = deviceToken;
    _agreecheck = agreecheck;
    _status = status;
    _wallet = wallet;
    _oauthProvider = oauthProvider;
    _oauthUid = oauthUid;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _refferalCode = refferalCode;
    _friendCode = friendCode;
    _addressesId = addressesId;
    _deliveryAddress = deliveryAddress;
    _driverPayAmount = driverPayAmount;
    _products = products;
}

  FoodOrder.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _userId = json['user_id'];
    _total = json['total'];
    _items = json['items'];
    _paymentMode = json['payment_mode'];
    _address = json['address'];
    _date = json['date'];
    _datea = json['datea'];
    _txnId = json['txn_id'];
    _pStatus = json['p_status'];
    _pDate = json['p_date'];
    _orderStatus = json['order_status'];
    _mobileNo = json['mobile_no'];
    _vendorId = json['vendor_id'];
    _subtotal = json['subtotal'];
    _vendorPaymentAdmin = json['vendor_payment_admin'];
    _gstCharge = json['gst_charge'];
    _deliveryCharge = json['delivery_charge'];
    _userGst = json['user_gst'];
    _assignId = json['assign_id'];
    _onlineStatus = json['online_status'];
    _otp = json['otp'];
    _username = json['username'];
    _addressId = json['address_id'];
    _userPayGst = json['user_pay_gst'];
    _id = json['id'];
    _email = json['email'];
    _countrycode = json['countrycode'];
    _mobile = json['mobile'];
    _password = json['password'];
    _profilePic = json['profile_pic'];
    _facebookId = json['facebook_id'];
    _type = json['type'];
    _isGold = json['isGold'];
    _city = json['city'];
    _country = json['country'];
    _deviceToken = json['device_token'];
    _agreecheck = json['agreecheck'];
    _status = json['status'];
    _wallet = json['wallet'];
    _oauthProvider = json['oauth_provider'];
    _oauthUid = json['oauth_uid'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _refferalCode = json['refferal_code'];
    _friendCode = json['friend_code'];
    _addressesId = json['addresses_id'];
    _deliveryAddress = json['delivery_address'];
    _driverPayAmount = json['driver_pay_amount'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _orderId;
  String? _userId;
  String? _total;
  String? _items;
  String? _paymentMode;
  String? _address;
  String? _date;
  String? _datea;
  String? _txnId;
  String? _pStatus;
  String? _pDate;
  String? _orderStatus;
  String? _mobileNo;
  String? _vendorId;
  String? _subtotal;
  String? _vendorPaymentAdmin;
  String? _gstCharge;
  String? _deliveryCharge;
  String? _userGst;
  String? _assignId;
  String? _onlineStatus;
  String? _otp;
  String? _username;
  String? _addressId;
  String? _userPayGst;
  String? _id;
  String? _email;
  String? _countrycode;
  String? _mobile;
  String? _password;
  String? _profilePic;
  String? _facebookId;
  String? _type;
  String? _isGold;
  String? _city;
  String? _country;
  String? _deviceToken;
  String? _agreecheck;
  String? _status;
  String? _wallet;
  dynamic _oauthProvider;
  dynamic _oauthUid;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  String? _refferalCode;
  String? _friendCode;
  String? _addressesId;
  String? _deliveryAddress;
  String? _driverPayAmount;
  List<Products>? _products;
FoodOrder copyWith({  String? orderId,
  String? userId,
  String? total,
  String? items,
  String? paymentMode,
  String? address,
  String? date,
  String? datea,
  String? txnId,
  String? pStatus,
  String? pDate,
  String? orderStatus,
  String? mobileNo,
  String? vendorId,
  String? subtotal,
  String? vendorPaymentAdmin,
  String? gstCharge,
  String? deliveryCharge,
  String? userGst,
  String? assignId,
  String? onlineStatus,
  String? otp,
  String? username,
  String? addressId,
  String? userPayGst,
  String? id,
  String? email,
  String? countrycode,
  String? mobile,
  String? password,
  String? profilePic,
  String? facebookId,
  String? type,
  String? isGold,
  String? city,
  String? country,
  String? deviceToken,
  String? agreecheck,
  String? status,
  String? wallet,
  dynamic oauthProvider,
  dynamic oauthUid,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
  String? refferalCode,
  String? friendCode,
  String? addressesId,
  String? deliveryAddress,
  String? driverPayAmount,
  List<Products>? products,
}) => FoodOrder(  orderId: orderId ?? _orderId,
  userId: userId ?? _userId,
  total: total ?? _total,
  items: items ?? _items,
  paymentMode: paymentMode ?? _paymentMode,
  address: address ?? _address,
  date: date ?? _date,
  datea: datea ?? _datea,
  txnId: txnId ?? _txnId,
  pStatus: pStatus ?? _pStatus,
  pDate: pDate ?? _pDate,
  orderStatus: orderStatus ?? _orderStatus,
  mobileNo: mobileNo ?? _mobileNo,
  vendorId: vendorId ?? _vendorId,
  subtotal: subtotal ?? _subtotal,
  vendorPaymentAdmin: vendorPaymentAdmin ?? _vendorPaymentAdmin,
  gstCharge: gstCharge ?? _gstCharge,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  userGst: userGst ?? _userGst,
  assignId: assignId ?? _assignId,
  onlineStatus: onlineStatus ?? _onlineStatus,
  otp: otp ?? _otp,
  username: username ?? _username,
  addressId: addressId ?? _addressId,
  userPayGst: userPayGst ?? _userPayGst,
  id: id ?? _id,
  email: email ?? _email,
  countrycode: countrycode ?? _countrycode,
  mobile: mobile ?? _mobile,
  password: password ?? _password,
  profilePic: profilePic ?? _profilePic,
  facebookId: facebookId ?? _facebookId,
  type: type ?? _type,
  isGold: isGold ?? _isGold,
  city: city ?? _city,
  country: country ?? _country,
  deviceToken: deviceToken ?? _deviceToken,
  agreecheck: agreecheck ?? _agreecheck,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  oauthProvider: oauthProvider ?? _oauthProvider,
  oauthUid: oauthUid ?? _oauthUid,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  refferalCode: refferalCode ?? _refferalCode,
  friendCode: friendCode ?? _friendCode,
  addressesId: addressesId ?? _addressesId,
  deliveryAddress: deliveryAddress ?? _deliveryAddress,
  driverPayAmount: driverPayAmount ?? _driverPayAmount,
  products: products ?? _products,
);
  String? get orderId => _orderId;
  String? get userId => _userId;
  String? get total => _total;
  String? get items => _items;
  String? get paymentMode => _paymentMode;
  String? get address => _address;
  String? get date => _date;
  String? get datea => _datea;
  String? get txnId => _txnId;
  String? get pStatus => _pStatus;
  String? get pDate => _pDate;
  String? get orderStatus => _orderStatus;
  String? get mobileNo => _mobileNo;
  String? get vendorId => _vendorId;
  String? get subtotal => _subtotal;
  String? get vendorPaymentAdmin => _vendorPaymentAdmin;
  String? get gstCharge => _gstCharge;
  String? get deliveryCharge => _deliveryCharge;
  String? get userGst => _userGst;
  String? get assignId => _assignId;
  String? get onlineStatus => _onlineStatus;
  String? get otp => _otp;
  String? get username => _username;
  String? get addressId => _addressId;
  String? get userPayGst => _userPayGst;
  String? get id => _id;
  String? get email => _email;
  String? get countrycode => _countrycode;
  String? get mobile => _mobile;
  String? get password => _password;
  String? get profilePic => _profilePic;
  String? get facebookId => _facebookId;
  String? get type => _type;
  String? get isGold => _isGold;
  String? get city => _city;
  String? get country => _country;
  String? get deviceToken => _deviceToken;
  String? get agreecheck => _agreecheck;
  String? get status => _status;
  String? get wallet => _wallet;
  dynamic get oauthProvider => _oauthProvider;
  dynamic get oauthUid => _oauthUid;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get refferalCode => _refferalCode;
  String? get friendCode => _friendCode;
  String? get addressesId => _addressesId;
  String? get deliveryAddress => _deliveryAddress;
  String? get driverPayAmount => _driverPayAmount;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['user_id'] = _userId;
    map['total'] = _total;
    map['items'] = _items;
    map['payment_mode'] = _paymentMode;
    map['address'] = _address;
    map['date'] = _date;
    map['datea'] = _datea;
    map['txn_id'] = _txnId;
    map['p_status'] = _pStatus;
    map['p_date'] = _pDate;
    map['order_status'] = _orderStatus;
    map['mobile_no'] = _mobileNo;
    map['vendor_id'] = _vendorId;
    map['subtotal'] = _subtotal;
    map['vendor_payment_admin'] = _vendorPaymentAdmin;
    map['gst_charge'] = _gstCharge;
    map['delivery_charge'] = _deliveryCharge;
    map['user_gst'] = _userGst;
    map['assign_id'] = _assignId;
    map['online_status'] = _onlineStatus;
    map['otp'] = _otp;
    map['username'] = _username;
    map['address_id'] = _addressId;
    map['user_pay_gst'] = _userPayGst;
    map['id'] = _id;
    map['email'] = _email;
    map['countrycode'] = _countrycode;
    map['mobile'] = _mobile;
    map['password'] = _password;
    map['profile_pic'] = _profilePic;
    map['facebook_id'] = _facebookId;
    map['type'] = _type;
    map['isGold'] = _isGold;
    map['city'] = _city;
    map['country'] = _country;
    map['device_token'] = _deviceToken;
    map['agreecheck'] = _agreecheck;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['oauth_provider'] = _oauthProvider;
    map['oauth_uid'] = _oauthUid;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['refferal_code'] = _refferalCode;
    map['friend_code'] = _friendCode;
    map['addresses_id'] = _addressesId;
    map['delivery_address'] = _deliveryAddress;
    map['driver_pay_amount'] = _driverPayAmount;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : "222"
/// cat_id : "4"
/// subcat_id : "10"
/// product_name : "fry"
/// product_description : "tasty"
/// product_price : "150"
/// product_image : "https://developmentalphawizz.com/SOD_New/uploads/product_images/63e4dac967b9a.jpg"
/// pro_ratings : "0.0"
/// role_id : "0"
/// selling_price : "100"
/// product_create_date : "2023-02-09 11:36:41"
/// vendor_id : "107"
/// other_image : "63e4dac96773d.jpg"
/// product_status : "1"
/// variant_name : "Full Plate"
/// product_type : "Veg"
/// tax : "0"
/// quantity : "3"

class Products {
  Products({
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
      String? productStatus, 
      String? variantName, 
      String? productType, 
      String? tax, 
      String? quantity,}){
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
    _productStatus = productStatus;
    _variantName = variantName;
    _productType = productType;
    _tax = tax;
    _quantity = quantity;
}

  Products.fromJson(dynamic json) {
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
    _productStatus = json['product_status'];
    _variantName = json['variant_name'];
    _productType = json['product_type'];
    _tax = json['tax'];
    _quantity = json['quantity'];
  }
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
  String? _productStatus;
  String? _variantName;
  String? _productType;
  String? _tax;
  String? _quantity;
Products copyWith({  String? productId,
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
  String? productStatus,
  String? variantName,
  String? productType,
  String? tax,
  String? quantity,
}) => Products(  productId: productId ?? _productId,
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
  productStatus: productStatus ?? _productStatus,
  variantName: variantName ?? _variantName,
  productType: productType ?? _productType,
  tax: tax ?? _tax,
  quantity: quantity ?? _quantity,
);
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
  String? get productStatus => _productStatus;
  String? get variantName => _variantName;
  String? get productType => _productType;
  String? get tax => _tax;
  String? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['product_status'] = _productStatus;
    map['variant_name'] = _variantName;
    map['product_type'] = _productType;
    map['tax'] = _tax;
    map['quantity'] = _quantity;
    return map;
  }

}