/// response_code : "1"
/// msg : "Get Booking  detail"
/// total_amount : "549"
/// total_ride : "2"
/// rides : [{"id":"2","user_id":"2","uneaque_id":null,"purpose":null,"pickup_area":null,"pickup_date":null,"drop_area":null,"pickup_time":null,"area":null,"landmark":null,"pickup_address":"Indore, Madhya Pradesh, India","drop_address":"Ujjain, Madhya Pradesh, India","taxi_type":"Bike","departure_time":null,"departure_date":null,"return_date":null,"flight_number":null,"package":null,"promo_code":null,"distance":null,"amount":"459","paid_amount":"487","address":"","transfer":null,"item_status":null,"transaction":"wallet","payment_media":null,"km":"51","timetype":null,"assigned_for":"116","is_paid_advance":"0","status":"1","latitude":"22.7195687","longitude":"75.8577258","date_added":"2023-02-15 13:47:29","drop_latitude":"23.1764665","drop_longitude":"75.7885163","booking_type":"Point To Point","accept_reject":"1","created_date":"2023-02-15 13:47:29","username":"dev singh","reason":"","surge_amount":"0","gst_amount":"28","base_fare":"","time_amount":"","rate_per_km":"9","admin_commision":null,"total_time":"","cancel_charge":"","car_categories":"0","start_time":"00:00:00","end_time":"00:00:00","taxi_id":"","hours":"","booking_time":"00:00:00","shareing_type":"","sharing_user_id":"0","promo_discount":"","payment_status":"","bookings_type":"ride_booking","pickup_floor":null,"drop_floor":null,"category":null,"unit":null,"email":"dev@gmail.com","countrycode":"91","mobile":"9993224906","password":"25d55ad283aa400af464c76d713c07ad","profile_pic":"63d8e3172d6d5.jpeg","facebook_id":"","type":"","isGold":"0","city":"","country":"","device_token":"","agreecheck":"0","otp":"3985","wallet":"243.46","oauth_provider":null,"oauth_uid":null,"last_login":"2023-02-07 12:29:56","created_at":"2023-01-24 13:57:31","updated_at":"2023-02-07 06:59:56","refferal_code":"SOD970622","friend_code":"","description":"","category_id":null,"per_d_charge":null,"per_h_charge":null,"experience":null,"vehicle_number":null,"vehicle_type":null,"rc_book":null,"per_km_charge":null,"lat":"","lang":"","uname":"Sushant ","profile_image":"","balance":"0.00","roll":"2","adhar_card":"63eb862e8ca1b.jpg","pancard":"63eb862e8d074.jpg","gst_no":"","fssai":"","store_name":"","band_details":"{\"UPI\" : \"7845123690@sbiok\"}","city_id":"42","vehicle_no":"RJ09es5678","registarion_card":"63eb862e8d2f3.jpg","driving_license":"63eb862e8d198.jpg","categories_id":"","company_name":"","role_user":"","event":"","delivery_type":"both","online_status":"1","store_description":"","commision":"","resto_type":"","gender":null,"cash_collection":"0","commision_amount_type":"","KM":"51","piclat":"22.7195687","piclong":"75.8577258","booking_id":"5","booking_status":"3","driver_pay_amount":408,"schedule_date":"2023-02-15 13:47:2900:00:00"},{"id":"5","user_id":"5","uneaque_id":null,"purpose":null,"pickup_area":null,"pickup_date":null,"drop_area":null,"pickup_time":null,"area":null,"landmark":null,"pickup_address":"Nehru Bazar, Film Colony, Pink City, Jaipur, Rajasthan, India","drop_address":"Vaishali Nagar, Jaipur, Rajasthan, India","taxi_type":"Bike","departure_time":null,"departure_date":null,"return_date":null,"flight_number":null,"package":null,"promo_code":null,"distance":null,"amount":"90","paid_amount":"100.8","address":"","transfer":null,"item_status":null,"transaction":"CASH","payment_media":null,"km":"8.8","timetype":null,"assigned_for":"116","is_paid_advance":"0","status":"1","latitude":"26.9186355","longitude":"75.8188946","date_added":"2023-02-15 13:50:52","drop_latitude":"26.9047751","drop_longitude":"75.74886409999999","booking_type":"Point To Point","accept_reject":"1","created_date":"2023-02-15 13:50:52","username":"Rohit ","reason":"","surge_amount":"0","gst_amount":"10.8","base_fare":"","time_amount":"","rate_per_km":"","admin_commision":null,"total_time":"","cancel_charge":"","car_categories":"0","start_time":"00:00:00","end_time":"00:00:00","taxi_id":"","hours":"","booking_time":"00:00:00","shareing_type":"","sharing_user_id":"0","promo_discount":"","payment_status":"","bookings_type":"ride_booking","pickup_floor":null,"drop_floor":null,"category":null,"unit":null,"email":"rohtij.alphawizz@gmail.com","countrycode":"91","mobile":"8770669964","password":"25d55ad283aa400af464c76d713c07ad","profile_pic":"","facebook_id":"","type":"","isGold":"0","city":"","country":"","device_token":"","agreecheck":"0","otp":"8363","wallet":"80.00","oauth_provider":null,"oauth_uid":null,"last_login":"2023-02-15 19:16:09","created_at":"2023-01-24 15:41:34","updated_at":"2023-02-15 13:46:09","refferal_code":"SOD303527","friend_code":"","description":"","category_id":null,"per_d_charge":null,"per_h_charge":null,"experience":null,"vehicle_number":null,"vehicle_type":null,"rc_book":null,"per_km_charge":null,"lat":"","lang":"","uname":"Sushant ","profile_image":"","balance":"0.00","roll":"2","adhar_card":"63eb862e8ca1b.jpg","pancard":"63eb862e8d074.jpg","gst_no":"","fssai":"","store_name":"","band_details":"{\"UPI\" : \"7845123690@sbiok\"}","city_id":"42","vehicle_no":"RJ09es5678","registarion_card":"63eb862e8d2f3.jpg","driving_license":"63eb862e8d198.jpg","categories_id":"","company_name":"","role_user":"","event":"","delivery_type":"both","online_status":"1","store_description":"","commision":"","resto_type":"","gender":null,"cash_collection":"0","commision_amount_type":"","KM":"8.8","piclat":"26.9186355","piclong":"75.8188946","booking_id":"290","booking_status":"0","driver_pay_amount":72,"schedule_date":"2023-02-15 13:50:5200:00:00"}]

class DeliveryBookingModel {
  DeliveryBookingModel({
      String? responseCode, 
      String? msg, 
      String? totalAmount, 
      String? totalRide, 
      List<Rides>? rides,}){
    _responseCode = responseCode;
    _msg = msg;
    _totalAmount = totalAmount;
    _totalRide = totalRide;
    _rides = rides;
}

  DeliveryBookingModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    _totalAmount = json['total_amount'];
    _totalRide = json['total_ride'];
    if (json['rides'] != null) {
      _rides = [];
      json['rides'].forEach((v) {
        _rides?.add(Rides.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  String? _totalAmount;
  String? _totalRide;
  List<Rides>? _rides;
DeliveryBookingModel copyWith({  String? responseCode,
  String? msg,
  String? totalAmount,
  String? totalRide,
  List<Rides>? rides,
}) => DeliveryBookingModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  totalAmount: totalAmount ?? _totalAmount,
  totalRide: totalRide ?? _totalRide,
  rides: rides ?? _rides,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  String? get totalAmount => _totalAmount;
  String? get totalRide => _totalRide;
  List<Rides>? get rides => _rides;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    map['total_amount'] = _totalAmount;
    map['total_ride'] = _totalRide;
    if (_rides != null) {
      map['rides'] = _rides?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// user_id : "2"
/// uneaque_id : null
/// purpose : null
/// pickup_area : null
/// pickup_date : null
/// drop_area : null
/// pickup_time : null
/// area : null
/// landmark : null
/// pickup_address : "Indore, Madhya Pradesh, India"
/// drop_address : "Ujjain, Madhya Pradesh, India"
/// taxi_type : "Bike"
/// departure_time : null
/// departure_date : null
/// return_date : null
/// flight_number : null
/// package : null
/// promo_code : null
/// distance : null
/// amount : "459"
/// paid_amount : "487"
/// address : ""
/// transfer : null
/// item_status : null
/// transaction : "wallet"
/// payment_media : null
/// km : "51"
/// timetype : null
/// assigned_for : "116"
/// is_paid_advance : "0"
/// status : "1"
/// latitude : "22.7195687"
/// longitude : "75.8577258"
/// date_added : "2023-02-15 13:47:29"
/// drop_latitude : "23.1764665"
/// drop_longitude : "75.7885163"
/// booking_type : "Point To Point"
/// accept_reject : "1"
/// created_date : "2023-02-15 13:47:29"
/// username : "dev singh"
/// reason : ""
/// surge_amount : "0"
/// gst_amount : "28"
/// base_fare : ""
/// time_amount : ""
/// rate_per_km : "9"
/// admin_commision : null
/// total_time : ""
/// cancel_charge : ""
/// car_categories : "0"
/// start_time : "00:00:00"
/// end_time : "00:00:00"
/// taxi_id : ""
/// hours : ""
/// booking_time : "00:00:00"
/// shareing_type : ""
/// sharing_user_id : "0"
/// promo_discount : ""
/// payment_status : ""
/// bookings_type : "ride_booking"
/// pickup_floor : null
/// drop_floor : null
/// category : null
/// unit : null
/// email : "dev@gmail.com"
/// countrycode : "91"
/// mobile : "9993224906"
/// password : "25d55ad283aa400af464c76d713c07ad"
/// profile_pic : "63d8e3172d6d5.jpeg"
/// facebook_id : ""
/// type : ""
/// isGold : "0"
/// city : ""
/// country : ""
/// device_token : ""
/// agreecheck : "0"
/// otp : "3985"
/// wallet : "243.46"
/// oauth_provider : null
/// oauth_uid : null
/// last_login : "2023-02-07 12:29:56"
/// created_at : "2023-01-24 13:57:31"
/// updated_at : "2023-02-07 06:59:56"
/// refferal_code : "SOD970622"
/// friend_code : ""
/// description : ""
/// category_id : null
/// per_d_charge : null
/// per_h_charge : null
/// experience : null
/// vehicle_number : null
/// vehicle_type : null
/// rc_book : null
/// per_km_charge : null
/// lat : ""
/// lang : ""
/// uname : "Sushant "
/// profile_image : ""
/// balance : "0.00"
/// roll : "2"
/// adhar_card : "63eb862e8ca1b.jpg"
/// pancard : "63eb862e8d074.jpg"
/// gst_no : ""
/// fssai : ""
/// store_name : ""
/// band_details : "{\"UPI\" : \"7845123690@sbiok\"}"
/// city_id : "42"
/// vehicle_no : "RJ09es5678"
/// registarion_card : "63eb862e8d2f3.jpg"
/// driving_license : "63eb862e8d198.jpg"
/// categories_id : ""
/// company_name : ""
/// role_user : ""
/// event : ""
/// delivery_type : "both"
/// online_status : "1"
/// store_description : ""
/// commision : ""
/// resto_type : ""
/// gender : null
/// cash_collection : "0"
/// commision_amount_type : ""
/// KM : "51"
/// piclat : "22.7195687"
/// piclong : "75.8577258"
/// booking_id : "5"
/// booking_status : "3"
/// driver_pay_amount : 408
/// schedule_date : "2023-02-15 13:47:2900:00:00"

class Rides {
  Rides({
      String? id, 
      String? userId, 
      dynamic uneaqueId, 
      dynamic purpose, 
      dynamic pickupArea, 
      dynamic pickupDate, 
      dynamic dropArea, 
      dynamic pickupTime, 
      dynamic area, 
      dynamic landmark, 
      String? pickupAddress, 
      String? dropAddress, 
      String? taxiType, 
      dynamic departureTime, 
      dynamic departureDate, 
      dynamic returnDate, 
      dynamic flightNumber, 
      dynamic package, 
      dynamic promoCode, 
      dynamic distance, 
      String? amount, 
      String? paidAmount, 
      String? address, 
      dynamic transfer, 
      dynamic itemStatus, 
      String? transaction, 
      dynamic paymentMedia, 
      String? km, 
      dynamic timetype, 
      String? assignedFor, 
      String? isPaidAdvance, 
      String? status, 
      String? latitude, 
      String? longitude, 
      String? dateAdded, 
      String? dropLatitude, 
      String? dropLongitude, 
      String? bookingType, 
      String? acceptReject, 
      String? createdDate, 
      String? username, 
      String? reason, 
      String? surgeAmount, 
      String? gstAmount, 
      String? baseFare, 
      String? timeAmount, 
      String? ratePerKm, 
      dynamic adminCommision, 
      String? totalTime, 
      String? cancelCharge, 
      String? carCategories, 
      String? startTime, 
      String? endTime, 
      String? taxiId, 
      String? hours, 
      String? bookingTime, 
      String? shareingType, 
      String? sharingUserId, 
      String? promoDiscount, 
      String? paymentStatus, 
      String? bookingsType, 
      dynamic pickupFloor, 
      dynamic dropFloor, 
      dynamic category, 
      dynamic unit, 
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
      String? otp, 
      String? wallet, 
      dynamic oauthProvider, 
      dynamic oauthUid, 
      String? lastLogin, 
      String? createdAt, 
      String? updatedAt, 
      String? refferalCode, 
      String? friendCode, 
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
      String? deliveryType, 
      String? onlineStatus, 
      String? storeDescription, 
      String? commision, 
      String? restoType, 
      dynamic gender, 
      String? cashCollection, 
      String? commisionAmountType,
      String? piclat, 
      String? piclong, 
      String? bookingId, 
      String? bookingStatus, 
      String? driverPayAmount,
      String? scheduleDate,}){
    _id = id;
    _userId = userId;
    _uneaqueId = uneaqueId;
    _purpose = purpose;
    _pickupArea = pickupArea;
    _pickupDate = pickupDate;
    _dropArea = dropArea;
    _pickupTime = pickupTime;
    _area = area;
    _landmark = landmark;
    _pickupAddress = pickupAddress;
    _dropAddress = dropAddress;
    _taxiType = taxiType;
    _departureTime = departureTime;
    _departureDate = departureDate;
    _returnDate = returnDate;
    _flightNumber = flightNumber;
    _package = package;
    _promoCode = promoCode;
    _distance = distance;
    _amount = amount;
    _paidAmount = paidAmount;
    _address = address;
    _transfer = transfer;
    _itemStatus = itemStatus;
    _transaction = transaction;
    _paymentMedia = paymentMedia;
    _km = km;
    _timetype = timetype;
    _assignedFor = assignedFor;
    _isPaidAdvance = isPaidAdvance;
    _status = status;
    _latitude = latitude;
    _longitude = longitude;
    _dateAdded = dateAdded;
    _dropLatitude = dropLatitude;
    _dropLongitude = dropLongitude;
    _bookingType = bookingType;
    _acceptReject = acceptReject;
    _createdDate = createdDate;
    _username = username;
    _reason = reason;
    _surgeAmount = surgeAmount;
    _gstAmount = gstAmount;
    _baseFare = baseFare;
    _timeAmount = timeAmount;
    _ratePerKm = ratePerKm;
    _adminCommision = adminCommision;
    _totalTime = totalTime;
    _cancelCharge = cancelCharge;
    _carCategories = carCategories;
    _startTime = startTime;
    _endTime = endTime;
    _taxiId = taxiId;
    _hours = hours;
    _bookingTime = bookingTime;
    _shareingType = shareingType;
    _sharingUserId = sharingUserId;
    _promoDiscount = promoDiscount;
    _paymentStatus = paymentStatus;
    _bookingsType = bookingsType;
    _pickupFloor = pickupFloor;
    _dropFloor = dropFloor;
    _category = category;
    _unit = unit;
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
    _otp = otp;
    _wallet = wallet;
    _oauthProvider = oauthProvider;
    _oauthUid = oauthUid;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _refferalCode = refferalCode;
    _friendCode = friendCode;
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
    _deliveryType = deliveryType;
    _onlineStatus = onlineStatus;
    _storeDescription = storeDescription;
    _commision = commision;
    _restoType = restoType;
    _gender = gender;
    _cashCollection = cashCollection;
    _commisionAmountType = commisionAmountType;
    _km = km;
    _piclat = piclat;
    _piclong = piclong;
    _bookingId = bookingId;
    _bookingStatus = bookingStatus;
    _driverPayAmount = driverPayAmount;
    _scheduleDate = scheduleDate;
}

  Rides.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _uneaqueId = json['uneaque_id'];
    _purpose = json['purpose'];
    _pickupArea = json['pickup_area'];
    _pickupDate = json['pickup_date'];
    _dropArea = json['drop_area'];
    _pickupTime = json['pickup_time'];
    _area = json['area'];
    _landmark = json['landmark'];
    _pickupAddress = json['pickup_address'];
    _dropAddress = json['drop_address'];
    _taxiType = json['taxi_type'];
    _departureTime = json['departure_time'];
    _departureDate = json['departure_date'];
    _returnDate = json['return_date'];
    _flightNumber = json['flight_number'];
    _package = json['package'];
    _promoCode = json['promo_code'];
    _distance = json['distance'];
    _amount = json['amount'];
    _paidAmount = json['paid_amount'];
    _address = json['address'];
    _transfer = json['transfer'];
    _itemStatus = json['item_status'];
    _transaction = json['transaction'];
    _paymentMedia = json['payment_media'];
    _km = json['km'];
    _timetype = json['timetype'];
    _assignedFor = json['assigned_for'];
    _isPaidAdvance = json['is_paid_advance'];
    _status = json['status'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _dateAdded = json['date_added'];
    _dropLatitude = json['drop_latitude'];
    _dropLongitude = json['drop_longitude'];
    _bookingType = json['booking_type'];
    _acceptReject = json['accept_reject'];
    _createdDate = json['created_date'];
    _username = json['username'];
    _reason = json['reason'];
    _surgeAmount = json['surge_amount'];
    _gstAmount = json['gst_amount'];
    _baseFare = json['base_fare'];
    _timeAmount = json['time_amount'];
    _ratePerKm = json['rate_per_km'];
    _adminCommision = json['admin_commision'];
    _totalTime = json['total_time'];
    _cancelCharge = json['cancel_charge'];
    _carCategories = json['car_categories'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _taxiId = json['taxi_id'];
    _hours = json['hours'];
    _bookingTime = json['booking_time'];
    _shareingType = json['shareing_type'];
    _sharingUserId = json['sharing_user_id'];
    _promoDiscount = json['promo_discount'];
    _paymentStatus = json['payment_status'];
    _bookingsType = json['bookings_type'];
    _pickupFloor = json['pickup_floor'];
    _dropFloor = json['drop_floor'];
    _category = json['category'];
    _unit = json['unit'];
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
    _otp = json['otp'];
    _wallet = json['wallet'];
    _oauthProvider = json['oauth_provider'];
    _oauthUid = json['oauth_uid'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _refferalCode = json['refferal_code'];
    _friendCode = json['friend_code'];
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
    _deliveryType = json['delivery_type'];
    _onlineStatus = json['online_status'];
    _storeDescription = json['store_description'];
    _commision = json['commision'];
    _restoType = json['resto_type'];
    _gender = json['gender'];
    _cashCollection = json['cash_collection'];
    _commisionAmountType = json['commision_amount_type'];
    _km = json['KM'];
    _piclat = json['piclat'];
    _piclong = json['piclong'];
    _bookingId = json['booking_id'];
    _bookingStatus = json['booking_status'];
    _driverPayAmount = json['driver_pay_amount'];
    _scheduleDate = json['schedule_date'];
  }
  String? _id;
  String? _userId;
  dynamic _uneaqueId;
  dynamic _purpose;
  dynamic _pickupArea;
  dynamic _pickupDate;
  dynamic _dropArea;
  dynamic _pickupTime;
  dynamic _area;
  dynamic _landmark;
  String? _pickupAddress;
  String? _dropAddress;
  String? _taxiType;
  dynamic _departureTime;
  dynamic _departureDate;
  dynamic _returnDate;
  dynamic _flightNumber;
  dynamic _package;
  dynamic _promoCode;
  dynamic _distance;
  String? _amount;
  String? _paidAmount;
  String? _address;
  dynamic _transfer;
  dynamic _itemStatus;
  String? _transaction;
  dynamic _paymentMedia;
  String? _km;
  dynamic _timetype;
  String? _assignedFor;
  String? _isPaidAdvance;
  String? _status;
  String? _latitude;
  String? _longitude;
  String? _dateAdded;
  String? _dropLatitude;
  String? _dropLongitude;
  String? _bookingType;
  String? _acceptReject;
  String? _createdDate;
  String? _username;
  String? _reason;
  String? _surgeAmount;
  String? _gstAmount;
  String? _baseFare;
  String? _timeAmount;
  String? _ratePerKm;
  dynamic _adminCommision;
  String? _totalTime;
  String? _cancelCharge;
  String? _carCategories;
  String? _startTime;
  String? _endTime;
  String? _taxiId;
  String? _hours;
  String? _bookingTime;
  String? _shareingType;
  String? _sharingUserId;
  String? _promoDiscount;
  String? _paymentStatus;
  String? _bookingsType;
  dynamic _pickupFloor;
  dynamic _dropFloor;
  dynamic _category;
  dynamic _unit;
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
  String? _otp;
  String? _wallet;
  dynamic _oauthProvider;
  dynamic _oauthUid;
  String? _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  String? _refferalCode;
  String? _friendCode;
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
  String? _deliveryType;
  String? _onlineStatus;
  String? _storeDescription;
  String? _commision;
  String? _restoType;
  dynamic _gender;
  String? _cashCollection;
  String? _commisionAmountType ;
  String? _piclat;
  String? _piclong;
  String? _bookingId;
  String? _bookingStatus;
  String? _driverPayAmount;
  String? _scheduleDate;
Rides copyWith({  String? id,
  String? userId,
  dynamic uneaqueId,
  dynamic purpose,
  dynamic pickupArea,
  dynamic pickupDate,
  dynamic dropArea,
  dynamic pickupTime,
  dynamic area,
  dynamic landmark,
  String? pickupAddress,
  String? dropAddress,
  String? taxiType,
  dynamic departureTime,
  dynamic departureDate,
  dynamic returnDate,
  dynamic flightNumber,
  dynamic package,
  dynamic promoCode,
  dynamic distance,
  String? amount,
  String? paidAmount,
  String? address,
  dynamic transfer,
  dynamic itemStatus,
  String? transaction,
  dynamic paymentMedia,
  String? km,
  dynamic timetype,
  String? assignedFor,
  String? isPaidAdvance,
  String? status,
  String? latitude,
  String? longitude,
  String? dateAdded,
  String? dropLatitude,
  String? dropLongitude,
  String? bookingType,
  String? acceptReject,
  String? createdDate,
  String? username,
  String? reason,
  String? surgeAmount,
  String? gstAmount,
  String? baseFare,
  String? timeAmount,
  String? ratePerKm,
  dynamic adminCommision,
  String? totalTime,
  String? cancelCharge,
  String? carCategories,
  String? startTime,
  String? endTime,
  String? taxiId,
  String? hours,
  String? bookingTime,
  String? shareingType,
  String? sharingUserId,
  String? promoDiscount,
  String? paymentStatus,
  String? bookingsType,
  dynamic pickupFloor,
  dynamic dropFloor,
  dynamic category,
  dynamic unit,
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
  String? otp,
  String? wallet,
  dynamic oauthProvider,
  dynamic oauthUid,
  String? lastLogin,
  String? createdAt,
  String? updatedAt,
  String? refferalCode,
  String? friendCode,
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
  String? deliveryType,
  String? onlineStatus,
  String? storeDescription,
  String? commision,
  String? restoType,
  dynamic gender,
  String? cashCollection,
  String? commisionAmountType,
  String? piclat,
  String? piclong,
  String? bookingId,
  String? bookingStatus,
  String? driverPayAmount,
  String? scheduleDate,
}) => Rides(  id: id ?? _id,
  userId: userId ?? _userId,
  uneaqueId: uneaqueId ?? _uneaqueId,
  purpose: purpose ?? _purpose,
  pickupArea: pickupArea ?? _pickupArea,
  pickupDate: pickupDate ?? _pickupDate,
  dropArea: dropArea ?? _dropArea,
  pickupTime: pickupTime ?? _pickupTime,
  area: area ?? _area,
  landmark: landmark ?? _landmark,
  pickupAddress: pickupAddress ?? _pickupAddress,
  dropAddress: dropAddress ?? _dropAddress,
  taxiType: taxiType ?? _taxiType,
  departureTime: departureTime ?? _departureTime,
  departureDate: departureDate ?? _departureDate,
  returnDate: returnDate ?? _returnDate,
  flightNumber: flightNumber ?? _flightNumber,
  package: package ?? _package,
  promoCode: promoCode ?? _promoCode,
  distance: distance ?? _distance,
  amount: amount ?? _amount,
  paidAmount: paidAmount ?? _paidAmount,
  address: address ?? _address,
  transfer: transfer ?? _transfer,
  itemStatus: itemStatus ?? _itemStatus,
  transaction: transaction ?? _transaction,
  paymentMedia: paymentMedia ?? _paymentMedia,
  km: km ?? _km,
  timetype: timetype ?? _timetype,
  assignedFor: assignedFor ?? _assignedFor,
  isPaidAdvance: isPaidAdvance ?? _isPaidAdvance,
  status: status ?? _status,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  dateAdded: dateAdded ?? _dateAdded,
  dropLatitude: dropLatitude ?? _dropLatitude,
  dropLongitude: dropLongitude ?? _dropLongitude,
  bookingType: bookingType ?? _bookingType,
  acceptReject: acceptReject ?? _acceptReject,
  createdDate: createdDate ?? _createdDate,
  username: username ?? _username,
  reason: reason ?? _reason,
  surgeAmount: surgeAmount ?? _surgeAmount,
  gstAmount: gstAmount ?? _gstAmount,
  baseFare: baseFare ?? _baseFare,
  timeAmount: timeAmount ?? _timeAmount,
  ratePerKm: ratePerKm ?? _ratePerKm,
  adminCommision: adminCommision ?? _adminCommision,
  totalTime: totalTime ?? _totalTime,
  cancelCharge: cancelCharge ?? _cancelCharge,
  carCategories: carCategories ?? _carCategories,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  taxiId: taxiId ?? _taxiId,
  hours: hours ?? _hours,
  bookingTime: bookingTime ?? _bookingTime,
  shareingType: shareingType ?? _shareingType,
  sharingUserId: sharingUserId ?? _sharingUserId,
  promoDiscount: promoDiscount ?? _promoDiscount,
  paymentStatus: paymentStatus ?? _paymentStatus,
  bookingsType: bookingsType ?? _bookingsType,
  pickupFloor: pickupFloor ?? _pickupFloor,
  dropFloor: dropFloor ?? _dropFloor,
  category: category ?? _category,
  unit: unit ?? _unit,
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
  otp: otp ?? _otp,
  wallet: wallet ?? _wallet,
  oauthProvider: oauthProvider ?? _oauthProvider,
  oauthUid: oauthUid ?? _oauthUid,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  refferalCode: refferalCode ?? _refferalCode,
  friendCode: friendCode ?? _friendCode,
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
  deliveryType: deliveryType ?? _deliveryType,
  onlineStatus: onlineStatus ?? _onlineStatus,
  storeDescription: storeDescription ?? _storeDescription,
  commision: commision ?? _commision,
  restoType: restoType ?? _restoType,
  gender: gender ?? _gender,
  cashCollection: cashCollection ?? _cashCollection,
  commisionAmountType: commisionAmountType ?? _commisionAmountType,
  piclat: piclat ?? _piclat,
  piclong: piclong ?? _piclong,
  bookingId: bookingId ?? _bookingId,
  bookingStatus: bookingStatus ?? _bookingStatus,
  driverPayAmount: driverPayAmount ?? _driverPayAmount,
  scheduleDate: scheduleDate ?? _scheduleDate,
);
  String? get id => _id;
  String? get userId => _userId;
  dynamic get uneaqueId => _uneaqueId;
  dynamic get purpose => _purpose;
  dynamic get pickupArea => _pickupArea;
  dynamic get pickupDate => _pickupDate;
  dynamic get dropArea => _dropArea;
  dynamic get pickupTime => _pickupTime;
  dynamic get area => _area;
  dynamic get landmark => _landmark;
  String? get pickupAddress => _pickupAddress;
  String? get dropAddress => _dropAddress;
  String? get taxiType => _taxiType;
  dynamic get departureTime => _departureTime;
  dynamic get departureDate => _departureDate;
  dynamic get returnDate => _returnDate;
  dynamic get flightNumber => _flightNumber;
  dynamic get package => _package;
  dynamic get promoCode => _promoCode;
  dynamic get distance => _distance;
  String? get amount => _amount;
  String? get paidAmount => _paidAmount;
  String? get address => _address;
  dynamic get transfer => _transfer;
  dynamic get itemStatus => _itemStatus;
  String? get transaction => _transaction;
  dynamic get paymentMedia => _paymentMedia;
  String? get km => _km;
  dynamic get timetype => _timetype;
  String? get assignedFor => _assignedFor;
  String? get isPaidAdvance => _isPaidAdvance;
  String? get status => _status;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get dateAdded => _dateAdded;
  String? get dropLatitude => _dropLatitude;
  String? get dropLongitude => _dropLongitude;
  String? get bookingType => _bookingType;
  String? get acceptReject => _acceptReject;
  String? get createdDate => _createdDate;
  String? get username => _username;
  String? get reason => _reason;
  String? get surgeAmount => _surgeAmount;
  String? get gstAmount => _gstAmount;
  String? get baseFare => _baseFare;
  String? get timeAmount => _timeAmount;
  String? get ratePerKm => _ratePerKm;
  dynamic get adminCommision => _adminCommision;
  String? get totalTime => _totalTime;
  String? get cancelCharge => _cancelCharge;
  String? get carCategories => _carCategories;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get taxiId => _taxiId;
  String? get hours => _hours;
  String? get bookingTime => _bookingTime;
  String? get shareingType => _shareingType;
  String? get sharingUserId => _sharingUserId;
  String? get promoDiscount => _promoDiscount;
  String? get paymentStatus => _paymentStatus;
  String? get bookingsType => _bookingsType;
  dynamic get pickupFloor => _pickupFloor;
  dynamic get dropFloor => _dropFloor;
  dynamic get category => _category;
  dynamic get unit => _unit;
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
  String? get otp => _otp;
  String? get wallet => _wallet;
  dynamic get oauthProvider => _oauthProvider;
  dynamic get oauthUid => _oauthUid;
  String? get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get refferalCode => _refferalCode;
  String? get friendCode => _friendCode;
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
  String? get deliveryType => _deliveryType;
  String? get onlineStatus => _onlineStatus;
  String? get storeDescription => _storeDescription;
  String? get commision => _commision;
  String? get restoType => _restoType;
  dynamic get gender => _gender;
  String? get cashCollection => _cashCollection;
  String? get commisionAmountType => _commisionAmountType;
  String? get piclat => _piclat;
  String? get piclong => _piclong;
  String? get bookingId => _bookingId;
  String? get bookingStatus => _bookingStatus;
  String? get driverPayAmount => _driverPayAmount;
  String? get scheduleDate => _scheduleDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['uneaque_id'] = _uneaqueId;
    map['purpose'] = _purpose;
    map['pickup_area'] = _pickupArea;
    map['pickup_date'] = _pickupDate;
    map['drop_area'] = _dropArea;
    map['pickup_time'] = _pickupTime;
    map['area'] = _area;
    map['landmark'] = _landmark;
    map['pickup_address'] = _pickupAddress;
    map['drop_address'] = _dropAddress;
    map['taxi_type'] = _taxiType;
    map['departure_time'] = _departureTime;
    map['departure_date'] = _departureDate;
    map['return_date'] = _returnDate;
    map['flight_number'] = _flightNumber;
    map['package'] = _package;
    map['promo_code'] = _promoCode;
    map['distance'] = _distance;
    map['amount'] = _amount;
    map['paid_amount'] = _paidAmount;
    map['address'] = _address;
    map['transfer'] = _transfer;
    map['item_status'] = _itemStatus;
    map['transaction'] = _transaction;
    map['payment_media'] = _paymentMedia;
    map['km'] = _km;
    map['timetype'] = _timetype;
    map['assigned_for'] = _assignedFor;
    map['is_paid_advance'] = _isPaidAdvance;
    map['status'] = _status;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['date_added'] = _dateAdded;
    map['drop_latitude'] = _dropLatitude;
    map['drop_longitude'] = _dropLongitude;
    map['booking_type'] = _bookingType;
    map['accept_reject'] = _acceptReject;
    map['created_date'] = _createdDate;
    map['username'] = _username;
    map['reason'] = _reason;
    map['surge_amount'] = _surgeAmount;
    map['gst_amount'] = _gstAmount;
    map['base_fare'] = _baseFare;
    map['time_amount'] = _timeAmount;
    map['rate_per_km'] = _ratePerKm;
    map['admin_commision'] = _adminCommision;
    map['total_time'] = _totalTime;
    map['cancel_charge'] = _cancelCharge;
    map['car_categories'] = _carCategories;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['taxi_id'] = _taxiId;
    map['hours'] = _hours;
    map['booking_time'] = _bookingTime;
    map['shareing_type'] = _shareingType;
    map['sharing_user_id'] = _sharingUserId;
    map['promo_discount'] = _promoDiscount;
    map['payment_status'] = _paymentStatus;
    map['bookings_type'] = _bookingsType;
    map['pickup_floor'] = _pickupFloor;
    map['drop_floor'] = _dropFloor;
    map['category'] = _category;
    map['unit'] = _unit;
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
    map['otp'] = _otp;
    map['wallet'] = _wallet;
    map['oauth_provider'] = _oauthProvider;
    map['oauth_uid'] = _oauthUid;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['refferal_code'] = _refferalCode;
    map['friend_code'] = _friendCode;
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
    map['delivery_type'] = _deliveryType;
    map['online_status'] = _onlineStatus;
    map['store_description'] = _storeDescription;
    map['commision'] = _commision;
    map['resto_type'] = _restoType;
    map['gender'] = _gender;
    map['cash_collection'] = _cashCollection;
    map['commision_amount_type'] = _commisionAmountType;
    map['KM'] = _km;
    map['piclat'] = _piclat;
    map['piclong'] = _piclong;
    map['booking_id'] = _bookingId;
    map['booking_status'] = _bookingStatus;
    map['driver_pay_amount'] = _driverPayAmount;
    map['schedule_date'] = _scheduleDate;
    return map;
  }

}