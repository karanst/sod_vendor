class GetNewOrderResponse {
  String? responseCode;
  String? message;
  List<Booking>? booking;

  GetNewOrderResponse({this.responseCode, this.message, this.booking});

  GetNewOrderResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    if (json['booking'] != null) {
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.booking != null) {
      data['booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String? id;
  String? userId;
  String? resId;
  String? serviceId;
  String? vid;
  String? date;
  String? slot;
  String? size;
  String? status;
  String? acceptReject;
  String? amount;
  String? txnId;
  String? paymentMode;
  String? pDate;
  String? paymentStatus;
  String? address;
  String? notes;
  String? otp;
  String? workHours;
  String? createDate;
  String? time;
  String? username;
  String? mobile;
  String? tax;
  List<String>? storeImage;
  Service? service;

  Booking(
      {this.id,
      this.userId,
      this.resId,
      this.serviceId,
      this.vid,
      this.date,
      this.slot,
      this.size,
      this.status,
      this.acceptReject,
      this.amount,
      this.txnId,
      this.paymentMode,
      this.pDate,
      this.paymentStatus,
      this.address,
      this.notes,
      this.otp,
      this.workHours,
      this.createDate,
      this.time,
      this.username,
      this.mobile,
      this.tax,
      this.storeImage,
      this.service});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    resId = json['res_id'];
    serviceId = json['service_id'];
    vid = json['vid'];
    date = json['date'];
    slot = json['slot'];
    size = json['size'];
    status = json['status'];
    acceptReject = json['accept_reject'];
    amount = json['amount'];
    txnId = json['txn_id'];
    paymentMode = json['payment_mode'];
    pDate = json['p_date'];
    paymentStatus = json['payment_status'];
    address = json['address'];
    notes = json['notes'];
    otp = json['otp'];
    workHours = json['work_hours'];
    createDate = json['create_date'];
    time = json['time'];
    username = json['username'];
    mobile = json['mobile'];
    tax = json['tax'];
    storeImage = json['store_image'].cast<String>();
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['res_id'] = this.resId;
    data['service_id'] = this.serviceId;
    data['vid'] = this.vid;
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['size'] = this.size;
    data['status'] = this.status;
    data['accept_reject'] = this.acceptReject;
    data['amount'] = this.amount;
    data['txn_id'] = this.txnId;
    data['payment_mode'] = this.paymentMode;
    data['p_date'] = this.pDate;
    data['payment_status'] = this.paymentStatus;
    data['address'] = this.address;
    data['notes'] = this.notes;
    data['otp'] = this.otp;
    data['work_hours'] = this.workHours;
    data['create_date'] = this.createDate;
    data['time'] = this.time;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['tax'] = this.tax;
    data['store_image'] = this.storeImage;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Service {
  String? id;
  String? catId;
  String? resId;
  String? vId;
  String? serviceName;
  String? servicePrice;
  String? serviceDescription;
  String? serviceImage;
  String? priceUnit;
  String? duration;
  String? serviceTime;
  String? serviceRatings;
  String? createdDate;
  String? cName;

  Service(
      {this.id,
      this.catId,
      this.resId,
      this.vId,
      this.serviceName,
      this.servicePrice,
      this.serviceDescription,
      this.serviceImage,
      this.priceUnit,
      this.duration,
      this.serviceTime,
      this.serviceRatings,
      this.createdDate,
      this.cName});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    resId = json['res_id'];
    vId = json['v_id'];
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    serviceDescription = json['service_description'];
    serviceImage = json['service_image'];
    priceUnit = json['price_unit'];
    duration = json['duration'];
    serviceTime = json['service_time'];
    serviceRatings = json['service_ratings'];
    createdDate = json['created_date'];
    cName = json['c_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['res_id'] = this.resId;
    data['v_id'] = this.vId;
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['service_description'] = this.serviceDescription;
    data['service_image'] = this.serviceImage;
    data['price_unit'] = this.priceUnit;
    data['duration'] = this.duration;
    data['service_time'] = this.serviceTime;
    data['service_ratings'] = this.serviceRatings;
    data['created_date'] = this.createdDate;
    data['c_name'] = this.cName;
    return data;
  }
}
