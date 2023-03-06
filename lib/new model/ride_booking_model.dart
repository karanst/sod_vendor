/// response_code : "1"
/// msg : "Get Booking  detail"
/// rides : {"id":"1","user_id":"1","uneaque_id":null,"purpose":null,"pickup_area":null,"pickup_date":null,"drop_area":null,"pickup_time":null,"area":null,"landmark":null,"pickup_address":"Indore, Madhya Pradesh, India","drop_address":"Palasia, Indore, Madhya Pradesh, India","taxi_type":"three_wheeler","departure_time":null,"departure_date":null,"return_date":null,"flight_number":null,"package":null,"promo_code":null,"distance":null,"amount":"20310","paid_amount":"331","address":null,"transfer":null,"item_status":null,"transaction":"CASH","payment_media":null,"km":null,"timetype":null,"assigned_for":null,"is_paid_advance":"0","status":"0","latitude":"22.7195687","longitude":"75.8577258","date_added":"2023-01-24 13:59:14","drop_latitude":"22.724355","drop_longitude":"75.8838944","booking_type":"Point To Point","accept_reject":"0","created_date":"2023-01-24","username":"devesh","reason":"","surge_amount":"0","gst_amount":"1","base_fare":"","time_amount":"","rate_per_km":"","admin_commision":"","total_time":"","cancel_charge":"","car_categories":"0","start_time":"00:00:00","end_time":"00:00:00","taxi_id":"","hours":"","booking_time":"19:28:44","shareing_type":"","sharing_user_id":"0","promo_discount":"","payment_status":"","bookings_type":"delivery_booking","pickup_floor":"1","drop_floor":"10","category":"refrigerator"}

class RideBookingModel {
  RideBookingModel({
      String? responseCode, 
      String? msg, 
      ParcelModel? rides,}){
    _responseCode = responseCode;
    _msg = msg;
    _rides = rides;
}

  RideBookingModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    _rides = json['rides'] != null ? ParcelModel.fromJson(json['rides']) : null;
  }
  String? _responseCode;
  String? _msg;
  ParcelModel? _rides;
RideBookingModel copyWith({  String? responseCode,
  String? msg,
  ParcelModel? rides,
}) => RideBookingModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  rides: rides ?? _rides,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  ParcelModel? get rides => _rides;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_rides != null) {
      map['rides'] = _rides?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// user_id : "1"
/// uneaque_id : null
/// purpose : null
/// pickup_area : null
/// pickup_date : null
/// drop_area : null
/// pickup_time : null
/// area : null
/// landmark : null
/// pickup_address : "Indore, Madhya Pradesh, India"
/// drop_address : "Palasia, Indore, Madhya Pradesh, India"
/// taxi_type : "three_wheeler"
/// departure_time : null
/// departure_date : null
/// return_date : null
/// flight_number : null
/// package : null
/// promo_code : null
/// distance : null
/// amount : "20310"
/// paid_amount : "331"
/// address : null
/// transfer : null
/// item_status : null
/// transaction : "CASH"
/// payment_media : null
/// km : null
/// timetype : null
/// assigned_for : null
/// is_paid_advance : "0"
/// status : "0"
/// latitude : "22.7195687"
/// longitude : "75.8577258"
/// date_added : "2023-01-24 13:59:14"
/// drop_latitude : "22.724355"
/// drop_longitude : "75.8838944"
/// booking_type : "Point To Point"
/// accept_reject : "0"
/// created_date : "2023-01-24"
/// username : "devesh"
/// reason : ""
/// surge_amount : "0"
/// gst_amount : "1"
/// base_fare : ""
/// time_amount : ""
/// rate_per_km : ""
/// admin_commision : ""
/// total_time : ""
/// cancel_charge : ""
/// car_categories : "0"
/// start_time : "00:00:00"
/// end_time : "00:00:00"
/// taxi_id : ""
/// hours : ""
/// booking_time : "19:28:44"
/// shareing_type : ""
/// sharing_user_id : "0"
/// promo_discount : ""
/// payment_status : ""
/// bookings_type : "delivery_booking"
/// pickup_floor : "1"
/// drop_floor : "10"
/// category : "refrigerator"

class ParcelModel {
  ParcelModel({
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
      dynamic address, 
      dynamic transfer, 
      dynamic itemStatus, 
      String? transaction, 
      dynamic paymentMedia, 
      dynamic km, 
      dynamic timetype, 
      dynamic assignedFor, 
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
      String? adminCommision, 
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
      String? pickupFloor, 
      String? dropFloor, 
      String? category,}){
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
}

  ParcelModel.fromJson(dynamic json) {
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
  dynamic _address;
  dynamic _transfer;
  dynamic _itemStatus;
  String? _transaction;
  dynamic _paymentMedia;
  dynamic _km;
  dynamic _timetype;
  dynamic _assignedFor;
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
  String? _adminCommision;
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
  String? _pickupFloor;
  String? _dropFloor;
  String? _category;
ParcelModel copyWith({  String? id,
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
  dynamic address,
  dynamic transfer,
  dynamic itemStatus,
  String? transaction,
  dynamic paymentMedia,
  dynamic km,
  dynamic timetype,
  dynamic assignedFor,
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
  String? adminCommision,
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
  String? pickupFloor,
  String? dropFloor,
  String? category,
}) => ParcelModel(  id: id ?? _id,
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
  dynamic get address => _address;
  dynamic get transfer => _transfer;
  dynamic get itemStatus => _itemStatus;
  String? get transaction => _transaction;
  dynamic get paymentMedia => _paymentMedia;
  dynamic get km => _km;
  dynamic get timetype => _timetype;
  dynamic get assignedFor => _assignedFor;
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
  String? get adminCommision => _adminCommision;
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
  String? get pickupFloor => _pickupFloor;
  String? get dropFloor => _dropFloor;
  String? get category => _category;

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
    return map;
  }

}