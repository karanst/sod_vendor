/// response_code : "1"
/// msg : "My Bookings"
/// data : [{"booking_id":"131","subtotal":"3360.00","date":"2023-02-15","vendor_payemnt_amount":"3024","gst_charge":"0","vendor_Gst":"360","admin_commsion":"","platform_charge":"336","delivery_charge":"","payment_mode":"wallet","address":"Vaishali Nagar, Jaipur, Rajasthan, India","txn_id":"","status":"3","username":"Shivansh","mobile":"9179374172","vendor_name":"Japiuriya Mehndi","vendor_mobile":"9638528529","vendor_address":"151, Ward 35, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","services":[{"service_id":"50","hours":null,"subtotal":"3000","no_of_person":"10"}],"products":[{"id":"50","artist_name":"japiuriya Mehndi ","category_id":"1","sub_id":"16","services_image":"https://developmentalphawizz.com/SOD_New/uploads/1676441173Screenshot_2023-01-28-13-35-47-99_40deb401b9ffe8e1df2f1cc5ba480b12.jpg","profile_image":"63ec765550cd8.jpg","mrp_price":"350","special_price":"300","v_id":"118","roll":"5","ser_desc":"this","service_status":"1","tax_status":"0","gst_amount":"0"}]},{"booking_id":"130","subtotal":"3360.00","date":"2023-02-15","vendor_payemnt_amount":"3024","gst_charge":"0","vendor_Gst":"360","admin_commsion":"","platform_charge":"336","delivery_charge":"","payment_mode":"Razorpay","address":"Vaishali Nagar, Jaipur, Rajasthan, India","txn_id":"pay_LGdkyrUpgJyJge","status":"3","username":"Shivansh","mobile":"9179374172","vendor_name":"Japiuriya Mehndi","vendor_mobile":"9638528529","vendor_address":"151, Ward 35, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","services":[{"service_id":"50","hours":null,"subtotal":"3000","no_of_person":"10"}],"products":[{"id":"50","artist_name":"japiuriya Mehndi ","category_id":"1","sub_id":"16","services_image":"https://developmentalphawizz.com/SOD_New/uploads/1676441173Screenshot_2023-01-28-13-35-47-99_40deb401b9ffe8e1df2f1cc5ba480b12.jpg","profile_image":"63ec765550cd8.jpg","mrp_price":"350","special_price":"300","v_id":"118","roll":"5","ser_desc":"this","service_status":"1","tax_status":"0","gst_amount":"0"}]},{"booking_id":"129","subtotal":"3360.00","date":"2023-02-15","vendor_payemnt_amount":"3024","gst_charge":"0","vendor_Gst":"360","admin_commsion":"","platform_charge":"336","delivery_charge":"","payment_mode":"COD","address":"Vaishali Nagar, Jaipur, Rajasthan, India","txn_id":"","status":"3","username":"Shivansh","mobile":"9179374172","vendor_name":"Japiuriya Mehndi","vendor_mobile":"9638528529","vendor_address":"151, Ward 35, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","services":[{"service_id":"50","hours":null,"subtotal":"3000","no_of_person":"10"}],"products":[{"id":"50","artist_name":"japiuriya Mehndi ","category_id":"1","sub_id":"16","services_image":"https://developmentalphawizz.com/SOD_New/uploads/1676441173Screenshot_2023-01-28-13-35-47-99_40deb401b9ffe8e1df2f1cc5ba480b12.jpg","profile_image":"63ec765550cd8.jpg","mrp_price":"350","special_price":"300","v_id":"118","roll":"5","ser_desc":"this","service_status":"1","tax_status":"0","gst_amount":"0"}]}]

class VendorBookingModel {
  VendorBookingModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  VendorBookingModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
VendorBookingModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => VendorBookingModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// booking_id : "131"
/// subtotal : "3360.00"
/// date : "2023-02-15"
/// vendor_payemnt_amount : "3024"
/// gst_charge : "0"
/// vendor_Gst : "360"
/// admin_commsion : ""
/// platform_charge : "336"
/// delivery_charge : ""
/// payment_mode : "wallet"
/// address : "Vaishali Nagar, Jaipur, Rajasthan, India"
/// txn_id : ""
/// status : "3"
/// username : "Shivansh"
/// mobile : "9179374172"
/// vendor_name : "Japiuriya Mehndi"
/// vendor_mobile : "9638528529"
/// vendor_address : "151, Ward 35, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India"
/// services : [{"service_id":"50","hours":null,"subtotal":"3000","no_of_person":"10"}]
/// products : [{"id":"50","artist_name":"japiuriya Mehndi ","category_id":"1","sub_id":"16","services_image":"https://developmentalphawizz.com/SOD_New/uploads/1676441173Screenshot_2023-01-28-13-35-47-99_40deb401b9ffe8e1df2f1cc5ba480b12.jpg","profile_image":"63ec765550cd8.jpg","mrp_price":"350","special_price":"300","v_id":"118","roll":"5","ser_desc":"this","service_status":"1","tax_status":"0","gst_amount":"0"}]

class Data {
  Data({
      String? bookingId, 
      String? subtotal, 
      String? date, 
      String? vendorPayemntAmount, 
      String? gstCharge, 
      String? vendorGst, 
      String? adminCommsion, 
      String? platformCharge, 
      String? deliveryCharge, 
      String? paymentMode, 
      String? address, 
      String? txnId, 
      String? status, 
      String? username, 
      String? mobile, 
      String? vendorName, 
      String? vendorMobile, 
      String? vendorAddress, 
      List<Services>? services, 
      List<Products>? products,}){
    _bookingId = bookingId;
    _subtotal = subtotal;
    _date = date;
    _vendorPayemntAmount = vendorPayemntAmount;
    _gstCharge = gstCharge;
    _vendorGst = vendorGst;
    _adminCommsion = adminCommsion;
    _platformCharge = platformCharge;
    _deliveryCharge = deliveryCharge;
    _paymentMode = paymentMode;
    _address = address;
    _txnId = txnId;
    _status = status;
    _username = username;
    _mobile = mobile;
    _vendorName = vendorName;
    _vendorMobile = vendorMobile;
    _vendorAddress = vendorAddress;
    _services = services;
    _products = products;
}

  Data.fromJson(dynamic json) {
    _bookingId = json['booking_id'];
    _subtotal = json['subtotal'];
    _date = json['date'];
    _vendorPayemntAmount = json['vendor_payemnt_amount'];
    _gstCharge = json['gst_charge'];
    _vendorGst = json['vendor_Gst'];
    _adminCommsion = json['admin_commsion'];
    _platformCharge = json['platform_charge'];
    _deliveryCharge = json['delivery_charge'];
    _paymentMode = json['payment_mode'];
    _address = json['address'];
    _txnId = json['txn_id'];
    _status = json['status'];
    _username = json['username'];
    _mobile = json['mobile'];
    _vendorName = json['vendor_name'];
    _vendorMobile = json['vendor_mobile'];
    _vendorAddress = json['vendor_address'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _bookingId;
  String? _subtotal;
  String? _date;
  String? _vendorPayemntAmount;
  String? _gstCharge;
  String? _vendorGst;
  String? _adminCommsion;
  String? _platformCharge;
  String? _deliveryCharge;
  String? _paymentMode;
  String? _address;
  String? _txnId;
  String? _status;
  String? _username;
  String? _mobile;
  String? _vendorName;
  String? _vendorMobile;
  String? _vendorAddress;
  List<Services>? _services;
  List<Products>? _products;
Data copyWith({  String? bookingId,
  String? subtotal,
  String? date,
  String? vendorPayemntAmount,
  String? gstCharge,
  String? vendorGst,
  String? adminCommsion,
  String? platformCharge,
  String? deliveryCharge,
  String? paymentMode,
  String? address,
  String? txnId,
  String? status,
  String? username,
  String? mobile,
  String? vendorName,
  String? vendorMobile,
  String? vendorAddress,
  List<Services>? services,
  List<Products>? products,
}) => Data(  bookingId: bookingId ?? _bookingId,
  subtotal: subtotal ?? _subtotal,
  date: date ?? _date,
  vendorPayemntAmount: vendorPayemntAmount ?? _vendorPayemntAmount,
  gstCharge: gstCharge ?? _gstCharge,
  vendorGst: vendorGst ?? _vendorGst,
  adminCommsion: adminCommsion ?? _adminCommsion,
  platformCharge: platformCharge ?? _platformCharge,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  paymentMode: paymentMode ?? _paymentMode,
  address: address ?? _address,
  txnId: txnId ?? _txnId,
  status: status ?? _status,
  username: username ?? _username,
  mobile: mobile ?? _mobile,
  vendorName: vendorName ?? _vendorName,
  vendorMobile: vendorMobile ?? _vendorMobile,
  vendorAddress: vendorAddress ?? _vendorAddress,
  services: services ?? _services,
  products: products ?? _products,
);
  String? get bookingId => _bookingId;
  String? get subtotal => _subtotal;
  String? get date => _date;
  String? get vendorPayemntAmount => _vendorPayemntAmount;
  String? get gstCharge => _gstCharge;
  String? get vendorGst => _vendorGst;
  String? get adminCommsion => _adminCommsion;
  String? get platformCharge => _platformCharge;
  String? get deliveryCharge => _deliveryCharge;
  String? get paymentMode => _paymentMode;
  String? get address => _address;
  String? get txnId => _txnId;
  String? get status => _status;
  String? get username => _username;
  String? get mobile => _mobile;
  String? get vendorName => _vendorName;
  String? get vendorMobile => _vendorMobile;
  String? get vendorAddress => _vendorAddress;
  List<Services>? get services => _services;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = _bookingId;
    map['subtotal'] = _subtotal;
    map['date'] = _date;
    map['vendor_payemnt_amount'] = _vendorPayemntAmount;
    map['gst_charge'] = _gstCharge;
    map['vendor_Gst'] = _vendorGst;
    map['admin_commsion'] = _adminCommsion;
    map['platform_charge'] = _platformCharge;
    map['delivery_charge'] = _deliveryCharge;
    map['payment_mode'] = _paymentMode;
    map['address'] = _address;
    map['txn_id'] = _txnId;
    map['status'] = _status;
    map['username'] = _username;
    map['mobile'] = _mobile;
    map['vendor_name'] = _vendorName;
    map['vendor_mobile'] = _vendorMobile;
    map['vendor_address'] = _vendorAddress;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "50"
/// artist_name : "japiuriya Mehndi "
/// category_id : "1"
/// sub_id : "16"
/// services_image : "https://developmentalphawizz.com/SOD_New/uploads/1676441173Screenshot_2023-01-28-13-35-47-99_40deb401b9ffe8e1df2f1cc5ba480b12.jpg"
/// profile_image : "63ec765550cd8.jpg"
/// mrp_price : "350"
/// special_price : "300"
/// v_id : "118"
/// roll : "5"
/// ser_desc : "this"
/// service_status : "1"
/// tax_status : "0"
/// gst_amount : "0"

class Products {
  Products({
      String? id, 
      String? artistName, 
      String? categoryId, 
      String? subId, 
      String? servicesImage, 
      String? profileImage, 
      String? mrpPrice, 
      String? specialPrice, 
      String? vId, 
      String? roll, 
      String? serDesc, 
      String? serviceStatus, 
      String? taxStatus, 
      String? gstAmount,}){
    _id = id;
    _artistName = artistName;
    _categoryId = categoryId;
    _subId = subId;
    _servicesImage = servicesImage;
    _profileImage = profileImage;
    _mrpPrice = mrpPrice;
    _specialPrice = specialPrice;
    _vId = vId;
    _roll = roll;
    _serDesc = serDesc;
    _serviceStatus = serviceStatus;
    _taxStatus = taxStatus;
    _gstAmount = gstAmount;
}

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _artistName = json['artist_name'];
    _categoryId = json['category_id'];
    _subId = json['sub_id'];
    _servicesImage = json['services_image'];
    _profileImage = json['profile_image'];
    _mrpPrice = json['mrp_price'];
    _specialPrice = json['special_price'];
    _vId = json['v_id'];
    _roll = json['roll'];
    _serDesc = json['ser_desc'];
    _serviceStatus = json['service_status'];
    _taxStatus = json['tax_status'];
    _gstAmount = json['gst_amount'];
  }
  String? _id;
  String? _artistName;
  String? _categoryId;
  String? _subId;
  String? _servicesImage;
  String? _profileImage;
  String? _mrpPrice;
  String? _specialPrice;
  String? _vId;
  String? _roll;
  String? _serDesc;
  String? _serviceStatus;
  String? _taxStatus;
  String? _gstAmount;
Products copyWith({  String? id,
  String? artistName,
  String? categoryId,
  String? subId,
  String? servicesImage,
  String? profileImage,
  String? mrpPrice,
  String? specialPrice,
  String? vId,
  String? roll,
  String? serDesc,
  String? serviceStatus,
  String? taxStatus,
  String? gstAmount,
}) => Products(  id: id ?? _id,
  artistName: artistName ?? _artistName,
  categoryId: categoryId ?? _categoryId,
  subId: subId ?? _subId,
  servicesImage: servicesImage ?? _servicesImage,
  profileImage: profileImage ?? _profileImage,
  mrpPrice: mrpPrice ?? _mrpPrice,
  specialPrice: specialPrice ?? _specialPrice,
  vId: vId ?? _vId,
  roll: roll ?? _roll,
  serDesc: serDesc ?? _serDesc,
  serviceStatus: serviceStatus ?? _serviceStatus,
  taxStatus: taxStatus ?? _taxStatus,
  gstAmount: gstAmount ?? _gstAmount,
);
  String? get id => _id;
  String? get artistName => _artistName;
  String? get categoryId => _categoryId;
  String? get subId => _subId;
  String? get servicesImage => _servicesImage;
  String? get profileImage => _profileImage;
  String? get mrpPrice => _mrpPrice;
  String? get specialPrice => _specialPrice;
  String? get vId => _vId;
  String? get roll => _roll;
  String? get serDesc => _serDesc;
  String? get serviceStatus => _serviceStatus;
  String? get taxStatus => _taxStatus;
  String? get gstAmount => _gstAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['artist_name'] = _artistName;
    map['category_id'] = _categoryId;
    map['sub_id'] = _subId;
    map['services_image'] = _servicesImage;
    map['profile_image'] = _profileImage;
    map['mrp_price'] = _mrpPrice;
    map['special_price'] = _specialPrice;
    map['v_id'] = _vId;
    map['roll'] = _roll;
    map['ser_desc'] = _serDesc;
    map['service_status'] = _serviceStatus;
    map['tax_status'] = _taxStatus;
    map['gst_amount'] = _gstAmount;
    return map;
  }

}

/// service_id : "50"
/// hours : null
/// subtotal : "3000"
/// no_of_person : "10"

class Services {
  Services({
      String? serviceId, 
      dynamic hours, 
      String? subtotal, 
      String? noOfPerson,}){
    _serviceId = serviceId;
    _hours = hours;
    _subtotal = subtotal;
    _noOfPerson = noOfPerson;
}

  Services.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _hours = json['hours'];
    _subtotal = json['subtotal'];
    _noOfPerson = json['no_of_person'];
  }
  String? _serviceId;
  dynamic _hours;
  String? _subtotal;
  String? _noOfPerson;
Services copyWith({  String? serviceId,
  dynamic hours,
  String? subtotal,
  String? noOfPerson,
}) => Services(  serviceId: serviceId ?? _serviceId,
  hours: hours ?? _hours,
  subtotal: subtotal ?? _subtotal,
  noOfPerson: noOfPerson ?? _noOfPerson,
);
  String? get serviceId => _serviceId;
  dynamic get hours => _hours;
  String? get subtotal => _subtotal;
  String? get noOfPerson => _noOfPerson;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['hours'] = _hours;
    map['subtotal'] = _subtotal;
    map['no_of_person'] = _noOfPerson;
    return map;
  }

}